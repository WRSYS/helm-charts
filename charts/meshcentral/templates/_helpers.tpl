{{/*
Expand the full name
*/}}
{{- define "meshcentral.fullname" -}}
{{- printf "%s" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Database Validation
*/}}
{{- define "meshcentral.validateDatabase" -}}
{{- $valid := list "none" "mariadb" "mysql" "postgres" "sqlite3" "acebase" }}
{{- if not (has .Values.meshcentral.databaseType $valid) }}
{{- fail (printf "Invalid databaseType '%s'. Allowed values: %s" .Values.meshcentral.databaseType (join ", " $valid)) }}
{{- end }}
{{- end }}
