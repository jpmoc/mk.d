_EKSCTL_CLUSTER_MK_VERSION= $(_EKSCTL_MK_VERSION)

ECL_CLUSTER_ADDONS_ALBINGRESSACCESS_FLAG?= false
ECL_CLUSTER_ADDONS_APPMESHACCESS_FLAG?= false
ECL_CLUSTER_ADDONS_ASGACCESS_FLAG?= false
ECL_CLUSTER_ADDONS_EXTERNALDNSACCESS_FLAG?= false
ECL_CLUSTER_ADDONS_FULLECRACCESS_FLAG?= false
# ECL_CLUSTER_API_VERSION?= 1.13
# ECL_CLUSTER_ARN?= arn:aws:eks:us-west-2:123456789012:cluster/hzvault
# ECL_CLUSTER_AUTHENTICATOR_ROLEARN?=
# ECL_CLUSTER_AUTOKUBECONFIG_FLAG?= false
# ECL_CLUSTER_AWSACCOUNT_ID?=
# ECL_CLUSTER_AWSPROFILE_NAME?=
# ECL_CLUSTER_AWSREGION_ID?= us-west-2
# ECL_CLUSTER_CONFIG_DIRPATH?= ./in/
# ECL_CLUSTER_CONFIG_FILENAME?= cluster-config.yaml
# ECL_CLUSTER_CONFIG_FILEPATH?= ./cluster-config.yaml
# ECL_CLUSTER_ENDPOINT_URL?= https://2B2FAF7255EB6BC02AC5B4A2F2XXXXXX.gr7.us-west-2.eks.amazonaws.com
ECL_CLUSTER_KUBECONTEXT_FLAG?= true
# ECL_CLUSTER_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config
# ECL_CLUSTER_LAYER_NAME?= eksctl-eks1-cluster
ECL_CLUSTER_LOGGING_APPROVEFLAG?= false
# ECL_CLUSTER_LOGGING_DISABLETYPES?=
ECL_CLUSTER_LOGGING_ENABLETYPES?= api audit authenticator controllerManager scheduler# aka all
# ECL_CLUSTER_LOGGROUP_NAME?= /aws/eks/eks5/cluster
ECL_CLUSTER_NAME?= fabulous-mushroom-1527688624
# ECL_CLUSTER_NODEGROUP_AMI?= static
# ECL_CLUSTER_NODEGROUP_AMINAME?= AmazonLinux2/1.13
# ECL_CLUSTER_NODEGROUP_COUNT?= 2
# ECL_CLUSTER_NODEGROUP_LABELS?= partition=backend,nodeclass=hugememory
# ECL_CLUSTER_NODEGROUP_INSTANCECOUNTMIN?= 2
# ECL_CLUSTER_NODEGROUP_INSTANCECOUNTMAX?= 2
# ECL_CLUSTER_NODEGROUP_MAXPODCOUNT?= 2
ECL_CLUSTER_NODEGROUP_FLAG?= true
# ECL_CLUSTER_NODEGROUP_NAME?= ng-8c9962de
# ECL_CLUSTER_NODEGROUP_INSTANCETYPE?= m5.large
# ECL_CLUSTER_NODEGROUP_PRIVATENETWORKING?=
# ECL_CLUSTER_NODEGROUP_SECURITYGROUPS?=
# ECL_CLUSTER_NODEGROUP_SSHACCESSFLAG?= false
# ECL_CLUSTER_NODEGROUP_SSHPUBLICKEYFILEPATH?= $(HOME)/.ssh/id_rsa.pub
# ECL_CLUSTER_NODEGROUP_VOLUMESIZE?= 50
# ECL_CLUSTER_NODEGROUP_VOLUMETYPE?= gp2
# ECL_CLUSTER_NODEGROUP_ZONES?= us-east-1a us-east-1b us-east-1d
# ECL_CLUSTER_OUTPUT_FORMAT?= table
# ECL_CLUSTER_ROLE_ARN?= arn:aws:iam::123456789012:role/eksctl-hzvault-cluster-ServiceRole-IPMKG8QER655
# ECL_CLUSTER_STACK_PREFIX?= eksctl-eks1
# ECL_CLUSTER_TAGS_KEYVALUES?= environment=staging
ECL_CLUSTER_TIMEOUT?= 20m0s
ECL_CLUSTER_VPC_CIDR?= 192.168.0.0/16
ECL_CLUSTER_VPC_NATMODE?= Single
# ECL_CLUSTER_VPC_PRIVATESUBNETS?=
# ECL_CLUSTER_VPC_PUBLICSUBNETS?=
ECL_CLUSTER_WRITEKUBECONFIG_FLAG?= true
# ECL_CLUSTERS_AWSPROFILE_NAME?= 
# ECL_CLUSTERS_AWSREGION_ID?= us-west-1
# ECL_CLUSTERS_NAMES?= my-cluster ...
# ECL_CLUSTERS_SET_NAME?= my-clusters-set

