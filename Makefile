install-sealed-secrets:
	helm upgrade --install bb-sealed-secrets sealed-secrets --repo https://bitnami-labs.github.io/sealed-secrets --version 2.16.2 --namespace kube-system
uninstall-sealed-secrets:
	helm uninstall bb-sealed-secrets -n kube-system

install-nginx:
	helm upgrade --install ingress-nginx ingress-nginx \
  		--repo https://kubernetes.github.io/ingress-nginx \
  		--namespace ingress-nginx --create-namespace
uninstall-nginx:
	helm uninstall ingress-nginx -n ingress-nginx

install-argocd:
	helm upgrade --install bb-argocd argo-cd --repo https://argoproj.github.io/argo-helm --namespace argocd --create-namespace --values argocd/values-argo.yaml

uninstall-argocd:
	helm uninstall bb-argocd -n argocd

port-forward:
	kubectl port-forward service/bb-argocd-server -n argocd 8100:443

apply-core-api:
	kubectl apply -f argocd/app-bb-core-api.yaml

apply-product-server:
	kubectl apply -f argocd/app-bb-product-server.yaml

apply-all: apply-core-api apply-product-server