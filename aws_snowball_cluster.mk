_AWS_SNOWBALL_CLUSTER_MK_VERSION= $(_AWS_SNOWBALL_MK_VERSION)

# SBL_CLUSTER_ADDRESS_ID?=
# SBL_CLUSTER_DESCRIPTION?=
# SBL_CLUSTER_FORWARDINGADDRESS_ID?=
# SBL_CLUSTER_JOB_TYPE?=
# SBL_CLUSTER_KMSKEY_ARN?=
# SBL_CLUSTER_RESOURCES?=
# SBL_CLUSTER_ROLE_ARN?=
# SBL_CLUSTER_SHIPPING_OPTION?=
# SBL_CLUSTER_SNOWBALL_TYPE?=

# Derived parameters
# SBL_CLUSTER_IDS?= $(SBL_CLUSTER_ID)

# Option parameters
__SBL_ADDRESS_ID= $(if $(SBL_CLUSTER_ADDRESS_ID), --address-id $(SBL_CLUSTER_ADDRESS_ID))
__SBL_CLUSTER_ID= $(if $(SBL_CLUSTER_ID), --cluster-id $(SBL_CLUSTER_ID))
__SBL_DESCRIPTION__CLUSTER= $(if $(SBL_CLUSTER_DESRIPTION), --description $(SBL_CLUSTER_DESCRIPTION))
__SBL_FORWARDING_ADDRESS_ID= $(if $(SBL_CLUSTER_FORWARDINGADDRESS_ID), --forwarding-address-id $(SBL_CLUSTER_FORWARDINGADDRESS_ID))
__SBL_JOB_TYPE= $(if $(SBL_CLUSTER_JOB_TYPE), --job-type $(SBL_CLUSTER_JOB_TYPE))
__SBL_KMS_KEY_ARN= $(if $(SBL_CLUSTER_KMSKEY_ARN), --kms-key-arn $(SBL_CLUSTER_KMSKEY_ARN))
__SBL_NOTIFICATION=
__SBL_RESOURCES= $(if $(SBL_CLUSTER_RESOURCES), --resources $(SBL_CLUSTER_RESOURCES))
__SBL_ROLE_ARN= $(if $(SBL_CLUSTER_ROLE_ARN), --role-arn $(SBL_CLUSTER_ROLE_ARN))
__SBL_SHIPPING_OPTION= $(if $(SBL_CLUSTER_SHIPPING_OPTION), --shipping-option $(SBL_CLUSTER_SHIPPING_OPTION))
__SBL_SNOWBALL_TYPE= $(if $(SBL_CLUSTER_SNOWBALL_TYPE), --snowball-type $(SBL_CLUSTER_SNOWBALL_TYPE))

# UI parameters
SBL_UI_VIEW_CLUSTERS_FIELDS?=
SBL_UI_VIEW_CLUSTERS_SET_FIELDS?= $(SBL_UI_VIEW_CLUSTERS_FIELDS)
SBL_UI_VIEW_CLUSTERS_SET_SLICE?=

#--- Utilities

#--- MACROS

_sbl_get_cluster_id= $(call _sbl_get_cluster_id_N, $(SBL_CLUSTER_NAME))
_sbl_get_cluster_id_N= $(call _sbl_get_cluster_id_NO, $(1), $(SBL_CLUSTER_ORGANIZATION_ID))
_sbl_get_cluster_id_NO= "$(shell $(AWS) snowball list-clusters --organization-id $(2) --query "Users[?Name=='$(strip $(1))'].Id" --output text)"

#----------------------------------------------------------------------
# USAGE
#

_sbl_view_framework_macros ::
	@echo 'AWS::SnowBalL::Cluster ($(_AWS_SNOWBALL_CLUSTER_MK_VERSION)) macros:'
	@echo '    _sbl_get_cluster_id_{|N|NO}                     - Get the ID of a cluster (Name,OrganizationId)'
	@echo