# Derived parameters
ECL_CLUSTER_API_VERSION?= $(ECL_API_VERSION)
ECL_CLUSTER_ARN?= arn:aws:eks:$(ECL_CLUSTER_AWSREGION_ID):$(ECL_CLUSTER_AWSACCOUNT_ID):cluster/$(ECL_CLUSTER_NAME)
ECL_CLUSTER_AWSACCOUNT_ID?= $(ECL_AWSACCOUNT_ID)
ECL_CLUSTER_AWSPROFILE_NAME?= $(ECL_AWSPROFILE_NAME)
ECL_CLUSTER_AWSREGION_ID?= $(ECL_AWSREGION_ID)
ECL_CLUSTER_CONFIG_DIRPATH?= $(ECL_INPUTS_DIRPATH)
ECL_CLUSTER_CONFIG_FILEPATH?= $(ECL_CLUSTER_CONFIG_DIRPATH)$(ECL_CLUSTER_CONFIG_FILENAME)
ECL_CLUSTER_KUBECONFIG_FILEPATH?= $(ECL_KUBECONFIG_FILEPATH)
ECL_CLUSTER_LAYER_NAME?= eksctl-$(ECL_CLUSTER_NAME)-cluster
ECL_CLUSTER_LOGGROUP_NAME?= /aws/eks/$(ECL_CLUSTER_NAME)/cluster
ECL_CLUSTER_NODEGROUP_AMI?= $(ECL_NODEGROUP_AMI)
ECL_CLUSTER_NODEGROUP_AMINAME?= $(ECL_NODEGROUP_AMI_NAME)
ECL_CLUSTER_NODEGROUP_INSTANCECOUNT?= $(ECL_NODEGROUP_INSTANCECOUNT)
ECL_CLUSTER_NODEGROUP_INSTANCECOUNT_MAX?= $(ECL_NODEGROUP_INSTANCECOUNT_MAX)
ECL_CLUSTER_NODEGROUP_INSTANCECOUNT_MIN?= $(ECL_NODEGROUP_INSTANCECOUNT_MIN)
ECL_CLUSTER_NODEGROUP_INSTANCETYPE?= $(ECL_NODEGROUP_INSTANCETYPE)
ECL_CLUSTER_NODEGROUP_LABELS?= $(ECL_NODEGROUP_LABELS)
ECL_CLUSTER_NODEGROUP_MAXPODCOUNT?= $(ECL_NODEGROUP_MAXPODCOUNT)
ECL_CLUSTER_NODEGROUP_NAME?= $(ECL_NODEGROUP_NAME)
ECL_CLUSTER_NODEGROUP_PRIVATENETWORKING?= $(ECL_NODEGROUP_PRIVATENETWORKING)
ECL_CLUSTER_NODEGROUP_SECURITYGROUPS?= $(ECL_NODEGROUP_SECURITYGROUPS)
ECL_CLUSTER_NODEGROUP_SSHACCESSFLAG?= $(ECL_NODEGROUP_SSHACCESS_FLAG)
ECL_CLUSTER_NODEGROUP_SSHPUBLICKEYFILEPATH?= $(ECL_NODEGROUP_SSHPUBLICKEY_FILEPATH)
ECL_CLUSTER_NODEGROUP_VOLUMESIZE?= $(ECL_NODEGROUP_VOLUME_SIZE)
ECL_CLUSTER_NODEGROUP_VOLUMETYPE?= $(ECL_NODEGROUP_VOLUME_TYPE)
ECL_CLUSTER_NODEGROUP_ZONES?= $(ECL_NODEGROUP_ZONES)
ECL_CLUSTER_OUTPUT_FORMAT?= $(ECL_OUTPUT_FORMAT)
ECL_CLUSTER_STACK_PREFIX?= eksctl-$(ECL_CLUSTER_NAME)
ECL_CLUSTERS_AWSPROFILE_NAME?= $(ECL_CLUSTER_AWSPROFILE_NAME)
ECL_CLUSTERS_AWSREGION_ID?= $(ECL_CLUSTER_AWSREGION_ID)

