_AWS_ACM_CERTIFICATE_MK_VERSION= $(_AWS_ACM_MK_VERSION)

# ACM_CERTIFICATE_ALTERNATIVE_NAMES?= b.example.com *.example.com
# ACM_CERTIFICATE_ARN?= arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012
# ACM_CERTIFICATE_AUTHORITY_ARN?= arn:aws:acm-pca:region:account:certificate-authority/12345678-1234-1234-1234-123456789012
# ACM_CERTIFICATE_CHAIN_FILEPATH?= ./in/intermediate.cer
# ACM_CERTIFICATE_DOMAIN_NAME?= example.com
# ACM_CERTIFICATE_EXPORT_PASSPHRASE?= "This is a secret passphrase -- pass as a command line parameter or through environment"
# ACM_CERTIFICATE_FILEPATH?= ./in/certificate.crt
# ACM_CERTIFICATE_IDEMPOTENCY_TOKEN?= 91adc45q
# ACM_CERTIFICATE_NAME?= my-certificate-name
ACM_CERTIFICATE_OPTIONS?= CertificateTransparencyLoggingPreference=ENABLED
# ACM_CERTIFICATE_PRIVATEKEY_FILEPATH?= ./in/certificate-private-key.pem
# ACM_CERTIFICATE_SERIAL?=
# ACM_CERTIFICATE_TAGS_KEYVALUES?= Key=string,Value=string ...
# ACM_CERTIFICATE_VALIDATION_DOMAIN?= subdomain.example.com
# ACM_CERTIFICATE_VALIDATION_METHOD?= DNS
# ACM_CERTIFICATE_VALIDATION_OPTIONS?= DomainName=example.com,ValidationDomain=mail.example.com
# ACM_CERTIFICATE_VALIDATION_RECORD?= _4952a229984540225a4b6110d44243f3.domain.com.
# ACM_CERTIFICATES_INCLUDES?= extendedKeyUsage=string,string,keyUsage=string,string,keyTypes=string,string
# ACM_CERTIFICATES_SET_NAME?= my-certificates-set
# ACM_CERTIFICATES_STATUSES?= PENDING_VALIDATION ISSUED INACTIVE  EXPIRED VALIDATION_TIMED_OUT REVOKED FAILED

# Derived parameters
ACM_CERTIFICATE_NAME?= $(ACM_CERTIFICATE_DOMAIN_NAME)

