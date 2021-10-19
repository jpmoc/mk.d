_AWS_LOGS_SUBSCRIPTIONFILTER_MK_VERSION= $(_AWS_LOGS_MK_VERSION)

# LGS_SUBSCRIPTIONFILTER_DESTINATION_ARN?= arn:aws:lambda:us-west-2:123456789012:function:LogsToElasticsearch-staging
# LGS_SUBSCRIPTIONFILTER_DISTRIBUTION?=
# LGS_SUBSCRIPTIONFILTER_EVENT_FILEPATH?= ./subscriptfilter-event.json
# LGS_SUBSCRIPTIONFILTER_FILTER_PATTERN?=
# LGS_SUBSCRIPTIONFILTER_LOGGROUP_NAME?=
# LGS_SUBSCRIPTIONFILTER_NAME?=
# LGS_SUBSCRIPTIONFILTER_ROLE_ARN?=
# LGS_SUBSCRIPTIONFILTERS_NAME_PREFIX?=
# LGS_SUBSCRIPTIONFILTERS_LOGGROUP_NAME?=
# LGS_SUBSCRIPTIONFILTERS_SET_NAME?= my-subscriptions-set

# Derived parameters
LGS_SUBSCRIPTIONFILTER_LOGGROUP_NAME?= $(LGS_LOGGROUP_NAME)
LGS_SUBSCRIPTIONFILTERS_LOGGROUP_NAME?= $(LGS_SUBSCRIPTIONFILTER_LOGGROUP_NAME)
LGS_SUBSCRIPTIONFILTERS_SET_NAME?= $(LGS_SUBSCRIPTIONFILTER_LOGGROUP_NAME)

# Options parameters
__LGS_DESTINATION_ARN= $(if $(LGS_SUBSCRIPTIONFILTER_DESTINATION_ARN), --destination-arn $(LGS_SUBSCRIPTIONFILTER_DESTINATION_ARN))
__LGS_DISTRIBUTION= $(if $(LGS_SUBSCRIPTIONFILTER_DISTRIBUTION), --distribution $(LGS_SUBSCRIPTIONFILTER_DISTRIBUTION))
__LGS_FILTER_NAME= $(if $(LGS_SUBSCRIPTIONFILTER_NAME), --filter-name $(LGS_SUBSCRIPTIONFILTER_NAME))
__LGS_FILTER_NAME_PREFIX__SUBSCRIPTIONFILTER= $(if $(LGS_SUBSCRIPTIONFILTER_NAME), --filter-name-prefix $(LGS_SUBSCRIPTIONFILTER_NAME))
__LGS_FILTER_NAME_PREFIX__SUBSCRIPTIONFILTERS= $(if $(LGS_SUBSCRIPTIONFILTERS_NAME_PREFIX), --filter-name-prefix $(LGS_SUBSCRIPTIONFILTERS_NAME_PREFIX))
__LGS_FILTER_PATTERN= $(if $(LGS_SUBSCRIPTIONFILTER_FILTER_PATTERN), --filter-pattern $(LGS_SUBSCRIPTIONFILTER_FILTER_PATTERN))
__LGS_LOG_GROUP_NAME__SUBSCRIPTIONFILTER= $(if $(LGS_SUBSCRIPTIONFILTER_LOGGROUP_NAME), --log-group-name $(LGS_SUBSCRIPTIONFILTER_LOGGROUP_NAME))
__LGS_LOG_GROUP_NAME__SUBSCRIPTIONFILTERS= $(if $(LGS_SUBSCRIPTIONFILTERS_LOGGROUP_NAME), --log-group-name $(LGS_SUBSCRIPTIONFILTERS_LOGGROUP_NAME))
__LGS_ROLE_ARN= $(if $(LGS_SUBSCRIPTIONFILTER_ROLE_ARN), --role-arn $(LGS_SUBSCRIPTIONFILTER_ROLE_ARN))