# Option parameters
__ECL_ALB_INGRESS_ACCESS= $(if $(filter true, $(ECL_CLUSTER_ADDONS_ALBINGRESSACCESS_FLAG)),--alb-ingress-access)
__ECL_APPMESH_ACCESS= $(if $(filter true, $(ECL_CLUSTER_ADDONS_APPMESHACCESS_FLAG)),--appmesh-access)
__ECL_APPROVE= $(if $(filter true, $(ECL_CLUSTER_LOGGING_APPROVEFLAG)),--approve)
__ECL_ASG_ACCESS= $(if $(filter true, $(ECL_CLUSTER_ADDONS_ASGACCESS_FLAG)),--asg-access)
__ECL_AUTO_KUBECONFIG__CLUSTER= $(if $(filter true, $(ECL_CLUSTER_AUTOKUBECONFIG_FLAG)),--auto-kubeconfig)
__ECL_CFN_ROLE_ARN=
__ECL_CLUSTER= $(if $(ECL_CLUSTER_NAME),--cluster $(ECL_CLUSTER_NAME))
__ECL_CONFIG_FILE= $(if $(ECL_CLUSTER_CONFIG_FILEPATH),--config-file $(ECL_CLUSTER_CONFIG_FILEPATH))
__ECL_DISABLE_TYPES= $(if $(ECL_CLUSTER_LOGGING_DISABLETYPES),--disable-types $(ECL_CLUSTER_LOGGING_DISABLETYPES))
__ECL_ENABLE_TYPES= $(if $(ECL_CLUSTER_LOGGING_ENABLETYPES),--enable-types $(subst $(SPACE),$(COMMA),$(ECL_CLUSTER_LOGGING_ENABLETYPES)))
__ECL_EXTERNAL_DNS_ACCESS= $(if $(filter true, $(ECL_CLUSTER_ADDONS_EXTERNALDNSACCESS_FLAG)),--external-dns-access)
__ECL_FULL_ECR_ACCESS= $(if $(filter true, $(ECL_CLUSTER_ADDONS_FULLECRACCESS_FLAG)),--full-ecr-access)
__ECL_KUBECONFIG= $(if $(ECL_CLUSTER_KUBECONFIG_FILEPATH),--kubeconfig $(ECL_CLUSTER_KUBECONFIG_FILEPATH))
__ECL_MAX_PODS_PER_NODE= $(if $(ECL_CLUSTER_NODEGROUP_MAXPODCOUNT),--max-pods-per-node $(ECL_CLUSTER_NODEGROUP_MAXPODCOUNT))
__ECL_NAME__CLUSTER= $(if $(ECL_CLUSTER_NAME),--name $(ECL_CLUSTER_NAME))
__ECL_NODE_AMI__CLUSTER= $(if $(ECL_CLUSTER_NODEGROUP_AMI),--node-ami=$(ECL_CLUSTER_NODEGROUP_AMI))
__ECL_NODE_AMI_FAMILY__CLUSTER= $(if $(ECL_CLUSTER_NODEGROUP_AMIFAMILY),--node-ami-family=$(ECL_CLUSTER_NODEGROUP_AMIFAMILY))
__ECL_NODE_LABELS__CLUSTER= $(if $(ECL_CLUSTER_NODEGROUP_LABELS),--node-labels=$(ECL_CLUSTER_NODEGROUP_LABELS))
__ECL_NODE_PRIVATE_NETWORKING= $(if $(ECL_CLUSTER_NODEGROUP_PRIVATENETWORKING),--node-private-networking $(ECL_CLUSTER_NODEGROUP_PRIVATENETWORKING))
__ECL_NODE_SECURITY_GROUPS= $(if $(ECL_CLUSTER_NODEGROUP_SECURITYGROUPS),--node-security-groups $(ECL_CLUSTER_NODEGROUP_SECURITYGROUPS))
__ECL_NODE_TYPE= $(if $(ECL_CLUSTER_NODEGROUP_INSTANCETYPE),--node-type=$(ECL_CLUSTER_NODEGROUP_INSTANCETYPE))
__ECL_NODE_VOLUME_SIZE= $(if $(ECL_CLUSTER_NODEGROUP_VOLUMESIZE),--node-volume-size=$(ECL_CLUSTER_NODEGROUP_VOLUMESIZE))
__ECL_NODE_VOLUME_TYPE= $(if $(ECL_CLUSTER_NODEGROUP_VOLUMETYPE),--node-volume-type=$(ECL_CLUSTER_NODEGROUP_VOLUMETYPE))
__ECL_NODE_ZONES= $(if $(ECL_CLUSTER_NODEGROUP_ZONES),--node-zones $(subst $(SPACE),$(COMMA),$(ECL_CLUSTER_NODEGROUP_ZONES)))
__ECL_NODEGROUP_NAME= $(if $(ECL_CLUSTER_NODEGROUP_NAME),--nodegroup-name $(ECL_CLUSTER_NODEGROUP_NAME))
__ECL_NODES= $(if $(ECL_CLUSTER_NODEGROUP_INSTANCECOUNT),--nodes=$(ECL_CLUSTER_NODEGROUP_INSTANCECOUNT))
__ECL_NODES_MAX= $(if $(ECL_CLUSTER_NODEGROUP_INSTANCECOUNTMAX),--nodes-max=$(ECL_CLUSTER_NODEGROUP_INSTANCECOUNTMAX))
__ECL_NODES_MIN= $(if $(ECL_CLUSTER_NODEGROUP_INSTANCECOUNTMIN),--nodes-min=$(ECL_CLUSTER_NODEGROUP_INSTANCECOUNTMIN))
__ECL_PROFILE__CLUSTER= $(if $(ECL_CLUSTER_AWSPROFILE_NAME),--profile $(ECL_CLUSTER_AWSPROFILE_NAME))
__ECL_PROFILE__CLUSTERS= $(if $(ECL_CLUSTERS_AWSPROFILE_NAME),--profile $(ECL_CLUSTERS_AWSPROFILE_NAME))
__ECL_REGION__CLUSTER= $(if $(ECL_CLUSTER_AWSREGION_ID),--region=$(ECL_CLUSTER_AWSREGION_ID))
__ECL_REGION__CLUSTERS= $(if $(ECL_CLUSTERS_AWSREGION_ID),--region=$(ECL_CLUSTERS_AWSREGION_ID))
__ECL_SET_KUBECONFIG_CONTEXT= $(if $(ECL_CLUSTER_KUBECONTEXT_FLAG),--set-kubeconfig-context $(ECL_CLUSTER_KUBECONTEXT_FLAG))
__ECL_SSH_ACCESS__CLUSTER= $(if $(filter true, $(ECL_CLUSTER_NODEGROUP_SSHACCESSFLAG)),--ssh-access) #--no-ssh-access
__ECL_SSH_PUBLIC_KEY__CLUSTER= $(if $(ECL_CLUSTER_NODEGROUP_SSHPUBLICKEYFILEPATH),--ssh-public-key=$(ECL_CLUSTER_NODEGROUP_SSHPUBLICKEYFILEPATH))
__ECL_WRITE_KUBECONFIG= $(if $(ECL_CLUSTER_WRITEKUBECONFIG_FLAG),--write-kubeconfig=$(ECL_CLUSTER_WRITEKUBECONFIG_FLAG))
__ECL_TAGS= $(if $(ECL_CLUSTER_TAGS_KEYVALUES),--tags $(subst $(SPACE),$(COMMA),$(ECL_CLUSTER_TAGS_KEYVALUES)))
__ECL_TIMEOUT= $(if $(ECL_CLUSTER_TIMEOUT),--timeout $(ECL_CLUSTER_TIMEOUT))
__ECL_VERSION= $(if $(ECL_CLUSTER_API_VERSION),--version $(ECL_CLUSTER_API_VERSION))
__ECL_VPC_CIDR= $(if $(ECL_CLUSTER_VPC_CIDR),--vpc-cidr $(ECL_CLUSTER_VPC_CIDR))
__ECL_VPC_FROM_KOPS_CLUSTER=
__ECL_VPC_NAT_MODE= $(if $(ECL_CLUSTER_VPC_NATMODE),--vpc-nat-mode $(ECL_CLUSTER_VPC_NATMODE))
__ECL_VPC_PRIVATE_SUBNETS= $(if $(ECL_CLUSTER_VPC_PRIVATESUBNETS),--vpc-private-subnets $(ECL_CLUSTER_VPC_PRIVATESUBNETS))
__ECL_VPC_PUBLIC_SUBNETS= $(if $(ECL_CLUSTER_VPC_PUBLICSUBNETS),--vpc-public-subnets $(ECL_CLUSTER_VPC_PUBLICSUBNETS))
__ECL_WITHOUT_NODEGROUP= $(if $(filter false, $(ECL_CLUSTER_NODEGROUP_FLAG)),--without-nodegroup)
__ECL_ZONES__CLUSTER= $(if $(ECL_CLUSTER_NODEGROUP_ZONES),--zones=$(subst $(SPACE),$(COMMA),$(ECL_CLUSTER_NODEGROUP_ZONES)))

