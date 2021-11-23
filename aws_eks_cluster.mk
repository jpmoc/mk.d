_AWS_EKS_CLUSTER_MK_VERSION= $(_AWS_EKS_MK_VERSION)

# EKS_CLUSTER_ARN?= arn:aws:eks:us-east-1:123456789012:cluster/Xlb-contour
# EKS_CLUSTER_ENDPOINT_CA64?= certificate-authority-base64
# EKS_CLUSTER_ENDPOINT_URL?= https://1B1D75EFC07CF5C1653B0EC3E2588B06.yl4.us-east-1.eks.amazonaws.com
# EKS_CLUSTER_KUBERNETES_VERSION?= 1.19
# EKS_CLUSTER_NAME?= my-eks-cluster
# EKS_CLUSTER_ROLE_ARN?= arn:aws:iam::123456789012:role/k8s-workshop-EksServiceRo-AWSServiceRoleForAmazonE-1ER4BEPS64GJC
# EKS_CLUSTER_SECURITYGROUP_IDS?= sg-012345678 ...
# EKS_CLUSTER_SUBNET_IDS?= subnet-12345678 ...
# EKS_CLUSTER_VPC_CONFIG?= subnetIds=string,string,securityGroupIds=string,string
# EKS_CLUSTER_VPC_CONFIG_FILEPATH?= ./cluster-vpc-config.json
# EKS_CLUSTERS_SET_NAME?= my-clusters-set

