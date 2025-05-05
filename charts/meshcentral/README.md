# MeshCentral Helm Chart

This Helm chart deploys MeshCentral, a remote management platform, on Kubernetes.

## Chart Details

- **Chart Name**: `meshcentral`
- **Version**: `0.3.0`
- **App Version**: `1.1.44`
- **Description**: A Helm chart for deploying MeshCentral.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- Persistent storage provisioner for PVC (if persistence is enabled)

## Installation

To install the chart with the release name `my-meshcentral`:

```sh
helm install my-release wrsys/meshcentral
```

## Configuration

The following table lists the configurable parameters of the MeshCentral chart and their default values:

| Parameter                          | Description                                                                 | Default                     |
|------------------------------------|-----------------------------------------------------------------------------|-----------------------------|
| `meshcentral.image.repository`    | MeshCentral image repository                                               | `ghcr.io/ylianst/meshcentral` |
| `meshcentral.image.tag`           | MeshCentral image tag                                                      | `""`                      |
| `meshcentral.image.pullPolicy`    | Image pull policy                                                          | `IfNotPresent`             |
| `meshcentral.databaseType`        | Database type to use (`none`, `mariadb`, `mysql`, `postgres`, `sqlite3`, `acebase`) | `none`                     |
| `meshcentral.config.settings`     | MeshCentral configuration settings in YAML format                          | `{}`                       |
| `meshcentral.config.domains`      | Domain-specific configuration                                              | See `values.yaml`          |
| `meshcentral.database.mariadb`    | MariaDB database configuration                                             | See `values.yaml`          |
| `meshcentral.database.mysql`      | MySQL database configuration                                               | See `values.yaml`          |
| `meshcentral.database.postgres`   | PostgreSQL database configuration                                          | See `values.yaml`          |
| `meshcentral.database.mongodb`    | MongoDB database configuration                                             | See `values.yaml`          |
| `meshcentral.database.sqlite`     | SQLite database configuration                                              | See `values.yaml`          |
| `resources.requests`              | Resource requests for the MeshCentral container                            | `{ cpu: 100m, memory: 256Mi }` |
| `resources.limits`                | Resource limits for the MeshCentral container                              | `{ cpu: 500m, memory: 512Mi }` |
| `service.type`                    | Kubernetes service type                                                    | `ClusterIP`                |
| `service.port`                    | Service port                                                               | `443`                      |
| `ingress.enabled`                 | Enable ingress                                                             | `false`                    |
| `ingress.hosts`                   | Ingress hosts configuration                                                | See `values.yaml`          |
| `persistence.enabled`             | Enable persistence                                                         | `false`                    |
| `persistence.size`                | Size of the persistent volume                                              | `10Gi`                     |

## Notes on Configuration

MeshCentral has a wide range of configuration options. To simplify the `values.yaml` file, users can add any additional configuration options in YAML format under `meshcentral.config.settings`. This allows for flexibility in customizing MeshCentral without modifying the chart itself.

For example, to add a custom plugin configuration:

```yaml
meshcentral:
  config:
    settings:
      plugins:
        customPlugin: true
```

## Persistence

If persistence is enabled, the chart will create a PersistentVolumeClaim (PVC) to store MeshCentral data. Ensure that your cluster has a storage class configured.

## Ingress

To enable ingress, set `ingress.enabled` to `true` and configure the `ingress` section in `values.yaml`. Example:

```yaml
ingress:
  enabled: true
  host:
    - host: meshcentral.example.com
      paths:
        - path: /
          pathType: ImplementationSpecific
```

## Database Configuration

MeshCentral supports multiple database backends, including MariaDB, MySQL, PostgreSQL, and SQLite. Configure the database settings in the `values.yaml` file under the `meshcentral.database` section.

## Uninstallation

To uninstall the chart:

```bash
helm uninstall my-meshcentral
```

This command removes all Kubernetes components associated with the chart and deletes the release.

## License

This Helm chart is licensed under the Apache License 2.0. See the [LICENSE](../../LICENSE) file for details.