# UI parameters

#--- Utilities

#--- Macros
_ecl_get_cluster_endpoint_url= $(call _ecl_get_cluster_endpoint_url_N, $(ECL_CLUSTER_NAME))
_ecl_get_cluster_endpoint_url_N= $(call _ecl_get_cluster_endpoint_url_NR, $(1), $(ECL_CLUSTER_AWSREGION_ID))
_ecl_get_cluster_endpoint_url_NR= $(shell $(EKSCTL) get cluster --name $(1) --region=$(strip $(2)) --output json | jq -r '.[0].Endpoint')

_ecl_get_cluster_role_arn= $(call _ecl_get_cluster_role_arn_N, $(ECL_CLUSTER_NAME))
_ecl_get_cluster_role_arn_N= $(call _ecl_get_cluster_role_arn_NR, $(1), $(ECL_CLUSTER_AWSREGION_ID))
_ecl_get_cluster_role_arn_NR= $(shell $(EKSCTL) get cluster --name $(1) --region=$(strip $(2)) --output json | jq -r '.[0].RoleArn')

#----------------------------------------------------------------------
# USAGE
#

_ecl_view_framework_macros ::
	@echo 'EksCtL::Cluster ($(_EKSCTL_CLUSTER_MK_VERSION)) macros:'
	@echo '    _ecl_get_cluster_endpoint_url_{|N|NR}       - Get endpoint of a cluster (Name,Region)'
	@echo '    _ecl_get_cluster_role_arn_{|N|NR}           - Get the ARM of the role of a cluster (Name,Region)'
	@echo

