# QuickBot LLM 🤖
### Institutional AI Assistant & Fine-Tuning Pipeline for Educational ERP Platforms

[![Python](https://img.shields.io/badge/Python-3.10%20%7C%203.11%20%7C%203.12-blue.svg)](https://www.python.org/)
[![Model](https://img.shields.io/badge/Base%20Model-Llama--3.2--3B--Instruct-purple.svg)](https://huggingface.co/unsloth/Llama-3.2-3B-Instruct)
[![Fine-Tuning](https://img.shields.io/badge/Optimization-Unsloth%20QLoRA%20(4--bit)-green.svg)](https://github.com/unslothai/unsloth)
[![Format](https://img.shields.io/badge/Inference-GGUF%20(Q4__K__M)-orange.svg)](https://github.com/ggerganov/llama.cpp)
[![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)](LICENSE)

---

## 📌 Overview

**QuickBot** is a role-isolated, fine-tuned institutional AI assistant engineered specifically for **CampusConnectSphere**. Operating as an on-device/local microservice, QuickBot provides precise operational guidance, navigation help, and role-enforced boundaries across all educational personas:

* **SuperAdmin**: Platform SaaS provisioning, multi-tenant domains, licensing, and cluster health.
* **SchoolAdmin / Admin**: Academic calendar, student admissions, fee schedules, automated timetable generation, and Report Studio governance.
* **Teacher**: Classroom attendance, gradebook entry, assignment dispatch, LMS virtual rooms, and lesson planning.
* **Student**: Daily timetables, assignment submission, exam schedules, and attendance metrics (strictly forbidden from administrative or grading actions).
* **Parent**: Fee payments, live school bus GPS tracking, PTM scheduling, and helpdesk inquiries.
* **Staff / Security**: Visitor badge generation, gate security, and fleet dispatch.
* **Accountant**: Fee collection POS, vouchers, daybook reconciliation, and tax reports.
* **Warden**: Hostel room allotments, night curfews, mess operations, and maintenance tickets.

---

## 🏛️ System Architecture

```
QuickBot_LLM (Model Training & Datasets Repo)
 ├── data/ (ChatML training & validation pairs)
 ├── scripts/ (Dataset synthesis, negative boundary injection, local runners)
 ├── notebooks/ (Colab 1-click fine-tuning with Unsloth)
 └── models/quickbot_lora_adapter/ (LoRA weights & configs)
       │
       ▼ (Exports GGUF / LoRA Adapter)
CampusConnectSphere (Application ERP Repo)
 ├── backend_python/services/quickbot_engine.py  <-- 3-Tier Runtime Dispatcher
 ├── backend_python/routers/quickbot_router.py   <-- Authenticated REST API
 └── campus_connect_app/                         <-- Floating Flutter UI Widget
```

---

## 📁 Repository Structure

```
QuickBot_LLM/
├── data/
│   ├── quickbot_train.jsonl           # 766 instruction-tuning pairs (85% train split)
│   ├── quickbot_val.jsonl             # 136 validation pairs (15% validation split)
│   └── dataset_manifest.json          # Checksums, metrics, and role breakdown
├── notebooks/
│   └── train_quickbot_colab.ipynb     # Google Colab fine-tuning pipeline (Unsloth T4 GPU)
├── scripts/
│   ├── build_quickbot_dataset.py      # Standalone dataset compiler with negative boundaries
│   ├── generate_colab_notebook.py     # Programmatic generator for the Colab notebook
│   ├── start_quickbot_llm.ps1         # Windows script to launch local llama-server (:8089)
│   └── test_inference.py              # CLI testing tool for inference and role-isolation
├── models/
│   └── quickbot_lora_adapter/         # Fine-tuned LoRA adapter configuration & tokenizer
│       ├── adapter_config.json
│       ├── chat_template.jinja
│       ├── tokenizer.json
│       ├── tokenizer_config.json
│       └── README.md
├── sources/                           # Input domain specifications for dataset generation
│   ├── CampusConnectSphere_Frontend_Screens_Catalog.md
│   ├── USER_ROLE_MANUAL.md
│   ├── RBAC_MATRIX.md
│   └── menu_config.dart
├── docs/
│   └── QUICKBOT_ARCHITECTURE_AND_TRAINING.md
├── requirements.txt
└── .gitignore
```

---

## 🔒 Zero-PII & Negative Boundary Guarantees

1. **Zero Personally Identifiable Information (Zero PII)**:
   All training datasets are synthetically extracted from screen specifications, route maps, and operational workflows. No real student records, grades, passwords, phone numbers, or credit card details are ever ingested.
2. **Negative Boundary Enforcement**:
   Lower-privileged roles (e.g. Student, Parent) contain hard negative boundary pairs in the training set ensuring immediate refusal when attempting unauthorized actions (e.g., student requesting to alter exam marks or delete another student's profile).

---

## 🚀 Fine-Tuning Pipeline (Google Colab)

Fine-tuning is automated via [`notebooks/train_quickbot_colab.ipynb`](notebooks/train_quickbot_colab.ipynb) on a free Google Colab T4 GPU:

1. **Base Model**: `unsloth/Llama-3.2-3B-Instruct`
2. **Method**: 4-bit QLoRA using Unsloth fast kernels
3. **Hyperparameters**:
   * Rank ($r$): 16
   * Alpha ($\alpha$): 16
   * Target Modules: `q_proj`, `k_proj`, `v_proj`, `o_proj`, `gate_proj`, `up_proj`, `down_proj`
   * Optimizer: `adamw_8bit`
   * Learning Rate: `2e-4` (cosine schedule)
   * Max Steps: 120 (~12 minutes execution time on T4)
4. **Outputs**:
   * LoRA Adapter: `quickbot_lora_adapter/`
   * Quantized GGUF: `quickbot.gguf` (`q4_k_m`, ~2.02 GB)

---

## 💻 Local Inference & Testing

### 1. Launch Local GGUF Server
Run the local inference server (listens on `http://127.0.0.1:8089/v1`):

```powershell
.\scripts\start_quickbot_llm.ps1 -ModelPath "path\to\quickbot.gguf" -Port 8089
```

### 2. Test Role Boundaries
Verify model inference and negative boundary compliance:

```bash
# Query as a Student
python scripts/test_inference.py --role Student --query "Where can I find my timetable?"

# Verify Negative Boundary Refusal
python scripts/test_inference.py --role Student --query "How do I edit final exam grades?"

# Run complete boundary test suite
python scripts/test_inference.py --run-tests
```

---

## 🔄 Recompiling Datasets

To regenerate or expand the dataset after adding new screens or RBAC permissions:

```bash
python scripts/build_quickbot_dataset.py
```
Outputs updated datasets to [`data/quickbot_train.jsonl`](data/quickbot_train.jsonl), [`data/quickbot_val.jsonl`](data/quickbot_val.jsonl), and [`data/dataset_manifest.json`](data/dataset_manifest.json).

---

## 🔗 Integration with CampusConnectSphere

To integrate the trained model with **CampusConnectSphere**:
1. Copy the exported `quickbot.gguf` into `CampusConnectSphere/backend_python/models/quickbot.gguf`.
2. Start the local server using `scripts/ai/start_quickbot_llm.ps1` or run via FastAPI backend.
3. The FastAPI service at `POST /api/v1/quickbot/chat` will automatically route queries through Tier 1 (Local GGUF), falling back to Tier 2 (In-memory semantic index) and Tier 3 (Persona catalog).
