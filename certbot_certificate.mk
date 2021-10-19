_CERTBOT_CERTIFICATE_MK_VERSION= $(_CERTBOT_MK_VERSION)

CBT_CERTIFICATE_AGREETOS_FLAG?= false
# CBT_CERTIFICATE_CERT_FILEPATH?= .../live/name/cert.pem
# CBT_CERTIFICATE_CHAIN_FILEPATH?= .../live/name/chain.pem
# CBT_CERTIFICATE_CHALLENGE_TYPE?= dns-01
# CBT_CERTIFICATE_CONFIG_DIRPATH?= ./
# CBT_CERTIFICATE_DIRPATH?= *.domain.com
# CBT_CERTIFICATE_DOMAIN_NAME?= *.domain.com
CBT_CERTIFICATE_DNSROUTE53_FLAG?= false
# CBT_CERTIFICATE_EMAIL?= me@domain.com
# CBT_CERTIFICATE_FULLCHAIN_FILEPATH?= .../live/name/fullchain.pem
CBT_CERTIFICATE_LOGS_DIRPATH?= /var/log/letsencrypt
CBT_CERTIFICATE_LOGS_FILENAME?= letsencrypt.log
# CBT_CERTIFICATE_LOGS_FILEPATH?= /var/log/letsencrypt/letsencrypt.log
CBT_CERTIFICATE_MANUAL_FLAG?= false
# CBT_CERTIFICATE_NAME?= servicemesh.biz
# CBT_CERTIFICATE_PRIVKEY_FILEPATH?= .../live/name/privkey.pem
CBT_CERTIFICATE_STANDALONE_FLAG?= false
# CBT_CERTIFICATE_WORK_DIRPATH?= ./
# CBT_CERTIFICATES_SET_NAME?= my-certificates-set

# Derived parameters
CBT_CERTIFICATE_ARCHIVE_DIRPATH?= $(CBT_CERTIFICATE_CONFIG_DIRPATH)archive/$(CBT_CERTIFICATE_DOMAIN_NAME)
CBT_CERTIFICATE_CERT_FILEPATH?= $(CBT_CERTIFICATE_DIRPATH)cert.pem
CBT_CERTIFICATE_CHAIN_FILEPATH?= $(CBT_CERTIFICATE_DIRPATH)chain.pem
CBT_CERTIFICATE_DIRPATH?= $(CBT_CERTIFICATE_CONFIG_DIRPATH)live/$(CBT_CERTIFICATE_DOMAIN_NAME)/
CBT_CERTIFICATE_FULLCHAIN_FILEPATH?= $(CBT_CERTIFICATE_DIRPATH)fullchain.pem
CBT_CERTIFICATE_LOGS_FILEPATH?= $(CBT_CERTIFICATE_LOGS_DIRPATH)$(CBT_CERTIFICATE_LOGS_FILENAME)
CBT_CERTIFICATE_NAME?= $(CBT_CERTIFICATE_DOMAIN_NAME)
CBT_CERTIFICATE_PRIVKEY_FILEPATH?= $(CBT_CERTIFICATE_DIRPATH)privkey.pem

# Option parameters
__CBT_AGREE_TOS= $(if $(filter true,$(CBT_CERTIFICATE_AGREETOS_FLAG)),--agree-tos)
__CBT_APACHE=
__CBT_CONFIG_DIR= $(if $(CBT_CERTIFICATE_CONFIG_DIRPATH),--config-dir $(CBT_CERTIFICATE_CONFIG_DIRPATH))
__CBT_DOMAIN= $(if $(CBT_CERTIFICATE_DOMAIN_NAME),-d $(CBT_CERTIFICATE_DOMAIN_NAME))
__CBT_DNS_ROUTE53= $(if $(filter true,$(CBT_CERTIFICATE_DNSROUTE53_FLAG)),--dns-route53)
__CBT_EMAIL= $(if $(CBT_CERTIFICATE_EMAIL),--email $(CBT_CERTIFICATE_EMAIL))
__CBT_LOGS_DIR= $(if $(CBT_CERTIFICATE_LOGS_DIRPATH),--logs-dir $(CBT_CERTIFICATE_LOGS_DIRPATH))
__CBT_MANUAL= $(if $(filter true,$(CBT_CERTIFICATE_MANUAL_FLAG)),--manual)
__CBT_NGINX=
__CBT_PREFERRED_CHALLENGES= $(if $(CBT_CERTIFICATE_CHALLENGE_TYPE),--preferred-challenges=$(CBT_CERTIFICATE_CHALLENGE_TYPE))
__CBT_STANDALONE= $(if $(filter true,$(CBT_CERTIFICATE_STANDALONE_FLAG)),--standalone)
__CBT_WEBROOT=
__CBT_WORK_DIR= $(if $(CBT_CERTIFICATE_WORK_DIRPATH),--work-dir $(CBT_CERTIFICATE_WORK_DIRPATH))

