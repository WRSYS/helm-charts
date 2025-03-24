# Cloudflare Tunnel Helm Chart

This Helm chart creates a `cloudflared` deployment, which sets up a reverse tunnel for an environment.

## Prerequisites

- Kubernetes 1.16+
- Helm 3.0+

## Installation

To install the chart with the release name `my-release`:

```sh
helm install my-release wrsys/cloudflare-tunnel
```

## Configuration

The following table lists the configurable parameters of the Cloudflare Tunnel chart and their default values.

| Parameter                         | Description                                      | Default                        |
| --------------------------------- | ------------------------------------------------ | ------------------------------ |
| `cloudflare.account`              | Your Cloudflare account number                   | `""`                           |
| `cloudflare.tunnelName`           | The name of the tunnel this instance will serve  | `""`                           |
| `cloudflare.tunnelId`             | The ID of the above tunnel                       | `""`                           |
| `cloudflare.secret`               | The secret for the tunnel                        | `""`                           |
| `cloudflare.secretName`           | The secret name for the credentials              | `null`                         |
| `cloudflare.enableWarp`           | Enable WARP routing for TCP                      | `false`                        |
| `cloudflare.ingress`              | Ingress rules for the tunnel                     | `[]`                           |
| `image.repository`                | Image repository                                 | `cloudflare/cloudflared`       |
| `image.pullPolicy`                | Image pull policy                                | `IfNotPresent`                 |
| `image.tag`                       | Image tag                                        | `""`                           |
| `replicaCount`                    | Number of replicas                               | `2`                            |
| `serviceAccount.annotations`      | Annotations for the service account              | `{}`                           |
| `serviceAccount.name`             | Name of the service account                      | `""`                           |
| `podAnnotations`                  | Annotations for the pod                          | `{}`                           |
| `podLabels`                       | Labels for the pod                               | `{}`                           |
| `podSecurityContext`              | Security context for the pod                     | `{ runAsNonRoot: true, runAsUser: 65532 }` |
| `securityContext`                 | Security context for the container               | `{ allowPrivilegeEscalation: false, capabilities: { drop: [ALL] }, readOnlyRootFilesystem: true }` |
| `resources`                       | Resource requests and limits                     | `{}`                           |
| `nodeSelector`                    | Node selector                                    | `{}`                           |
| `tolerations`                     | Tolerations                                      | `[]`                           |
| `affinity`                        | Affinity                                         | `{}`                           |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example:

```sh
helm install my-release wrsys/cloudflare-tunnel --set cloudflare.tunnel_token=your-token
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```sh
helm install my-release wrsys/cloudflare-tunnel -f values.yaml
```

## Uninstallation

To uninstall/delete the `my-release` deployment:

```sh
helm uninstall my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## License

This project is licensed under the Apache 2.0 License. See the [LICENSE](../../LICENSE) file for details.