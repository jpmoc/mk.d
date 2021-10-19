_SOPS_YAMLFILE_MK_VERSION= 0.99.4

# SPS_YAMLFILE_DIRPATH?= ./in/
# SPS_YAMLFILE_ENCRYPT_REGEX?= "^(data|stringData)$"
# SPS_YAMLFILE_FILENAME?= file.yaml
# SPS_YAMLFILE_FILEPATH?= ./in/file.yaml
SPS_YAMLFILE_INPLACE_FLAG?= false
# SPS_YAMLFILE_NAME?= file
# SPS_YAMLFILES_DIRPATH?= ./in/
SPS_YAMLFILES_REGEX?= *.yaml
# SPS_YAMLFILES_SET_NAME?= my-yaml-files-set

# Derived variables
SPS_YAMLFILE_NAME?= $(basename $(SPS_YAMLFILE_FILENAME))
SPS_YAMLFILE_DIRPATH?= $(SPS_INPUTS_DIRPATH)
SPS_YAMLFILE_FILEPATH?= $(SPS_YAMLFILE_DIRPATH)$(SPS_YAMLFILE_FILENAME)
SPS_YAMLFILES_DIRPATH?= $(SPS_YAMLFILE_DIRPATH)
SPS_YAMLFILES_SET_NAME?= yaml-files@$(SPS_YAMLFILES_DIRPATH)@$(SPS_YAMLFILES_REGEX)

# Options variables
__SPS_ENCRYPTED_REGEX= $(if $(SPS_YAMLFILE_ENCRYPT_REGEX),--encrypted-regex $(SPS_YAMLFILE_ENCRYPT_REGEX))
__SPS_IN_PLACE__YAMLFILE= $(if $(filter true,$(SDS_YAMLFILE_INPLACE_FLAG)),--in-place)

# UI parameters

# Pipe
|_SPS_ENCRYPT_YAMLFILE?= $(if $(filter false,$(SPS_YAMLFILE_INPLACE_FLAG)),| tee $(SPS_SOPSFILE_FILEPATH))

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_sps_view_framework_macros ::
	@echo 'SoPS::YamlFile ($(_SOPS_YAMLFILE_MK_VERSION)) macros:'
	@echo

_sps_view_framework_parameters ::
	@echo 'SoPS::YamlFile ($(_SOPS_YAMLFILE_MK_VERSION)) parameters:'
	@echo '    SPS_YAMLFILE_DIRPATH=$(SPS_YAMLFILE_DIRPATH)'
	@echo '    SPS_YAMLFILE_ENCRYPT_REGEX=$(SPS_YAMLFILE_ENCRYPT_REGEX)'
	@echo '    SPS_YAMLFILE_FILENAME=$(SPS_YAMLFILE_FILENAME)'
	@echo '    SPS_YAMLFILE_FILEPATH=$(SPS_YAMLFILE_FILEPATH)'
	@echo '    SPS_YAMLFILE_INPLACE_FLAG=$(SPS_YAMLFILE_INPLACE_FLAG)'
	@echo '    SPS_YAMLFILE_NAME=$(SPS_YAMLFILE_NAME)'
	@echo '    SPS_YAMLFILES_DIRPATH=$(SPS_YAMLFILES_DIRPATH)'
	@echo '    SPS_YAMLFILES_REGEX=$(SPS_YAMLFILES_REGEX)'
	@echo '    SPS_YAMLFILES_SET_NAME=$(SPS_YAMLFILES_SET_NAME)'
	@echo

_sps_view_framework_targets ::
	@echo 'SoPS::YamlFile ($(_SOPS_YAMLFILE_MK_VERSION)) targets:'
	@echo '    _sps_create_yamlfile              - Create a YAML-file'
	@echo '    _sps_delete_yamlfile              - Delete a YAML-file'
	@echo '    _sps_edit_yamlfile                - Edit a YAML-file'
	@echo '    _sps_encrypt_yamlfile             - Encrypt a YAML-file'
	@echo '    _sps_show_yamlfile                - Show everything related to a YAML-file' 
	@echo '    _sps_show_yamlfiler_content       - Show content of a YAML-file' 
	@echo '    _sps_show_yamlfiler_description   - Show description of a YAML-file' 
	@echo '    _sps_view_yamlfiles               - View ALL YAML-files' 
	@echo '    _sps_view_yamlfiles_set           - View a set of YAML-files' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sps_create_yamlfile:
	@$(INFO) '$(SPS_UI_LABEL)Creating YAML-file "$(SPS_YAMLFILE_NAME)" ...'; $(NORMAL)

_sps_delete_yamlfile:
	@$(INFO) '$(SPS_UI_LABEL)Deleting YAML-file "$(SPS_YAMLFILE_NAME)" ...'; $(NORMAL)
	# rm -rf $(SPS_YAMLFILE_FILEPATH)

_sps_edit_yamlfile:
	@$(INFO) '$(SPS_UI_LABEL)Editing YAML-file "$(SPS_YAMLFILE_NAME)" ...'; $(NORMAL)
	$(EDITOR) $(SPS_YAMLFILE_FILEPATH)

_sps_encrypt_yamlfile:
	@$(INFO) '$(SPS_UI_LABEL)Encrypting YAML-file "$(SPS_YAMLFILE_NAME)" ...'; $(NORMAL)
	$(SOPS) --encrypt $(__SPS_ENCRYPTED_REGEX) $(SPS_YAMLFILE_FILEPATH) $(|_SPS_ENCRYPT_YAMLFILE)

_sps_show_yamlfile: _sps_show_yamlfile_content _sps_show_yamlfile_description

_sps_show_yamlfile_description:
	@$(INFO) '$(SPS_UI_LABEL)Showing description of YAML-file "$(SPS_YAMLFILE_NAME)" ...'; $(NORMAL)
	ls -al $(SPS_YAMLFILE_FILEPATH)

_sps_show_yamlfile_content:
	@$(INFO) '$(SPS_UI_LABEL)Showing content of YAML-file "$(SPS_YAMLFILE_NAME)" ...'; $(NORMAL)
	cat $(SPS_YAMLFILE_FILEPATH)

_sps_view_yamlfiles:
	@$(INFO) '$(SPS_UI_LABEL)Viewing ALL YAML-files ...'; $(NORMAL)
	ls -al $(SPS_YAMLFILES_DIRPATH)

_sps_view_yamlfiles_set:
	@$(INFO) '$(SPS_UI_LABEL)Viewing YAML-files-set "$(SPS_YAMLFILES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The YAML-files are grouped based on the provided directory and regex'; $(NORMAL)
	ls -al $(SPS_YAMLFILES_DIRPATH)$(SPS_YAMLFILES_REGEX)