# UI parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_cbt_view_framework_macros ::
	@echo 'CertBoT::Certificate ($(_CERTBOT_CERTIFICATE_MK_VERSION)) macros:'
	@echo

_cbt_view_framework_parameters ::
	@echo 'CertBoT::Certificate ($(_CERTBOT_CERTIFICATE_MK_VERSION)) variables:'
	@echo '    CBT_CERTIFICATE_AGREETOS_FLAG=$(CBT_CERTIFICATE_AGREETOS_FLAG)'
	@echo '    CBT_CERTIFICATE_ARCHIVE_DIRPATH=$(CBT_CERTIFICATE_ARCHIVE_DIRPATH)'
	@echo '    CBT_CERTIFICATE_CERT_FILEPATH=$(CBT_CERTIFICATE_CERT_FILEPATH)'
	@echo '    CBT_CERTIFICATE_CHAIN_FILEPATH=$(CBT_CERTIFICATE_CHAIN_FILEPATH)'
	@echo '    CBT_CERTIFICATE_CHALLENGE_TYPE=$(CBT_CERTIFICATE_CHALLENGE_TYPE)'
	@echo '    CBT_CERTIFICATE_CONFIG_DIRPATH=$(CBT_CERTIFICATE_CONFIG_DIRPATH)'
	@echo '    CBT_CERTIFICATE_DIRPATH=$(CBT_CERTIFICATE_DIRPATH)'
	@echo '    CBT_CERTIFICATE_DOMAIN_NAME=$(CBT_CERTIFICATE_DOMAIN_NAME)'
	@echo '    CBT_CERTIFICATE_DNSROUTE53_FLAG=$(CBT_CERTIFICATE_DNSROUTE53_FLAG)'
	@echo '    CBT_CERTIFICATE_EMAIL=$(CBT_CERTIFICATE_EMAIL)'
	@echo '    CBT_CERTIFICATE_FULLCHAIN_FILEPATH=$(CBT_CERTIFICATE_FULLCHAIN_FILEPATH)'
	@echo '    CBT_CERTIFICATE_LOGS_DIRPATH=$(CBT_CERTIFICATE_LOGS_DIRPATH)'
	@echo '    CBT_CERTIFICATE_LOGS_FILENAME=$(CBT_CERTIFICATE_LOGS_FILENAME)'
	@echo '    CBT_CERTIFICATE_LOGS_FILEPATH=$(CBT_CERTIFICATE_LOGS_FILEPATH)'
	@echo '    CBT_CERTIFICATE_MANUAL_FLAG=$(CBT_CERTIFICATE_MANUAL_FLAG)'
	@echo '    CBT_CERTIFICATE_NAME=$(CBT_CERTIFICATE_NAME)'
	@echo '    CBT_CERTIFICATE_PRIVKEY_FILEPATH=$(CBT_CERTIFICATE_PRIVKEY_FILEPATH)'
	@echo '    CBT_CERTIFICATE_STANDALONE_FLAG=$(CBT_CERTIFICATE_STANDALONE_FLAG)'
	@echo '    CBT_CERTIFICATE_WORK_DIRPATH=$(CBT_CERTIFICATE_WORK_DIRPATH)'
	@echo '    CBT_CERTIFICATES_SET_NAME=$(CBT_CERTIFICATES_SET_NAME)'
	@echo

