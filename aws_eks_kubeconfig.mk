_AWS_EKS_KUBECONFIG_MK_VERSION= $(_AWS_EKS_MK_VERSION)

# EKS_KUBECONFIG_CLUSTER_NAME?= my-cluster
# EKS_KUBECONFIG_CONTEXT_NAME?= arn:aws:eks:us-east-1:123456789012:cluster/my-cluster
EKS_KUBECONFIG_DIRPATH?= $(HOME)/.kube/
# EKS_KUBECONFIG_ENDPOINT_CA64?= <base64-encoded-ca-cert>
# EKS_KUBECONFIG_ENDPOINT_URL?=
EKS_KUBECONFIG_FILENAME?= config
# EKS_KUBECONFIG_NAME?= my-name
# EKS_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config-clustername
# EKS_KUBECONFIGS_DIRPATH?= $(HOME)/.kube/
EKS_KUBECONFIGS_REGEX?= config*
# EKS_KUBECONFIGS_SET_NAME?= kubeconfigs@dirpath@regex

# Derived parameters
EKS_KUBECONFIG_CLUSTER_NAME?= $(EKS_CLUSTER_NAME)
EKS_KUBECONFIG_CONTEXT_NAME?= arn:aws:eks:$(EKS_REGION_ID):$(EKS_ACCOUNT_ID):cluster/$(EKS_KUBECONFIG_CLUSTER_NAME)
EKS_KUBECONFIG_ENDPOINT_CA64?= $(EKS_CLUSTER_ENDPOINT_CA64)
EKS_KUBECONFIG_ENDPOINT_URL?= $(EKS_CLUSTER_ENDPOINT_URL)
EKS_KUBECONFIG_FILEPATH?= $(EKS_KUBECONFIG_DIRPATH)$(EKS_KUBECONFIG_FILENAME)
EKS_KUBECONFIG_NAME?= $(EKS_KUBECONFIG_FILENAME)
EKS_KUBECONFIGS_DIRPATH?= $(EKS_KUBECONFIG_DIRPATH)
EKS_KUBECONFIGS_SET_NAME?= kubeconfigs@$(EKS_KUBECONFIGS_DIRPATH)@$(EKS_KUBECONFIGS_REGEX)

# Option parameters
__EKS_CLUSTER__KUBECONFIG= --cluster=$(EKS_KUBECONFIG_CLUSTER_NAME)
__EKS_KUBECONFIG= --kubeconfig=$(EKS_KUBECONFIG_FILEPATH)
__EKS_NAME__KUBECONFIG= --name=$(EKS_KUBECONFIG_CLUSTER_NAME)

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_eks_view_framework_macros ::
	@echo 'AWS::EKS::Kubeconfig ($(_AWS_EKS_KUBECONFIG_MK_VERSION)) macros:'
	@echo

_eks_view_framework_parameters ::
	@echo 'AWS::EKS::Kubeconfig ($(_AWS_EKS_KUBECONFIG_MK_VERSION)) parameters:'
	@echo '    EKS_KUBECONFIG_CLUSTER_NAME=$(EKS_KUBECONFIG_CLUSTER_NAME)'
	@echo '    EKS_KUBECONFIG_CONTEXT_NAME=$(EKS_KUBECONFIG_CONTEXT_NAME)'
	@echo '    EKS_KUBECONFIG_DIRPATH=$(EKS_KUBECONFIG_DIRPATH)'
	@echo '    EKS_KUBECONFIG_ENDPOINT_CA64=$(EKS_KUBECONFIG_ENDPOINT_CA64)'
	@echo '    EKS_KUBECONFIG_ENDPOINT_URL=$(EKS_KUBECONFIG_ENDPOINT_URL)'
	@echo '    EKS_KUBECONFIG_FILENAME=$(EKS_KUBECONFIG_FILENAME)'
	@echo '    EKS_KUBECONFIG_FILEPATH=$(EKS_KUBECONFIG_FILEPATH)'
	@echo '    EKS_KUBECONFIG_NAME=$(EKS_KUBECONFIG_NAME)'
	@echo '    EKS_KUBECONFIGS_DIRPATH=$(EKS_KUBECONFIGS_DIRPATH)'
	@echo '    EKS_KUBECONFIGS_REGEX=$(EKS_KUBECONFIGS_REGEX)'
	@echo '    EKS_KUBECONFIGS_SET_NAME=$(EKS_KUBECONFIGS_SET_NAME)'
	@echo