# Derived parameters
EKS_CLUSTER_ARN?= arn:aws:eks:$(AWS_REGION_ID):$(AWS_ACCOUNT_ID):cluster/$(EKS_CLUSTER_NAME)
EKS_CLUSTER_VPC_CONFIG?= $(if $(EKS_CLUSTER_VPC_CONFIG_FILEPATH),file://$(EKS_CLUSTER_VPC_CONFIG_FILEPATH))$(if $(EKS_CLUSTER_SUBNET_IDS),$(call _cmn_space2comma,subnetIds=$(EKS_CLUSTER_SUBNET_IDS) securityGroupIds=$(EKS_CLUSTER_SECURITYGROUP_IDS)))

# Options
__EKS_CLUSTER_NAME= $(if $(EKS_CLUSTER_NAME),--cluster-name $(EKS_CLUSTER_NAME))
__EKS_KUBERNETES_VERSION= $(if $(EKS_CLUSTER_KUBERNETES_VERSION),--kubernetes-version $(EKS_CLUSTER_KUBERNETES_VERSION))
__EKS_NAME__CLUSTER= $(if $(EKS_CLUSTER_NAME),--name $(EKS_CLUSTER_NAME))
__EKS_RESOURCE_ARN__CLUSTER= $(if $(EKS_CLUSTER_ARN),--resource-arn $(EKS_CLUSTER_ARN))
__EKS_RESOURCES_VPC_CONFIG= $(if $(EKS_CLUSTER_VPC_CONFIG),--resources-vpc-config $(EKS_CLUSTER_VPC_CONFIG))
__EKS_ROLE_ARN= $(if $(EKS_CLUSTER_ROLE_ARN),--role-arn $(EKS_CLUSTER_ROLE_ARN))

# Customizations
_EKS_SHOW_CLUSTER_DESCRIPTION_FIELDS?= .{status:status,endpoint:endpoint,identity:identity,logging:logging,name:name,platformVersion:platformVersion,rolearn:roleArn,version:version,arn:arn,createdAt:createdAt,resourcesVpcConfig:resourcesVpcConfig}
_EKS_LIST_CLUSTERS_FIELDS?=
_EKS_LIST_CLUSTERS_SET_FIELDS?= $(_EKS_LIST_CLUSTERS_FIELDS)
_EKS_LIST_CLUSTERS_SET_QUERYFILTER?=

# Macros
_eks_get_cluster_arn= $(call _eks_get_cluster_endpoint_arn_N, $(EKS_CLUSTER_NAME))
_eks_get_cluster_arn_N= $(shell $(AWS) eks describe-cluster --name $(1) --query "cluster.arn" --output text)

_eks_get_cluster_endpoint_ca64= $(call _eks_get_cluster_endpoint_ca64_N, $(EKS_CLUSTER_NAME))
_eks_get_cluster_endpoint_ca64_N= $(shell $(AWS) eks describe-cluster --name $(1) --query "cluster.certificateAuthority.data" --output text)

_eks_get_cluster_endpoint_url= $(call _eks_get_cluster_endpoint_url_N, $(EKS_CLUSTER_NAME))
_eks_get_cluster_endpoint_url_N= $(shell $(AWS) eks describe-cluster --name $(1) --query "cluster.endpoint" --output text)

#----------------------------------------------------------------------
# USAGE
#

_eks_list_macros ::
	@echo 'AWS::EKS::Cluster ($(_AWS_EKS_CLUSTER_MK_VERSION)) macros:'
	@echo '    _eks_get_cluster_arn                        - Get the ARN of a cluster' 
	@echo '    _eks_get_cluster_endpoint_ca64              - Get the base64-encoded CA of a cluster-endpoint' 
	@echo '    _eks_get_cluster_endpoint_url               - Get the URL of a cluster-endpoint' 
	@echo

_eks_list_parameters ::
	@echo 'AWS::EKS::Cluster ($(_AWS_EKS_CLUSTER_MK_VERSION)) parameters:'
	@echo '    EKS_CLUSTER_ARN=$(EKS_CLUSTER_ARN)'
	@echo '    EKS_CLUSTER_ENDPOINT_CA64=$(EKS_CLUSTER_ENDPOINT_CA64)'
	@echo '    EKS_CLUSTER_ENDPOINT_URL=$(EKS_CLUSTER_ENDPOINT_URL)'
	@echo '    EKS_CLUSTER_KUBERNETES_VERSION=$(EKS_CLUSTER_KUBERNETES_VERSION)'
	@echo '    EKS_CLUSTER_NAME=$(EKS_CLUSTER_NAME)'
	@echo '    EKS_CLUSTER_ROLE_ARN=$(EKS_CLUSTER_ROLE_ARN)'
	@echo '    EKS_CLUSTER_SECURITYGROUP_IDS=$(EKS_CLUSTER_SECURITYGROUP_IDS)'
	@echo '    EKS_CLUSTER_SUBNET_IDS=$(EKS_CLUSTER_SUBNET_IDS)'
	@echo '    EKS_CLUSTER_VPC_CONFIG=$(EKS_CLUSTER_VPC_CONFIG)'
	@echo '    EKS_CLUSTER_VPC_CONFIG_FILEPATH=$(EKS_CLUSTER_VPC_CONFIG_FILEPATH)'
	@echo '    EKS_CLUSTERS_SET_NAME=$(EKS_CLUSTERS_SET_NAME)'
	@echo

_eks_list_targets ::
	@echo 'AWS::EKS::Cluster ($(_AWS_EKS_CLUSTER_MK_VERSION)) targets:'
	@echo '    _eks_create_cluster                          - Create a cluster'
	@echo '    _eks_delete_cluster                          - Delete a cluster'
	@echo '    _eks_list_clusters                           - List all existing clusters'
	@echo '    _eks_list_clusters_set                       - List a set of clusters'
	@echo '    _eks_show_cluster                            - Show everything related to a cluster'
	@echo '    _eks_show_cluster_addons                     - Show add-ons of a cluster'
	@echo '    _eks_show_cluster_certificateauthority       - Show certificate of a cluster'
	@echo '    _eks_show_cluster_description                - Show description of a cluster'
	@echo '    _eks_show_cluster_fargateprofiles            - Show fargate-profiles of a cluster'
	@echo '    _eks_show_cluster_idpconfigs                 - Show identity-provider-configs of a cluster'
	@echo '    _eks_show_cluster_nodegroups                 - Show node-groups of a cluster'
	@echo '    _eks_show_cluster_tags                       - Show tags of a cluster'
	@echo '    _eks_show_cluster_token                      - Show token of a cluster'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_eks_create_cluster:
	@$(INFO) '$(EKS_UI_LABEL)Creating an EKS-clusters "$(EKS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) eks create-cluster $(__EKS_KUBERNETES_VERSION) $(__EKS_NAME__CLUSTER) $(__EKS_RESOURCES_VPC_CONFIG) $(__EKS_ROLE_ARN) --query "cluster"

_eks_delete_cluster:
	@$(INFO) '$(EKS_UI_LABEL)Deleting an EKS-cluster "$(EKS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) eks delete-cluster $(__EKS_NAME__CLUSTER)

_eks_list_clusters:
	@$(INFO) '$(EKS_UI_LABEL)Listing ALL clusters ...'; $(NORMAL)
	$(AWS) eks list-clusters --query "clusters[]$(EKS_UI_VIEW_CLUSTERS_FIELDS)"

_eks_list_clusters_set:
	@$(INFO) '$(EKS_UI_LABEL)Listing clusters-set "$(EKS_CLUSTERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Clusters are grouped based on the query-filter'; $(NORMAL)
	$(AWS) eks list-clusters --query "clusters[$(EKS_UI_VIEW_CLUSTERS_SET_QUERYFILTER)]$(EKS_UI_VIEW_CLUSTERS_SET_FIELDS)" 

_EKS_SHOW_CLUSTER_TARGETS?= _eks_show_cluster_addons _eks_show_cluster_certificateauthority _eks_show_cluster_fargateprofiles _eks_show_cluster_idpconfigs _eks_show_cluster_nodegroups _eks_show_cluster_tags _eks_show_cluster_token _eks_show_cluster_description
_eks_show_cluster: $(_EKS_SHOW_CLUSTER_TARGETS)

_eks_show_cluster_addons:
	@$(INFO) '$(EKS_UI_LABEL)Showing add-ons of cluster "$(EKS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) eks list-addons $(__EKS_CLUSTER_NAME)

_eks_show_cluster_certificateauthority:
	@$(INFO) '$(EKS_UI_LABEL)Showing certificate-authority of cluster "$(EKS_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This is the base64 encoded CA cert!'; $(NORMAL)
	$(AWS) eks describe-cluster $(__EKS_NAME__CLUSTER) --query "cluster.certificateAuthority" --output json

_eks_show_cluster_description:
	@$(INFO) '$(EKS_UI_LABEL)Showing description of cluster "$(EKS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) eks describe-cluster $(__EKS_NAME__CLUSTER) --query "cluster$(_EKS_SHOW_CLUSTER_DESCRIPTION_FIELDS)"

_eks_show_cluster_fargateprofiles:
	@$(INFO) '$(EKS_UI_LABEL)Showing fargate-profiles of cluster "$(EKS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) eks list-fargate-profiles $(__EKS_CLUSTER_NAME)

_eks_show_cluster_idpconfigs:
	@$(INFO) '$(EKS_UI_LABEL)Showing identity-provider-configs of cluster "$(EKS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) eks list-identity-provider-configs $(__EKS_CLUSTER_NAME)

_eks_show_cluster_nodegroups:
	@$(INFO) '$(EKS_UI_LABEL)Showing node-groups of cluster "$(EKS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) eks list-nodegroups $(__EKS_CLUSTER_NAME)

_eks_show_cluster_tags:
	@$(INFO) '$(EKS_UI_LABEL)Showing tags of cluster "$(EKS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(if $(EKS_CLUSTER_ARN), \
		$(AWS) eks list-tags-for-resource $(__EKS_RESOURCE_ARN__CLUSTER), \
		@echo "EKS_CLUSTER_ARN not set ..." \
	)

_eks_show_cluster_token:
	@$(INFO) '$(EKS_UI_LABEL)Showing token of cluster "$(EKS_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation can be executed by assuming a role, which is not the cluster role!'; $(NORMAL)
	$(AWS) eks get-token $(__EKS_CLUSTER_NAME) # $(__EKS_ROLE_ARN)

_eks_tag_cluster:
	@$(INFO) '$(EKS_UI_LABEL)Tagging cluster "$(EKS_CLUSTER_NAME)" ...'; $(NORMAL)

_eks_untag_cluster:
	@$(INFO) '$(EKS_UI_LABEL)Un-tagging cluster "$(EKS_CLUSTER_NAME)" ...'; $(NORMAL)
