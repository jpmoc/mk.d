_DOCKER_REPOSITORY_MK_VERSION= $(_DOCKER_MK_VERSION)

# DKR_REPOSITORY_API_URI?= 
# DKR_REPOSITORY_CNAME?= runner.servicemesh.biz:5000/allspark/runner
# DKR_REPOSITORY_NAME?= allspark/runner
# DKR_REPOSITORY_REGISTRYAPI_URI?= runner.servicemesh:5000/v2
# DKR_REPOSITORY_REGISTRYAPI_VERSION?= v2
# DKR_REPOSITORY_REGISTRY_CNAME?= runner.servicemesh:5000

# Derived parameters
DKR_REPOSITORY_API_URI?= $(DKR_REPOSITORY_REGISTRYAPI_URI)/$(DKR_REPOSITORY_NAME)
DKR_REPOSITORY_CNAME?= $(DKR_REPOSITORY_REGISTRY_CNAME)/$(DKR_REPOSITORY_NAME)
DKR_REPOSITORY_REGISTRY_CNAME?= $(DKR_REGISTRY_CNAME)
DKR_REPOSITORY_REGISTRYAPI_URI?= $(DKR_REGISTRY_API_URI)
DKR_REPOSITORY_REGISTRYAPI_VERSION?= $(DKR_REGISTRY_API_VERSION)

# Option parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_dkr_view_framework_macros ::
	@echo 'DocKeR::Repository ($(_DOCKER_REPOSITORY_MK_VERSION)) targets:'
	@echo '    _dkr_get_image_id_{|N}        - Get the ID of an image (Name)'
	@echo

_dkr_view_framework_parameters ::
	@echo 'DocKeR::Repository ($(_DOCKER_REPOSITORY_MK_VERSION)) parameters:'
	@echo '    DKR_REPOSITORY_API_URI=$(DKR_REPOSITORY_API_URI)'
	@echo '    DKR_REPOSITORY_CNAME=$(DKR_REPOSITORY_CNAME)'
	@echo '    DKR_REPOSITORY_NAME=$(DKR_REPOSITORY_NAME)'
	@echo '    DKR_REPOSITORY_REGISTRYAPI_URI=$(DKR_REPOSITORY_REGISTRYAPI_URI)'
	@echo '    DKR_REPOSITORY_REGISTRYAPI_VERSION=$(DKR_REPOSITORY_REGISTRYAPI_VERSION)'
	@echo

_dkr_view_framework_targets ::
	@echo 'DocKeR::Registry ($(_DOCKER_REPOSITORY_MK_VERSION)) targets:'
	@echo '    _dkr_show_repository               - Show everything related to a repository'
	@echo '    _dkr_show_repository_tags          - Show the available tags in a repository'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dkr_show_repository: _dkr_show_repository_tags

_dkr_show_repository_tags:
	@$(INFO) '$(DKR_UI_LABEL)Showing tags in repository "$(DKR_REPOSITORY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if credentials are required and not provided'; $(NORMAL)
	curl -s -X GET $(DKR_REPOSITORY_API_URI)/tags/list | jq -r '.tags[]' | sort
