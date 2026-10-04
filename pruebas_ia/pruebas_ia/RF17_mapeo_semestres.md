# RF17 — Ajuste de Dificultad por IA según Semestre Académico

Este documento define cómo el sistema debe adaptar la generación de casos clínicos
según el semestre académico del grupo de estudiantes, cubriendo las 3 dimensiones
exigidas por el requerimiento:

1. Complejidad clínica del caso
2. Lenguaje técnico del paciente estandarizado
3. Criterios de la rúbrica de evaluación

Carrera de Medicina: 10 semestres.

---

## Semestre 1
- **Etapa:** Ciclo básico inicial
- **Categoría derivada:** BAJA
- **Complejidad clínica:** Enfoque en anatomía, fisiología normal y signos vitales. Sin diagnóstico diferencial. Un solo sistema corporal a la vez.
- **Lenguaje del paciente:** Muy simple, cotidiano, sin ningún término médico ("me duele la panza", "no puedo respirar bien").
- **Criterios de rúbrica:** Identificar estructuras anatómicas, reconocer signos vitales normales vs. anormales, técnica correcta de exploración física básica.

## Semestre 2
- **Etapa:** Ciclo básico inicial
- **Categoría derivada:** BAJA
- **Complejidad clínica:** Reconocimiento de signos y síntomas evidentes de un cuadro típico y común. Un único sistema afectado.
- **Lenguaje del paciente:** Simple, cotidiano, puede repetir alguna palabra que escuchó de un médico pero sin entenderla bien.
- **Criterios de rúbrica:** Toma correcta de signos vitales, anamnesis básica ordenada, identificación de síntomas principales.

## Semestre 3
- **Etapa:** Ciclo básico avanzado
- **Categoría derivada:** BAJA
- **Complejidad clínica:** Cuadros típicos con 2-3 síntomas relacionados, sin comorbilidades. Introducción a semiología por sistemas.
- **Lenguaje del paciente:** Simple, con alguna expresión coloquial regional. Puede describir intensidad/duración del síntoma.
- **Criterios de rúbrica:** Semiología correcta del sistema evaluado, orden lógico de la anamnesis, comunicación empática básica.

## Semestre 4
- **Etapa:** Ciclo básico avanzado
- **Categoría derivada:** BAJA
- **Complejidad clínica:** Cuadros típicos con hallazgos físicos claros. Se introduce un diagnóstico diferencial simple (2 opciones).
- **Lenguaje del paciente:** Simple, puede mencionar antecedentes familiares básicos si se le pregunta.
- **Criterios de rúbrica:** Elaboración de hipótesis diagnóstica simple, examen físico dirigido, registro correcto de hallazgos.

## Semestre 5
- **Etapa:** Ciclo clínico inicial
- **Categoría derivada:** MEDIA
- **Complejidad clínica:** Cuadro clínico con algunos hallazgos que requieren razonamiento adicional. Diagnóstico diferencial de al menos 2-3 opciones plausibles.
- **Lenguaje del paciente:** Semi-técnico; puede repetir términos médicos escuchados previamente ("me dijeron que tengo la presión alta").
- **Criterios de rúbrica:** Formulación de diagnóstico diferencial, justificación clínica de hallazgos, solicitud pertinente de exámenes complementarios básicos.

## Semestre 6
- **Etapa:** Ciclo clínico inicial
- **Categoría derivada:** MEDIA
- **Complejidad clínica:** Caso con comorbilidad leve o antecedente relevante que debe considerarse. Diagnóstico diferencial más amplio.
- **Lenguaje del paciente:** Semi-técnico, puede tener ansiedad o preocupación explícita sobre su condición.
- **Criterios de rúbrica:** Integración de antecedentes con cuadro actual, priorización de diagnósticos diferenciales, plan diagnóstico inicial coherente.

## Semestre 7
- **Etapa:** Ciclo clínico avanzado
- **Categoría derivada:** MEDIA
- **Complejidad clínica:** Presentación clínica con cierta atipicidad o superposición de síntomas entre 2 posibles diagnósticos. Requiere descartar activamente alternativas.
- **Lenguaje del paciente:** Técnico moderado, el paciente puede citar mal información médica previa (mala interpretación).
- **Criterios de rúbrica:** Razonamiento clínico para descartar diagnósticos, plan de manejo inicial, comunicación de hallazgos al paciente.

## Semestre 8
- **Etapa:** Ciclo clínico avanzado
- **Categoría derivada:** MEDIA-ALTA
- **Complejidad clínica:** Caso con comorbilidades relevantes que modifican el manejo. Diagnóstico diferencial amplio con al menos una entidad menos frecuente.
- **Lenguaje del paciente:** Técnico moderado-alto, referencia tratamientos previos y medicación actual con nombres (aunque imprecisos).
- **Criterios de rúbrica:** Plan de tratamiento considerando comorbilidades, priorización de estudios complementarios, análisis de riesgo-beneficio.

## Semestre 9
- **Etapa:** Internado
- **Categoría derivada:** ALTA
- **Complejidad clínica:** Presentación atípica, múltiples comorbilidades, requiere descartar varios diagnósticos diferenciales antes de llegar al correcto. Puede incluir hallazgos contradictorios o distractores.
- **Lenguaje del paciente:** Técnico, el paciente puede tener conocimiento médico previo (por trabajo o enfermedad crónica) y usar terminología real.
- **Criterios de rúbrica:** Razonamiento clínico avanzado, plan de tratamiento completo y escalonado, manejo de incertidumbre diagnóstica, comunicación de malas noticias si aplica.

## Semestre 10
- **Etapa:** Internado
- **Categoría derivada:** ALTA
- **Complejidad clínica:** Caso complejo tipo "emergencia" o de alta complejidad diagnóstica/terapéutica, con comorbilidades múltiples y necesidad de trabajo interdisciplinario.
- **Lenguaje del paciente:** Técnico avanzado o, alternativamente, familiar/acompañante con alta carga emocional que el estudiante debe manejar junto con la parte clínica.
- **Criterios de rúbrica:** Manejo integral del caso, toma de decisiones bajo presión/tiempo, plan de tratamiento completo con seguimiento, competencias de comunicación avanzada.

---

## Resumen de la categoría derivada (para compatibilidad con TipoDificultad existente)

| Rango de semestre | TipoDificultad |
|---|---|
| 1 - 4 | BAJA |
| 5 - 8 | MEDIA |
| 9 - 10 | ALTA |

> Nota: esta tabla resumen es la que permite que el backend siga usando el enum
> `TipoDificultad` (BAJA/MEDIA/ALTA) sin rediseñar el dominio, mientras que el
> parámetro real que se envía a la IA para generar el caso es el `semestreAcademico`
> (1-10), que es el que efectivamente ajusta las 3 dimensiones exigidas por el RF17.
