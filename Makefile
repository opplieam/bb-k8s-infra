install-argocd:
	helm upgrade --install local-argocd argo-cd --repo https://argoproj.github.io/argo-helm --namespace argocd --create-namespace --values argocd/values-argo.yaml

uninstall-argocd:
	helm uninstall local-argocd -n argocd

port-forward:
	kubectl port-forward service/local-argocd-server -n argocd 8100:443