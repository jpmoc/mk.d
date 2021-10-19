_TERRAFORM_MK_VERSION= 0.99.4

TFM_AUTOAPPROVE_FLAG?= false
TFM_ASKFORMISSINGVARIABLES_FLAG?= true
TFM_COLOR_FLAG?= false
# TFM_INPUTS_DIRPATH?= ./in/
TFM_LOCK_FLAG?= true
TFM_LOCK_TIMEOUT?= 0s
# TFM_MODE_DEBUG?= false
# TFM_MODE_YES?= false
# TFM_OUTPUTS_DIRPATH?= ./out/
TFM_PARALLELISM_COUNT?= 10
# TFM_PROJECT_NAME?= my-project
TFM_REFRESHSTATE_FLAG?= true
# TFM_VARIABLES_KEYVALUES?= region=us-west-2 ...
# TFM_VARIABLES_DIRPATH?= ./in/
# TFM_VARIABLES_FILENAME?= terraform.tfvars
# TFM_VARIABLES_FILEPATH?= ./in/variables.tfvars
# TFM_VARIABLES_FILEPATH?= ./in/variables.tfvars ...

# Derived variables
TFM_MODE_DEBUG?= $(CMN_MODE_DEBUG)
TFM_MODE_YES?= $(CMN_MODE_YES)
TFM_VARIABLES_DIRPATH?= $(TFM_TEMPLATE_DIRPATH)
TFM_VARIABLES_FILEPATH?= $(if $(TFM_VARIABLES_FILENAME),$(TFM_VARIABLES_DIRPATH)$(TFM_VARIABLES_FILENAME))
TFM_VARIABLES_FILEPATHS?= $(TFM_VARIABLES_FILEPATH)

# Options variables

# UI parameters
TFM_UI_LABEL?= [terraform] #

# Utilities
__TERRAFORM_ENVIRONMENT+= $(if $(filter true, $(TFM_MODE_DEBUG)), OS_DEBUG=1)
__TERRAFORM_ENVIRONMENT+= $(if $(filter true, $(TFM_MODE_DEBUG)), TF_LOG=DEBUG)

TERRAFORM_BIN?= terraform
TERRAFORM_VERSION?= 0.12.12
TERRAFORM?= $(strip $(__TERRAFORM_ENVIRONMENT) $(TERRAFORM_ENVIRONMENT) $(TERRAFORM_BIN) $(__TERRAFORM_OPTIONS) $(TERRAFORM_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _tfm_view_framework_macros
_tfm_view_framework_macros ::
	@echo 'TerraForM ($(_TERRAFORM_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _tfm_view_framework_parameters
_tfm_view_framework_parameters ::
	@echo 'TerraForM ($(_TERRAFORM_MK_VERSION)) parameters:'
	@echo '    TERRAFORM=$(TERRAFORM)'
	@echo '    TERRAFORM_VERSION=$(TERRAFORM_VERSION)'
	@echo '    TFM_ASKFORMISSINGVARIABLES_FLAG=$(TFM_ASKFORMISSINGVARIABLES_FLAG)'
	@echo '    TFM_AUTOAPPROVE_FLAG=$(TFM_AUTOAPPROVE_FLAG)'
	@echo '    TFM_COLOR_FLAG=$(TFM_COLOR_FLAG)'
	@echo '    TFM_INPUTS_DIRPATH=$(TFM_INPUTS_DIRPATH)'
	@echo '    TFM_LOCK_FLAG=$(TFM_LOCK_FLAG)'
	@echo '    TFM_LOCK_TIMEOUT=$(TFM_LOCK_TIMEOUT)'
	@echo '    TFM_MODE_DEBUG=$(TFM_MODE_DEBUG)'
	@echo '    TFM_MODE_YES=$(TFM_MODE_YES)'
	@echo '    TFM_OUTPUTS_DIRPATH=$(TFM_OUTPUTS_DIRPATH)'
	@echo '    TFM_PARALLELISM_COUNT=$(TFM_PARALLELISM_COUNT)'
	@echo '    TFM_PROJECT_NAME=$(TFM_PROJECT_NAME)'
	@echo '    TFM_REFRESHSTATE_FLAG=$(TFM_REFRESHSTATE_FLAG)'
	@echo '    TFM_VARIABLES_DIRPATH=$(TFM_VARIABLES_DIRPATH)'
	@echo '    TFM_VARIABLES_FILENAME=$(TFM_VARIABLES_FILENAME)'
	@echo '    TFM_VARIABLES_FILEPATH=$(TFM_VARIABLES_FILEPATH)'
	@echo '    TFM_VARIABLES_FILEPATHS=$(TFM_VARIABLES_FILEPATHS)'
	@echo '    TFM_VARIABLES_KEYVALUES=$(TFM_VARIABLES_KEYVALUES)'
	@echo

_view_framework_targets :: _tfm_view_framework_targets
_tfm_view_framework_targets ::
	@echo 'TerraForM ($(_TERRAFORM_MK_VERSION)) targets:'
	@echo '    _tfm_install_dependencies          - Install dependencies'
	@echo '    _tfm_show_version                  - Show version of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/terraform_config.mk
-include $(MK_DIR)/terraform_environment.mk
-include $(MK_DIR)/terraform_graph.mk
-include $(MK_DIR)/terraform_plan.mk
-include $(MK_DIR)/terraform_resource.mk
-include $(MK_DIR)/terraform_stack.mk
-include $(MK_DIR)/terraform_state.mk
-include $(MK_DIR)/terraform_template.mk
-include $(MK_DIR)/terraform_tfeserver.mk
-include $(MK_DIR)/terraform_workspace.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _tfm_install_dependencies
_tfm_install_dependencies ::
	@$(INFO) '$(TFM_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs at https://www.terraform.io/downloads.html'; $(NORMAL)
	@$(WARN) 'Install docs at https://computingforgeeks.com/how-to-install-terraform-on-ubuntu-centos-7/'; $(NORMAL)
	sudo apt-get install -y feh graphviz wget unzip
	cd /tmp; wget https://releases.hashicorp.com/terraform/$(TERRAFORM_VERSION)/terraform_$(TERRAFORM_VERSION)_linux_amd64.zip
	cd /tmp; unzip terraform_$(TERRAFORM_VERSION)_linux_amd64.zip
	sudo mv /tmp/terraform /usr/local/bin/terraform
	which terraform
	terraform --version

_view_versions:: _tfm_show_version
_tfm_show_version:
	@$(INFO) '$(TFM_UI_LABEL)Show version ...'; $(NORMAL)
	terraform --version
