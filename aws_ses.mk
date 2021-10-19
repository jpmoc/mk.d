_AWS_SES_MK_VERSION=0.99.6

# SES_DESTINATION?= ToAddresses=mike@g.com,toto@g.com,CcAddresses=mike@g.com,toto@g.com,BccAddresses=mike@g.com,toto@g.com
# SES_DESTINATION_FILEPATH?= ./destination.json
# SES_EMAIL_ADDRESS?= mike@domain.com
# SES_FROM?= sender@example.com
# SES_MESSAGE?= Subject={Data=from ses,Charset=utf8},Body={Text={Data=ses says hi,Charset=utf8},Html={Data=,Charset=utf8}}
# SES_MESSAGE_FILEPATH?= ./message.json
# SES_RAW_MESSAGE?= Data=blob
# SES_RAW_MESSAGE_FILEPATH?= ./message.json

# Derived variables
SES_DESTINATION?= $(if $(SES_DESTINATION_FILEPATH), file://$(SES_DESTINATION_FILEPATH))
SES_MESSAGE?= $(if $(SES_MESSAGE_FILEPATH), file://$(SES_MESSAGE_FILEPATH))
SES_RAW_MESSAGE?= $(if $(SES_RAW_MESSAGE_FILEPATH), file://$(SES_RAW_MESSAGE_FILEPATH))

# Options
__SES_DESTINATION= $(if $(SES_DESTINATION), --destination $(SES_DESTINATION))
__SES_EMAIL_ADDRESS= $(if $(SES_EMAIL_ADDRESS), --email-address $(SES_EMAIL_ADDRESS))
__SES_FROM= $(if $(SES_FROM), --from $(SES_FROM))
__SES_MESSAGE= $(if $(SES_MESSAGE), --message $(SES_MESSAGE))
__SES_RAW_MESSAGE= $(if $(SES_RAW_MESSAGE), --raw-message $(SES_RAW_MESSAGE))

# UI variables
SES_SEND_EMAIL_FIELDS?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_account_limits :: _ses_view_account_limits

_aws_view_makefile_macros :: _ses_view_makefile_macros
_ses_view_makefile_macros:
	@echo "AWS::SES ($(_AWS_SES_MK_VERSION)) macros:"
	@echo

_aws_view_makefile_targets :: _ses_view_makefile_targets
_ses_view_makefile_targets:
	@echo "AWS::SES ($(_AWS_SES_MK_VERSION)) targets:"
	@echo "    _ses_send_email                - Send an email"
	@echo "    _ses_send_raw_email            - Send a raw email"
	@echo "    _ses_view_account_limits       - View quotas and limits"
	@echo "    _ses_verify_email              - Attempt to verify a new email"
	@echo "    _ses_view_verified_identities  - View verified sender emails"
	@echo 

_aws_view_makefile_variables :: _ses_view_makefile_variables
_ses_view_makefile_variables:
	@echo "AWS::SES ($(_AWS_SES_MK_VERSION)) variables:"
	@echo "    SES_DESTINATION=$(SES_DESTINATION)"
	@echo "    SES_DESTINATION_FILEPATH=$(SES_DESTINATION_FILEPATH)"
	@echo "    SES_EMAIL_ADDRESS=$(SES_EMAIL_ADDRESS)"
	@echo "    SES_MESSAGE=$(SES_MESSAGE)"
	@echo "    SES_MESSAGE_FILEPATH=$(SES_MESSAGE_FILEPATH)"
	@echo "    SES_RAW_MESSAGE=$(SES_RAW_MESSAGE)"
	@echo "    SES_RAW_MESSAGE_FILEPATH=$(SES_RAW_MESSAGE_FILEPATH)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ses_send_email:
	@$(INFO) "$(AWS_LABEL)Sending email ..."; $(NORMAL)
	@$(WARN) "Checking email's destination ..."; $(NORMAL)
	[ -f $(SES_DESTINATION_FILEPATH) ] && cat $(SES_DESTINATION_FILEPATH)
	@$(WARN) "Checking email's content ..."; $(NORMAL)
	[ -f $(SES_MESSAGE_FILEPATH) ] && cat $(SES_MESSAGE_FILEPATH)
	$(AWS) ses send-email $(__SES_DESTINATION) $(__SES_FROM) $(__SES_MESSAGE)

_ses_send_raw_email:
	@$(INFO) "$(AWS_LABEL)Sending raw email ..."; $(NORMAL)
	@$(WARN) "Check the email's custom headers and content ..."; $(NORMAL)
	[ -f $(SES_RAW_MESSAGE_FILEPATH) ] && cat $(SES_RAW_MESSAGE_FILEPATH)
	$(AWS) ses send-raw-email $(__SES_RAW_MESSAGE)

_ses_view_account_limits:
	@$(INFO) "$(AWS_LABEL)Viewing email quotas and limits ..."; $(NORMAL)
	$(AWS) ses get-send-quota

_ses_email_verification_request:
	@$(INFO) "$(AWS_LABEL)Emailing a verification request '$(SES_EMAIL_ADDRESS)' ..."; $(NORMAL)
	@$(WARN) "To successfully verify this email, click on the link in request"; $(NORMAL)
	$(AWS)  ses verify-email-identity $(__SES_EMAIL_ADDRESS)

_ses_view_verified_identities:
	@$(INFO) "$(AWS_LABEL)Viewing verified identities by email or domain ..."; $(NORMAL)
	$(AWS)  ses list-identities
