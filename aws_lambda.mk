_AWS_LAMBDA_MK_VERSION= 0.99.0

# LBA_ACCOUNT_ID?= 123456789012
# LBA_REGION_NAME?= us-west-2

# Derived parameters
LBA_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)
LBA_REGION_NAME?= $(AWS_REGION_NAME)

# Option parameters

# UI parameters

#--- Utilities

#--- Macros


#----------------------------------------------------------------------
# USAGE
#

_aws_install_software_dependencies :: _lba_install_software_dependencies
_lba_install_software_dependencies ::
	sudo apt-get install --upgrade zip

	# Node 8 @ https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
	curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
	sudo apt-get install -y nodejs
	/usr/bin/node --version        # v8.11.1
	/usr/bin/nodejs --version      # v8.11.1
	/usr/bin/npm --version         # v5.6.0
	sudo apt-get install -y build-essential


_aws_view_framework_macros :: _lba_view_framework_macros
_lba_view_framework_macros ::
	@#echo 'AWS::LamBdA:: ($(_AWS_LAMBDA_MK_VERSION)) targets:'
	@#echo

_aws_view_framework_parameters :: _lba_view_framework_parameters
_lba_view_framework_parameters ::
	@echo 'AWS::LamBdA:: ($(_AWS_LAMBDA_MK_VERSION)) parameters:'
	@echo '    LBA_ACCOUNT_ID=$(LBA_ACCOUNT_ID)'
	@echo '    LBA_REGION_NAME=$(LBA_REGION_NAME)'
	@echo

_aws_view_framework_targets :: _lba_view_framework_targets
_lba_view_framework_targets ::
	@echo 'AWS::LamBdA:: ($(_AWS_LAMBDA_MK_VERSION)) targets:'
	@echo '    _lba_view_account_limits            - Retrieve lambda-service limits information'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

MK_DIR?= .
-include $(MK_DIR)/aws_lambda_eventsourcemapping.mk
-include $(MK_DIR)/aws_lambda_function.mk
-include $(MK_DIR)/aws_lambda_functionalias.mk
-include $(MK_DIR)/aws_lambda_layer.mk
-include $(MK_DIR)/aws_lambda_layerversion.mk
-include $(MK_DIR)/aws_lambda_package.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_aws_view_account_limits :: _lba_view_account_limits
_lba_view_account_limits:
	@$(INFO) '$(AWS_UI_LABEL)Retrieving lambda service limits information ...'; $(NORMAL)
	$(AWS) lambda get-account-settings
