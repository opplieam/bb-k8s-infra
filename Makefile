# --------------- Controller --------------
# DON'T FORGET TO SET STATIC IP FOR INGRESS NGINX 

STATIC_IP := ""

ns:
	kubectl apply -f k8s/namespace.yaml

install-sealed-secrets:
	helm upgrade --install bb-sealed-secrets sealed-secrets \
	--repo https://bitnami-labs.github.io/sealed-secrets --version 2.16.2 \
	--namespace kube-system

uninstall-sealed-secrets:
	helm uninstall bb-sealed-secrets -n kube-system

install-nginx:
	helm upgrade --install ingress-nginx ingress-nginx \
  		--repo https://kubernetes.github.io/ingress-nginx \
  		--namespace ingress-nginx --create-namespace
install-nginx-static:
	helm upgrade --install ingress-nginx ingress-nginx \
  		--repo https://kubernetes.github.io/ingress-nginx \
  		--namespace ingress-nginx --create-namespace \
		--set controller.service.loadBalancerIP=$(STATIC_IP)
uninstall-nginx:
	helm uninstall ingress-nginx -n ingress-nginx

install-cert-manager:
	helm repo add jetstack https://charts.jetstack.io
	helm repo update
	helm install cert-manager jetstack/cert-manager \
	--namespace cert-manager --create-namespace \
	--set crds.enabled=true

install-issuer:
	kubectl apply -f cert-manager/issuer.yaml

uninstall-cert-manager:
	helm uninstall cert-manager -n cert-manager

install-argocd:
	helm upgrade --install bb-argocd argo-cd --repo https://argoproj.github.io/argo-helm --namespace argocd --create-namespace --values argocd/values-argo.yaml

uninstall-argocd:
	helm uninstall bb-argocd -n argocd


initial-dev: ns install-sealed-secrets install-nginx
initial-static: ns install-sealed-secrets install-nginx-static install-cert-manager install-issuer

# --------------- Utils --------------

port-forward-argo:
	kubectl port-forward service/bb-argocd-server -n argocd 8100:443


# --------------- Manifest --------------


apply-core-api:
	kubectl apply -f argocd/app-bb-core-api.yaml

apply-product-server:
	kubectl apply -f argocd/app-bb-product-server.yaml

apply-all: apply-core-api apply-product-server