_ecl_view_framework_parameters ::
	@echo 'EksCtL::Cluster ($(_EKSCTL_CLUSTER_MK_VERSION)) parameters:'
	@echo '    ECL_CLUSTER_ADDONS_ALBINGRESSACCESS_FLAG=$(ECL_CLUSTER_ADDONS_ALBINGRESSACCESS_FLAG)'
	@echo '    ECL_CLUSTER_ADDONS_APPMESHACCESS_FLAG=$(ECL_CLUSTER_ADDONS_APPMESHACCESS_FLAG)'
	@echo '    ECL_CLUSTER_ADDONS_ASGACCESS_FLAG=$(ECL_CLUSTER_ADDONS_ASGACCESS_FLAG)'
	@echo '    ECL_CLUSTER_ADDONS_EXTERNALDNSACCESS_FLAG=$(ECL_CLUSTER_ADDONS_EXTERNALDNSACCESS_FLAG)'
	@echo '    ECL_CLUSTER_ADDONS_FULLECRACCESS_FLAG=$(ECL_CLUSTER_ADDONS_FULLECRACCESS_FLAG)'
	@echo '    ECL_CLUSTER_API_VERSION=$(ECL_CLUSTER_API_VERSION)'
	@echo '    ECL_CLUSTER_ARN=$(ECL_CLUSTER_ARN)'
	@echo '    ECL_CLUSTER_AUTHENTICATOR_ROLEARN=$(ECL_CLUSTER_AUTHENTICATOR_ROLEARN)'
	@echo '    ECL_CLUSTER_AUTOKUBECONFIG_FLAG=$(ECL_CLUSTER_AUTOKUBECONFIG_FLAG)'
	@echo '    ECL_CLUSTER_AWSPROFILE_NAME=$(ECL_CLUSTER_AWSPROFILE_NAME)'
	@echo '    ECL_CLUSTER_AWSREGION_ID=$(ECL_CLUSTER_AWSREGION_ID)'
	@echo '    ECL_CLUSTER_CONFIG_DIRPATH=$(ECL_CLUSTER_CONFIG_DIRPATH)'
	@echo '    ECL_CLUSTER_CONFIG_FILENAME=$(ECL_CLUSTER_CONFIG_FILENAME)'
	@echo '    ECL_CLUSTER_CONFIG_FILEPATH=$(ECL_CLUSTER_CONFIG_FILEPATH)'
	@echo '    ECL_CLUSTER_ENDPOINT_URL=$(ECL_CLUSTER_ENDPOINT_URL)'
	@echo '    ECL_CLUSTER_KUBECONFIG_FILEPATH=$(ECL_CLUSTER_KUBECONFIG_FILEPATH)'
	@echo '    ECL_CLUSTER_KUBECONTEXT_FLAG=$(ECL_CLUSTER_KUBECONTEXT_FLAG)'
	@echo '    ECL_CLUSTER_LAYER_NAME=$(ECL_CLUSTER_LAYER_NAME)'
	@echo '    ECL_CLUSTER_LOGGING_APPROVEFLAG=$(ECL_CLUSTER_LOGGING_APPROVEFLAG)'
	@echo '    ECL_CLUSTER_LOGGING_DISABLETYPES=$(ECL_CLUSTER_LOGGING_DISABLETYPES)'
	@echo '    ECL_CLUSTER_LOGGING_ENABLETYPES=$(ECL_CLUSTER_LOGGING_ENABLETYPES)'
	@echo '    ECL_CLUSTER_LOGGROUP_NAME=$(ECL_CLUSTER_LOGGROUP_NAME)'
	@echo '    ECL_CLUSTER_NAME=$(ECL_CLUSTER_NAME)'
	@echo '    ECL_CLUSTER_NODEGROUP_AMINAME=$(ECL_CLUSTER_NODEGROUP_AMINAME)'
	@echo '    ECL_CLUSTER_NODEGROUP_INSTANCECOUNT=$(ECL_CLUSTER_NODEGROUP_INSTANCECOUNT)'
	@echo '    ECL_CLUSTER_NODEGROUP_INSTANCECOUNTMAX=$(ECL_CLUSTER_NODEGROUP_INSTANCECOUNTMAX)'
	@echo '    ECL_CLUSTER_NODEGROUP_INSTANCECOUNTMIN=$(ECL_CLUSTER_NODEGROUP_INSTANCECOUNTMIN)'
	@echo '    ECL_CLUSTER_NODEGROUP_INSTANCETYPE=$(ECL_CLUSTER_NODEGROUP_INSTANCETYPE)'
	@echo '    ECL_CLUSTER_NODEGROUP_LABELS=$(ECL_CLUSTER_NODEGROUP_LABELS)'
	@echo '    ECL_CLUSTER_NODEGROUP_MAXPODCOUNT=$(ECL_CLUSTER_NODEGROUP_MAXPODCOUNT)'
	@echo '    ECL_CLUSTER_NODEGROUP_NAME=$(ECL_CLUSTER_NODEGROUP_NAME)'
	@echo '    ECL_CLUSTER_NODEGROUP_PRIVATENETWORKING=$(ECL_CLUSTER_NODEGROUP_PRIVATENETWORKING)'
	@echo '    ECL_CLUSTER_NODEGROUP_SECURITYGROUPS=$(ECL_CLUSTER_NODEGROUP_SECURITYGROUPS)'
	@echo '    ECL_CLUSTER_NODEGROUP_SSHACCESSFLAG=$(ECL_CLUSTER_NODEGROUP_SSHACCESSFLAG)'
	@echo '    ECL_CLUSTER_NODEGROUP_SSHPUBLICKEYFILEPATH=$(ECL_CLUSTER_NODEGROUP_SSHPUBLICKEYFILEPATH)'
	@echo '    ECL_CLUSTER_NODEGROUP_VOLUMESIZE=$(ECL_CLUSTER_NODEGROUP_VOLUMESIZE)'
	@echo '    ECL_CLUSTER_NODEGROUP_VOLUMETYPE=$(ECL_CLUSTER_NODEGROUP_VOLUMETYPE)'
	@echo '    ECL_CLUSTER_NODEGROUP_ZONES=$(ECL_CLUSTER_NODEGROUP_ZONES)'
	@echo '    ECL_CLUSTER_ROLE_ARN=$(ECL_CLUSTER_ROLE_ARN)'
	@echo '    ECL_CLUSTER_OUTPUT_FORMAT=$(ECL_CLUSTER_OUTPUT_FORMAT)'
	@echo '    ECL_CLUSTER_STACK_PREFIX=$(ECL_CLUSTER_STACK_PREFIX)'
	@echo '    ECL_CLUSTER_TAGS_KEYVALUES=$(ECL_CLUSTER_TAGS_KEYVALUES)'
	@echo '    ECL_CLUSTER_VPC_CIDR=$(ECL_CLUSTER_VPC_CIDR)'
	@echo '    ECL_CLUSTER_VPC_NATMODE=$(ECL_CLUSTER_VPC_NATMODE)'
	@echo '    ECL_CLUSTER_VPC_PRIVATESUBNETS=$(ECL_CLUSTER_VPC_PRIVATESUBNETS)'
	@echo '    ECL_CLUSTER_VPC_PUBLICSUBNETS=$(ECL_CLUSTER_VPC_PUBLICSUBNETS)'
	@echo '    ECL_CLUSTER_WRITEKUBECONFIG_FLAG=$(ECL_CLUSTER_WRITEKUBECONFIG_FLAG)'
	@echo '    ECL_CLUSTERS_AWSPROFILE_NAME=$(ECL_CLUSTERS_AWSPROFILE_NAME)'
	@echo '    ECL_CLUSTERS_AWSREGION_ID=$(ECL_CLUSTERS_AWSREGION_ID)'
	@echo '    ECL_CLUSTERS_NAMES=$(ECL_CLUSTERS_NAMES)'
	@echo '    ECL_CLUSTERS_SET_NAME=$(ECL_CLUSTERS_SET_NAME)'
	@echo

