_AWS_BUDGETS_MK_VERSION=0.99.6

BGT_ACCOUNT_ID?=$(AWS_ACCOUNT_ID)
# BGT_BUDGET?= BudgetName=string,BudgetLimit={Amount=string,Unit=string},CostFilters={KeyName1=string,string,KeyName2=string,string},CostTypes={IncludeTax=boolean,IncludeSubscription=boolean,UseBlended=boolean,IncludeRefund=boolean,IncludeCredit=boolean,IncludeUpfront=boolean,IncludeRecurring=boolean,IncludeOtherSubscription=boolean,IncludeSupport=boolean,IncludeDiscount=boolean,UseAmortized=boolean},TimeUnit=string,TimePeriod={Start=timestamp,End=timestamp},CalculatedSpend={ActualSpend={Amount=string,Unit=string},ForecastedSpend={Amount=string,Unit=string}},BudgetType=string
# BGT_BUDGET_NAME?= MyBudget
# BGT_NOTIFICATIONS_WITH_SUBSCRIBERS?= Notification={NotificationType=string,ComparisonOperator=string,Threshold=double,ThresholdType=string},Subscribers=[{SubscriptionType=string,Address=string},{SubscriptionType=string,Address=string}]
# BGT_SUBSCRIBER?=

# Derived variables
BGT_SUBSCRIBERS?=$(BGT_SUBSCRIBER)

__BGT_ACCOUNT_ID= $(if $(BGT_ACCOUNT_ID), --account-id $(BGT_ACCOUNT_ID))
__BGT_BUDGET= $(if $(BGT_BUDGET), --budget $(BGT_BUDGET))
__BGT_BUDGET_NAME= $(if $(BGT_BUDGET_NAME), --budget-name $(BGT_BUDGET_NAME))
__BGT_NOTIFICATION= $(if $(BGT_NOTIFICATION), --notification $(BGT_NOTIFICATION))
__BGT_NOTIFICATIONS_WITH_SUBSCRIBERS= $(if $(BGT_NOTIFICATIONS_WITH_SUBSCRIBERS), --notifications-with-subscribers $(BGT_NOTIFICATIONS_WITH_SUBSCRIBERS))
__BGT_SUBSCRIBER= $(if $(BGT_SUBSCRIBER), --subscriber $(BGT_SUBSCRIBER))
__BGT_SUBSCRIBERS= $(if $(BGT_SUBSCRIBERS), --subscribers $(BGT_SUBSCRIBERS))

BGT_VIEW_BUDGETS_FIELDS?= .{BudgetName:BudgetName,BudgetType:BudgetType,Limit:BudgetLimit.Amount,Unit:BudgetLimit.Unit,_ActualSpend:CalculatedSpend.ActualSpend.Amount,_ForcastedSpend:CalculatedSpend.ForecastedSpend.Amount}

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _bgt_view_makefile_macros
_bgt_view_makefile_macros:
	@echo "AWS::BudGeTs ($(_AWS_BUDGETS_MK_VERSION)) macros:"
	@echo

_aws_view_makefile_targets :: _bgt_view_makefile_targets
_bgt_view_makefile_targets:
	@echo "AWS::BudGeTs ($(_AWS_BUDGETS_MK_VERSION)) targets:"
	@echo "    _bgt_create_budget                     - Create a new budget"
	@echo "    _bgt_create_notification               - Create a new notification"
	@echo "    _bgt_create_subscriber                 - Create a new subscriber"
	@echo "    _bgt_delete_budget                     - Delete an existing budget"
	@echo "    _bgt_delete_notification               - Delete an existing notification"
	@echo "    _bgt_delete_subscriber                 - Delete an existing subscriber"
	@echo "    _bgt_show_budget                       - Show details on an existing budget"
	@echo "    _bgt_update_budget                     - Update a budget"
	@echo "    _bgt_update_notification               - Update a notification for a budget"
	@echo "    _bgt_update_subscriber                 - Update a subscribers to a notification"
	@echo "    _bgt_view_budgets                      - View existing budgets"
	@echo "    _bgt_view_notifications                - View notifications on a budget"
	@echo "    _bgt_view_subscribers                  - View subscribers to a notification"
	@echo 

