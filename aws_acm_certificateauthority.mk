_AWS_ACM_CERTIFICATEAUTHORITY_MK_VERSION= $(_AWS_ACM_MK_VERSION)

# ACM_CERTIFICATEAUTHORITY_ARN?= arn:aws:acm-pca:region:account:certificate-authority/12345678-1234-1234-1234-123456789012
# ACM_CERTIFICATEAUTHORITY_BODY_FILEPATH?= ./cert/subordinate_cert.pem
# ACM_CERTIFICATEAUTHORITY_CERTIFICATE_NAME?=
# ACM_CERTIFICATEAUTHORITY_CERTIFICATE_SERIAL?=
# ACM_CERTIFICATEAUTHORITY_CERTIFICATE_STATUS?=
# ACM_CERTIFICATEAUTHORITY_CHAIN_FILEPATH?=
# ACM_CERTIFICATEAUTHORITY_CONFIGURATION?=
# ACM_CERTIFICATEAUTHORITY_CONFIGURATION_FILEPATH?= ./certificateauthority-configuration.json
# ACM_CERTIFICATEAUTHORITY_CSR_FILEPATH?= ./csr/CSR.pem
ACM_CERTIFICATEAUTHORITY_DELETION_DELAY?= 30
# ACM_CERTIFICATEAUTHORITY_IDEMPOTENCY_TOKEN?= 91adc45q
# ACM_CERTIFICATEAUTHORITY_NAME?=
# ACM_CERTIFICATEAUTHORITY_REVOCATION_CONFIGURATION?= CrlConfiguration={Enabled=boolean,ExpirationInDays=integer,CustomCname=string,S3BucketName=string}
# ACM_CERTIFICATEAUTHORITY_REVOCATION_CONFIGURATION_FILEPATH?= ./certificateauthority-revocation-configuration.json
# ACM_CERTIFICATEAUTHORITY_REVOCATION_REASON?= KEY_COMPROMISE
# ACM_CERTIFICATEAUTHORITY_STATUS?= ACTIVE
# ACM_CERTIFICATEAUTHORITY_TAGS_KEYVALUES?= Key=string,Value=string ...
ACM_CERTIFICATEAUTHORITY_TYPE?= SUBORDINATE
# ACM_CERTICATEAUTHORITIES_SET_NAME?= my-certificate-authorities-set

