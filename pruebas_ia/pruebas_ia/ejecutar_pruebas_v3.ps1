# ============================================================
# Script de pruebas automatizadas v3 - Casos Clinicos ECOE / Ollama
# ============================================================
# Usa "ollama run" DIRECTO (el modelo corriendo en tu PC, sin API),
# pero captura la salida de forma limpia usando Start-Process,
# para evitar los codigos de terminal / spinner en el archivo.
#
# USO:
#   1. Coloca este script en la misma carpeta donde estan los .txt de prompts
#   2. Abre PowerShell en esa carpeta
#   3. Ejecuta:  .\ejecutar_pruebas_v3.ps1
# ============================================================

# --- CONFIGURA AQUI LOS MODELOS QUE QUIERES PROBAR ---
# (deben coincidir EXACTO con lo que muestra "ollama list")
$modelos = @(
    "llama3.1"
)

$carpetaPrompts = $PSScriptRoot
$carpetaResultados = Join-Path $carpetaPrompts "resultados"
$carpetaTemp = Join-Path $carpetaPrompts "_temp"

if (-not (Test-Path $carpetaResultados)) { New-Item -ItemType Directory -Path $carpetaResultados | Out-Null }
if (-not (Test-Path $carpetaTemp)) { New-Item -ItemType Directory -Path $carpetaTemp | Out-Null }

$prompts = Get-ChildItem -Path $carpetaPrompts -Filter "*.txt"

$csvPath = Join-Path $carpetaResultados "resumen_tiempos.csv"
"Modelo,Prompt,TiempoSegundos,ArchivoResultado" | Out-File -FilePath $csvPath -Encoding utf8

Write-Host "=================================================="
Write-Host "Iniciando pruebas: $($modelos.Count) modelos x $($prompts.Count) prompts"
Write-Host "Usando 'ollama run' directo (modelo local en tu PC)"
Write-Host "=================================================="

foreach ($modelo in $modelos) {

    $modeloSlug = $modelo -replace "[:\\/]", "_"

    foreach ($prompt in $prompts) {

        $nombrePrompt = [System.IO.Path]::GetFileNameWithoutExtension($prompt.Name)
        $nombreArchivoSalida = "$modeloSlug`_$nombrePrompt.txt"
        $rutaSalida = Join-Path $carpetaResultados $nombreArchivoSalida

        Write-Host ""
        Write-Host "-> Modelo: $modelo | Prompt: $nombrePrompt (esto puede tardar, espera...)"

        $contenidoPrompt = Get-Content $prompt.FullName -Raw

        # Guardamos el prompt en un archivo temporal para pasarlo como argumento sin
        # problemas de comillas o caracteres especiales
        $tempOut = Join-Path $carpetaTemp "stdout.txt"
        $tempErr = Join-Path $carpetaTemp "stderr.txt"
        if (Test-Path $tempOut) { Remove-Item $tempOut -Force }
        if (Test-Path $tempErr) { Remove-Item $tempErr -Force }

        $tiempoInicio = Get-Date

        # Start-Process con redireccion REAL de archivo evita que ollama dibuje el spinner
        $proceso = Start-Process -FilePath "ollama" `
            -ArgumentList @("run", $modelo, $contenidoPrompt) `
            -RedirectStandardOutput $tempOut `
            -RedirectStandardError $tempErr `
            -NoNewWindow -Wait -PassThru

        $tiempoFin = Get-Date
        $duracion = [math]::Round(($tiempoFin - $tiempoInicio).TotalSeconds, 2)

        $textoRespuesta = if (Test-Path $tempOut) { Get-Content $tempOut -Raw } else { "" }
        $textoError = if (Test-Path $tempErr) { Get-Content $tempErr -Raw } else { "" }

        $encabezado = "MODELO: $modelo`nPROMPT: $nombrePrompt`nTIEMPO (segundos): $duracion`n`n===== RESPUESTA =====`n"
        $contenidoFinal = $encabezado + $textoRespuesta
        if ($textoError) {
            $contenidoFinal += "`n`n===== ERRORES/AVISOS =====`n$textoError"
        }
        $contenidoFinal | Out-File -FilePath $rutaSalida -Encoding utf8

        "$modelo,$nombrePrompt,$duracion,$nombreArchivoSalida" | Out-File -FilePath $csvPath -Append -Encoding utf8

        Write-Host "   Tiempo: $duracion s -> guardado en $nombreArchivoSalida"
    }
}

Remove-Item $carpetaTemp -Recurse -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "=================================================="
Write-Host "Pruebas terminadas."
Write-Host "Resultados en: $carpetaResultados"
Write-Host "Resumen en: $csvPath"
Write-Host "=================================================="
