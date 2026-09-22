# QuickBot Local GGUF LLM Runner
# Starts high-performance local inference server for QuickBot
param (
    [string]$ModelPath = "",
    [int]$Port = 8089,
    [int]$ContextSize = 2048,
    [int]$GpuLayers = 0
)

# Detect Model Path
if (-not $ModelPath) {
    $candidatePaths = @(
        "$PSScriptRoot\..\models\quickbot.gguf",
        "$PSScriptRoot\..\..\CampusConnectSphere\backend_python\models\quickbot.gguf"
    )
    foreach ($candidate in $candidatePaths) {
        if (Test-Path $candidate) {
            $ModelPath = (Resolve-Path $candidate).Path
            break
        }
    }
}

if (-not $ModelPath -or -not (Test-Path $ModelPath)) {
    Write-Error "quickbot.gguf not found. Please specify -ModelPath or place quickbot.gguf in the models/ directory."
    exit 1
}

# Detect llama-server.exe
$serverExe = "$env:USERPROFILE\.docker\bin\inference\llama-server.exe"
if (-not (Test-Path $serverExe)) {
    $cmd = Get-Command "llama-server" -ErrorAction SilentlyContinue
    if ($cmd) {
        $serverExe = $cmd.Source
    } else {
        Write-Error "llama-server.exe not found at $serverExe or in PATH. Please install llama.cpp."
        exit 1
    }
}

Write-Host "=================================================" -ForegroundColor Cyan
Write-Host "         QuickBot Local GGUF Server              " -ForegroundColor Green
Write-Host "=================================================" -ForegroundColor Cyan
Write-Host "Model:        $ModelPath" -ForegroundColor Yellow
Write-Host "Port:         $Port (OpenAI-compatible API)" -ForegroundColor Yellow
Write-Host "Listening on: http://127.0.0.1:$Port/v1" -ForegroundColor Yellow
Write-Host "=================================================" -ForegroundColor Cyan

& $serverExe -m $ModelPath --port $Port -c $ContextSize -ngl $GpuLayers --host 127.0.0.1
