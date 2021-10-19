_CFSSL_MK_VERSION= 0.99.4

# CFL_INPUTS_DIRPATH= ./in/
# CFL_OUTPUTS_DIRPATH= ./out/

# Derived parameters
CFL_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
CFL_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)

# Option parameters

# UI parameters
CFL_UI_LABEL?= [cfssl] #

#--- Utilities

# __CFSSL_ENVIRONMENT+=
__CFSSL_OPTIONS+=

CFSSL_BIN?= cfssl
CFSSL?= $(strip $(__CFSSL_ENVIRONMENT) $(CFSSL_ENVIRONMENT) $(CFSSL_BIN) $(__CFSSL_OPTIONS) $(CFSSL_OPTIONS))

CFSSLJSON_BIN?= cfssljson
CFSSLJSON?= $(strip $(__CFSSLJSON_ENVIRONMENT) $(CFSSLJSON_ENVIRONMENT) $(CFSSLJSON_BIN) $(__CFSSLJSON_OPTIONS) $(CFSSLJSON_OPTIONS))

CFSSL_VERSION?= 1.2

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _cfl_view_framework_macros
_cfl_view_framework_macros ::
	@echo 'CFssL ($(_CFSSL_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _cfl_view_framework_parameters
_cfl_view_framework_parameters ::
	@echo 'CFssL ($(_CFSSL_MK_VERSION)) parameters:'
	@echo '    CFL_INPUTS_DIRPATH=$(CFL_INPUTS_DIRPATH)'
	@echo '    CFL_OUTPUTS_DIRPATH=$(CFL_OUTPUTS_DIRPATH)'
	@echo '    CFSSL=$(CFSSL)'
	@echo '    CFSSL_VERSION=$(CFSSL_VERSION)'
	@echo '    CFSSLJSON=$(CFSSLJSON)'
	@echo

_view_framework_targets :: _cfl_view_framework_targets
_cfl_view_framework_targets ::
	@echo 'CFssL ($(_CFSSL_MK_VERSION)) targets:'
	@echo '    _cfl_install_dependencies       - Install dependencies'
	@echo '    _cfl_view_version               - Show version'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/cfssl_cacert.mk
-include $(MK_DIR)/cfssl_certificate.mk
-include $(MK_DIR)/cfssl_certificatesigningrequest.mk
-include $(MK_DIR)/cfssl_server.mk


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _cfl_install_dependencies
_cfl_install_dependencies ::
	@$(INFO) '$(CFL_UI_LABEL)Installaing dependencies...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://github.com/cloudflare/cfssl'; $(NORMAL)
	$(foreach B, cfssl cfssl-bundle cfss-certinfo cfssl-newkey cfssl-scan cfssljson, \
		cd /usr/local/bin; \
		$(SUDO) curl --location --silent --output $(B)-$(CFSSL_VERSION) https://pkg.cfssl.org/R$(CFSSL_VERSION)/$(B)_linux-amd64; \
		$(SUDO) chmod +x $(B)-$(CFSSL_VERSION); \
		$(SUDO) rm -f $(B); \
		$(SUDO) ln -s $(B)-$(CFSSL_VERSION) $(B); \
		which $(B); \
	)

_view_versions :: _cfl_view_versions
_cfl_view_versions:
	@$(INFO) '$(CFL_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	$(CFSSL) version
	@echo 'cfssl            $(CFSSL_VERSION)'
	@echo 'cfssl-bundle     $(CFSSL_VERSION)'
	@echo 'cfssl-certinfo   $(CFSSL_VERSION)'
	@echo 'cfssl-newkey     $(CFSSL_VERSION)'
	@echo 'cfssl-scan       $(CFSSL_VERSION)'
	@echo 'cfssljson        $(CFSSL_VERSION)'
	@echo 'mkbundle         $(CFSSL_VERSION)'
	@echo 'multirootca      $(CFSSL_VERSION)'

_install_framework_dependencies :: _csl_install_dependencies
_csl_install_dependencies ::
