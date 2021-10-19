_SOPS_SOPSFILE_MK_VERSION= 0.99.4

# SPS_SOPSFILE_DIRPATH?= ./in/
# SPS_SOPSFILE_FILENAME?= file.sops.yaml
# SPS_SOPSFILE_FILEPATH?= ./in/file.sops.yaml
SPS_SOPSFILE_INPLACE_FLAG?= false
# SPS_SOPSFILE_NAME?= file
# SPS_SOPSFILES_DIRPATH?= ./in/
# SPS_SOPSFILES_DIRPATH?= ./out/
SPS_SOPSFILES_REGEX?= *.sops.yaml
SPS_SOPSFILES_OUT_REGEX?= *.sops.yaml
# SPS_SOPSFILES_SET_NAME?= my-sops-files-set

# Derived variables
SPS_SOPSFILE_NAME?= $(basename $(SPS_SOPSFILE_FILENAME))
SPS_SOPSFILE_DIRPATH?= $(SPS_INPUTS_DIRPATH)
SPS_SOPSFILE_FILEPATH?= $(SPS_SOPSFILE_DIRPATH)$(SPS_SOPSFILE_FILENAME)
SPS_SOPSFILES_DIRPATH?= $(SPS_SOPSFILE_DIRPATH)
SPS_SOPSFILES_SET_NAME?= SOPS-files@$(SPS_SOPSFILES_DIRPATH)@$(SPS_SOPSFILES_REGEX)

# Options variables
__SPS_IN_PLACE= $(if $(filter true,$(SDS_SOPSFILE_INPLACE_FLAG)),--in-place)

# UI parameters

# Pipe
|_SPS_DECRYPT_SOPSFILE?= $(if $(filter false,$(SPS_SOPSFILE_INPLACE_FLAG)),| tee $(SPS_YAMLFILE_FILEPATH))

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_sps_view_framework_macros ::
	@echo 'SoPS::SopsFile ($(_SOPS_SOPSFILE_MK_VERSION)) macros:'
	@echo

_sps_view_framework_parameters ::
	@echo 'SoPS::SopsFile ($(_SOPS_SOPSFILE_MK_VERSION)) parameters:'
	@echo '    SPS_SOPSFILE_DIRPATH=$(SPS_SOPSFILE_DIRPATH)'
	@echo '    SPS_SOPSFILE_FILENAME=$(SPS_SOPSFILE_FILENAME)'
	@echo '    SPS_SOPSFILE_FILEPATH=$(SPS_SOPSFILE_FILEPATH)'
	@echo '    SPS_SOPSFILE_INPLACE_FLAG=$(SPS_SOPSFILE_INPLACE_FLAG)'
	@echo '    SPS_SOPSFILE_NAME=$(SPS_SOPSFILE_NAME)'
	@echo '    SPS_SOPSFILES_DIRPATH=$(SPS_SOPSFILES_DIRPATH)'
	@echo '    SPS_SOPSFILES_REGEX=$(SPS_SOPSFILES_REGEX)'
	@echo '    SPS_SOPSFILES_SET_NAME=$(SPS_SOPSFILES_SET_NAME)'
	@echo

_sps_view_framework_targets ::
	@echo 'SoPS::SopsFile ($(_SOPS_SOPSFILE_MK_VERSION)) targets:'
	@echo '    _sps_create_sopsfile              - Create a SOPS-file'
	@echo '    _sps_delete_sopsfile              - Delete a SOPS-file'
	@echo '    _sps_encrypt_sopsfile             - Encrypt a SOPS-file'
	@echo '    _sps_decrypt_sopsfile             - Decrypt a SOPS-file'
	@echo '    _sps_show_sopsfile                - Show everything related to a SOPS-file' 
	@echo '    _sps_show_sopsfiler_content       - Show content of a SOPS-file' 
	@echo '    _sps_show_sopsfiler_description   - Show description of a SOPS-file' 
	@echo '    _sps_view_sopsfiles               - View ALL SOPS-files' 
	@echo '    _sps_view_sopsfiles_set           - View a set of SOPS-files' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sps_create_sopsfile:
	@$(INFO) '$(SPS_UI_LABEL)Creating SOPS-file "$(SPS_SOPSFILE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the defautl created file is left as-is'; $(NORMAL)
	$(SOPS) $(SPS_SOPSFILE_FILEPATH)

_sps_delete_sopsfile:
	@$(INFO) '$(SPS_UI_LABEL)Deleting SOPS-file "$(SPS_SOPSFILE_NAME)" ...'; $(NORMAL)
	# rm -rf $(SPS_SOPSFILE_FILEPATH)

_sps_decrypt_sopsfile:
	@$(INFO) '$(SPS_UI_LABEL)Decrypting SOPS-file "$(SPS_SOPSFILE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation uses the included metadata (sops key) to decrypt the file-s content'; $(NORMAL)
	$(SOPS) -d $(SPS_SOPSFILE_FILEPATH) $(|_SPS_DECRYPT_SOPSFILE)

_sps_show_sopsfile: _sps_show_sopsfile_content _sps_show_sopsfile_description

_sps_show_sopsfile_description:
	@$(INFO) '$(SPS_UI_LABEL)Showing description of SOPS-file "$(SPS_SOPSFILE_NAME)" ...'; $(NORMAL)
	ls -al $(SPS_SOPSFILE_FILEPATH)

_sps_show_sopsfile_content:
	@$(INFO) '$(SPS_UI_LABEL)Showing content of SOPS-file "$(SPS_SOPSFILE_NAME)" ...'; $(NORMAL)
	cat $(SPS_SOPSFILE_FILEPATH)

_sps_view_sopsfiles:
	@$(INFO) '$(SPS_UI_LABEL)Viewing ALL SOPS-files ...'; $(NORMAL)
	ls -al $(SPS_SOPSFILES_DIRPATH)

_sps_view_sopsfiles_set:
	@$(INFO) '$(SPS_UI_LABEL)Viewing SOPS-files-set "$(SPS_SOPSFILES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The SOPS files are grouped based on the provided directory and regex'; $(NORMAL)
	ls -al $(SPS_SOPSFILES_DIRPATH)$(SPS_SOPSFILES_REGEX)
