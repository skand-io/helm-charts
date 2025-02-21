{{/*
Expand the name of the chart.
*/}}
{{- define "skand-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "skand-app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- /*
  Processes a value based on its type and content.

  - For strings:
    - If the string contains template markers `{{` and `}}`, it is evaluated as a template using `tpl`.
    - Otherwise, the string is returned as-is.
  - For non-strings, the value is converted to YAML format.

  Parameters:
  - `value`: The value to process. Can be a string or other type.
  - `context`: The context for template evaluation, typically the current context (`$`).

  Usage:
  - Use this function to handle values that may be templates or other types in Helm templates.
*/ -}}
{{- define "processTemplateValue" -}}
{{- $value := .value -}}
{{- $context := .context -}}
{{- if and
  (eq (typeOf $value) "string")
  (contains "{{" $value)
  (contains "}}" $value)
}}
  {{- tpl $value $context | quote -}}
{{- else }}
  {{- $value | toYaml -}}
{{- end }}
{{- end }}
