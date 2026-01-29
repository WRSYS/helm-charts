# Changelog

## [0.2.0]
### Added
- Health probes (liveness and readiness) for better Kubernetes integration
- Pod and container security contexts (runAsNonRoot, drop ALL capabilities, readOnlyRootFilesystem)
- Authentication support with password and OAuth providers (Google, Microsoft, GitHub)
- `auth.password`, `auth.sessionSecret` for simple password authentication
- `auth.google`, `auth.microsoft`, `auth.github` for OAuth configuration
- `existingAuthSecret` to reference pre-existing auth secrets
- `env.faxApplicationId` for Telnyx fax application settings management
- `NOTES.txt` template for post-install instructions
- `secret-auth.yaml` template for authentication secrets
- Temporary volume mount for `/tmp` when using readOnlyRootFilesystem
- Node selector, affinity, and tolerations support in deployment

### Changed
- Removed duplicate command-line args (now using environment variables only)
- Improved deployment template structure and readability

### Fixed
- Added missing `nodeSelector`, `affinity`, and `tolerations` to deployment spec

## [0.1.0]
### Changed
- Initial Version