_cbt_view_framework_targets ::
	@echo 'CertBoT::Certificate ($(_CERTBOT_CERTIFICATE_MK_VERSION)) targets:'
	@echo '    _cbt_create_certificate               - Create a certificate'
	@echo '    _cbt_delete_certificate               - Delete a certificate'
	@echo '    _cbt_distclean_certificate            - Dist-clean the certificates'
	@echo '    _cbt_enhance_certificate              - Enhance a certificate'
	@echo '    _cbt_renew_certificate                - Renew a certificate'
	@echo '    _cbt_show_certificate                 - Show everything related to a certificate'
	@echo '    _cbt_show_certificate_cert            - Show cert of a certificate'
	@echo '    _cbt_show_certificate_chain           - Show chain of a certificate'
	@echo '    _cbt_show_certificate_description     - Show decription of a certificate'
	@echo '    _cbt_show_certificate_fullchain       - Show fullchain of a certificate'
	@echo '    _cbt_revoke_certificate               - Revoke a certificate'
	@echo '    _cbt_tail_certificate                 - Tail logs of certificate'
	@echo '    _cbt_view_certificates                - View certificates'
	@echo '    _cbt_view_certificates_set            - View a set of certificates'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

# https://certbot.eff.org/docs/using.html#certbot-command-line-options

_cbt_create_certificate:
	@$(INFO) '$(CBT_UI_LABEL)Creating certificate "$(CBT_CERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation requires a webpage or DNS challenge to complete correctly'
	@$(WARN) 'Challenge can be fulfilled manually or be fully automated by using plugins, such as dns-route53'; $(NORMAL)
	$(CERTBOT) certonly $(strip $(__CBT_AGREE_TOS) $(__CBT_APACHE) $(__CBT_CONFIG_DIR) $(__CBT_DNS_ROUTE53) $(__CBT_DOMAIN) $(__CBT_EMAIL) $(__CBT_LOGS_DIR) $(__CBT_MANUAL) $(__CBT_NGINX) $(__CBT_PREFERRED_CHALLENGES) $(__CBT_STANDALONE) $(__CBT_WEBROOT) $(__CBT_WORK_DIR) )

_cbt_delete_certificate:
	@$(INFO) '$(CBT_UI_LABEL)Deleting certificate "$(CBT_CERTIFICATE_NAME)" ...'; $(NORMAL)

_cbt_distclean_certificates:
	@$(INFO) '$(CBT_UI_LABEL)Distcleaning certificates ...'; $(NORMAL)
	cd $(CBT_CERTIFICATE_CONFIG_DIRPATH); $(SUDO__CERTBOT) rm -rf *
	cd $(CBT_CERTIFICATE_LOGS_DIRPATH); $(SUDO__CERTBOT) rm -rf *log
	cd $(CBT_CERTIFICATE_WORK_DIRPATH); $(SUDO__CERTBOT) rm -rf *

_cbt_enhance_certificate:
	@$(INFO) '$(CBT_UI_LABEL)Deleting certificate "$(CBT_CERTIFICATE_NAME)" ...'; $(NORMAL)

_cbt_renew_certificate:
	@$(INFO) '$(CBT_UI_LABEL)Renewing certificate "$(CBT_CERTIFICATE_NAME)" ...'; $(NORMAL)

_cbt_revoke_certificate:
	@$(INFO) '$(CBT_UI_LABEL)Revoking certificate "$(CBT_CERTIFICATE_NAME)" ...'; $(NORMAL)

_cbt_show_certificate: _cbt_show_certificate_archive _cbt_show_certificate_cert _cbt_show_certificate_chain _cbt_show_certificate_fullchain _cbt_show_certificate_modulus _cbt_show_certificate_privatekey _cbt_show_certificate_description

_cbt_show_certificate_archive:
	@$(INFO) '$(CBT_UI_LABEL)Showing current and previous versions of certificate "$(CBT_CERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the current and previous versions of the key and certificate files'; $(NORMAL)
	ls -la $(CBT_CERTIFICATE_ARCHIVE_DIRPATH)

