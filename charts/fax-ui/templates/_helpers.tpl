{{- define "fax-ui.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "fax-ui.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "fax-ui.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Auth secret name helper
*/}}
{{- define "fax-ui.authSecretName" -}}
{{- .Values.existingAuthSecret.name | default (printf "%s-auth" (include "fax-ui.fullname" .)) -}}
{{- end -}}

{{/*
Ngrok secret name helper
*/}}
{{- define "fax-ui.ngrokSecretName" -}}
{{- .Values.ngrok.existingSecret.name | default (printf "%s-ngrok" (include "fax-ui.fullname" .)) -}}
{{- end -}}
