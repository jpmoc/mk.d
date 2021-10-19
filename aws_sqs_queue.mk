_AWS_SQS_QUEUE_MK_VERSION=$(_AWS_SQS_MK_VERSION)

SQS_QUEUE_ATTRIBUTE_NAMES= All
# SQS_QUEUE_ATTRIBUTES?=
# SQS_QUEUE_ATTRIBUTES_FILEPATH?= ./queue-attributes.json
# SQS_QUEUE_DELAY_SECONDS?= 10
# SQS_QUEUE_NAME?= my-queue
# SQS_QUEUE_NAME_PREFIX?=
# SQS_QUEUE_TAG_KEYS?= 'string' 'string' ...
# SQS_QUEUE_TAGS?= KeyName1=string,KeyName2=string
# SQS_QUEUE_URL?= https://sqs.us-east-1.amazonaws.com/80398EXAMPLE/MyNewerQueue

# Derived variables
SQS_QUEUE_ATTRIBUTES?= $(if $(SQS_QUEUE_ATTRIBUTES_FILEPATH), file://$(SQS_QUEUE_ATTRIBUTES_FILEPATH))

# Options variables
__SQS_ATTRIBUTE_NAMES_QUEUE= $(if $(SQS_QUEUE_ATTRIBUTE_NAMES), --attribute-names $(SQS_QUEUE_ATTRIBUTE_NAMES))
__SQS_ATTRIBUTES_QUEUE= $(if $(SQS_QUEUE_ATTRIBUTES), --attributes $(SQS_QUEUE_ATTRIBUTES))
__SQS_QUEUE_NAME= $(if $(SQS_QUEUE_NAME), --queue-name $(SQS_QUEUE_NAME))
__SQS_QUEUE_NAME_PREFIX= $(if $(SQS_QUEUE_NAME_PREFIX), --queue-name-prefix $(SQS_QUEUE_NAME_PREFIX))
__SQS_QUEUE_URL= $(if $(SQS_QUEUE_URL), --queue-url $(SQS_QUEUE_URL))
__SQS_TAG_KEYS= $(if $(SQS_QUEUE_TAG_KEYS), --tag-keys $(SQS_QUEUE_TAG_KEYS))
__SQS_TAGS_QUEUE= $(if $(SQS_QUEUE_TAGS), --tags $(SQS_QUEUE_TAGS))

# UI variables

#--- Utilities

#--- MACRO

# This macro was created to bypass network access
# For network access, use _sqs_get_queue_attribute_N !
_sqs_get_queue_arn=$(call _sqs_get_queue_arn_N, $(SQS_QUEUE_NAME))
_sqs_get_queue_arn_N=$(call _sqs_get_queue_arn_NR, $(1), $(AWS_REGION))
_sqs_get_queue_arn_NR=$(call _sqs_get_queue_arn_NRA, $(1), $(2), $(AWS_ACCOUNT_ID))
_sqs_get_queue_arn_NRA=$(shell echo arn:aws:sqs:$(strip $(2)):$(strip $(3)):$(strip $(1)))

# You could user the get-url-queue API call, but requires network access!
_sqs_get_queue_url=$(call _sqs_get_queue_url_N, $(SQS_QUEUE_NAME))
_sqs_get_queue_url_N=$(call _sqs_get_queue_url_NA, $(1), $(AWS_ACCOUNT_ID))
_sqs_get_queue_url_NA=$(shell echo https://queue.amazonaws.com/$(strip $(2))/$(strip $(1)))

_sqs_get_queue_attribute_N=$(call _sqs_get_queue_attribute_NU, $(1), $(SQS_QUEUE_URL))
_sqs_get_queue_attribute_NU=$(shell $(AWS) sqs get-queue-attribute --queue-url $(2) --attribute-names $(1) --query "Attributes.$(strip $(1))" --output text)

_sqs_get_queue_delay_seconds=$(call _sqs_get_queue_attribute_N, DelaySeconds)

#----------------------------------------------------------------------
# USAGE
#

_sqs_view_makefile_macros ::
	@echo "AWS::SQS::Queue ($(_AWS_SQS_QUEUE_MK_VERSION)) macros:"
	@echo "    _sqs_get_queue_arn_{|N|NR|NRA}       - Get the ARN of a queue (queueName,Region,AccountId)"
	@echo "    _sqs_get_queue_url_{|N|NA}           - Get the URL of a queue (queueName,AccountId)"
	@echo

_sqs_view_makefile_targets ::
	@echo "AWS::SQS::Queue ($(_AWS_SQS_QUEUE_MK_VERSION)) targets:"
	@echo "    _sqs_create_queue                    - Create a SQS queue"
	@echo "    _sqs_delete_queue                    - Delete a SQS queue"
	@echo "    _sqs_show_queue                      - Show details of a SQS queue"
	@echo "    _sqs_show_queue_attributes           - Show attribtues of a SQS queue"
	@echo "    _sqs_show_queue_tags                 - Show tags of a SQS queue"
	@echo "    _sqs_tag_queue                       - Tag an existing SQS queue"
	@echo "    _sqs_untag_queue                     - Untag an existing SQS queue"
	@echo "    _sqs_view_queues                     - View SQS queues"
	@echo

_sqs_view_makefile_variables ::
	@echo "AWS::SQS::Queue ($(_AWS_SQS_QUEUE_MK_VERSION)) variables:"
	@echo "    SQS_QUEUE_ATTRIBUTE_NAMES=$(SQS_QUEUE_ATTRIBUTE_NAMES)"
	@echo "    SQS_QUEUE_ATTRIBUTES=$(SQS_QUEUE_ATTRIBUTES)"
	@echo "    SQS_QUEUE_ATTRIBUTES_FILEPATH=$(SQS_QUEUE_ATTRIBUTES_FILEPATH)"
	@echo "    SQS_QUEUE_DELAY_SECONDS=$(SQS_QUEUE_DELAY_SECONDS)"
	@echo "    SQS_QUEUE_KEYS=$(SQS_QUEUE_KEYS)"
	@echo "    SQS_QUEUE_NAME=$(SQS_QUEUE_NAME)"
	@echo "    SQS_QUEUE_NAME_PREFIX=$(SQS_QUEUE_NAME_PREFIX)"
	@echo "    SQS_QUEUE_TAG_KEYS=$(SQS_QUEUE_TAG_KEYS)"
	@echo "    SQS_QUEUE_TAGS=$(SQS_QUEUE_TAGS)"
	@echo "    SQS_QUEUE_URL=$(SQS_QUEUE_URL)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/aws_sqs_queue_deadletter.mk
-include $(MK_DIR)/aws_sqs_queue_fifo.mk
-include $(MK_DIR)/aws_sqs_queue_standard.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sqs_create_queue:
	@$(INFO) "$(AWS_LABEL)Creating a new queue '$(SQS_QUEUE_NAME)' ..."; $(NORMAL)
	@$(WARN) "You must wait 60 seconds after deleting a queue before you can create another with the same name"; $(NORMAL)
	@$(WARN) "IF you use a dead letter queue, it must exist before you refer to it"; $(NORMAL)
	$(AWS) sqs create-queue $(__SQS_ATTRIBUTES_QUEUE) $(__SQS_QUEUE_NAME)

_sqs_delete_queue:
	@$(INFO) "$(AWS_LABEL)Deleting queue '$(SQS_QUEUE_NAME)' ..."; $(NORMAL)
	$(AWS) sqs delete-queue $(__SQS_QUEUE_URL)

_sqs_show_queue:
	@$(INFO) "$(AWS_LABEL)Showing details of queue '$(SQS_QUEUE_NAME)' ..."; $(NORMAL)
	$(AWS) sqs XXXX $(__SQS_QUEUE_NAME)

_sqs_show_queue_attributes:
	@$(INFO) "$(AWS_LABEL)Showing attributes of SQS queue '$(SQS_QUEUE_NAME)' ..."; $(NORMAL)
	$(AWS) sqs get-queue-attributes $(__SQS_ATTRIBUTE_NAMES_QUEUE) $(__SQS_QUEUE_URL) --query "Attributes"

_sqs_show_queue_url:
	@$(INFO) "$(AWS_LABEL)Showing URL of SQS queue '$(SQS_QUEUE_NAME)' ..."; $(NORMAL)
	$(AWS) sqs get-queue-url $(__SQS_QUEUE_NAME)

_sqs_show_queue_tags:
	@$(INFO) "$(AWS_LABEL)Showing tags of SQS queue '$(SQS_QUEUE_NAME)' ..."; $(NORMAL)
	$(AWS) sqs list-queue-tags $(__SQS_QUEUE_URL) --query "Tags"

_sqs_tag_queue:
	@$(INFO) "$(AWS_LABEL)Tagging SQS queue '$(SQS_QUEUE_NAME)' ..."; $(NORMAL)
	$(AWS) sqs tag-queue $(__SQS_QUEUE_URL) $(__SQS_TAGS_QUEUE)

_sqs_untag_queue:
	@$(INFO) "$(AWS_LABEL)Untagging SQS queue '$(SQS_QUEUE_NAME)' ..."; $(NORMAL)
	$(AWS) sqs untag-queue $(__SQS_QUEUE_URL) $(__SQS_TAG_KEYS)

_sqs_view_queues:
	@$(INFO) "$(AWS_LABEL)Viewing all existing queues ..."; $(NORMAL)
	$(AWS) sqs list-queues $(__SQS_QUEUE_NAME_PREFIX) --query "QueueUrls"
