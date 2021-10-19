_KUBECTL_CERTIFICATE_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_CERTIFICATE_CERTIFICATESIGNINGREQUEST_NAME?= my-certificate-signing-request
# KCL_CERTIFICATE_DIRPATH?= ./in/
# KCL_CERTIFICATE_FILENAME?= csr-config.json
# KCL_CERTIFICATE_FILEPATH?= ./in/csr-config.json
# KCL_CERTIFICATE_NAME?= my-certificate
# KCL_CERTIFICATES_DIRPATH?= ./out/
KCL_CERTIFICATES_REGEX?= *.crt
# KCL_CERTIFICATES_SET_NAME?= my-certificates-set

# Derived parameters
KCL_CERTIFICATE_CERTIFICATESIGNINGREQUEST_NAME?= $(KCL_CERTIFICATESIGNINGREQUEST_NAME)
KCL_CERTIFICATE_DIRPATH?= $(KCL_OUTPUTS_DIRPATH)
KCL_CERTIFICATE_FILENAME?= $(KCL_CERTIFICATE_NAME).crt
KCL_CERTIFICATE_FILEPATH?= $(KCL_CERTIFICATE_DIRPATH)$(KCL_CERTIFICATE_FILENAME)
KCL_CERTIFICATE_NAME?= $(KCL_CERTIFICATESIGNINGREQUEST_NAME)
KCL_CERTIFICATES_DIRPATH?= $(KCL_CERTIFICATE_DIRPATH)
KCL_CERTIFICATESIGNINGREQUESTS_SET_NAME?= certificates@$(KCL_CERTIFICATES_DIRPATH)

# Option parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Certificate ($(_KUBECTL_CERTIFICATE_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Certificate ($(_KUBECTL_CERTIFICATE_MK_VERSION)) parameters:'
	@echo '    KCL_CERTIFICATE_CERTIFICATESIGNINGREQUEST_NAME=$(KCL_CERTIFICATE_CERTIFICATESIGNINGREQUEST_NAME)'
	@echo '    KCL_CERTIFICATE_DIRPATH=$(KCL_CERTIFICATE_DIRPATH)'
	@echo '    KCL_CERTIFICATE_FILENAME=$(KCL_CERTIFICATE_FILENAME)'
	@echo '    KCL_CERTIFICATE_FILEPATH=$(KCL_CERTIFICATE_FILEPATH)'
	@echo '    KCL_CERTIFICATE_NAME=$(KCL_CERTIFICATE_NAME)'
	@echo '    KCL_CERTIFICATES_DIRPATH=$(KCL_CERTIFICATES_DIRPATH)'
	@echo '    KCL_CERTIFICATES_REGEX=$(KCL_CERTIFICATES_REGEX)'
	@echo '    KCL_CERTIFICATES_SET_NAME=$(KCL_CERTIFICATES_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Certificate ($(_KUBECTL_CERTIFICATE_MK_VERSION)) targets:'
	@echo '    _kcl_delete_certificate                 - Delete a certificate'
	@echo '    _kcl_download_certificate               - Download a certificate'
	@echo '    _kcl_show_certificate                   - Show everything related to a certificate'
	@echo '    _kcl_show_certificate_description       - Show description of a certificate'
	@echo '    _kcl_view_certificates                  - View all certificates'
	@echo '    _kcl_view_certificates_set              - View set of certificates'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_download_certificate:
	@$(INFO) '$(KCL_UI_LABEL)Downloading certificate "$(KCL_CERTIFICATE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get certificatesigningrequests $(KCL_CERTIFICATE_CERTIFICATESIGNINGREQUEST_NAME) --output jsonpath='{.status.certificate}' | base64 --decode | tee $(KCL_CERTIFICATE_FILEPATH)

_kcl_delete_certificate:
	@$(INFO) '$(KCL_UI_LABEL)Deleting certificate "$(KCL_CERTIFICATE_NAME)" ...'; $(NORMAL)
	rm -f $(KCL_CERTIFICATE_FILEPATH)

_kcl_show_certificate :: _kcl_show_certificate_description

_kcl_show_certificate_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of certificate "$(KCL_CERTIFICATE_NAME)" ...'; $(NORMAL)
	ls -al $(KCL_CERTIFICATE_FILEPATH)

_kcl_view_certificates:
	@$(INFO) '$(KCL_UI_LABEL)Viewing certificates ...'; $(NORMAL)
	ls -la $(KCL_CERTIFICATES_DIRPATH)

_kcl_view_certificates_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing certificates-set "$(KCL_CERTIFICATESIGNINGREQUESTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Certificates are grouped based on directory, regex, ...'; $(NORMAL)
	ls -la $(KCL_CERTIFICATES_DIRPATH)$(KCL_CERTIFICATES_REGEX)
