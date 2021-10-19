_KUSTOMIZE_RESOURCE_MK_VERSION= $(_KUSTOMIZE_MK_VERSION)

# KZE_RESOURCE_DIRPATH?= ./in/
# KZE_RESOURCE_FILENAME?= resource.yaml
# KZE_RESOURCE_FILEPATH?= ./in/resource.yaml
# KZE_RESOURCE_NAME?= my-resource
# KZE_RESOURCES_DIRPATH?= ./in/
KZE_RESOURCES_REGEX?= *
# KZE_RESOURCES_SET_NAME?= my-resources-set

# Derived parameters
KZE_RESOURCE_DIRPATH?= $(KZE_KUSTOMIZATION_DIRPATH)
KZE_RESOURCE_FILEPATH?= $(KZE_RESOURCE_DIRPATH)$(KZE_RESOURCE_FILENAME)
KZE_RESOURCES_DIRPATH?= $(KZE_RESOURCE_DIRPATH)

# Option parameters

# Pipe
|_KZE_VIEW_RESOURCES_SET?=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kze_view_framework_macros ::
	@echo 'KustomiZE::Resource ($(_KUSTOMIZE_RESOURCE_MK_VERSION)) macros:'
	@echo

_kze_view_framework_parameters ::
	@echo 'KustomiZE::Resource ($(_KUSTOMIZE_RESOURCE_MK_VERSION)) parameters:'
	@echo '    KZE_RESOURCE_DIRPATH=$(KZE_RESOURCE_DIRPATH)'
	@echo '    KZE_RESOURCE_FILENAME=$(KZE_RESOURCE_FILENAME)'
	@echo '    KZE_RESOURCE_FILEPATH=$(KZE_RESOURCE_FILEPATH)'
	@echo '    KZE_RESOURCE_NAME=$(KZE_RESOURCE_NAME)'
	@echo '    KZE_RESOURCES_DIRPATH=$(KZE_RESOURCES_DIRPATH)'
	@echo '    KZE_RESOURCES_REGEX=$(KZE_RESOURCES_REGEX)'
	@echo '    KZE_RESOURCES_SET_NAME=$(KZE_RESOURCES_SET_NAME)'
	@echo

_kze_view_framework_targets ::
	@echo 'KustomiZE::Resource ($(_KUSTOMIZE_RESOURCE_MK_VERSION)) targets:'
	@echo '    _kze_create_resource                  - Create resources in a resource'
	@echo '    _kze_delete_resource                  - Delete resources in a resource'
	@echo '    _kze_edit_resource                    - Edit a resource'
	@echo '    _kze_show_resource                    - Show everything related to a resource'
	@echo '    _kze_show_resource_content            - Show everything related to a resource'
	@echo '    _kze_show_resource_description        - Show description of resource'
	@echo '    _kze_update_resource                  - Update resource'
	@echo '    _kze_view_resources                  - View resources'
	@echo '    _kze_view_resources_set              - View set of resources'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kze_create_resource: _kze_edit_resource

_kze_delete_resource:
	@$(INFO) '$(KZE_UI_LABEL)Deleting resource "$(KZE_RESOURCE_NAME)" ...'; $(NORMAL)
	rm $(KZE_RESOURCE_FILEPATH)	

_kze_edit_resource:
	@$(INFO) '$(KZE_UI_LABEL)Editing resource "$(KZE_RESOURCE_NAME)" ...'; $(NORMAL)
	$(EDITOR) $(KZE_RESOURCE_FILEPATH)

_kze_show_resource :: _kze_show_resource_content _kze_show_resource_description

_kze_show_resource_content:
	@$(INFO) '$(KZE_UI_LABEL)Showing context of resource "$(KZE_RESOURCE_NAME)" ...'; $(NORMAL)
	-cat $(KZE_RESOURCE_FILEPATH)
	
_kze_show_resource_description:
	@$(INFO) '$(KZE_UI_LABEL)Showing description of resource "$(KZE_RESOURCE_NAME)" ...'; $(NORMAL)
	-ls -al $(KZE_RESOURCE_FILEPATH)

_kze_update_resource: _kze_edit_resource

_kze_view_resources:
	@$(INFO) '$(KZE_UI_LABEL)Viewing resources ...'; $(NORMAL)
	ls -al $(KZE_RESOURCES_DIRPATH)

_kze_view_resources_set:
	@$(INFO) '$(KZE_UI_LABEL)Viewing resources-set "$(KZE_RESOURCES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Reources are grouped based on directory, regex, and pipe-filter'; $(NORMAL)
	ls -al $(KZE_RESOURCES_DIRPATH)$(KZE_RESOURCES_REGEX) $(|_KZE_VIEW_RESOURCES_SET)
