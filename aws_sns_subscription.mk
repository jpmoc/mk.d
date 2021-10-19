_AWS_SNS_SUBSCRIPTION_MK_VERSION= $(_AWS_SNS_MK_VERSION)

# SNS_SUBSCRIPTION_ARN?=
# SNS_SUBSCRIPTION_NOTIFICATION_ENDPOINT?= me@domain.com
# SNS_SUBSCRIPTION_PROTOCOL?= email

# Derived variables

# Option variables
__SNS_NOTIFICATION_ENDPOINT?= $(if $(SNS_SUBSCRIPTION_NOTIFICATION_ENDPOINT), --notification-endpoint $(SNS_SUBSCRIPTION_NOTIFICATION_ENDPOINT))
__SNS_PROTOCOL?= $(if $(SNS_SUBSCRIPTION_PROTOCOL), --protocol $(SNS_SUBSCRIPTION_PROTOCOL))
__SNS_SUBSCRIPTION_ARN?= $(if $(SNS_SUBSCRIPTION_ARN), --subscription-arn $(SNS_SUBSCRIPTION_ARN))

# UI variables
SNS_UI_SHOW_SUBSCRIPTION_FIELDS?= .{Endpoint:Endpoint,Protocol:Protocol,TopicArn:TopicArn,RawMessageDelivery:RawMessageDelivery,ConfigurationWasAuthenticated:ConfirmationWasAuthenticated}
SNS_UI_VIEW_SUBSCRIPTIONS_FIELDS?= .{Endpoint:Endpoint,Protocol:Protocol,TopicArn:TopicArn}

#--- Utilities

#--- MACRO

# Note that the subscription ARN is set to PendingConfirmation if it has not been confirmed yes!
_sns_get_subscription_arn=$(call _sns_get_subscription_arn_E, $(SNS_SUBSCRIPTION_NOTIFICATION_ENDPOINT))
_sns_get_subscription_arn_E=$(call _sns_get_subscription_arn_EP, $(1), $(SNS_SUBSCRIPTION_PROTOCOL))
_sns_get_subscription_arn_EP=$(call _sns_get_subscription_arn_EPA, $(1), $(2), $(SNS_TOPIC_ARN))
_sns_get_subscription_arn_EPA=$(shell $(AWS) sns list-subscriptions-by-topic --topic-arn $(3) --query "Subscriptions[?Protocol=='$(strip $(2))'&&Endpoint=='$(strip $(1))'].SubscriptionArn" --output text)

#----------------------------------------------------------------------
# USAGE
#

_sns_view_framework_macros ::
	@echo 'AWS::SNS::Subscription ($(_AWS_SNS_SUBSCRIPTION_MK_VERSION)) macros:'
	@echo '    _sns_get_subscription_arn_{|E|EP|EPA}   - Get a subscription arn (Endpoint,Protocol,Arn)'
	@echo

_sns_view_framework_parameters ::
	@echo 'AWS::SNS::Subscription ($(_AWS_SNS_SUBSCRIPTIO_MK_VERSION)) parameters:'
	@echo '    SNS_SUBSCRIPTION_ARN=$(SNS_SUBSCRIPTION_ARN)'
	@echo '    SNS_SUBSCRIPTION_NOTIFICATION_ENDPOINT=$(SNS_SUBSCRIPTION_NOTIFICATION_ENDPOINT)'
	@echo '    SNS_SUBSCRIPTION_PROTOCOL=$(SNS_SUBSCRIPTION_PROTOCOL)'
	@echo

_sns_view_framework_targets ::
	@echo 'AWS::SNS::Subscription ($(_AWS_SNS_iSUBSCRIPTION_MK_VERSION)) targets:'
	@echo '    _sns_create_subscription                - Create a new subscription'
	@echo '    _sns_delete_subscription                - Delete an existing subscription'
	@echo '    _sns_show_subscription                  - Show details of a subscription'
	@echo '    _sns_view_subscriptions                 - View existing subscriptions'
	@echo


#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sns_create_subscription:
	@$(INFO) '$(SNS_UI_LABEL)Creating a subscription to topic "$(SNS_TOPIC_NAME)" ...'; $(NORMAL)
	$(AWS) sns subscribe $(__SNS_NOTIFICATION_ENDPOINT) $(__SNS_PROTOCOL) $(__SNS_TOPIC_ARN)
	@$(WARN) 'An invitation has been generated and sent, it needs to be confirmed ASAP'; $(NORMAL)
	@$(WARN) 'In the meantime, the subscription ARN is set to 'PendingConfirmation''; $(NORMAL)

_sns_delete_subscription:
	@$(INFO) '$(SNS_UI_LABEL)Deleting subscription of "$(SNS_SUBSCRIPTION_NOTIFICATION_ENDPOINT)" to topic '$(SNS_TOPIC_NAME)' ...'; $(NORMAL)
	@$(WARN) 'When subscriptions are still to be confirmed, their ARN is set to 'PendingConfirmation''; $(NORMAL)
	$(AWS) sns unsubscribe $(__SNS_SUBSCRIPTION_ARN)

_sns_show_subscription: _sns_show_subscription_description

_sns_show_subscription-desctiption:
	@$(INFO) '$(SNS_UI_LABEL)Showing subscription of endpoint "$(SNS_SUBSCRIPTION_NOTIFICATION_ENDPOINT)" ...'; $(NORMAL)
	@$(WARN) 'When subscriptions are still to be confirmed, their ARN is set to "PendingConfirmation"'; $(NORMAL)
	$(AWS) sns get-subscription-attributes $(__SNS_SUBSCRIPTION_ARN) --query "Attributes$(SNS_UI_SHOW_SUBSCRIPTION_FIELDS)"

_sns_view_subscriptions:
	@$(INFO) '$(SNS_UI_LABEL)Viewing ALL subscriptions ...'; $(NORMAL)
	$(AWS) sns list-subscriptions --query "Subscriptions[]$(SNS_UI_VIEW_SUBSCRIPTIONS_FIELDS)"