_ecl_view_framework_targets ::
	@echo 'EksCtL::Cluster ($(_EKSCTL_CLUSTER_MK_VERSION)) targets:'
	@echo '    _ecl_create_cluster                       - Create a new cluster'
	@echo '    _ecl_delete_cluster                       - Delete a cluster'
	@echo '    _ecl_disable_cluster_logging              - Disable logging of cluster'
	@echo '    _ecl_enable_cluster_logging               - Enable logging of cluster'
	@echo '    _ecl_show_cluster                         - Show everything related to a cluster'
	@echo '    _ecl_show_cluster_description             - Show description of a cluster'
	@echo '    _ecl_show_cluster_coredns                 - Show coredns of a cluster'
	@echo '    _ecl_show_cluster_iamidebtitymapping      - Show iam-identity-mapping of a cluster'
	@echo '    _ecl_show_cluster_logging                 - Show logging of a cluster'
	@echo '    _ecl_show_cluster_nodegroups              - Show nodegroups attached to a cluster'
	@echo '    _ecl_show_cluster_stacks                  - Show stacks attached to a cluster'
	@echo '    _ecl_update_cluster_coredns               - Update vesion of core-dns in a cluster'
	@echo '    _ecl_update_cluster_logging               - Update logging configuration of a cluster'
	@echo '    _ecl_view_clusters                        - View clusters'
	@echo '    _ecl_view_clusterset                      - View a set of clusters'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ecl_create_cluster:
	@$(INFO) '$(ECL_UI_LABEL)Creating cluster "$(ECL_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Kubeconfig is generated after the cloudformation stacks have been created or later on demand'; $(NORMAL)
	@$(WARN) 'The first stack to be created is the control-plane'; $(NORMAL)
	@$(WARN) 'The second stack to be created is the initial node-group if enabled!'; $(NORMAL)
	$(EKSCTL) create cluster $(strip $(__ECL_ALB_INGRESS_ACCESS) $(__ECL_APPMESH_ACCESS) $(__ECL_ASG_ACCESS) $(__ECL_AUTO_KUBECONFIG__CLUSTER) $(__ECL_CFN_ROLE_ARN) $(__ECL_CONFIG_FILE) $(__ECL_EXTERNAL_DNS_ACCESS) $(__ECL_FULL_ECR_ACCESS) $(__ECL_KUBECONFIG) $(__ECL_MAX_PODS_PER_NODE) $(__ECL_NAME__CLUSTER) $(__ECL_NODE_AMI__CLUSTER) $(__ECL_NODE_AMI_FAMILY__CLUSTER) $(__ECL_NODE_LABELS__CLUSTER) $(__ECL_NODE_PRIVATE_NETWORKING) $(__ECL_NODE_SECURITY_GROUPS) $(__ECL_NODE_TYPE) $(__ECL_NODE_VOLUME_SIZE) $(__ECL_NODE_VOLUME_TYPE) $(__ECL_NODE_ZONES) $(__ECL_NODEGROUP_NAME) $(__ECL_NODES) $(__ECL_NODES_MAX) $(__ECL_NODES_MIN) $(__ECL_PROFILE__CLUSTER) $(__ECL_REGION__CLUSTER) $(__ECL_SSH_ACCESS__CLUSTER) $(__ECL_SSH_PUBLIC_KEY__CLUSTER) $(__ECL_WRITE_KUBECONFIG) $(__ECL_TAGS) $(__ECL_VERSION) $(__ECL_VPC_CIDR) $(__ECL_VPC_FROM_KOPS_CLUSTER) $(__ECL_VPC_NAT_MODE) $(__ECL_VPC_PRIVATE_SUBNETS) $(__ECL_VPC_PUBLIC_SUBNETS) $(__ECL_WITHOUT_NODEGROUP) $(__ECL_ZONES__CLUSTER))

