# Contrato JSON actualizado — incluye RF17 (Ajuste de Dificultad por IA)

## Cambios respecto al contrato original

Se agregan dos campos nuevos para cumplir el RF17:

- `semestreAcademico` (entero, 1-10): parámetro real que controla la generación.
- `criteriosRubrica` (arreglo de strings): criterios de evaluación adaptados al nivel del estudiante.

El campo `dificultad` se mantiene por compatibilidad con el dominio ya definido
(TipoDificultad: BAJA/MEDIA/ALTA), pero ahora se calcula a partir del semestre
según la tabla de RF17_mapeo_semestres.md. No se le pide a la IA que lo invente
libremente; se le indica cuál corresponde según el semestre recibido.

## Estructura completa

```json
{
  "titulo": "string",
  "especialidad": "string",
  "semestreAcademico": 0,
  "dificultad": "BAJA|MEDIA|ALTA",
  "descripcion": "string",
  "objetivoClinico": "string",
  "anamnesis": "string",
  "hallazgos": ["string", "string"],
  "diagnosticosPosibles": ["string", "string"],
  "criteriosRubrica": ["string", "string"],
  "pacienteEstandarizado": {
    "nombre": "string",
    "edad": 0,
    "guion": "string",
    "nivelLenguaje": "BASICO|INTERMEDIO|TECNICO"
  }
}
```

## Notas de cada campo nuevo

- **semestreAcademico**: número entero del 1 al 10. Es el dato que el docente
  selecciona en el frontend y el que realmente se envía al prompt de la IA.
- **criteriosRubrica**: lista de 2 a 5 criterios de evaluación, redactados acorde
  al nivel del semestre (ver ejemplos en RF17_mapeo_semestres.md, sección
  "Criterios de rúbrica" de cada semestre).
- **nivelLenguaje**: etiqueta que indica qué tan técnico debe sonar el guion del
  paciente estandarizado. Se deriva del semestre:
  - Semestres 1-4 → BASICO
  - Semestres 5-8 → INTERMEDIO
  - Semestres 9-10 → TECNICO

## Compatibilidad con el backend (Persona 1)

Si el dominio ya tiene `CasoClinico` con campo `dificultad: TipoDificultad`, no
hace falta romper esa estructura. Basta con:
1. Agregar `semestreAcademico: Integer` como nuevo atributo de `CasoClinico`.
2. Agregar `criteriosRubrica: List<String>` (o una entidad `CriterioRubrica` si
   se prefiere relacional).
3. En el caso de uso `GenerarCasoClinico`, calcular `dificultad` a partir de
   `semestreAcademico` usando la tabla de mapeo antes de guardar, en vez de
   pedirle a la IA que decida la dificultad libremente.