_sbl_view_framework_parameters ::
	@echo 'AWS::SnowBalL::Cluster ($(_AWS_SNOWBALL_CLUSTER_MK_VERSION)) parameters:'
	@echo '    SBL_CLUSTER_ADDRESS_ID=$(SBL_CLUSTER_ADDRESS_ID)'
	@echo '    SBL_CLUSTER_DESCRIPTION=$(SBL_CLUSTER_DESCRIPTION)'
	@echo '    SBL_CLUSTER_FORWARDINGADDRESS_ID=$(SBL_CLUSTER_FORWARDINGADDRESS_ID)'
	@echo '    SBL_CLUSTER_JOB_TYPE=$(SBL_CLUSTER_JOB_TYPE)'
	@echo '    SBL_CLUSTER_KMSKEY_ARN=$(SBL_CLUSTER_KMSKEY_ARN)'
	@echo '    SBL_CLUSTER_RESOURCES=$(SBL_CLUSTER_RESOURCES)'
	@echo '    SBL_CLUSTER_ROLE_ARN=$(SBL_CLUSTER_ROLE_ARN)'
	@echo '    SBL_CLUSTER_SHIPPING_OPTION=$(SBL_CLUSTER_SHIPPING_OPTION)'
	@echo '    SBL_CLUSTER_SNOWBALL_TYPE=$(SBL_CLUSTER_SNOWBALL_TYPE)'
	@echo '    SBL_CLUSTERS_SET_NAME=$(SBL_CLUSTERS_SET_NAME)'
	@echo

_sbl_view_framework_targets ::
	@echo 'AWS::SnowBalL::Cluster ($(_AWS_SNOWBALL_CLUSTER_MK_VERSION)) targets:'A
	@echo '    _sbl_create_cluster                           - Create a new cluster'
	@echo '    _sbl_delete_cluster                           - Delete an existing cluster'
	@echo '    _sbl_show_cluster                             - Show everything related to a cluster'
	@echo '    _sbl_view_clusters                            - View clusters'
	@echo '    _sbl_view_clusters_set                        - View a set of clusters'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sbl_create_cluster:
	@$(INFO) '$(AWS_UI_LABEL)Creating cluster "$(SBL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) snowball create-cluster $(__SBL_ADDRESS_ID) $(__SBL_DESCRIPTION__CLUSTER) $(__SBL_FORWARDING_ADDRESS_ID) $(__SBL_JOB_TYPE) $(__SBL_KMS_KEY_ARN) $(__SBL_RESOURCES) $(__SBL_ROLE_ARN) $(__SBL_SHIPPING_OPTION) $(__SBL_SNOWBALL_TYPE)

_sbl_delete_cluster:
	@$(INFO) '$(AWS_UI_LABEL)Deleting/Cancelling cluster "$(SBL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) snowball delete-cluster $(__SBL_CLUSTER_ID)

_sbl_show_cluster:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of cluster "$(SBL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) snowball describe-cluster $(__SBL_CLUSTER_ID)

_sbl_update_cluster:
	@$(INFO) '$(AWS_UI_LABEL)Updating cluster "$(SBL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) snowball update-cluster $(__SBL_ADDRESS_ID) $(__SBL_CLUSTER_ID) $(__SBL_DESCRIPTION__CLUSTER) $(__SBL_FORWARDING_ADDRESS_ID) $(__SBL_NOTIFICATION) $(__SBL_RESOURCES) $(__SBL_ROLE_ARN) $(__SBL_SHIPPING_OPTION)

_sbl_view_clusters:
	@$(INFO) '$(AWS_UI_LABEL)Viewing clusters ...'; $(NORMAL)
	$(AWS) snowball list-clusters --query "Clusters[]$(SBL_UI_VIEW_CLUSTERS_FIELDS)"

_sbl_view_clusters_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing clusters-set "$(SBL_CLUSTERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Clusters are grouped based on the provided slice'; $(NORMAL)
	$(AWS) snowball list-clusters --query "Clusters[$(SBL_UI_VIEW_CLUSTERS_SET_SLICE)]$(SBL_UI_VIEW_CLUSTERS_SET_FIELDS)"