# Options
__ACM_CERTIFICATE= $(if $(ACM_CERTIFICATE_FILEPATH),--certificate fileb://$(ACM_CERTIFICATE_FILEPATH))
__ACM_CERTIFICATE_ARN= $(if $(ACM_CERTIFICATE_ARN),--certificate-arn $(ACM_CERTIFICATE_ARN))
__ACM_CERTIFICATE_AUTHORITY_ARN= $(if $(ACM_CERTIFICATE_AUTHORITY_ARN),--certificate-authority-arn $(ACM_CERTIFICATE_AUTHORITY_ARN))
__ACM_CERTIFICATE_CHAIN= $(if $(ACM_CERTIFICATE_CHAIN_FILEPATH),--certificate-chain fileb://$(ACM_CERTIFICATE_CHAIN_FILEPATH))
__ACM_CERTIFICATE_STATUSES= $(if $(ACM_CERTIFICATES_STATUSES),--certificate-statuses $(ACM_CERTIFICATES_STATUSES))
__ACM_DOMAIN= $(if $(ACM_CERTIFICATE_DOMAIN_NAME),--domain $(ACM_CERTIFICATE_DOMAIN_NAME))
__ACM_DOMAIN_NAME= $(if $(ACM_CERTIFICATE_DOMAIN_NAME),--domain-name $(ACM_CERTIFICATE_DOMAIN_NAME))
__ACM_DOMAIN_VALIDATION_OPTIONS= $(if $(ACM_CERTIFICATE_VALIDATION_OPTIONS),--domain-validation-options $(ACM_CERTIFICATE_VALIDATION_OPTIONS))
__ACM_IDEMPOTENCY_TOKEN__CERTIFICATE= $(if $(ACM_CERTIFICATE_IDEMPOTENCY_TOKEN),--idempotency-token $(ACM_CERTIFICATE_IDEMPOTENCY_TOKEN))
__ACM_INCLUDES= $(if $(ACM_CERTIFICATES_INCLUDES),--includes $(ACM_CERTIFICATES_INCLUDES))
__ACM_OPTIONS= $(if $(ACM_CERTIFICATE_OPTIONS),--options $(ACM_CERTIFICATE_OPTIONS))
__ACM_PASSPHRASE= $(if $(ACM_CERTIFICATE_EXPORT_PASSPHRASE),--passphrase $(ACM_CERTIFICATE_EXPORT_PASSPHRASE))
__ACM_PRIVATE_KEY= $(if $(ACM_CERTIFICATE_PRIVATEKEY_FILEPATH),--private-key fileb://$(ACM_CERTIFICATE_PRIVATEKEY_FILEPATH))
__ACM_SUBJECT_ALTERNATIVE_NAMES= $(if $(ACM_CERTIFICATE_ALTERNATIVE_NAMES),--subject-alternative-names $(ACM_CERTIFICATE_ALTERNATIVE_NAMES))
__ACM_TAGS__CERTIFICATE= $(if $(ACM_CERTIFICATE_TAGS_KEYVALUES),--tags $(ACM_CERTIFICATE_TAGS_KEYVALUES))
__ACM_VALIDATION_DOMAIN= $(if $(ACM_CERTIFICATE_VALIDATION_DOMAIN),--validation-domain $(ACM_CERTIFICATE_VALIDATION_DOMAIN))
__ACM_VALIDATION_METHOD= $(if $(ACM_CERTIFICATE_VALIDATION_METHOD),--validation-method $(ACM_CERTIFICATE_VALIDATION_METHOD))

# Customizations
_ACM_LIST_CERTIFICATES_FIELDS?=
_ACM_LIST_CERTIFICATES_SET_FIELDS?= $(_ACM_LIST_CERTIFICATES_FIELDS)
_ACM_LIST_CERTIFICATES_SET_SLICE?=

#--- MACROS
_acm_get_certificate_arn= $(call _acm_get_certificate_arn_N, $(ACM_CERTIFICATE_DOMAIN_NAME))
_acm_get_certificate_arn_N= $(shell $(AWS) acm list-certificates --query "CertificateSummaryList[?DomainName=='$(strip $(1))'].CertificateArn" --output text)

_arn_get_certificate_serial= $(call _acm_get_certificate_serial_A, $(ACM_CERTIFICATE_ARN))
_arn_get_certificate_serial_A= $(call $(AWS) acm describe-certificate --certificate-arn $(1) --query "Certificate.Serial" --output text)

_acm_get_certificate_validation_record= $(call _acm_get_certificate_validation_record_A, $(ACM_CERTIFICATE_ARN))
_acm_get_certificate_validation_record_A= $(shell $(AWS) acm describe-certificate --certificate-arn $(1) --query "Certificate.DomainValidationOptions[0].ResourceRecord.Name"  --output text)

#----------------------------------------------------------------------
# USAGE
#

_acm_list_macros ::
	@echo 'AWS::ACM::Certificate ($(_AWS_ACM_CERTIFICATE_MK_VERSION)) macros:'
	@echo '    _get_certificate_arn_{|N}                   - Get ARN of a certificate (Name)'
	@echo '    _get_certificate_validation_record_{|A}     - Get the validation record of a certificate (Arn)'
	@echo

_acm_list_parameters ::
	@echo 'AWS::ACM::Certificate ($(_AWS_ACM_CERTIFICATE_MK_VERSION)) parameters:'
	@echo '    ACM_CERTIFICATE_ALTERNATIVE_NAMES=$(ACM_CERTIFICATE_ALTERNATIVE_NAMES)'
	@echo '    ACM_CERTIFICATE_ARN=$(ACM_CERTIFICATE_ARN)'
	@echo '    ACM_CERTIFICATE_AUTHORITY_ARN=$(ACM_CERTIFICATE_AUTHORITY_ARN)'
	@echo '    ACM_CERTIFICATE_CHAIN_FILEPATH=$(ACM_CERTIFICATE_CHAIN_FILEPATH)'
	@echo '    ACM_CERTIFICATE_DOMAIN_NAME=$(ACM_CERTIFICATE_DOMAIN_NAME)'
	@echo '    ACM_CERTIFICATE_EXPORT_PASSPHRASE=$(ACM_CERTIFICATE_EXPORT_PASSPHRASE)'
	@echo '    ACM_CERTIFICATE_FILEPATH=$(ACM_CERTIFICATE_FILEPATH)'
	@echo '    ACM_CERTIFICATE_IDEMPOTENCY_TOKEN=$(ACM_CERTIFICATE_IDEMPOTENCY_TOKEN)'
	@echo '    ACM_CERTIFICATE_NAME=$(ACM_CERTIFICATE_NAME)'
	@echo '    ACM_CERTIFICATE_OPTIONS=$(ACM_CERTIFICATE_OPTIONS)'
	@echo '    ACM_CERTIFICATE_PRIVATEKEY_FILEPATH=$(ACM_CERTIFICATE_PRIVATEKEY_FILEPATH)'
	@echo '    ACM_CERTIFICATE_SERIAL=$(ACM_CERTIFICATE_SERIAL)'
	@echo '    ACM_CERTIFICATE_TAGS_KEYVALUES=$(ACM_CERTIFICATE_TAGS_KEYVALUES)'
	@echo '    ACM_CERTIFICATE_VALIDATION_DOMAIN=$(ACM_CERTIFICATE_VALIDATION_DOMAIN)'
	@echo '    ACM_CERTIFICATE_VALIDATION_METHOD=$(ACM_CERTIFICATE_VALIDATION_METHOD)'
	@echo '    ACM_CERTIFICATE_VALIDATION_OPTIONS=$(ACM_CERTIFICATE_VALIDATION_OPTIONS)'
	@echo '    ACM_CERTIFICATE_VALIDATION_RECORD=$(ACM_CERTIFICATE_VALIDATION_RECORD)'
	@echo '    ACM_CERTIFICATES_INCLUDES=$(ACM_CERTIFICATES_INCLUDES)'
	@echo '    ACM_CERTIFICATES_SET_NAME=$(ACM_CERTIFICATES_SET_NAME)'
	@echo '    ACM_CERTIFICATES_STATUSES=$(ACM_CERTIFICATES_STATUSES)'
	@echo

_acm_list_targets ::
	@echo 'AWS::ACM::Certificate ($(_AWS_ACM_CERTIFICATE_MK_VERSION)) targets:'
	@echo '    _acm_delete_certificate                 - Delete an existing certificate'
	@echo '    _acm_export_certificate                 - Export an ACM certificate'
	@echo '    _acm_import_certificate                 - Import an ACM certificate'
	@echo '    _acm_issue_certificate                  - Issue a private-certificate with a private CA'
	@echo '    _acm_list_certificates                  - List all certificates'
	@echo '    _acm_list_certificates_set              - List a set of certificates'
	@echo '    _acm_request_certificate                - Request a certificates'
	@echo '    _acm_resend_validationemail             - Resend validation-email'
	@echo '    _acm_revoke_certificate                 - Revoke a private-certificate from a private CA'
	@echo '    _acm_show_certificate                   - Show everything related to a certificate'
	@echo '    _acm_show_certificate_body              - Show the body of a certificate'
	@echo '    _acm_show_certificate_chain             - Show the chain to a certificate'
	@echo '    _acm_show_certificate_description       - Show description of a certificate'
	@echo '    _acm_show_certificate_privatekey        - Show private-key of a certificate'
	@echo '    _acm_show_certificate_tags              - Show tags of a certificate'
	@echo '    _acm_show_certificate_validationrecord  - Show the validation-record of a certificate'
	@echo '    _acm_tag_certificate                    - Tag a certificate'
	@echo '    _acm_untag_certificate                  - Untag a certificate'
	@echo '    _acm_update_certificate                 - Update an ACM certificate'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGET
#
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_acm_create_certificate: _acm_request_certificate

_acm_delete_certificate:
	@$(INFO) '$(ACM_UI_LABEL)Deleting certificate "$(ACM_CERTIFICATE_NAME)" ...'; $(NORMAL)
	$(AWS) acm delete-certificate $(__ACM_CERTIFICATE_ARN)

_acm_export_certificate:
	@$(INFO) '$(ACM_UI_LABEL)Exporting private-certificate "$(ACM_CERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Certificate issued by AWS through ACM are NOT private certificates!'; $(NORMAL)
	@$(WARN) 'Private certificates are issued by a private-certificate-authority!'; $(NORMAL)
	$(AWS) acm export-certificate $(__ACM_CERTIFICATE_ARN) $(__ACM_PASSPHRASE)

_acm_import_certificate:
	@$(INFO) '$(ACM_UI_LABEL)Importing certificate "$(ACM_CERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Public and private certificates can be imported!'; $(NORMAL)
	@$(WARN) 'The certificate chain must be provided if the certificate is not self signed!'; $(NORMAL)
	$(AWS) acm import-certificate $(__ACM_CERTIFICATE) $(_X__ACM_CERTIFICATE_ARN) $(__ACM_CERTIFICATE_CHAIN) $(__ACM_PRIVATE_KEY)

_acm_issue_certificate: _asm_issue_certificate_by_certificateauthority

_acm_request_certificate:
	@$(INFO) '$(ACM_UI_LABEL)Requesting a certificate for domain "$(ACM_CERTIFICATE_DOMAIN_NAME) "...'; $(NORMAL)
	$(AWS) acm request-certificate $(__ACM_CERTIFICATE_AUTHORITY_ARN) $(__ACM_DOMAIN_NAME) $(__ACM_DOMAIN_VALIDATION_OPTIONS) $(__ACM_IDEMPOTENCY_TOKEN__CERTIFICATE) $(__ACM_OPTIONS) $(__ACM_SUBJECT_ALTERNATIVE_NAMES) $(__ACM_VALIDATION_METHOD)

_acm_revoke_certificate: _acm_revoke_certificate_by_certificateauthority

_acm_resend_validationemail:
	@$(INFO) '$(ACM_UI_LABEL)Resending validation-email for domain "$(ACM_CERTIFICATE_DOMAIN_NAME) "...'; $(NORMAL)
	$(AWS) acm resend-validation-email $(__ACM_CERTIFICATE_ARN) $(__ACM_DOMAIN) $(__ACM_VALIDATION_DOMAIN)

_acm_show_certificate: _acm_show_certificate_body _acm_show_certificate_chain _acm_show_certificate_privatekey _acm_show_certificate_tags _acm_show_certificate_validationrecord  _acm_show_certificate_description

_acm_show_certificate_body:
	@$(INFO) '$(ACM_UI_LABEL)Showing body/content of certificate "$(ACM_CERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the certificate is not in the ISSUED state'; $(NORMAL)
	-echo; $(AWS) acm get-certificate $(__ACM_CERTIFICATE_ARN) --query "Certificate" --output text

_acm_show_certificate_chain:
	@$(INFO) '$(ACM_UI_LABEL)Showing certificate-chain of certificate "$(ACM_CERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the certificate is not in the ISSUED state'; $(NORMAL)
	@$(WARN) 'All certificates in the certificate-chain can be invalidated any time'; $(NORMAL)
	@$(WARN) 'No root certificates should be used in a certificate-chain, only intermediate certificates'; $(NORMAL)
	-echo; $(AWS) acm get-certificate $(__ACM_CERTIFICATE_ARN) --query "CertificateChain" --output text

_acm_show_certificate_description:
	@$(INFO) '$(ACM_UI_LABEL)Showing description of certificate "$(ACM_CERTIFICATE_NAME)" ...'; $(NORMAL)
	$(AWS) acm describe-certificate $(__ACM_CERTIFICATE_ARN) --query "Certificate"

_acm_show_certificate_privatekey:
	@$(INFO) '$(ACM_UI_LABEL)Showing private-key of certificate "$(ACM_CERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The returned private-key needs to be kept secret!'; $(NORMAL)
	$(if $(ACM_CERTIFICATE_PRIVATEKEY_FILEPATH), \
		cat $(ACM_CERTIFICATE_PRIVATEKEY_FILEPATH), \
		@echo "ACM_CERTIFICATE_PRIVATEKEY_FILEPATH not set!"\
	)

_acm_show_certificate_tags:
	@$(INFO) '$(ACM_UI_LABEL)Showing tags of certificate "$(ACM_CERTIFICATE_NAME)" ...'; $(NORMAL)
	$(AWS) acm list-tags-for-certificate $(__ACM_CERTIFICATE_ARN) --query "Tags[]"

_acm_show_certificate_validationrecord:
	@$(INFO) '$(ACM_UI_LABEL)Showing validation-record of certificate "$(ACM_CERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Operation is skipped if ACM_CERTIFICATE_VALIDATION_RECORD is not set'; $(NORMAL)
	@$(WARN) 'The validation record needs to be present only at the issuance of the certificate. It can be deleted thereafter.'; $(NORMAL)
	$(if $(ACM_CERTIFICATE_VALIDATION_RECORD), \
		dig $(ACM_CERTIFICATE_VALIDATION_RECORD), \
		@echo "ACM_CERTIFICATE_VALIDATION_RECORD not set!"\
	)

_acm_tag_certificate:
	@$(INFO) '$(ACM_UI_LABEL)Tagging certificate "$(ACM_CERTIFICATE_NAME)" ...'; $(NORMAL)
	$(AWS) acm add-tags-to-certificate $(__ACM_CERTIFICATE_ARN) $(__ACM_TAGS__CERTIFICATE)

_acm_untag_certificate:
	@$(INFO) '$(ACM_UI_LABEL)Untagging certificate "$(ACM_CERTIFICATE_NAME)" ...'; $(NORMAL)
	$(AWS) acm remove-tags-from-certificate $(__ACM_CERTIFICATE_ARN) $(__ACM_TAGS__CERTIFICATE)

_acm_update_certificate:
	@$(INFO) '$(ACM_UI_LABEL)Updating certificate "$(ACM_CERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Public and private certificates can be imported!'; $(NORMAL)
	@$(WARN) 'The certificate chain must be provided if the certificate is not self signed!'; $(NORMAL)
	$(AWS) acm import-certificate $(__ACM_CERTIFICATE) $(__ACM_CERTIFICATE_ARN) $(__ACM_CERTIFICATE_CHAIN) $(__ACM_PRIVATE_KEY)

_acm_update_certificate_option:
	@$(INFO) '$(ACM_UI_LABEL)Updating options of certificate "$(ACM_CERTIFICATE_NAME)" ...'; $(NORMAL)
	$(AWS) acm update-certificate-options $(__ACM_CERTIFICATE_ARN) $(__ACM_OPTIONS)

_acm_list_certificates:
	@$(INFO) '$(ACM_UI_LABEL)Listing ALL certificates ...'; $(NORMAL)
	@$(WARN) 'The returned certificates may or may NOT be used'; $(NORMAL)
	$(AWS) acm list-certificates $(_X__ACM_CERTIFICATE_STATUSES) $(_X__ACM_INCLUDES) --query "CertificateSummaryList[]$(_ACM_LIST_CERTIFICATES_FIELDS)"

_acm_list_certificates_set:
	@$(INFO) '$(ACM_UI_LABEL)Listing certificates-set "$(ACM_CERTIFICATES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Certificates are grouped based on status, includes, and slice'; $(NORMAL)
	$(AWS) acm list-certificates $(__ACM_CERTIFICATE_STATUSES) $(__ACM_INCLUDES) --query "CertificateSummaryList[$(_ACM_LIST_CERTIFICATES_SET_SLICE)]$(_ACM_LIST_CERTIFICATES_SET_FIELDS)"
