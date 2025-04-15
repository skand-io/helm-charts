upgrade:
	helm upgrade --install -n observability --wait lgtm . --values values.yaml

install:
	helm install lgtm . -n observability --values values.yaml

uninstall:
	helm uninstall lgtm --namespace observability