# UI parameters
LGS_UI_VIEW_SUBSCRIPTIONFILTERS_FIELDS?=
LGS_UI_VIEW_SUBSCRIPTIONFILTERS_SET_FIELDS?= $(LGS_UI_VIEW_SUBSCRIPTIONFILTERS_FIELDS)

#--- Utilities

#--- MACRO

_lgs_get_subscriptionfilter_destination_arn= $(call _lgs_get_subscriptionfilter_destination_arn_N, $(LGS_SUBSCRIPTIONFILTER_NAME))
_lgs_get_subscriptionfilter_destination_arn_N= $(call _lgs_get_subscriptionfilter_destination_arn_NG, $(1), $(LGS_SUBSCRIPTIONFILTER_LOGGROUP_NAME))
_lgs_get_subscriptionfilter_destination_arn_NG= $(shell $(AWS) logs describe-subscription-filters --filter-name-prefix $(1) --log-group-name $(2) --query 'subscriptionFilters[].destinationArn' --output text)

#----------------------------------------------------------------------
# USAGE
#

_lgs_view_framework_macros ::
	@echo 'AWS::LoGS::SubscriptionFilter ($(_AWS_LOGS_SUBSCRIPTIONFILTER_MK_VERSION)) macros:'
	@echo '    _lgs_get_subscriptionfilter_destination_arn_{|N|NG}  - Get destination ARN of a subscription-filter (Name,Group)'
	@echo

_lgs_view_framework_parameters ::
	@echo 'AWS::LoGS::SubscriptionFilter ($(_AWS_LOGS_SUBSCRIPTIONFILTER_MK_VERSION)) parameters:'
	@echo '    LGS_SUBSCRIPTIONFILTER_DESTINATION_ARN=$(LGS_SUBSCRIPTIONFILTER_DESTINATION_ARN)'
	@echo '    LGS_SUBSCRIPTIONFILTER_DISTRIBUTION=$(LGS_SUBSCRIPTIONFILTER_DISTRIBUTION)'
	@echo '    LGS_SUBSCRIPTIONFILTER_EVENT_FILEPATH=$(LGS_SUBSCRIPTIONFILTER_EVENT_FILEPATH)'
	@echo '    LGS_SUBSCRIPTIONFILTER_FILTER_PATTERN=$(LGS_SUBSCRIPTIONFILTER_FILTER_PATTERN)'
	@echo '    LGS_SUBSCRIPTIONFILTER_LOGGROUP_NAME=$(LGS_SUBSCRIPTIONFILTER_LOGGROUP_NAME)'
	@echo '    LGS_SUBSCRIPTIONFILTER_NAME=$(LGS_SUBSCRIPTIONFILTER_NAME)'
	@echo '    LGS_SUBSCRIPTIONFILTER_ROLE_ARN=$(LGS_SUBSCRIPTIONFILTER_ROLE_ARN)'
	@echo '    LGS_SUBSCRIPTIONFILTERS_LOGGROUP_NAME=$(LGS_SUBSCRIPTIONFILTERS_LOGGROUP_NAME)'
	@echo '    LGS_SUBSCRIPTIONFILTERS_NAME_PREFIX=$(LGS_SUBSCRIPTIONFILTERS_NAME_PREFIX)'
	@echo '    LGS_SUBSCRIPTIONFILTERS_SET_NAME=$(LGS_SUBSCRIPTIONFILTERS_SET_NAME)'
	@echo

