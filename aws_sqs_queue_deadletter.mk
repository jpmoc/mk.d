_AWS_SQS_QUEUE_DEADLETTER_MK_VERSION=$(_AWS_SQS_QUEUE_MK_VERSION)

# SQS_DEADLETTER_NAME?= my-dead-letter-queue
# SQS_DEADLETTER_URL?= https://sqs.us-east-1.amazonaws.com/80398EXAMPLE/MyDeadLeatterQueue

# Derived variables

# Options variables
# __SQS_ATTRIBUTE_NAMES= $(if $(SQS_QUEUE_ATTRIBUTE_NAMES), --attribute-names $(SQS_QUEUE_ATTRIBUTE_NAMES))
# __SQS_ATTRIBUTES= $(if $(SQS_QUEUE_ATTRIBUTES), --attributes $(SQS_QUEUE_ATTRIBUTES))
__SQS_QUEUE_NAME_DEADLETTER= $(if $(SQS_DEADLETTER_NAME), --queue-name $(SQS_DEADLETTER_NAME))
# __SQS_QUEUE_NAME_PREFIX= $(if $(SQS_QUEUE_NAME_PREFIX), --queue-name-prefix $(SQS_QUEUE_NAME_PREFIX))
# __SQS_QUEUE_URL= $(if $(SQS_QUEUE_URL), --queue-url $(SQS_QUEUE_URL))

# UI variables

#--- Utilities

#--- MACRO

# This macro was created to bypass network access
# For network access, use _sqs_get_queue_attribute_N !
# _sqs_get_queue_arn=$(call _sqs_get_queue_arn_N, $(SQS_QUEUE_NAME))
# _sqs_get_queue_arn_N=$(call _sqs_get_queue_arn_NR, $(1), $(AWS_REGION))
# _sqs_get_queue_arn_NR=$(call _sqs_get_queue_arn_NRA, $(1), $(2), $(AWS_ACCOUNT_ID))
# _sqs_get_queue_arn_NRA=$(shell echo arn:aws:sqs:$(strip $(2)):$(strip $(3)):$(strip $(1)))

# You could user the get-url-queue API call, but requires network access!
# _sqs_get_queue_url=$(call _sqs_get_queue_url_N, $(SQS_QUEUE_NAME))
# _sqs_get_queue_url_N=$(call _sqs_get_queue_url_NA, $(1), $(AWS_ACCOUNT_ID))
# _sqs_get_queue_url_NA=$(shell echo https://queue.amazonaws.com/$(strip $(2))/$(strip $(1)))

# _sqs_get_queue_attribute_N=$(call _sqs_get_queue_attribute_NU, $(1), $(SQS_QUEUE_URL))
# _sqs_get_queue_attribute_NU=$(shell $(AWS) sqs get-queue-attribute --queue-url $(2) --attribute-names $(1) --query "Attributes.$(strip $(1))" --output text)

# _sqs_get_queue_delay_seconds=$(call _sqs_get_queue_attribute_N, DelaySeconds)

#----------------------------------------------------------------------
# USAGE
#

_sqs_view_makefile_macros ::
	@echo "AWS::SQS::Queue::DeadLetter ($(_AWS_SQS_QUEUE_DEADLETTER_MK_VERSION)) macros:"
	@echo "    _sqs_get_queue_arn_{|N|NR|NRA}       - Get the ARN of a queue (queueName,Region,AccountId)"
	@echo "    _sqs_get_queue_url_{|N|NA}           - Get the URL of a queue (queueName,AccountId)"
	@echo

_sqs_view_makefile_targets ::
	@echo "AWS::SQS::Queue::DeadLetter ($(_AWS_SQS_QUEUE_DEADLETTER_MK_VERSION)) targets:"
	@echo "    _sqs_show_deadletter_sources         - Show source-queues of a SQS dead letter queue"
	@echo

_sqs_view_makefile_variables ::
	@echo "AWS::SQS::Queue::DeadLetter ($(_AWS_SQS_QUEUE_DEADLETTER_MK_VERSION)) variables:"
	@echo "    SQS_DEADLETTER_NAME=$(SQS_DEADLETTER_NAME)"
	@echo "    SQS_DEADLETTER_URL=$(SQS_DEADLETTER_URL)"
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sqs_create_deadletter: SQS_QUEUE_ATTRIBUTES= $(SQS_DEADLETTER_ATTRIBUTES)
_sqs_create_deadletter: SQS_QUEUE_NAME= $(SQS_DEADLETTER_NAME)
_sqs_create_deadletter: _sqs_create_queue

_sqs_delete_deadletter: SQS_QUEUE_NAME= $(SQS_DEADLETTER_NAME)
_sqs_delete_deadletter: SQS_QUEUE_URL= $(SQS_DEADLETTER_URL)
_sqs_delete_deadletter: _sqs_delete_queue
 
_sqs_show_deadletter:
 
_sqs_show_deadletter_sources:
	@$(INFO) "$(AWS_LABEL)Showing source queues of dead-letter queue '$(SQS_DEADLETTER_NAME) ..."; $(NORMAL)
	$(AWS) sqs list-dead-letter-source-queues $(__SQS_DEADLETTER_URL)
 
_sqs_show_deadletter_attributes: SQS_QUEUE_ATTRIBUTE_NAMES= $(SQS_DEADLETTER_ATTRIBUTE_NAMES)
_sqs_show_deadletter_attributes: SQS_QUEUE_URL= $(SQS_DEADLETTER_URL)
_sqs_show_deadletter_attributes: _sqs_show_queue_attributes
 
_sqs_show_deadletter_url: SQS_QUEUE_NAME= $(SQS_DEADLETTER_NAME)
_sqs_show_deadletter_uel: _sqs_show_queue_url
 
_sqs_view_deadletters:
	@$(INFO) "$(AWS_LABEL)Viewing all dead-letter queues ..."; $(NORMAL)
	$(AWS) sqs list-queues $(__SQS_QUEUE_NAME_PREFIX) --query "QueueURLs????"