_ecl_delete_cluster:
	@$(INFO) '$(ECL_UI_LABEL)Deleting cluster "$(ECL_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operaton deletes a cluster asynchronously!'; $(NORMAL)
	$(EKSCTL) delete cluster $(__ECL_NAME__CLUSTER) $(__ECL_PROFILE__CLUSTER) $(__ECL_REGION__CLUSTER)

_ecl_disable_cluster_logging:
	@$(INFO) '$(ECL_UI_LABEL)Disabling logging for cluster "$(ECL_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Cloudwatch log-group-name used by this cluster is: $(ECL_CLUSTER_LOGGROUP_NAME)'; $(NORMAL)
	$(EKSCTL) utils update-cluster-logging $(__ECL_APPROVE) $(_X__ECL_CONFIG_FILE) $(_X__ECL_DISABLE_TYPES) --disable-types all $(_X__ECL_ENABLE_TYPES) $(__ECL_NAME__CLUSTER)

_ecl_enable_cluster_logging:
	@$(INFO) '$(ECL_UI_LABEL)Enabling logging for cluster "$(ECL_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Cloudwatch log-group-name used by this cluster is: $(ECL_CLUSTER_LOGGROUP_NAME)'; $(NORMAL)
	$(EKSCTL) utils update-cluster-logging $(__ECL_APPROVE) $(_X__ECL_CONFIG_FILE) $(_X__ECL_DISABLE_TYPES) $(_X__ECL_ENABLE_TYPES) --enable-types all $(__ECL_NAME__CLUSTER)