_aws_view_makefile_variables :: _bgt_view_makefile_variables
_bgt_view_makefile_variables:
	@echo "AWS::BudGeTs ($(_AWS_BUDGETS_MK_VERSION)) variables:"
	@echo "    BGT_ACCOUNT_ID=$(BGT_ACCOUNT_ID)"
	@echo "    BGT_BUDGET=$(BGT_BUDGET)"
	@echo "    BGT_BUDGET_NAME=$(BGT_BUDGET_NAME)"
	@echo "    BGT_NOTIFICATION=$(BGT_NOTIFICATION)"
	@echo "    BGT_NOTIFICATIONS_WITH_SUBSCRIBERS=$(BGT_NOTIFICATIONS_WITH_SUBSCRIBERS)"
	@echo "    BGT_SUBSCRIBER=$(BGT_SUBSCRIBER)"
	@echo "    BGT_SUBSCRIBERS=$(BGT_SUBSCRIBERS)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_bgt_create_budget:
	@$(INFO) "$(AWS_LABEL)Creating a budget for account '$(BGT_ACCOUNT_ID)' ..."; $(NORMAL)
	$(AWS) budgets create-budget $(__BGT_ACCOUNT_ID) $(__BGT_BUDGET) $(__BGT_NOTIFICATIONS_WITH_SUBSCRIBERS)

_bgt_create_notification:
	@$(INFO) "$(AWS_LABEL)Creating a notification for budget '$(BGT_BUDGET_NAME)' ..."; $(NORMAL)
	$(AWS) budgets create-notification $(__BGT_ACCOUNT_ID) $(__BGT_BUDGET_NAME) $(__BGT_NOTIFICATION) $(__BGT_SUBSCRIBERS)

_bgt_create_subscriber:
	@$(INFO) "$(AWS_LABEL)Creating a subscriber for budget '$(BGT_BUDGET_NAME)' ..."; $(NORMAL)
	$(AWS) budgets create-subscriber $(__BGT_ACCOUNT_ID) $(__BGT_BUDGET_NAME) $(__BGT_NOTIFICATION) $(__BGT_SUBSCRIBER)

_bgt_delete_budget:
	@$(INFO) "$(AWS_LABEL)Deleting budget '$(BGT_BUDGET_NAME)' in account '$(BGT_ACCOUNT_ID)' ..."; $(NORMAL)
	$(AWS) budgets delete-budget $(__BGT_ACCOUNT_ID) $(__BGT_BUDGET_NAME)

_bgt_delete_notification:
	@$(INFO) "$(AWS_LABEL)Deleting notification '$(BGT_NOTIFICATION)' for budget '$(BGT_BUDGET_NAME)' ..."; $(NORMAL)
	$(AWS) budgets delete-notification $(__BGT_ACCOUNT_ID) $(__BGT_BUDGET_NAME) $(__BGT_NOTIFICATION)

_bgt_delete_subscriber:
	@$(INFO) "$(AWS_LABEL)Deleting subscriber '$(BGT_SUBSCRIBER)' from notification '$(BGT_NOTICIATION)' in budget '$(BGT_BUDGET_NAME)' ..."; $(NORMAL)
	$(AWS) budgets delete-subscriber $(__BGT_ACCOUNT_ID) $(__BGT_BUDGET_NAME) $(__BGT_NOTIFICATION) $(__BGT_SUBSCRIBER)

_bgt_show_budget:
	@$(INFO) "$(AWS_LABEL)Show budget '$(BGT_BUDGET_NAME)' on account '$(BGT_ACCOUNT_ID)' ..."; $(NORMAL)
	@$(WARN) "This operation doesn't work on linked accounts!"; $(NORMAL)
	$(AWS) budgets describe-budget $(__BGT_ACCOUNT_ID) $(__BGT_BUDGET_NAME)

_bgt_update_budget:

_bgt_update_notification:

_bgt_update_subscriber:

_bgt_view_budgets:
	@$(INFO) "$(AWS_LABEL)View budgets on account '$(BGT_ACCOUNT_ID)' ..."; $(NORMAL)
	@$(WARN) "This operation doesn't work on linked accounts!"; $(NORMAL)
	$(AWS) budgets describe-budgets $(__BGT_ACCOUNT_ID) --query "Budgets[]$(BGT_VIEW_BUDGETS_FIELDS)"

_bgt_view_notifications:
	@$(INFO) "$(AWS_LABEL)View notifications on budget '$(BGT_BUDGET_NAME)' on account '$(BGT_ACCOUNT_ID)' ..."; $(NORMAL)
	@$(WARN) "This operation doesn't work on linked accounts!"; $(NORMAL)
	$(AWS) budgets describe-notifications-for-budget $(__BGT_ACCOUNT_ID) $(__BGT_BUDGET_NAME)

_bgt_view_subscribers:
	@$(INFO) "$(AWS_LABEL)View subscribers for notification '$(BGT_NOTIFICATION)'  on budget '$(BGT_BUDGET_NAME)' on account '$(BGT_ACCOUNT_ID)' ..."; $(NORMAL)
	@$(WARN) "This operation doesn't work on linked accounts!"; $(NORMAL)
	$(AWS) budgets describe-subscribers-for-notification $(__BGT_ACCOUNT_ID) $(__BGT_BUDGET_NAME) $(__BGT_NOTIFICATION)
