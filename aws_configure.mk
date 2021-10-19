_AWS_CONFIGURE_MK_VERSION= 0.99.6

# CFE_CREDENTIALS_FILEPATH?= .aws/credentials

# Derived parameters
CFE_CREDENTIALS_FILEPATH?= $(AWS_CREDENTIALS_FILEPATH)

# Option parameters

# UI parameters
CFE_UI_LABEL?= $(AWS_UI_LABEL)

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _cfe_view_framework_macros
_cfe_view_framework_macros ::
	@#echo 'AWS::ConFigurE ($(_AWS_CONFIGURE_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _cfe_view_framework_parameters
_cfe_view_framework_parameters ::
	@echo 'AWS::ConFigurE ($(_AWS_CONFIGURE_MK_VERSION)) parameters:'
	@echo '    CFE_CREDENTIALS_FILEPATH=$(CFE_CREDENTIALS_FILEPATH)'
	@echo

_aws_view_framework_targets :: _cfe_view_framework_targets
_cfe_view_framework_targets ::
	@echo 'AWS::ConFigurE ($(_AWS_CONFIGURE_MK_VERSION)) targets:'
	@echo '    _cfe_install_dependencies            - Install the dependencies'
	@echo '    _cfe_view_versions                   - View versions of dependencies'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_IR?= .
-include $(MK_DIR)/aws_configure_awsprofile.mk
-include $(MK_DIR)/aws_configure_servicemodel.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#


_aws_install_dependencies :: _cfe_install_dependencies
_cfe_install_dependencies:
	@$(INFO) '$(CFE_UI_LABEL)Install dependencies ...'; $(NORMAL)
	$(SUDO) apt-get install crudini

_aws_view_versions :: _cfe_view_versions
_cfe_view_versions:
	@$(INFO) '$(CFE_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	crudini --version
