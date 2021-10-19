_KUSTOMIZE_PATCH_MK_VERSION= $(_KUSTOMIZE_MK_VERSION)

# KZE_PATCH_DIRPATH?= ./in/
# KZE_PATCH_FILENAME?= patch.yaml
# KZE_PATCH_FILEPATH?= ./in/patch.yaml
# KZE_PATCH_NAME?= my-patch
# KZE_PATCHES_DIRPATH?= ./in/
KZE_PATCHES_REGEX?= *
# KZE_PATCHES_SET_NAME?= my-patchs-set

# Derived parameters
KZE_PATCH_DIRPATH?= $(KZE_KUSTOMIZATION_DIRPATH)
KZE_PATCH_FILEPATH?= $(KZE_PATCH_DIRPATH)$(KZE_PATCH_FILENAME)
KZE_PATCHES_DIRPATH?= $(KZE_PATCH_DIRPATH)

# Option parameters

# Pipe
|_KZE_VIEW_PATCHES_SET?=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kze_view_framework_macros ::
	@echo 'KustomiZE::Patch ($(_KUSTOMIZE_PATCH_MK_VERSION)) macros:'
	@echo

_kze_view_framework_parameters ::
	@echo 'KustomiZE::Patch ($(_KUSTOMIZE_PATCH_MK_VERSION)) parameters:'
	@echo '    KZE_PATCH_DIRPATH=$(KZE_PATCH_DIRPATH)'
	@echo '    KZE_PATCH_FILENAME=$(KZE_PATCH_FILENAME)'
	@echo '    KZE_PATCH_FILEPATH=$(KZE_PATCH_FILEPATH)'
	@echo '    KZE_PATCH_NAME=$(KZE_PATCH_NAME)'
	@echo '    KZE_PATCHES_DIRPATH=$(KZE_PATCHES_DIRPATH)'
	@echo '    KZE_PATCHES_REGEX=$(KZE_PATCHES_REGEX)'
	@echo '    KZE_PATCHES_SET_NAME=$(KZE_PATCHES_SET_NAME)'
	@echo

_kze_view_framework_targets ::
	@echo 'KustomiZE::Patch ($(_KUSTOMIZE_PATCH_MK_VERSION)) targets:'
	@echo '    _kze_create_patch                  - Create resources in a patch'
	@echo '    _kze_delete_patch                  - Delete resources in a patch'
	@echo '    _kze_edit_patch                    - Edit a patch'
	@echo '    _kze_show_patch                    - Show everything related to a patch'
	@echo '    _kze_show_patch_content            - Show everything related to a patch'
	@echo '    _kze_show_patch_description        - Show description of patch'
	@echo '    _kze_update_patch                  - Update patch'
	@echo '    _kze_view_patches                  - View patches'
	@echo '    _kze_view_patches_set              - View set of patches'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kze_create_patch: _kze_edit_patch

_kze_delete_patch:
	@$(INFO) '$(KZE_UI_LABEL)Deleting patch "$(KZE_PATCH_NAME)" ...'; $(NORMAL)
	rm $(KZE_PATCH_FILEPATH)	

_kze_edit_patch:
	@$(INFO) '$(KZE_UI_LABEL)Editing patch "$(KZE_PATCH_NAME)" ...'; $(NORMAL)
	$(EDITOR) $(KZE_PATCH_FILEPATH)

_kze_show_patch :: _kze_show_patch_content _kze_show_patch_description

_kze_show_patch_content:
	@$(INFO) '$(KZE_UI_LABEL)Showing context of patch "$(KZE_PATCH_NAME)" ...'; $(NORMAL)
	-cat $(KZE_PATCH_FILEPATH)
	
_kze_show_patch_description:
	@$(INFO) '$(KZE_UI_LABEL)Showing description of patch "$(KZE_PATCH_NAME)" ...'; $(NORMAL)
	-ls -al $(KZE_PATCH_FILEPATH)

_kze_update_patch: _kze_edit_patch

_kze_view_patches:
	@$(INFO) '$(KZE_UI_LABEL)Viewing patches ...'; $(NORMAL)
	ls -al $(KZE_PATCHES_DIRPATH)

_kze_view_patches_set:
	@$(INFO) '$(KZE_UI_LABEL)Viewing patches-set "$(KZE_PATCHES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Patches are grouped based on directory, regex, and pipe-filter'; $(NORMAL)
	ls -al $(KZE_PATCHES_DIRPATH)$(KZE_PATCHES_REGEX) $(|_KZE_VIEW_PATCHES_SET)
