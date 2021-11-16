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

# Options

# Customizations
|_KZE_LIST_RESOURCES_SET?=

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kze_list_macros ::
	@#echo 'KustomiZE::Resource ($(_KUSTOMIZE_RESOURCE_MK_VERSION)) macros:'
	@#echo

_kze_list_parameters ::
	@echo 'KustomiZE::Resource ($(_KUSTOMIZE_RESOURCE_MK_VERSION)) parameters:'
	@echo '    KZE_RESOURCE_DIRPATH=$(KZE_RESOURCE_DIRPATH)'
	@echo '    KZE_RESOURCE_FILENAME=$(KZE_RESOURCE_FILENAME)'
	@echo '    KZE_RESOURCE_FILEPATH=$(KZE_RESOURCE_FILEPATH)'
	@echo '    KZE_RESOURCE_NAME=$(KZE_RESOURCE_NAME)'
	@echo '    KZE_RESOURCES_DIRPATH=$(KZE_RESOURCES_DIRPATH)'
	@echo '    KZE_RESOURCES_REGEX=$(KZE_RESOURCES_REGEX)'
	@echo '    KZE_RESOURCES_SET_NAME=$(KZE_RESOURCES_SET_NAME)'
	@echo

_kze_list_targets ::
	@echo 'KustomiZE::Resource ($(_KUSTOMIZE_RESOURCE_MK_VERSION)) targets:'
	@echo '    _kze_create_resource                  - Create resources in a resource'
	@echo '    _kze_delete_resource                  - Delete resources in a resource'
	@echo '    _kze_list_resources                   - List all resources'
	@echo '    _kze_list_resources_set               - List a set of resources'
	@echo '    _kze_show_resource                    - Show everything related to a resource'
	@echo '    _kze_show_resource_content            - Show the content of a resource'
	@echo '    _kze_show_resource_description        - Show description of resource'
	@echo '    _kze_update_resource                  - Update resource'
	@echo '    _kze_write_resource                   - Write a resource'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kze_create_resource: _kze_edit_resource

_kze_delete_resource:
	@$(INFO) '$(KZE_UI_LABEL)Deleting resource "$(KZE_RESOURCE_NAME)" ...'; $(NORMAL)
	rm $(KZE_RESOURCE_FILEPATH)	

_kze_list_resources:
	@$(INFO) '$(KZE_UI_LABEL)Listing ALL resources ...'; $(NORMAL)
	ls -al $(KZE_RESOURCES_DIRPATH)

_kze_list_resources_set:
	@$(INFO) '$(KZE_UI_LABEL)Listing resources-set "$(KZE_RESOURCES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Reources are grouped based on directory, regex, and pipe-filter'; $(NORMAL)
	ls -al $(KZE_RESOURCES_DIRPATH)$(KZE_RESOURCES_REGEX) $(|_KZE_LIST_RESOURCES_SET)

_KZE_SHOW_RESOURCE_TARGETS?= _kze_show_resource_content _kze_show_resource_description
_kze_show_resource: $(_KZE_SHOW_RESOURCE_TARGETS)

_kze_show_resource_content:
	@$(INFO) '$(KZE_UI_LABEL)Showing context of resource "$(KZE_RESOURCE_NAME)" ...'; $(NORMAL)
	-cat $(KZE_RESOURCE_FILEPATH)
	
_kze_show_resource_description:
	@$(INFO) '$(KZE_UI_LABEL)Showing description of resource "$(KZE_RESOURCE_NAME)" ...'; $(NORMAL)
	-ls -al $(KZE_RESOURCE_FILEPATH)

_kze_update_resource: _kze_edit_resource

_kze_write_resource:
	@$(INFO) '$(KZE_UI_LABEL)Writing resource "$(KZE_RESOURCE_NAME)" ...'; $(NORMAL)
	$(WRITE) $(KZE_RESOURCE_FILEPATH)