_eks_view_framework_targets ::
	@echo 'AWS::EKS::Kubeconfig ($(_AWS_EKS_KUBECONFIG_MK_VERSION)) targets:'
	@echo '    create_kubeconfig             - Create the kubeconfig for a cluster'
	@echo '    show_kubeconfig               - Show everything related to a kubeconfig'
	@echo '    show_kubeconfig_content       - Show content of to a kubeconfig'
	@echo '    show_kubeconfig_description   - Show description of to a kubeconfig'
	@echo '    update_kubeconfig             - Update the kubeconfig for a cluster'
	@echo '    view_kubeconfigs              - View ALL kubeconfigs'
	@echo '    view_kubeconfigs_set          - View a set of kubeconfigs'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

# Source @ https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html
define EKS_KUBECONFIG_CONTENT
apiVersion: v1
clusters:
- cluster:
    server: $(EKS_KUBECONFIG_ENDPOINT_URL)
    certificate-authority-data: $(EKS_KUBECONFIG_ENDPOINT_CA64)
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "$(EKS_KUBECONFIG_CLUSTER_NAME)"
        # - "-r"
        # - "<role-arn>"
      # env:
        # - name: AWS_PROFILE
        #   value: "<aws-profile>"
endef
export EKS_KUBECONFIG_CONTENT
_eks_create_kubeconfig:
	@$(INFO) '$(EKS_UI_LABEL)Creating kubeconfig "$(EKS_KUBECONFIG_NAME)" ...'; $(NORMAL)
	mkdir -p $(EKS_KUBECONFIG_DIRPATH)
	echo "$${EKS_KUBECONFIG_CONTENT}" > $(EKS_KUBECONFIG_FILEPATH)

_eks_show_kubeconfig: _eks_show_kubeconfig_content _eks_show_kubeconfig_description

_eks_show_kubeconfig_content:
	@$(INFO) '$(EKS_UI_LABEL)Showing content of kubeconfig "$(EKS_KUBECONFIG_NAME)" ...'; $(NORMAL)
	cat $(EKS_KUBECONFIG_FILEPATH)

_eks_show_kubeconfig_description:
	@$(INFO) '$(EKS_UI_LABEL)Showing description of kubeconfig "$(EKS_KUBECONFIG_NAME)" ...'; $(NORMAL)
	ls -al $(EKS_KUBECONFIG_FILEPATH)

_eks_update_kubeconfig:
	@$(INFO) '$(EKS_UI_LABEL)Updating kubeconfig "$(EKS_KUBECONFIG_NAME)" ...'; $(NORMAL)
	$(AWS) eks update-kubeconfig $(__EKS_KUBECONFIG) $(__EKS_NAME__KUBECONFIG)

_eks_view_kubeconfigs:
	@$(INFO) '$(EKS_UI_LABEL)Viewing ALL kubeconfigs ...'; $(NORMAL)
	ls -al $(EKS_KUBECONFIGS_DIRPATH)

_eks_view_kubeconfigs_set:
	@$(INFO) '$(EKS_UI_LABEL)Viewing kubeconfigs-set "$(EKS_KUBECONFIGS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Kubeconfigs are grouped based on the provided dirpath and regex'; $(NORMAL)
	ls -al $(EKS_KUBECONFIGS_DIRPATH)$(EKS_KUBECONFIGS_REGEX)