_ecl_show_cluster: _ecl_show_cluster_coredns _ecl_show_cluster_iamidentitymapping _ecl_show_cluster_logging _ecl_show_cluster_nodegroups _ecl_show_cluster_stacks _ecl_show_cluster_description

_ecl_show_cluster_description:
	@$(INFO) '$(ECL_UI_LABEL)Showing description of cluster "$(ECL_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation may return information that is out-of-date if drift is significant!'; $(NORMAL)
	$(EKSCTL) get cluster $(__ECL_NAME__CLUSTER) $(__ECL_REGION__CLUSTER)

_ecl_show_cluster_coredns:
	@$(INFO) '$(ECL_UI_LABEL)Showing core-dns status on cluster "$(ECL_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation checks the running version of core-dns.'; $(NORMAL)
	$(EKSCTL) utils update-coredns $(_X__ECL_APPROVE) $(__ECL_CLUSTER)

_ecl_show_cluster_iamidentitymapping:
	@$(INFO) '$(ECL_UI_LABEL)Showing iam-identity-mapping of cluster "$(ECL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(EKSCTL) get iamidentitymapping $(__ECL_CLUSTER) $(__ECL_REGION__CLUSTER)

_ecl_show_cluster_logging:
	@$(INFO) '$(ECL_UI_LABEL)Showing logging of cluster "$(ECL_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation plans for disabling all logging.'; $(NORMAL)
	@$(WARN) 'If cluster is up-to-date, logging is disabled which is the default'; $(NORMAL)
	$(EKSCTL) utils update-cluster-logging $(_X__ECL_APPROVE) $(__ECL_CLUSTER) $(__X_ECL_CONFIG_FILE) $(_X__ECL_DISABLE_TYPES) --disable-types all $(_X__ECL_ENABLE_TYPES)

_ecl_show_cluster_nodegroups:
	@$(INFO) '$(ECL_UI_LABEL)Showing node-groups of cluster "$(ECL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(EKSCTL) get nodegroup $(__ECL_CLUSTER) $(__ECL_OUTPUT__CLUSTER) $(__ECL_REGION__CLUSTER)

_ecl_show_cluster_stacks:
	@$(INFO) '$(ECL_UI_LABEL)Showing cloudformation stacks of cluster "$(ECL_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns a stack for the control-plane and one for each nodegroup'; $(NORMAL)
	$(EKSCTL) utils describe-stacks $(__ECL_CLUSTER) $(__ECL_REGION__CLUSTER)

_ecl_update_cluster_coredns:
	@$(INFO) '$(ECL_UI_LABEL)Updating core-dns on cluster "$(ECL_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT appear to the working!'; $(NORMAL)
	$(EKSCTL) utils update-coredns $(__ECL_APPROVE) $(__ECL_CLUSTER) $(__ECL_CONFIG_FILE)

_ecl_update_cluster_logging:
	@$(INFO) '$(ECL_UI_LABEL)Updating logging configuration for cluster "$(ECL_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Cloudwatch log-group-name used by this cluster is: $(ECL_CLUSTER_LOGGROUP_NAME)'; $(NORMAL)
	$(EKSCTL) utils update-cluster-logging $(__ECL_APPROVE) $(__ECL_CLUSTER) $(__ECL_CONFIG_FILE) $(__ECL_DISABLE_TYPES) $(__ECL_ENABLE_TYPES)

_ecl_view_clusters:
	@$(INFO) '$(ECL_UI_LABEL)Viewing ALL clusters ...'; $(NORMAL)
	@$(WARN) 'This operation returns information extracted from the control-plane stacks'; $(NORMAL)
	$(EKSCTL) get clusters $(__ECL_PROFILE__CLUSTERS) $(__ECL_REGION__CLUSTERS)

_ecl_view_clusters_set:
	@$(INFO) '$(ECL_UI_LABEL)Viewing clusters-set "$(ECL_CLUSTERS_SET_NAME)" ...'; $(NORMAL)
	@$(foreach N,$(ECL_CLUSTERS_NAMES), $(EKSCTL) get cluster --name $(N) --region $(ECL_CLUSTERS_AWS_REGION); )
