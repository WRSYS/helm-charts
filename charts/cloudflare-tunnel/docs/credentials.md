# Cloudflare Tunnel — Credentials

The chart supports three ways to provide tunnel credentials, evaluated in order of precedence.
cloudflared expects a `credentials.json` file at `/etc/cloudflared/creds/credentials.json`.

## 1. Inline values (chart creates the Secret)

Supply `cloudflare.account`, `cloudflare.tunnelId`, and `cloudflare.secret`. The chart renders a
`credentials.json` Secret automatically. No other configuration is needed.

```yaml
cloudflare:
  account: "your-account-tag"
  tunnelId: "your-tunnel-id"
  secret: "your-tunnel-secret"
```

## 2. Pre-existing Secret (`cloudflare.secretName`)

Point the chart at a Secret you manage externally (e.g. via External Secrets Operator, Helm secret
management, or manual creation). The Secret must contain a key named `credentials.json`.

```yaml
cloudflare:
  secretName: my-cloudflare-secret
```

## 3. Custom volume source (`cloudflare.credentialsVolume`)

Override the entire `creds` volume source. Use this when credentials are provided by a CSI driver,
sidecar injector, or any other mechanism. The value is passed through verbatim as the Kubernetes
volume source. `secretName` is ignored and no Secret is created from inline values when this is set.

Any valid Kubernetes volume source type can be used. See the [Kubernetes volumes documentation](https://kubernetes.io/docs/concepts/storage/volumes/).

**Rollout on credential rotation:** when `credentialsVolume` is set, the chart does not include a
`checksum/secret` pod annotation, so credential changes will not automatically restart the pod.

### Example A — Secrets Store CSI driver

Works with Azure Key Vault, AWS Secrets Manager, GCP Secret Manager, and HashiCorp Vault via the
[Secrets Store CSI Driver](https://secrets-store-csi-driver.sigs.k8s.io/). Requires a
`SecretProviderClass` resource to be deployed separately. The SPC must expose the credential
under the key `credentials.json`.

```yaml
cloudflare:
  credentialsVolume:
    csi:
      driver: secrets-store.csi.k8s.io
      readOnly: true
      volumeAttributes:
        secretProviderClass: cloudflare-tunnel-spc
```

### Example B — hostPath (local file)

Use a `hostPath` volume to mount a credentials file that already exists on the node's filesystem.
This is useful for local development (e.g. a file created by `cloudflared tunnel login`) or
single-node environments where you control the node directly.

`cloudflared tunnel login` stores credentials as `~/.cloudflared/<tunnel-id>.json`. The chart
expects the file to be named `credentials.json` inside the mounted directory, so copy it first:

```sh
mkdir -p /etc/cloudflared/creds
cp ~/.cloudflared/*.json /etc/cloudflared/creds/credentials.json
```

> If you have multiple tunnel credential files in `~/.cloudflared/`, specify the file explicitly
> rather than using the glob.

```yaml
cloudflare:
  credentialsVolume:
    hostPath:
      path: /etc/cloudflared/creds
      type: Directory
```

> **Warning:** `hostPath` volumes are node-scoped. Not recommended for production or multi-node clusters.

> **Local dev — file permissions:** the pod runs as UID `65532` by default. If the credential files
> are owned by your local user, the pod will fail to read them. Either transfer ownership of the
> files to UID `65532` on the node:
>
> ```sh
> chown -R 65532 /etc/cloudflared/creds
> ```
>
> Or override `runAsUser` at install time to match your local UID instead:
>
> ```sh
> helm upgrade --install my-release ./charts/cloudflare-tunnel \
>   --set podSecurityContext.runAsUser=$(id -u)
> ```