# Derived parameters
ACM_CERTIFICATEAUTHORITY_CERTIFICATE_NAME?= $(ACM_CERTIFICATE_NAME)
ACM_CERTIFICATEAUTHORITY_CERTIFICATE_SERIAL?= $(ACM_CERTIFICATE_SERIAL)
ACM_CERTIFICATEAUTHORITY_CONFIGURATION?= $(if $(ACM_CERTIFICATEAUTHORITY_CONFIGURATION_FILEPATH),file://$(ACM_CERTIFICATEAUTHORITY_CONFIGURATION_FILEPATH))
ACM_CERTIFICATEAUTHORITY_REVOCATION_CONFIGURATION?= $(if $(ACM_CERTIFICATEAUTHORITY_REVOCATION_CONFIGURATION_FILEPATH),file://$(ACM_CERTIFICATEAUTHORITY_REVOCATION_CONFIGURATION_FILEPATH))

# Option parameters
__ACM_CERTIFICATE__CERTIFICATEAUTHORITY= $(if $(ACM_CERTIFICATEAUTHORITY_BODY_FILEPATH),--certificate $(ACM_CERTIFICATEAUTHORITY_BODY_FILEPATH))
__ACM_CERTIFICATE_AUTHORITY_ARN= $(if $(ACM_CERTIFICATEAUTHORITY_ARN),--certificate-authority-arn $(ACM_CERTIFICATEAUTHORITY_ARN))
__ACM_CERTIFICATE_AUTHORITY_CONFIGURATION= $(if $(ACM_CERTIFICATEAUTHORITY_CONFIGURATION),--certificate-authority-configuration $(ACM_CERTIFICATEAUTHORITY_CONFIGURATION))
__ACM_CERTIFICATE_AUTHORITY_TYPE= $(if $(ACM_CERTIFICATEAUTHORITY_TYPE),--certificate-authority-type $(ACM_CERTIFICATEAUTHORITY_TYPE))
__ACM_CERTIFICATE_CHAIN__CERTIFICATEAUTHORITY= $(if $(ACM_CERTIFICATEAUTHORITY_CHAIN_FILEPATH),--certificate-chain $(ACM_CERTIFICATEAUTHORITY_CHAIN_FILEPATH))
__ACM_CERTIFICATE_SERIAL__CERTIFICATEAUTHORITY= $(if $(ACM_CERTIFICATEAUTHORITY_CERTIFICATE_SERIAL),--certificate-serial $(ACM_CERTIFICATEAUTHORITY_CERTIFICATE_SERIAL))
__ACM_CSR=
__ACM_IDEMPOTENCY_TOKEN__CERTIFICATEAUTHORITY= $(if $(ACM_CERTIFICATEAUTHORITY_IDEMPOTENCY_TOKEN),--idempotency-token $(ACM_CERTIFICATEAUTHORITY_IDEMPOTENCY_TOKEN))
__ACM_PERMANENT_DELETION_TIME_IN_DAYS= $(if $(ACM_CERTIFICATEAUTHORITY_DELETION_DELAY),--permanent-deletion-time-in-days $(ACM_CERTIFICATEAUTHORITY_DELETION_DELAY))
__ACM_REVOCATION_CONFIGURATION= $(if $(ACM_CERTIFICATEAUTHORITY_REVOCATION_CONFIGURATION),--revocation-configuration $(ACM_CERTIFICATEAUTHORITY_REVOCATION_CONFIGURATION))
__ACM_REVOCATION_REASON= $(if $(ACM_CERTIFICATEAUTHORITY_REVOCATION_REASON),--revocation-reason $(ACM_CERTIFICATEAUTHORITY_REVOCATION_REASON))
__ACM_SIGNING_ALGORITHM=
__ACM_STATUS__CERTIFICATEAUTHORITY= $(if $(ACM_CERTIFICATEAUTHORITY_STATUS),--status $(ACM_CERTIFICATEAUTHORITY_STATUS))
__ACM_TAGS__CERTIFICATEAUTHORITY= $(if $(ACM_CERTIFICATEAUTHORITY_TAGS_KEYVALUES),--tags $(ACM_CERTIFICATEAUTHORITY_TAGS_KEYVALUES))
__ACM_VALIDITY=

# UI parameters
ACM_UI_VIEW_CERTIFICATEAUTHORITIES_FIELDS?= .{status:Status,Arn:Arn,subject: CertificateAuthorityConfiguration.Subject | join(' * ',values(@))}
ACM_UI_VIEW_CERTIFICATEAUTHORITIES_SET_FIELDS?= $(ACM_UI_VIEW_CERTIFICATEAUTHORITIES_FIELDS)
ACM_UI_VIEW_CERTIFICATEAUTHORITIES_SET_SLICE?= 0:5

#--- MACROS
ACM_GET_CERTIFICATEAUTHORITY_ARN_SLICE?= $(ACM_UI_VIEW_CERTIFICATEAUTHORITIES_SET_SLICE)
_acm_get_certificateauthority_arn= $(call _acm_get_certificateauthority_arn_N, $(ACM_GET_CERTIFICATEAUTHORITY_ARN_SLICE))
_acm_get_certificateauthority_arn_N= $(shell $(AWS) acm-pca list-certificate-authorities --query "CertificateAuthorities[$(strip $(1))].Arn" --output text)

#----------------------------------------------------------------------
# USAGE
#

_acm_view_framework_macros ::
	@echo 'AWS::ACM::CertificateAuthority ($(_AWS_ACM_CERTIFICATE_MK_VERSION)) macros:'
	@echo '    _get_certificateauthority_arn_{|N}                   - Get ARN of a certificate-authority (Name)'
	@echo

_acm_view_framework_parameters ::
	@echo 'AWS::ACM::CertificateAuthority ($(_AWS_ACM_CERTIFICATEAUTHORITY_MK_VERSION)) parameters:'
	@echo '    ACM_CERTIFICATEAUTHORITY_ARN=$(ACM_CERTIFICATEAUTHORITY_ARN)'
	@echo '    ACM_CERTIFICATEAUTHORITY_BODY_FILEPATH=$(ACM_CERTIFICATEAUTHORITY_BODY_FILEPATH)'
	@echo '    ACM_CERTIFICATEAUTHORITY_CERTIFICATE_NAME=$(ACM_CERTIFICATEAUTHORITY_CERTIFICATE_NAME)'
	@echo '    ACM_CERTIFICATEAUTHORITY_CERTIFICATE_SERIAL=$(ACM_CERTIFICATEAUTHORITY_CERTIFICATE_SERIAL)'
	@echo '    ACM_CERTIFICATEAUTHORITY_CHAIN_FILEPATH=$(ACM_CERTIFICATEAUTHORITY_CHAIN_FILEPATH)'
	@echo '    ACM_CERTIFICATEAUTHORITY_CONFIGURATION=$(ACM_CERTIFICATEAUTHORITY_CONFIGURATION)'
	@echo '    ACM_CERTIFICATEAUTHORITY_CONFIGURATION_FILEPATH=$(ACM_CERTIFICATEAUTHORITY_CONFIGURATION_FILEPATH)'
	@echo '    ACM_CERTIFICATEAUTHORITY_CSR_FILEPATH=$(ACM_CERTIFICATEAUTHORITY_CSR_FILEPATH)'
	@echo '    ACM_CERTIFICATEAUTHORITY_DELETION_DELAY=$(ACM_CERTIFICATEAUTHORITY_DELETION_DELAY)'
	@echo '    ACM_CERTIFICATEAUTHORITY_IDEMPOTENCY_TOKEN=$(ACM_CERTIFICATEAUTHORITY_IDEMPOTENCY_TOKEN)'
	@echo '    ACM_CERTIFICATEAUTHORITY_NAME=$(ACM_CERTIFICATEAUTHORITY_NAME)'
	@echo '    ACM_CERTIFICATEAUTHORITY_REVOCATION_CERTNAME=$(ACM_CERTIFICATEAUTHORITY_REVOCATION_CERTNAME)'
	@echo '    ACM_CERTIFICATEAUTHORITY_REVOCATION_CONFIGURATION=$(ACM_CERTIFICATEAUTHORITY_REVOCATION_CONFIGURATION)'
	@echo '    ACM_CERTIFICATEAUTHORITY_REVOCATION_CONFIGURATION_FILEPATH=$(ACM_CERTIFICATEAUTHORITY_REVOCATION_CONFIGURATION_FILEPATH)'
	@echo '    ACM_CERTIFICATEAUTHORITY_REVOCATION_REASON=$(ACM_CERTIFICATEAUTHORITY_REVOCATION_REASON)'
	@echo '    ACM_CERTIFICATEAUTHORITY_STATUS=$(ACM_CERTIFICATEAUTHORITY_STATUS)'
	@echo '    ACM_CERTIFICATEAUTHORITY_TAGS_KEYVALUES=$(ACM_CERTIFICATEAUTHORITY_TAGS_KEYVALUES)'
	@echo '    ACM_CERTIFICATEAUTHORITY_TYPE=$(ACM_CERTIFICATEAUTHORITY_TYPE)'
	@echo '    ACM_CERTIFICATEAUTHORITIES_SET_NAME=$(ACM_CERTIFICATEAUTHORITIES_SET_NAME)'
	@echo

_acm_view_framework_targets ::
	@echo 'AWS::ACM::CertificateAuthority ($(_AWS_ACM_CERTIFICATEAUTHORITY_MK_VERSION)) targets:'
	@echo '    _acm_create_certificateauthority                 - Create a certificate-authority'
	@echo '    _acm_delete_certificateauthority                 - Delete an existing certificate-authority'
	@echo '    _acm_revoke_certificate_by_certificateauthority  - Revoke a certificate by certificate-authority'
	@echo '    _acm_show_certificateauthority                   - Show everything related to a certificate-authority'
	@echo '    _acm_show_certificateauthority_csr               - Show certificate-signing-request of a certificate-authority'
	@echo '    _acm_show_certificateauthority_description       - Show description of a certificate-authority'
	@echo '    _acm_show_certificateauthority_tags              - Show tags of a certificate-authority'
	@echo '    _acm_tag_certificateauthority                    - Tag a certificate-authority'
	@echo '    _acm_untag_certificateauthority                  - Untag a certificate-authority'
	@echo '    _acm_update_certificateauthority                 - Update a certificate-authority'
	@echo '    _acm_view_certificateauthorities                 - View existing certificate-authorities'
	@echo '    _acm_view_certificateauthorities_set             - View a set of certificate-authorities'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGET
#
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_acm_create_certificateauthority:
	@$(INFO) '$(AWS_UI_LABEL)Creating certificate-authority "$(ACM_CERTIFICATEAUTHORITY_NAME) "...'; $(NORMAL)
	$(AWS) acm-pca create-certificate-authority $(__ACM_CERTIFICATE_AUTHORITY_CONFIGURATION) $(__ACM_CERTIFICATE_AUTHORITY_TYPE) $(__ACM_IDEMPOTENCY_TOKEN__CERTIFICATEAUTHORITY) $(__ACM_REVOCATION_CONFIGURATION)

_acm_delete_certificateauthority:
	@$(INFO) '$(AWS_UI_LABEL)Deleting certificate-authority "$(ACM_CERTIFICATEAUTHORITY_NAME)" ...'; $(NORMAL)
	$(AWS) acm-pca delete-certificate-authority $(__ACM_CERTIFICATE_AUTHORITY_ARN) $(__ACM_PERMANENT_DELETION_TIME_IN_DAYS)

_acm_import_certificateauthority:
	@$(INFO) '$(AWS_UI_LABEL)Importing certificate-authority "$(ACM_CERTIFICATEAUTHORITY_NAME)" ...'; $(NORMAL)
	# https://aws.amazon.com/blogs/aws/aws-certificate-manager-launches-private-certificate-authority/
	$(AWS) acm-pca import-certificate-authority $(__ACM_CERTIFICATE__CERTIFICATEAUTHORITY) $(__ACM_CERTIFICATE_AUTHORITY_ARN) $(__ACM_CERTIFICATE_CHAIN__CERTIFICATEAUTHORITY)

_acm_issue_certificate_by_certificateauthority:
	@$(INFO) '$(AWS_UI_LABEL)Issuing certificate "$(ACM_CERTIFICATEAUTHORITY_CERTIFICATE_NAME)" by certificate-authority "$(ACM_CERTIFICATEAUTHORITY_NAME)" ...'; $(NORMAL)
	$(AWS) acm-pca issue-certificate $(__ACM_CERTIFICATE_AUTHORITY_ARN) $(__ACM_CSR) $(__ACM_SIGNING_ALGORITHM) $(__ACM_VALIDITY)

_acm_revoke_certificate_by_certificateauthority:
	@$(INFO) '$(AWS_UI_LABEL)Revoking certificate "$(ACM_CERTIFICATEAUTHORITY_CERTIFICATE_NAME)" by certificate-authority "$(ACM_CERTIFICATEAUTHORITY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Certificate is revoked for following reason: $(ACM_CERTIFICATEAUTHORITY_REVOCATION_REASON)'; $(NORMAL)
	$(AWS) acm-pca revoke-certificate $(__ACM_CERTIFICATE_AUTHORITY_ARN) $(__ACM_REVOCATION_REASON) $(__ACM_CERTIFICATE_SERIAL__CERTIFICATEAUTHORITY)

_acm_show_certificateauthority: _acm_show_certificateauthority_chain _acm_show_certificateauthority_csr _acm_show_certificateauthority_tags _acm_show_certificateauthority_description

_acm_show_certificateauthority_chain:
	@$(INFO) '$(AWS_UI_LABEL)Showing certificate-chain to certificate-authority "$(ACM_CERTIFICATEAUTHORITY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the certificate has not be signed and the certificate-chain has not be generated!'; $(NORMAL)
	-echo; $(AWS) acm-pca get-certificate-authority-certificate $(__ACM_CERTIFICATE_AUTHORITY_ARN) # --query "Csr" --output text

_acm_show_certificateauthority_csr:
	@$(INFO) '$(AWS_UI_LABEL)Showing certificate-signing-request of certificate-authority "$(ACM_CERTIFICATEAUTHORITY_NAME)" ...'; $(NORMAL)
	echo; $(AWS) acm-pca get-certificate-authority-csr $(__ACM_CERTIFICATE_AUTHORITY_ARN) --query "Csr" --output text

_acm_show_certificateauthority_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of certificate-authority "$(ACM_CERTIFICATEAUTHORITY_NAME)" ...'; $(NORMAL)
	$(AWS) acm-pca describe-certificate-authority $(__ACM_CERTIFICATE_AUTHORITY_ARN)

_acm_show_certificateauthority_tags:
	@$(INFO) '$(AWS_UI_LABEL)Showing tags of certificate-authority "$(ACM_CERTIFICATEAUTHORITY_NAME)" ...'; $(NORMAL)
	$(AWS) acm-pca list-tags $(__ACM_CERTIFICATE_AUTHORITY_ARN)

_acm_tag_certificateauthority:
	@$(INFO) '$(AWS_UI_LABEL)Tagging certificate-authority "$(ACM_CERTIFICATEAUTHORITY_NAME)" ...'; $(NORMAL)
	$(AWS) acm-pca tag-certificate-authority $(__ACM_CERTIFICATE_AUTHORITY_ARN) $(__ACM_TAGS__CERTIFICATEAUTHORITY)

_acm_untag_certificateauthority:
	@$(INFO) '$(AWS_UI_LABEL)Untagging certificate-authority "$(ACM_CERTIFICATEAUTHORITY_NAME)" ...'; $(NORMAL)
	$(AWS) acm-pca untag-certificate-authority $(__ACM_CERTIFICATE_AUTHORITY_ARN) $(__ACM_TAGS__CERTIFICATEAUTHORITY)

_acm_update_certificateauthority:
	@$(INFO) '$(AWS_UI_LABEL)Updating certificate-authority "$(ACM_CERTIFICATEAUTHORITY_NAME)" ...'; $(NORMAL)
	$(AWS) acm-pca update-certificate-authority $(__ACM_CERTIFICATE_AUTHORITY_ARN) $(__ACM_REVOCATION_CONFIGURATION) $(__ACM_STATUS__CERTIFICATEAUTHORITY)

_acm_view_certificateauthorities:
	@$(INFO) '$(AWS_UI_LABEL)Viewing certificate-authorities ...'; $(NORMAL)
	$(AWS) acm-pca list-certificate-authorities --query "CertificateAuthorities[]$(ACM_UI_VIEW_CERTIFICATEAUTHORITIES_FIELDS)"

_acm_view_certificateauthorities_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing certificate-authorities-set "$(ACM_CERTIFICATEAUTHORITIES_SET_NAME)" ...'; $(NORMAL)
	$(AWS) acm-pca list-certificate-authorities --query "CertificateAuthorities[$(ACM_UI_VIEW_CERTIFICATEAUTHORITIES_SET_SLICE)]$(ACM_UI_VIEW_CERTIFICATEAUTHORITIES_SET_FIELDS)"