_cbt_show_certificate_cert:
	@$(INFO) '$(CBT_UI_LABEL)Showing cert of certificate "$(CBT_CERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the server certificate that we previously created'; $(NORMAL)
	cat $(CBT_CERTIFICATE_CERT_FILEPATH)
	@echo
	openssl x509 -in $(CBT_CERTIFICATE_CERT_FILEPATH)  -noout -text
	@echo
	openssl x509 -in $(CBT_CERTIFICATE_CERT_FILEPATH) -noout -modulus

_cbt_show_certificate_chain:
	@$(INFO) '$(CBT_UI_LABEL)Showing chain of certificate "$(CBT_CERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the intermediate certificate(s) that browsers need to validate the created server cert'; $(NORMAL)
	cat $(CBT_CERTIFICATE_CERT_FILEPATH)
	@echo
	openssl x509 -in $(CBT_CERTIFICATE_CHAIN_FILEPATH)  -noout -text
	@echo
	openssl x509 -in $(CBT_CERTIFICATE_CHAIN_FILEPATH) -noout -modulus

_cbt_show_certificate_description:
	@$(INFO) '$(CBT_UI_LABEL)Showing description of certificate "$(CBT_CERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the links to the current version of the certificate and key files'; $(NORMAL)
	@$(WARN) 'For pervious versions of those files, check the certificate artchive'; $(NORMAL)
	cat $(CBT_CERTIFICATE_DIRPATH)README
	ls -la $(CBT_CERTIFICATE_DIRPATH)

_cbt_show_certificate_fullchain:
	@$(INFO) '$(CBT_UI_LABEL)Showing fullchain of certificate "$(CBT_CERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns all certificates -- the server certificate followed by any intermediates'; $(NORMAL)
	@$(WARN) 'The full-chain is what needs to be installed on webservers and then shared with web clients'; $(NORMAL)
	cat $(CBT_CERTIFICATE_FULLCHAIN_FILEPATH)
	@echo
	openssl x509 -in $(CBT_CERTIFICATE_FULLCHAIN_FILEPATH)  -noout -text
	@echo
	openssl x509 -in $(CBT_CERTIFICATE_FULLCHAIN_FILEPATH) -noout -modulus

_cbt_show_certificate_modulus:
	@$(INFO) '$(CBT_UI_LABEL)Showing modulus of certificate "$(CBT_CERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The modulus of the cert, fullchain, and private-key must match'; $(NORMAL)
	openssl x509 -in $(CBT_CERTIFICATE_CERT_FILEPATH) -noout -modulus | openssl md5
	openssl x509 -in $(CBT_CERTIFICATE_FULLCHAIN_FILEPATH) -noout -modulus | openssl md5
	openssl rsa -in $(CBT_CERTIFICATE_PRIVKEY_FILEPATH) -noout -modulus | openssl md5
	@echo
	openssl rsa -in $(CBT_CERTIFICATE_PRIVKEY_FILEPATH) -noout -modulus

_cbt_show_certificate_privatekey:
	@$(INFO) '$(CBT_UI_LABEL)Showing modulus of certificate "$(CBT_CERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The private key must be kept secret at all time'; $(NORMAL)
	# cat $(CBT_CERTIFICATE_PRIVKEY_FILEPATH)
	@echo
	openssl rsa -in $(CBT_CERTIFICATE_PRIVKEY_FILEPATH) -noout -modulus

_cbt_tail_certificate:
	@$(INFO) '$(CBT_UI_LABEL)Tail log of certificate "$(CBT_CERTIFICATE_NAME)" ...'; $(NORMAL)
	tail --follow --lines=100 $(CBT_CERTIFICATE_LOGS_FILEPATH)

_cbt_view_certificates: 
	@$(INFO) '$(CBT_UI_LABEL)Viewing certificates ...'; $(NORMAL)

_cbt_view_certificates_set:
	@$(INFO) '$(CBT_UI_LABEL)Viewing certificates-set "$(CBT_CERTIFICATES_SET_NAME)" ...'; $(NORMAL)
