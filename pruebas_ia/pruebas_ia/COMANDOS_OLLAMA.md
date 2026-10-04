# Guía rápida de comandos de Ollama

## Ver qué modelos tienes descargados
```powershell
ollama list
```

## Descargar (instalar) un modelo nuevo
```powershell
ollama pull nombre-del-modelo
```
Ejemplos:
```powershell
ollama pull phi3
ollama pull mistral
ollama pull medgemma:4b
ollama pull medgemma1.5
ollama pull meditron
ollama pull medllama2
ollama pull llama3.1
```

## Eliminar un modelo (para liberar espacio)
```powershell
ollama rm nombre-del-modelo
```
Ejemplo:
```powershell
ollama rm phi3
```
> Si da "Acceso denegado": cierra Ollama desde la bandeja del sistema (clic derecho → Quit Ollama), espera unos segundos, y vuelve a intentar. A veces el proceso de fondo tiene el archivo bloqueado.

## Ver cuánto espacio ocupan los modelos
```powershell
ollama list
```
(la columna SIZE te muestra el tamaño de cada uno)

## Ejecutar un modelo con un prompt de un archivo de texto
Esta es la forma correcta de mandar un prompt largo sin que PowerShell rompa las comillas:
```powershell
ollama run nombre-del-modelo "$(Get-Content ruta\al\prompt.txt -Raw)"
```
Ejemplo:
```powershell
ollama run mistral "$(Get-Content medicina_interna_media.txt -Raw)"
```

## Medir cuánto tarda un modelo en responder
```powershell
Measure-Command { ollama run mistral "$(Get-Content medicina_interna_media.txt -Raw)" }
```

## Forzar salida en JSON (parámetro extra que puede mejorar el cumplimiento del formato)
Usando la API directamente en vez del CLI:
```powershell
curl.exe http://localhost:11434/api/generate -d "{\"model\": \"mistral\", \"prompt\": \"tu prompt aqui\", \"format\": \"json\", \"stream\": false}"
```

## Ver si Ollama está corriendo
```powershell
Get-Process ollama* -ErrorAction SilentlyContinue
```

## Cerrar Ollama completamente
1. Bandeja del sistema (flechita `^` junto al reloj) → clic derecho en el ícono de Ollama → **Quit Ollama**
2. O por comando:
```powershell
Stop-Process -Name ollama -Force -ErrorAction SilentlyContinue
```

## Correr TODAS las pruebas automáticamente (todos los modelos x todos los prompts)
1. Asegúrate de tener descargados todos los modelos que quieras probar (ver arriba `ollama pull`)
2. Copia el archivo `ejecutar_pruebas.ps1` en la misma carpeta donde están los 15 archivos `.txt` de prompts
3. Abre PowerShell en esa carpeta y ejecuta:
```powershell
.\ejecutar_pruebas.ps1
```
4. Esto va a generar una carpeta `resultados` con:
   - Un archivo `.txt` por cada combinación modelo+prompt, con la respuesta completa y el tiempo que tardó
   - Un archivo `resumen_tiempos.csv` con todos los tiempos, listo para abrir en Excel

> Nota: si nunca has ejecutado scripts `.ps1` en tu PC, puede que PowerShell lo bloquee por política de seguridad. Si pasa eso, ejecuta esto una sola vez (te va a pedir confirmar con "S"):
> ```powershell
> Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
> ```
