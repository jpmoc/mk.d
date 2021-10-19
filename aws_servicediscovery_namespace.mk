_AWS_SERVICEDISCOVERY_NAMESPACE_MK_VERSION= $(_AWS_SERVICEDISCOVERY_MK_VERSION)

# SDY_NAMESPACE_DESCRIPTION?= "This is my namespace"
# SDY_NAMESPACE_ID?= ns-cxw72pb7q4vw3h7h
# SDY_NAMESPACE_NAME?= my-namespace
# SDY_NAMESPACE_REQUEST_ID?= 20191112_170011
SDY_NAMESPACE_TYPE?= HTTP
# SDY_NAMESPACE_VPC_ID?= vpc-12345678
# SDY_NAMESPACES_FILTERS?=
# SDY_NAMESPACES_SET_NAME?=

# Derived parameters
SDY_NAMESPACE_VPC_ID?= $(EC2_VPC_ID)

# Option parameters
__SDY_CREATOR_REQUEST_ID__NAMESPACE= $(if $(SDY_NAMESPACE_REQUEST_ID),--creator-request-id $(SDY_NAMESPACE_REQUEST_ID))
__SDY_DESCRIPTION__NAMESPACE= $(if $(SDY_NAMESPACE_DESCRIPTION),--description $(SDY_NAMESPACE_DESCRIPTION))
__SDY_FILTERS__NAMESPACES= $(if $(SDY_NAMESPACES_FILTERS),--filters $(SDY_NAMESPACES_FILTERS))
__SDY_ID__NAMESPACE= $(if $(SDY_NAMESPACE_ID),--id $(SDY_NAMESPACE_ID))
__SDY_NAME__NAMESPACE= $(if $(SDY_NAMESPACE_NAME),--name $(SDY_NAMESPACE_NAME))

# UI parameters
SDY_UI_SHOW_NAMESPACE_FIELDS?=
SDY_UI_VIEW_NAMESPACES_FIELDS?= .{Id:Id,Name:Name,Type:Type}
SDY_UI_VIEW_NAMESPACES_SET_FIELDS?= $(SDY_UI_VIEW_NAMESPACES_FIELDS)
SDY_UI_VIEW_NAMESPACES_SET_QUERYFILTER?=

#--- MACROS

_sdy_get_namespace_arn= $(call _sdy_get_namespace_arn_I, $(SDY_NAMESPACE_ID))
_sdy_get_namespace_arn_I= $(shell echo "arn:aws:servicediscovery:$(AWSS_REGION):$(AWS_ACCOUNT_ID):namespace/$(strip $(1))")

_sdy_get_namespace_id= $(call  _sdy_get_namespace_id_N, $(SDY_NAMESPACE_NAME))
_sdy_get_namespace_id_N= $(shell $(AWS) servicediscovery list-namespaces --query "Namespaces[?Name=='$(strip $(1))'].Id" --output text )

#--- Utilities

#----------------------------------------------------------------------
# USAGE
#

_sdy_view_framework_macros ::
	@echo 'AWS::ServiceDiscoverY::Namespace ($(_AWS_SERVICEDISCOVERY_NAMESPACE_MK_VERSION)) macros:'
	@echo '    _sdy_get_namespace_arn_{|I}            - Get the ARN of a namespace (Id)'
	@echo '    _sdy_get_namespace_id_{|N}             - Get the ID of a namespace (Name)'
	@echo

_sdy_view_framework_parameters ::
	@echo 'AWS::ServiceDiscoverY::Namespace ($(_AWS_SERVICEDISCOVERY_NAMESPACE_MK_VERSION)) parameters:'
	@echo '    SDY_NAMESPACE_DESCRIPTION=$(SDY_NAMESPACE_DESCRIPTION)'
	@echo '    SDY_NAMESPACE_ID=$(SDY_NAMESPACE_ID)'
	@echo '    SDY_NAMESPACE_NAME=$(SDY_NAMESPACE_NAME)'
	@echo '    SDY_NAMESPACE_REQUEST_ID=$(SDY_NAMESPACE_REQUEST_ID)'
	@echo '    SDY_NAMESPACE_TYPE=$(SDY_NAMESPACE_TYPE)'
	@echo '    SDY_NAMESPACE_VPC_ID=$(SDY_NAMESPACE_VPC_ID)'
	@echo '    SDY_NAMESPACES_FILTERS=$(SDY_NAMESPACES_FILTERS)'
	@echo '    SDY_NAMESPACES_SET_NAME=$(SDY_NAMESPACES_SET_NAME)'
	@echo

