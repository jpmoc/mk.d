_AWS_SNS_TOPIC_MK_VERSION= $(_AWS_SNS_MK_VERSION)

# SNS_TOPIC_ARN?= arn:aws:sns:us-east-1:123456789012:WordPressTopic
# SNS_TOPIC_NAME?= my-topic

# Derived variables
SNS_TOPIC_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)
SNS_TOPIC_REGION?= $(AWS_REGION)

# Option variables
__SNS_NAME?= $(if $(SNS_TOPIC_NAME), --name $(SNS_TOPIC_NAME))
__SNS_TOPIC_ARN?= $(if $(SNS_TOPIC_ARN), --topic-arn $(SNS_TOPIC_ARN))

# UI variables
SNS_UI_SHOW_TOPIC_FIELDS?= .{SubscriptionsConfirmed:SubscriptionsConfirmed,SubscriptionsDeleted:SubscriptionsDeleted,SubscriptionsPending:SubscriptionsPending,Owner:Owner,DisplayName:DisplayName}
SNS_UI_SHOW_TOPIC_SUBSCRIPTIONS_FIELDS?= .{Endpoint:Endpoint,Protocol:Protocol,SubscriptionArn:SubscriptionArn}

#--- Utilities

#--- MACRO
_sns_get_topic_arn=$(call _sns_get_topic_arn_N, $(SNS_TOPIC_NAME))
_sns_get_topic_arn_N=$(call _sns_get_topic_arn_NR, $(1), $(SNS_TOPIC_REGION))
_sns_get_topic_arn_NR=$(call _sns_get_topic_arn_NRA, $(1), $(2), $(SNS_TOPIC_ACCOUNT_ID))
_sns_get_topic_arn_NRA=$(shell echo arn:aws:sns:$(strip $(2)):$(strip $(3)):$(strip $(1)))

#----------------------------------------------------------------------
# USAGE
#

_sns_view_framework_macros ::
	@echo 'AWS::SNS::Topic ($(_AWS_SNS_TOPIC_MK_VERSION)) macros:'
	@echo '    _sns_get_topic_arn_{|N|NR|NRA}          - Get a topic arn (Name,Region,Account)'
	@echo

_sns_view_framework_parameters ::
	@echo 'AWS::SNS::Topic ($(_AWS_SNS_TOPIC_MK_VERSION)) parameters:'
	@echo '    SNS_TOPIC_ACCOUNT_ID=$(SNS_TOPIC_ACCOUNT_ID)'
	@echo '    SNS_TOPIC_ARN=$(SNS_TOPIC_ARN)'
	@echo '    SNS_TOPIC_NAME=$(SNS_TOPIC_NAME)'
	@echo '    SNS_TOPIC_REGION=$(SNS_TOPIC_REGION)'
	@echo

_sns_view_framework_targets ::
	@echo 'AWS::SNS::Topic ($(_AWS_SNS_TOPIC_MK_VERSION)) targets:'
	@echo '    _sns_create_topic                       - Create a new topic'
	@echo '    _sns_delete_topic                       - Delete an existing topic'
	@echo '    _sns_show_topic                         - Show details of a topic'
	@echo '    _sns_show_topic_delivery_policy         - Show policy of a topic'
	@echo '    _sns_show_topic_policy                  - Show policy of a topic'
	@echo '    _sns_show_topic_subscriptions           - Show subscriptions of a topic'
	@echo '    _sns_view_topics                        - View existing topics'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sns_create_topic:
	@$(INFO) '$(SNS_UI_LABEL)Creating topic "$(SNS_TOPIC_NAME)" ...'; $(NORMAL)
	$(AWS) sns create-topic $(__SNS_NAME)
	$(AWS) sns set-topic-attributes $(__SNS_TOPIC_ARN) --attribute-name DisplayName --attribute-value '$(SNS_TOPIC_NAME)'

_sns_delete_topic:
	@$(INFO) '$(SNS_UI_LABEL)Deleting topic "$(SNS_TOPIC_NAME)" ...'; $(NORMAL)
	$(AWS) sns delete-topic $(__SNS_TOPIC_ARN)

_sns_show_topic:
	@$(INFO) '$(SNS_UI_LABEL)Showing topic "$(SNS_TOPIC_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The subscription statistics are updated asynchronously, i.e not in real time, but every few minutes!'; $(NORMAL)
	$(AWS) sns get-topic-attributes $(__SNS_TOPIC_ARN) --query "Attributes$(SNS_UI_SHOW_TOPIC_FIELDS)"

_sns_show_topic_delivery_policy:
	@$(INFO) '$(SNS_UI_LABEL)Showing effective delivery-policy of topic '$(SNS_TOPIC_NAME)' ...'; $(NORMAL)
	$(AWS) sns get-topic-attributes $(__SNS_TOPIC_ARN) --query "Attributes.EffectiveDeliveryPolicy" --output text | jq -M '.'

_sns_show_topic_policy:
	@$(INFO) '$(SNS_UI_LABEL)Showing policy of topic "$(SNS_TOPIC_NAME)" ...'; $(NORMAL)
	$(AWS) sns get-topic-attributes $(__SNS_TOPIC_ARN) --query "Attributes.Policy" --output text | jq  -M '.'

_sns_show_topic_subscriptions:
	@$(INFO) '$(SNS_UI_LABEL)Showing subscriptions to topic "$(SNS_TOPIC_NAME)" ...'; $(NORMAL)
	$(AWS) sns list-subscriptions-by-topic $(__SNS_TOPIC_ARN) --query "Subscriptions[]$(SNS_UI_SHOW_TOPIC_SUBSCRIPTIONS_FIELDS)"

_sns_view_topics:
	@$(INFO) '$(SNS_UI_LABEL)Viewing ALL topics ...'; $(NORMAL)
	$(AWS) sns list-topics 