_lgs_view_framework_targets ::
	@echo 'AWS::LoGS::SubscriptionFilter ($(_AWS_LOGS_SUBSCRIPTIONFILTER_MK_VERSION)) targets:'
	@echo '    _lgs_create_subscriptionfilter                - Create a subscription-filter in a log-group'
	@echo '    _lgs_delete_subscriptionfilter                - Delete an existing subscription-filter in a log-group'
	@echo '    _lgs_show_subscriptionfilter                  - Show everything relatead to a subscription-filter in a log-group'
	@echo '    _lgs_show_subscriptionfilter_description      - Show description of a subscription-filter in a log-group'
	@echo '    _lgs_show_subscriptionfilter_event            - Show a smaple events of a subscription-filter in a log-group'
	@echo '    _lgs_view_subscriptionfilters                 - View subscription-filters'
	@echo '    _lgs_view_subscriptionfilters_set             - View a set of subscription-filters'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_lgs_create_subscriptionfilter:
	@$(INFO) '$(AWS_UI_LABEL)Creating subscription-filter "$(LGS_SUBSCRIPTIONFILTER_NAME)" for log-group "$(LGS_SUBSCRIPTIONFILTER_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) logs put-subscription-filter $(strip $(__LGS_DESTINATION_ARN) $(__LGS_DISTRIBUTION) $(__LGS_FILTER_NAME) $(__LGS_FILTER_PATTERN) $(__LGS_LOG_GROUP_NAME__SUBSCRIPTIONFILTER) $(__LGS_LOG_STREAM_NAME) $(__LGS_ROLE_ARN) )

_lgs_delete_subscriptionfilter:
	@$(INFO) '$(AWS_UI_LABEL)Deleting subscription-filter "$(LGS_SUBSCRIPTIONFILTER_NAME)" in log-group "$(LGS_SUBSCRIPTIONFILTER_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) logs delete-subscription-filter $(__LGS_FILTER_NAME) $(__LGS_LOG_GROUP_NAME__SUBSCRIPTIONFILTER)

_lgs_show_subscriptionfilter:: _lgs_show_subscriptionfilter_event _lgs_show_subscriptionfilter_description

_lgs_show_subscriptionfilter_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of subscription-filter "$(LGS_SUBSCRIPTIONFILTER_NAME)" of log-group "$(LGS_SUBSCRIPTIONFILTER_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) logs describe-subscription-filters $(__LGS_FILTER_NAME_PREFIX__SUBSCRIPTIONFILTER) $(__LGS_LOG_GROUP_NAME__SUBSCRIPTIONFILTER) --query 'subscriptionFilters'
	@$(WARN) 'If the filter pattern is empty, all events are sent to the destination resource'; $(NORMAL)

_lgs_show_subscriptionfilter_event:
	@$(INFO) '$(AWS_UI_LABEL)Showing sample-event sent by subscription-filter "$(LGS_SUBSCRIPTIONFILTER_NAME)" of log-group "$(LGS_SUBSCRIPTIONFILTER_LOGGROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns a sample event that would be sent to the descrination of the subscription'; $(NORMAL)
	@$(if $(LGS_SUBSCRIPTIONFILTER_EVENT_FILEPATH), cat $(LGS_SUBSCRIPTIONFILTER_EVENT_FILEPATH))
	@$(if $(LGS_SUBSCRIPTIONFILTER_EVENT_FILEPATH), jq -r '.awslogs.data' $(LGS_SUBSCRIPTIONFILTER_EVENT_FILEPATH) | base64 --decode | gunzip | jq '.')

_lgs_view_subscriptionfilters:
	@$(INFO) '$(AWS_UI_LABEL)View subscription-filters ...'; $(NORMAL)
	$(AWS) logs describe-subscription-filters $(_X__LGS_FILTER_NAME_PREFIX__SUBSCRIPTIONFILTERS) $(__LGS_LOG_GROUP_NAME__SUBSCRIPTIONFILTERS) --query 'subscriptionFilters[]$(LGS_UI_VIEW_SUBSCRIPTIONFILTERS_FIELDS)'

_lgs_view_subscriptionfilters_set:
	@$(INFO) '$(AWS_UI_LABEL)View subscription-filters-set "$(LGS_SUBSCRIPTIONFILTERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Subscription-filters are grouped by log-group, prefix, ...'; $(NORMAL)
	$(AWS) logs describe-subscription-filters $(__LGS_FILTER_NAME_PREFIX__SUBSCRIPTIONFILTERS) $(__LGS_LOG_GROUP_NAME__SUBSCRIPTIONFILTERS) --query 'subscriptionFilters[]$(LGS_UI_VIEW_SUBSCRIPTIONFILTERS_SET_FIELDS)'
