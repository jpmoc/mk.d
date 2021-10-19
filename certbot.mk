_CERTBOT_MK_VERSION= 0.99.4

CERTBOT_SUDO_FLAG?= false
# CBT_INPUTS_DIRPATH= ./in/
# CBT_OUTPUTS_DIRPATH= ./out/

# Derived parameters
CBT_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
CBT_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)

# Option parameters

# UI parameters
CBT_UI_LABEL?= [certbot] #

#--- Utilities

# __CERTBOT_ENVIRONMENT+=
SUDO__CERTBOT= $(if $(filter true,$(CERTBOT_SUDO_FLAG)),sudo)
__CERTBOT_OPTIONS+= $(if $(CMM_MODE_DEBUG), --debug)

CERTBOT_BIN?= certbot
CERTBOT?= $(strip $(SUDO__CERTBOT) $(__CERTBOT_ENVIRONMENT) $(CERTBOT_ENVIRONMENT) $(CERTBOT_BIN) $(__CERTBOT_OPTIONS) $(CERTBOT_OPTIONS))

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _cbt_view_framework_macros
_cbt_view_framework_macros ::
	@echo 'CertBoT:: ($(_CERTBOT_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _cbt_view_framework_parameters
_cbt_view_framework_parameters ::
	@echo 'CertBoT:: ($(_CERTBOT_MK_VERSION)) parameters:'
	@echo '    CBT_INPUTS_DIRPATH=$(CBT_INPUTS_DIRPATH)'
	@echo '    CBT_OUTPUTS_DIRPATH=$(CBT_OUTPUTS_DIRPATH)'
	@echo '    CERTBOT=$(CERTBOT)'
	@echo

_view_framework_targets :: _cbt_view_framework_targets
_cbt_view_framework_targets ::
	@echo 'CertBoT:: ($(_CERTBOT_MK_VERSION)) targets:'
	@echo '    _cbt_install_dependencies       - Install dependencies'
	@echo '    _cbt_show_version               - Show version'
	@echo '    _cbt_view_plugins               - View plugins'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/certbot_certificate.mk


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _cbt_install_dependencies
_cbt_install_dependencies ::
	@$(INFO) '$(CBT_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://certbot.eff.org/docs/install.html#operating-system-packages'; $(NORMAL)
	@$(WARN) 'Install docs @ https://www.ceos3c.com/open-source/install-certbot-ubuntu-16-04-auto-cert-renew/'; $(NORMAL)
	$(SUDO) apt-get update -y && sudo apt-get upgrade -y
	$(SUDO) apt-get install software-properties-common
	$(SUDO) add-apt-repository -y ppa:certbot/certbot
	$(SUDO) apt-get update
	$(SUDO) apt-get install -y certbot python-certbot-apache
	which certbot
	ls -la /usr/bin/certbot
	@$(INFO) '$(CBT_UI_LABEL)Installing certbot-auto ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://certbot.eff.org/docs/install.html#alternate-installation-methods'; $(NORMAL)
	wget https://dl.eff.org/certbot-auto
	chmod +x certbot-auto
	$(SUDO) mv certbot-auto /usr/local/bin
	which certbot-auto
	@$(INFO) '$(CBT_UI_LABEL)Installing plugins ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://devops.stackexchange.com/questions/3757/how-to-install-certbot-plugins'; $(NORMAL)
	# Not sure this works on bionic
	# $(SUDO) pip3 install certbot
	# $(SUDO) pip3 install certbot-dns-azure
	# $(SUDO) pip3 install certbot-dns-digitalocean
	# $(SUDO) pip3 install certbot-dns-route53

_cbt_view_versions:
	@$(INFO) '$(CBT_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	$(CERTBOT) --version

_cbt_view_plugins:
	@$(INFO) '$(CBT_UI_LABEL)View plugins ...'; $(NORMAL)
	certbot-auto plugins 

