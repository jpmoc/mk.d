_AWS_NEPTUNE_EVENTSUBSCRIPTION_MK_VERSION= $(_AWS_NEPTUNE_MK_VERSION)

# NTE_EVENTSUBSCRIPTION_ENABLE?= false
# NTE_EVENTSUBSCRIPTION_NAME?= my-event-subscription-name
# NTE_EVENTSUBSCRIPTION_SNSTOPIC_ARN?=
# NTE_EVENTSUBSCRIPTION_SOURCE_IDS?=
# NTE_EVENTSUBSCRIPTION_SOURCE_TYPE?=
# NTE_EVENTSUBSCRIPTION_TAGS?= Key=string,Value=string ...

# Derived parameters

# Options parameters
__NTE_ENABLED__EVENTSUBSCRIPTION=
__NTE_EVENT_CATEGORIES=
__NTE_SNS_TOPIC_ARN= $(if $(NTE_EVENTSUBSCRIPTION_SNSTOPIC_ARN), --sns-topic-arn $(NTE_EVENTSUBSCRIPTION_SNSTOPIC_ARN))
__NTE_SOURCE_IDS= $(if $(NTE_EVENTSUBSCRIPTION_SOURCE_IDS), --source-ids $(NTE_EVENTSUBSCRIPTION_SOURCE_IDS))
__NTE_SOURCE_TYPE= $(if $(NTE_EVENTSUBSCRIPTION_SOURCE_TYPE), --source-type $(NTE_EVENTSUBSCRIPTION_SOURCE_TYPE))
__NTE_SUBSCRIPTION_NAME= $(if $(NTE_EVENTSUBSCRIPTION_NAME), --subscription-name $(NTE_EVENTSUBSCRIPTION_NAME))
__NTE_TAGS__EVENTSUBSCRIPTION= $(if $(NTE_EVENTSUBSCRIPTION_TAGS), --tags $(NTE_EVENTSUBSCRIPTION_TAGS))

# UI parameters
NTE_UI_VIEW_EVENTSUBSCRIPTION_FIELDS?=
NTE_UI_VIEW_EVENTSUBSCRIPTION_SET_FIELDS?= $(NTE_UI_VIEW_EVENTSUBSCRIPTION_FIELDS)

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_nte_view_framework_macros ::
	@#echo 'AWS::NepTunE::EventSubscription ($(_AWS_NEPTUNE_EVENTSUBSCRIPTION_MK_VERSION)) macros:'
	@#echo

_nte_view_framework_parameters ::
	@echo 'AWS::NepTunE::EventSubscription ($(_AWS_NEPTUNE_EVENTSUBSCRIPTION_MK_VERSION)) parameters:'
	@echo '    NTE_EVENTSUBSCRIPTION_ENABLE=$(NTE_EVENTSUBSCRIPTION_ENABLE)'
	@echo '    NTE_EVENTSUBSCRIPTION_NAME=$(NTE_EVENTSUBSCRIPTION_NAME)'
	@echo '    NTE_EVENTSUBSCRIPTION_SNSTOPIC_ARN=$(NTE_EVENTSUBSCRIPTION_SNSTOPIC_ARN)'
	@echo '    NTE_EVENTSUBSCRIPTION_SOURCE_TYPE=$(NTE_EVENTSUBSCRIPTION_SOURCE_TYPE)'
	@echo '    NTE_EVENTSUBSCRIPTION_TAGS=$(NTE_EVENTSUBSCRIPTION_TAGS)'
	@echo

_nte_view_framework_targets ::
	@echo 'AWS::NepTunE::EventSubscription ($(_AWS_NEPTUNE_EVENTSUBSCRIPTION_MK_VERSION)) targets:'
	@echo '    _nte_create_eventsubscription                      - Create an event-subscription'
	@echo '    _nte_delete_eventsubscription                      - Delete an event-subscription'
	@echo '    _nte_show_eventsubscription                        - Show everything related to an event-subscription'
	@echo '    _nte_show_eventsubscription_description            - Show description of an event-subscription'
	@echo '    _nte_view_eventsubscriptions                       - View event-subscriptions'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_nte_create_eventsubscription:
	@$(INFO) '$(AWS_UI_LABEL)Creating event-subscription "$(NTE_EVENTSUBSCRIPTION_NAME)" ...'; $(NORMAL)
	$(AWS) neptune create-event-subscription $(__NTE_ENABLED__EVENTSUBSCRIPTION) $(__NTE_EVENT_CATEGORIES) $(__NTE_SNS_TOPIC_ARN) $(__NTE_SOURCE_IDS) $(__NTE_SOURCE_TYPE) $(__NTE_SUBSCRIPTION_NAME) $(__NTE_TAGS__EVENTSUSBCRIPTION)

_nte_delete_eventsubscription:
	@$(INFO) '$(AWS_UI_LABEL)Deleting event-subscription "$(NTE_EVENTSUBSCRIPTION_NAME)" ...'; $(NORMAL)
	$(AWS) neptune delete-event-subscription $(__NTE_SUBSCRIPTION_NAME)

_nte_show_eventsubscription: _nte_show_eventsubscription_description

_nte_show_eventsubscription_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing event-subscription "$(NTE_EVENTSUBSCRIPTION_NAME)" ...'; $(NORMAL)
	$(AWS) neptune describe-event-subscriptions $(__NTE_SUBSCRIPTION_NAME) $(_X__NTE_FILTERS__EVENTSUBSCRIPTION)

_nte_view_eventsubscriptions:
	@$(INFO) '$(AWS_UI_LABEL)Viewing event-subscriptions ...'; $(NORMAL)
	$(AWS) neptune describe-event-subscriptions $(_X__NTE_SUBSCRIPTION_NAME) $(_X__NTE_FILTERS__EVENTSUBSCRIPTION)

_nte_view_eventsubscriptions_set:
