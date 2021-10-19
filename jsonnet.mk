_JSONNET_MK_VERSION= 0.99.4

# JNT_INPUT_DIRPATH= ./in

# Derived parameters

# Option parameters

# UI parameters
JNT_UI_LABEL?= [jsonnet] #

#--- Utilities

# __JK_ENVIRONMENT+=

__JSONNET_OPTIONS+=

JSONNET_BIN?= jsonnet
JSONNET?= $(strip $(__JSONNET_ENVIRONMENT) $(JSONNET_ENVIRONMENT) $(JSONNET_BIN) $(__JSONNET_OPTIONS) $(JSONNET_OPTIONS))

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _jnt_view_framework_macros
_jnt_view_framework_macros ::
	@echo 'JsonNeT:: ($(_JSONNET_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _jnt_view_framework_parameters
_jnt_view_framework_parameters ::
	@echo 'JsonNeT:: ($(_JSONNET_MK_VERSION)) parameters:'
	@echo '    JSONNET=$(JSONNET)'
	@echo '    JNT_INPUT_DIRPATH=$(JNT_INPUT_DIRPATH)'
	@echo

_view_framework_targets :: _jnt_view_framework_targets
_jnt_view_framework_targets ::
	@echo 'JsonNeT:: ($(_JSONNET_MK_VERSION)) targets:'
	@echo '    _jnt_install_dependencies       - Install dependencies'
	@echo '    _jnt_show_version               - Show version'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/jk_kubernetes.mk


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _jnt_install_dependencies
_jnt_install_dependencies ::
	@$(INFO) '$(JNT_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://github.com/google/jsonnet'; $(NORMAL)
	cd /tmp; rm -rf jsonnet
	cd /tmp; git clone https://github.com/google/jsonnet
	cd /tmp; cd jsonnet; make; chmod +x jsonnet; sudo mv jsonnet /usr/local/bin/
	which jsonnet

_jnt_show_version:
	@$(INFO) '$(JNT_UI_LABEL)Showing version ...'; $(NORMAL)
	$(JSONNET) --version