_sdy_view_framework_targets ::
	@echo 'AWS::ServiceDiscoverY::Namespace ($(_AWS_SERVICEDISCOVERY_NAMESPACE_MK_VERSION)) targets:'
	@echo '    _sdy_create_namespace                  - Create a new namespace'
	@echo '    _sdy_delete_namespace                  - Delete an existing namespace'
	@echo '    _sdy_show_namespace                    - Show everything related to a namespace'
	@echo '    _sdy_show_namespace_description        - Show description of a namespace'
	@echo '    _sdy_view_namespaces                   - View namespaces'
	@echo '    _sdy_view_namespaces_set               - View a set of namespaces'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sdy_create_namespace:
	@$(INFO) '$(AWS_UI_LABEL)Creating a new namespace "$(SDY_NAMESPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is asynchronous, not instantaneous'; $(NORMAL)
	@$(WARN) 'Namespace type is $(SDY_NAMESPACE_TYPE)'; $(NORMAL)
	$(if $(filter dns_private DNS_PRIVATE, $(SDY_NAMESPACE_TYPE)),$(AWS) servicediscovery create-private-dns-namespace $(__SDY_CREATOR_REQUEST_ID__NAMESPACE) $(__SDY_DESCRIPTION__NAMESPACE) $(__SDY_NAME__NAMESPACE) $(__SDY_VPC__NAMESPACE))
	$(if $(filter dns_public DNS_PUBLIC, $(SDY_NAMESPACE_TYPE)),$(AWS) servicediscovery create-public-dns-namespace $(__SDY_CREATOR_REQUEST_ID__NAMESPACE) $(__SDY_DESCRIPTION__NAMESPACE) $(__SDY_NAME__NAMESPACE) )
	$(if $(filter http HTTP, $(SDY_NAMESPACE_TYPE)),$(AWS) servicediscovery create-http-namespace $(__SDY_CREATOR_REQUEST_ID__NAMESPACE) $(__SDY_DESCRIPTION__NAMESPACE) $(__SDY_NAME__NAMESPACE) )

_sdy_delete_namespace:
	@$(INFO) '$(AWS_UI_LABEL)Deleting namespace "$(SDY_NAMESPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is asynchronous, not instantaneous'; $(NORMAL)
	$(AWS) servicediscovery delete-namespace $(__SDY_ID__NAMESPACE)

_sdy_show_namespace: _sdy_show_namespace_operations _sdy_show_namespace_description

_sdy_show_namespace_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of namespace "$(SDY_NAMESPACE_NAME)"...'; $(NORMAL)
	@$(WARN) 'This operation fails if namespace ID is NOT set'; $(NORMAL)
	$(AWS) servicediscovery get-namespace $(__SDY_ID__NAMESPACE) --query "@.Namespace$(SDY_UI_SHOW_NAMESPACE_FIELDS)"

_sdy_show_namespace_operations:
	@$(INFO) '$(AWS_UI_LABEL)Showing operations of namespace "$(SDY_NAMESPACE_NAME)"...'; $(NORMAL)
	@$(WARN) 'This operation fails if namespace ID is NOT set'; $(NORMAL)
	-$(AWS) servicediscovery list-operations --filters Name=NAMESPACE_ID,Values=$(strip $(SDY_NAMESPACE_ID)),Condition=EQ --query "Operations[]"

_sdy_view_namespaces:
	@$(INFO) '$(AWS_UI_LABEL)Viewing namespaces ...'; $(NORMAL)
	$(AWS) servicediscovery list-namespaces $(_X__SDY_FILTERS__NAMESPACES) $(_X__MAX_ITEMS) --query "Namespaces[]$(SDY_UI_VIEW_NAMESPACES_FIELDS)"

_sdy_view_namespaces_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing namespaces-set "$(SDY_NAMESPACES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Namespaces are grouped based on the provided filters, and/or slice'; $(NORMAL)
	$(AWS) servicediscovery list-namespaces $(__SDY_FILTERS__NAMESPACES) $(_X__MAX_ITEMS) --query "Namespaces[$(SDY_UI_VIEW_NAMESPACES_SET_FIELDS)]$(SDY_UI_VIEW_NAMESPACES_SET_FIELDS)"
