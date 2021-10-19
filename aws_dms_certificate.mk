_AWS_DMS_CERTIFICATE_MK_VERSION=$(_AWS_DMS_MK_VERSION)

# DMS_CERTIFICATE_ARN?=
# DMS_CERTIFICATE_IDENTIFIER?= my-certificate
# DMS_CERTIFICATE_PEM?=
# DMS_CERTIFICATE_TAGS?=
# DMS_CERTIFICATE_WALLET?=

# Option variables
__DMS_CERTIFICATE_ARN= $(if $(DMS_CERTIFICATE_ARN), --certificate-arn $(DMS_CERTIFICATE_ARN))
__DMS_CERTIFICATE_IDENTIFIER= $(if $(DMS_CERTIFICATE_IDENTIFIER), --certificate-identifier $(DMS_CERTIFICATE_IDENTIFIER))
__DMS_CERTIFICATE_PEM= $(if $(DMS_CERTIFICATE_PEM), --certificate-pem $(DMS_CERTIFICATE_PEM))
__DMS_CERTIFICATE_WALLET= $(if $(DMS_CERTIFICATE_WALLET), --certificate-wallet $(DMS_CERTIFICATE_WALLET))
__DMS_TAGS_CERTIFICATE=

# UI variables
DMS_UI_VIEW_CERTIFICATES_FIELDS?=

#--- Utilities

#--- MACROS
_dms_get_certificate_arn=$(call _dms_get_certificate_arn_I, $(DMS_CERTIFICATE_IDENTIFIER))
_dms_get_certificate_arn_I=$(sheel $(AWS) dms describe-certificates --query "Certificates[?CertificateIdentifier=='$(strip $(1))].CertificateArn" --output text)

#----------------------------------------------------------------------
# USAGE
#

_dms_view_makefile_macros ::
	@echo "AWS::DMS::Certificate ($(_AWS_DMS_CERTIFICATE_MK_VERSION)) macros:"
	@echo

_dms_view_makefile_targets ::
	@echo "AWS::DMS::Certificate ($(_AWS_DMS_CERTIFICATE_MK_VERSION)) targets:"
	@echo "    _dms_delete_certificate                 - Delete certificate"
	@echo "    _dms_import_certificate                 - Import a certificate"
	@echo "    _dms_view_certificates                  - View certificates"
	@echo 

_dms_view_makefile_variables ::
	@echo "AWS::DMS::Certificate ($(_AWS_DMS_CERTIFICATE_MK_VERSION)) variables:"
	@echo "    DMS_CERTIFICATE_ARN=$(DMS_CERTIFICATE_ARN)"
	@echo "    DMS_CERTIFICATE_IDENTIFIER=$(DMS_CERTIFICATE_IDENTIFIER)"
	@echo "    DMS_CERTIFICATE_PEM=$(DMS_CERTIFICATE_PEM)"
	@echo "    DMS_CERTIFICATE_TAGS=$(DMS_CERTIFICATE_TAGS)"
	@echo "    DMS_CERTIFICATE_WALLET=$(DMS_CERTIFICATE_WALLET)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dms_delete_certificate:
	@$(INFO) "$(AWS_UI_LABEL)Deleting DMS certificate '$(DMS_CERTIFICATE_IDENTIFER)'  ..."; $(NORMAL)
	$(AWS) dms delete-certificates $(__DMS_CERTIFICATE_ARN)

_dms_import_certificate:
	@$(INFO) "$(AWS_UI_LABEL)Importing DMS certificate '$(DMS_CERTIFICATE_IDENTIFER)'  ..."; $(NORMAL)
	$(AWS) dms import-certificates $(__DMS_CERTIFICATE_IDENTIFER) $(__DMS_CERTIFICATE_PEM) $(__DMS_CERTIFICATE_WALLET) $(__DMS_TAGS_CERTIFICATE)

_dms_view_certificates:
	@$(INFO) "$(AWS_UI_LABEL)Viewing DMS certificates ..."; $(NORMAL)
	$(AWS) dms describe-certificates 
