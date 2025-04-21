# MeshCentral Helm Chart

This Helm chart is used to deploy [MeshCentral](https://meshcentral.com/), a powerful remote management web application, on Kubernetes.

## Chart Details

- **Chart Name**: `meshcentral`
- **Version**: `0.2.0`
- **App Version**: `1.1.43`
- **Description**: A Helm chart for deploying MeshCentral.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- Persistent storage provisioner for PVC (if persistence is enabled)

## Installation

To install the chart with the release name `my-meshcentral`:

```bash
helm repo add my-repo https://example.com/charts
helm install my-meshcentral my-repo/meshcentral
```

## Configuration

The following table lists the configurable parameters of the MeshCentral chart and their default values.

| Parameter                          | Description                                      | Default                          |
|------------------------------------|--------------------------------------------------|----------------------------------|
| `meshcentral.image.repository`     | MeshCentral image repository                     | `ghcr.io/ylianst/meshcentral`   |
| `meshcentral.image.tag`            | MeshCentral image tag                            | `""` (uses `appVersion`)        |
| `meshcentral.image.pullPolicy`     | Image pull policy                                | `IfNotPresent`                  |
| `meshcentral.service.type`         | Kubernetes service type                          | `ClusterIP`                     |
| `meshcentral.service.port`         | Service port                                     | `443`                           |
| `meshcentral.config.settings`      | MeshCentral configuration settings               | See `values.yml` for details    |
| `meshcentral.database`             | Database configuration                           | See `values.yml` for details    |
| `ingress.enabled`                  | Enable ingress                                   | `false`                         |
| `persistence.enabled`              | Enable persistence                               | `false`                         |
| `persistence.size`                 | PVC storage size                                 | `10Gi`                          |
| `persistence.accessModes`          | PVC access modes                                 | `ReadWriteMany`                 |

For a full list of configurable parameters, refer to the `values.yml` file.

## Persistence

If persistence is enabled, the chart will create a PersistentVolumeClaim (PVC) to store MeshCentral data. Ensure that your cluster has a storage class configured.

## Ingress

To enable ingress, set `ingress.enabled` to `true` and configure the `ingress` section in `values.yml`. Example:

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

MeshCentral supports multiple database backends, including MariaDB, MySQL, PostgreSQL, and SQLite. Configure the database settings in the `values.yml` file under the `meshcentral.database` section.

## Uninstallation

To uninstall the chart:

```bash
helm uninstall my-meshcentral
```

This command removes all Kubernetes components associated with the chart and deletes the release.

## License

This Helm chart is licensed under the Apache License 2.0. See the [LICENSE](../../LICENSE) file for details.