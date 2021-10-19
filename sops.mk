_SOPS_MK_VERSION= 0.99.4

# SOPS_AWSPROFILE_NAME?= default
# SOPS_KMSKEY_ARN?= 
# SPS_INPUTS_DIRPATH?= ./in/
# SPS_MODE_DEBUG?= false
# SPS_OUTPUTS_DIRPATH?= ./out/

# Derived variables
SOPS_AWSPROFILE_NAME?= $(AWS_PROFILE_NAME)
SOPS_KMSKEY_ARN?= $(KMS_KEY_ARN)
SPS_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
SPS_MODE_DEBUG?= $(CMN_MODE_DEBUG)
SPS_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)

# Options variables

# UI parameters
SPS_UI_LABEL?= [sops] #

# Utilities
__SOPS_OPTIONS+= $(if $(SOPS_AWSPROFILE_NAME),--aws-profile $(SOPS_AWSPROFILE_NAME)) 
__SOPS_OPTIONS+= $(if $(SOPS_KMSKEY_ARN),--kms $(SOPS_KMSKEY_ARN)) 

SOPS_BIN?= sops
SOPS?= $(strip $(__SOPS_ENVIRONMENT) $(SOPS_ENVIRONMENT) $(SOPS_BIN) $(__SOPS_OPTIONS) $(SOPS_OPTIONS))
SOPS_VERSION?= 3.5.0

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _sps_view_framework_macros
_sps_view_framework_macros ::
	@echo 'SoPS ($(_SOPS_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _sps_view_framework_parameters
_sps_view_framework_parameters ::
	@echo 'SoPS ($(_SOPS_MK_VERSION)) parameters:'
	@echo '    SOPS=$(SOPS)'
	@#echo '    SOPS_AWSPROFILE_NAME=$(SOPS_AWSPROFILE_NAME)'
	@#echo '    SOPS_KMSKEY_ARN=$(SOPS_KMSKEY_ARN)'
	@echo '    SPS_INPUTS_DIRPATH=$(SPS_INPUTS_DIRPATH)'
	@echo '    SPS_MODE_DEBUG=$(SPS_MODE_DEBUG)'
	@echo '    SPS_OUTPUTS_DIRPATH=$(SPS_OUTPUTS_DIRPATH)'
	@echo

_view_framework_targets :: _sps_view_framework_targets
_sps_view_framework_targets ::
	@echo 'SoPS ($(_SOPS_MK_VERSION)) targets:'
	@echo '    _sps_install_dependencies          - Install dependencies'
	@echo '    _sps_show_version                  - Show version of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/sops_config.mk
-include $(MK_DIR)/sops_sopsfile.mk
-include $(MK_DIR)/sops_yamlfile.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _sps_install_dependencies
_sps_install_dependencies ::
	@$(INFO) '$(SPS_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	# Install GOLANG? https://www.tecmint.com/install-go-in-linux/
	# wget -c https://storage.googleapis.com/golang/go1.14.2.linux-amd64.tar.gz
	# tar -C -C /usr/local -xvzf go1.14.2.linux-amd64.tar.gz
	# OR $(SUDO) apt install golang
	@$(WARN) 'Install docs at https://github.com/mozilla/sops'; $(NORMAL)
	$(SUDO) wget -O /usr/local/bin/sops https://github.com/mozilla/sops/releases/download/v3.5.0/sops-v3.5.0.linux
	$(SUDO) chmod +x /usr/local/bin/sops 
	which sops
	sops --version

_view_versions:: _sps_view_versions
_sps_view_versions:
	@$(INFO) '$(SPS_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	# go version
	sops --version
