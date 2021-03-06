_AWS_SQS_MESSAGE_MK_VERSION=$(_AWS_SQS_MK_VERSION)

SQS_MESSAGE_ATTRIBUTE_NAMES?= All
# SQS_MESSAGE_ATTRIBUTES?= KeyName1=StringValue=string,BinaryValue=blob,StringListValues=string,string,BinaryListValues=blob,blob,DataType=string,KeyName2=StringValue=string,BinaryValue=blob,StringListValues=string,string,BinaryListValues=blob,blob,DataType=string
# SQS_MESSAGE_ATTRIBUTES_FILEPATH?= ./message-attributes.json
# SQS_MESSAGE_DEDUPLICATION_ID?=
# SQS_MESSAGE_GROUP_ID?=
# SQS_RECEIVE_MAX_NUMBER_OF_MESSAGES?= 10
# SQS_RECEIVE_REQUEST_ATTEMPT_ID?=
# SQS_RECEIVE_WAIT_TIME_SECONDS?= 10
# SQS_SEND_DELAY_SECONDS?= 10

# Derived variables
SQS_MESSAGE_ATTRIBUTES?= $(if $(SQS_MESSAGE_ATTRIBUTES_FILEPATH), file://$(SQS_MESSAGE_ATTRIBUTES_FILEPATH))
SQS_MESSAGE_DELAY_SECONDS?= $(SQS_QUEUE_DELAY_SECONDS)

# Options variables
__SQS_ATTRIBUTE_NAMES_MESSAGE= $(if $(SQS_MESSAGE_ATTRIBUTE_NAMES), --attribute-names $(SQS_MESSAGE_ATTRIBUTE_NAMES))
__SQS_DELAY_SECONDS= $(if $(SQS_SEND_DELAY_SECONDS), --delay-seconds $(SQS_SEND_DELAY_SECONDS))
__SQS_MAX_NUMBER_OF_MESSAGES= $(if $(SQS_RECEIVE_MAX_NUMBER_OF_MESSAGES), --max-number-of-messages $(SQS_RECEIVE_MAX_NUMBER_OF_MESSAGES))
__SQS_MESSAGE_ATTRIBUTE_NAMES=
__SQS_MESSAGE_ATTRIBUTES= $(if $(SQS_MESSAGE_ATTRIBUTES), --message-attributes $(SQS_MESSAGE_ATTRIBUTES))
__SQS_MESSAGE_BODY= $(if $(SQS_MESSAGE_BODY), --message-body "$(SQS_MESSAGE_BODY)")
__SQS_MESSAGE_DEDUPLICATION_ID= $(if $(SQS_MESSAGE_DEDUPLICATION_ID), --message-deduplication-id $(SQS_MESSAGE_DEDUPLICATION_ID))
__SQS_MESSAGE_GROUP_ID= $(if $(SQS_MESSAGE_GROUP_ID), --message-group-id $(SQS_MESSAGE_GROUP_ID))
__SQS_RECEIVE_REQUEST_ATTEMPT_ID=
__SQS_VISIBILITY_TIMEOUT=
__SQS_WAIT_TIME_SECONDS= $(if $(SQS_RECEIVE_WAIT_TIME_SECONDS), --wait-time-seconds $(SQS_RECEIVE_WAIT_TIME_SECONDS))

# UI variables
SQS_I_RECEIVE_MESSAGE_FIELDS?=

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_sqs_view_makefile_macros ::
	@echo "AWS::SQS::Message ($(_AWS_SQS_MESSAGE_MK_VERSION)) macros:"
	@echo

_sqs_view_makefile_targets ::
	@echo "AWS::SQS::Message ($(_AWS_SQS_MESSAGE_MK_VERSION)) targets:"
	@echo "    _sqs_send_message       - Send a message to a SQS queue"
	@echo

_sqs_view_makefile_variables ::
	@echo "AWS::SQS::Message ($(_AWS_SQS_MESSAGE_MK_VERSION)) variables:"
	@echo "    SQS_MESSAGE_ATTRIBUTE_NAMES=$(SQS_MESSAGE_ATTRIBUTE_NAMES)"
	@echo "    SQS_MESSAGE_ATTRIBUTES=$(SQS_MESSAGE_ATTRIBUTES)"
	@echo "    SQS_MESSAGE_ATTRIBUTES_FILEAPTH=$(SQS_MESSAGE_ATTRIBUTE_FILEPATH)"
	@echo "    SQS_MESSAGE_DEDUPLICATION_ID=$(SQS_QUEUE_DEDUPLICATION_ID)"
	@echo "    SQS_MESSAGE_GROUP_ID=$(SQS_QUEUE_GROUP_ID)"
	@echo "    SQS_RECEIVE_MAX_NUMBER_OF_MESSAGES=$(SQS_RECEIVE_MAX_NUMBER_OF_MESSAGES)"
	@echo "    SQS_RECEIVE_REQUEST_ATTEMPT_ID=$(SQS_RECEIVE_REQUEST_ATTEMPT_ID)"
	@echo "    SQS_RECEIVE_WAIT_TIME_SECONDS=$(SQS_RECEIVE_WAIT_TIME_SECONDS)"
	@echo "    SQS_SEND_DELAY_SECONDS=$(SQS_SEND_DELAY_SECONDS)"
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sqs_receive_message:
	@$(INFO) "$(AWS_LABEL)Receiving message from the queue '$(SQS_QUEUE_NAME)' ..."; $(NORMAL)
	$(AWS) sqs receive-message $(__SQS_ATTRIBUTE_NAMES_MESSAGE) $(__SQS_MAX_NUMBER_OF_MESSAGES) $(__SQS_MESSAGE_ATTRIBUTE_NAMES) $(__SQS_QUEUE_URL) $(__SQS_RECEIVE_REQUEST_ATTEMPT_ID) $(__SQS_VISIBILITY_TIMEOUT) $(__SQS_WAIT_TIME_SECONDS) --query "Messages[]$(SQS_UI_RECEIVE_MESSAGE_FIELDS)"

_sqs_send_message:
	@$(INFO) "$(AWS_LABEL)Sending message to the queue '$(SQS_QUEUE_NAME)' ..."; $(NORMAL)
	$(if $(SQS_MESSAGE_ATTRIBUTES_FILEPATH), cat $(SQS_MESSAGE_ATTRIBUTES_FILEPATH))
	$(AWS) sqs send-message $(__SQS_DELAY_SECONDS) $(__SQS_MESSAGE_ATTRIBUTES) $(__SQS_MESSAGE_BODY) $(__SQS_MESSAGE_DEDUPLICATION_ID) $(__SQS_MESSAGE_GROUP_ID) $(__SQS_QUEUE_URL)
