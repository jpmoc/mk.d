_AWS_IAM_CERTIFICATE_MK_VERSION= $(_AWS_IAM_MK_VERSION)

# IAM_CERTIFICATE_NAME?= star-surfcrew-com
# IAM_CERTIFICATE_BODY?=
# IAM_CERTIFICATE_PRIVATE_KEY?=

# Derived parameters

# Option parameters
__IAM_SERVER_CERTIFICATE_NAME= $(if $(IAM_CERTIFICATE_NAME), --server-certificate-name $(IAM_CERTIFICATE_NAME))
__IAM_CERTIFICATE_BODY= $(if $(IAM_CERTIFICATE_BODY), --certificate-body $(IAM_CERTIFICATE_BODY))
__IAM_CERTIFICATE_CHAIN= $(if $(IAM_CERTIFICATE_CHAIN), --certificate-chain $(IAM_CERTIFICATE_CHAIN))
__IAM_PRIVATE_KEY_FILE= $(if $(IAM_CERTIFICATE_PRIVATE_KEY), --private-key $(IAM_CERTIFICATE_PRIVATE_KEY))

# UI parameters
IAM_UI_SHOW_CERTIFICATE_FIELDS?=

#--- MACROS
_iam_get_certificate_arn=$(call get_certificate_arn_N, $(IAM_CERTIFICATE_NAME))
_iam_get_certificate_arn_N=$(shell $(AWS) iam get-server-certificate --server-certificate-name $(1) --query 'ServerCertificate.ServerCertificateMetadata.Arn' --output text)

#----------------------------------------------------------------------
# USAGE
#
_iam_list_macros ::
	@echo 'AWS::IAM::Certificate ($(_AWS_IAM_CERTIFICATE_MK_VERSION)) macros:'
	@echo '    _iam_get_certificate_arn_{|N}        - Get the ARN of a current certificate'
	@echo

_iam_list_parameters ::
	@echo 'AWS::IAM::Certificate ($(_AWS_IAM_CERTIFICATE_MK_VERSION)) parameters:'
	@echo '    IAM_CERTIFICATE_BODY=$(IAM_CERTIFICATE_BODY)'
	@echo '    IAM_CERTIFICATE_CHAIN=$(IAM_CERTIFICATE_CHAIN)'
	@echo '    IAM_CERTIFICATE_NAME=$(IAM_CERTIFICATE_NAME)'
	@echo '    IAM_CERTIFICATE_PRIVATE_KEY=$(IAM_CERTIFICATE_PRIVATE_KEY)'
	@echo

_iam_list_targets ::
	@echo 'AWS::IAM::Certificate ($(_AWS_IAM_CERTIFICATE_MK_VERSION)) targets:'
	@echo '    _iam_show_certificate_content        - Show PEM-encoded certificate, CA bundle, metadata'
	@echo '    _iam_show_certificate_metadata       - Show the metadata of the current certificate'
	@echo '    _iam_upload_server_certificate       - Upload a certificate to IAM'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_iam_show_certificate_content:
	@$(INFO) '$(IAM_UI_LABEL)Displaying content of certificate "$(IAM_CERTIFICATE_NAME)" ...'; $(NORMAL)
	$(AWS) iam get-server-certificate $(__IAM_SERVER_CERTIFICATE_NAME) --output json

_iam_show_certificate_metadata:
	@$(INFO) '$(IAM_UI_LABEL)Showing metadata of certificate "$(IAM_CERTIFICATE_NAME)" ...'; $(NORMAL)
	$(AWS) iam get-server-certificate $(__IAM_SERVER_CERTIFICATE_NAME) --query 'ServerCertificate.ServerCertificateMetadata'

_iam_upload_certificate:
	@$(INFO) '$(IAM_UI_LABEL)Uploading certificate "$(IAM_CERTIFICATE_NAME)" to AWS ...'; $(NORMAL)
	$(AWS) iam upload-server-certificate $(__IAM_CERTIFICATE_BODY) $(__IAM_CERTIFICATE_CHAIN) $(__IAM_PRIVATE_KEY) $(__IAM_SERVER_CERTIFICATE_NAME)
