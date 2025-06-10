# azure-keyvault

This Helm chart deploys a shared `SecretProviderClass` resource for integrating
Azure Key Vault secrets with Kubernetes workloads via the CSI driver.

## Usage

- This chart is **standalone**.
- Deploy it **once per cluster** (or per namespace) to create the required `SecretProviderClass`.
- Other application charts (e.g., microservices) should **not** include this chart as a dependency.
- Instead, they should reference the existing `SecretProviderClass` by name in their `volumeAttributes`.

## Example Installation

```bash
helm install azure-keyvault ./azure-keyvault -n csi-secrets
