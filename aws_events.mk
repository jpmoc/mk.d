_AWS_EVENTS_MK_VERSION=0.99.6

EVT_BUS_NAME?= default
# EVT_EVENT_FILEPATH?= ./event.json
# EVT_EVENT?="{\"id\":\"1\",\"source\":\"com.mycompany.myapp\",\"detail-type\":\"myDetailType\",\"account\":\"123456789012\",\"region\":\"us-east-1\",\"time\":\"2017-04-11T20:11:04Z\"}"
# EVT_EVENT_PATTERN_FILEPATH?= ./event_pattern.json
# EVT_EVENT_PATTERN?= "{\"source\":[\"com.mycompany.myapp\"]}"
# EVT_EVENTS_FILEPATH?= ./emit_event.json
# EVT_GRANT_ACTION?=
# EVT_GRANT_PERMISSION?=
# EVT_GRANT_PRINCIPAL?= 1234567890
# EVT_GRANT_STATEMENT_ID?=
# EVT_RULE_DESCRIPTION?= THis is a sample description
# EVT_RULE_NAME?= DailyLambdaFunction
# EVT_RULE_ROLE_ARN?=
# EVT_RULE_STATE?= DISABLED
# EVT_RULE_TARGETS_FILEPATH?= ./targets.json
# EVT_RULE_TARGET_IDS?= Target_1 Target_2
# EVT_SCHEDULE_EXPRESSION?= cron(0 9 * * ? *)
# EVT_TARGET_ARN?= arn:aws:lambda:us-east-1:123456789012:function:MyFunctionName

# Derived variables
EVT_BUS_ARN?= $(if $(EVT_BUS_NAME), arn:aws:events:$(AWS_REGION):$(AWS_ACCOUNT_ID):event-bus/$(EVT_BUS_NAME))
EVT_EVENT?= $(if $(EVT_EVENT_FILEPATH), file://$(EVT_EVENT_FILEPATH))
EVT_EVENT_PATTERN?= $(if $(EVT_EVENT_PATTERN_FILEPATH), file://$(EVT_EVENT_PATTERN_FILEPATH))
EVT_EVENTS?= $(if $(EVT_EVENTS_FILEPATH), file://$(EVT_EVENTS_FILEPATH))
# EVT_TARGETS?= "Id"="Target_1","Arn"="$(EVT_TARGET_ARN)","RoleArn"="$(EVT_RULE_ROLE_ARN)"
EVT_RULE_TARGETS?= $(if $(EVT_RULE_TARGETS_FILEPATH), file://$(EVT_RULE_TARGETS_FILEPATH))

__EVT_ACTION?= $(if $(EVT_GRANT_ACTION), --action $(EVT_GRANT_ACTION))
__EVT_DESCRIPTION?= $(if $(EVT_RULE_DESCRIPTION), --description "$(EVT_RULE_DESCRIPTION)")
__EVT_ENTRIES?= $(if $(EVT_EVENTS), --entries $(EVT_EVENTS))
__EVT_EVENT?= $(if $(EVT_EVENT), --event $(EVT_EVENT))
__EVT_EVENT_PATTERN?= $(if $(EVT_EVENT_PATTERN), --event-pattern $(EVT_EVENT_PATTERN))
__EVT_IDS?= $(if $(EVT_IDS), $(foreach I, $(EVT_IDS), $(I))
__EVT_NAME?= $(if $(EVT_RULE_NAME), --name $(EVT_RULE_NAME))
__EVT_PERMISSION?= $(if $(EVT_GRANT_PERMISSION), --permission $(EVT_GRANT_PERMISSION))
__EVT_PRINCIPAL?= $(if $(EVT_GRANT_PRINCIPAL), --principal $(EVT_GRANT_PRINCIPAL))
__EVT_ROLE_ARN?= $(if $(EVT_RULE_cwROLE_ARNNAME), --cwrole-arn $(EVT_RULE_ROLE_ARN))
__EVT_RULE?= $(if $(EVT_RULE_NAME), --rule $(EVT_RULE_NAME))
__EVT_STATE?= $(if $(EVT_RULE_STATE), --state $(EVT_RULE_STATE))
__EVT_STATEMENT_ID?= $(if $(EVT_GRANT_STATEMENT_ID), --statement-id $(EVT_GRANT_STATEMENT_ID))
__EVT_SCHEDULE_EXPRESSION?= $(if $(EVT_SCHEDULE_EXPRESSION), --schedule-expression "$(EVT_SCHEDULE_EXPRESSION)")
__EVT_TARGET_ARN?= $(if $(EVT_TARGET_ARN), --target-arn $(EVT_TARGET_ARN))
__EVT_TARGETS?= $(if $(EVT_RULE_TARGETS), --targets $(EVT_RULE_TARGETS))

EVT_VIEW_RULES_FIELDS?= .[Name,State,Description]

#--- MACROS
_evt_get_bus_name= $(shell $(AWS)  events describe-event-bus --query "Name" --output text)
_evt_get_bus_arn= $(shell $(AWS)  events describe-event-bus --query "Arn" --output text)

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _evt_view_makefile_macros
_evt_view_makefile_macros:
	@echo "AWS::EVenTs ($(_AWS_EVENTS_MK_VERSION)) macros:"
	@echo "    _evt_get_bus_name             - Get the name of the event bus"
	@echo "    _evt_get_bus_arn              - Get the ARN of the event bus"
	@echo

_aws_view_makefile_targets :: _evt_view_makefile_targets
_evt_view_makefile_targets:
	@echo "AWS::EVenTs ($(_AWS_EVENTS_MK_VERSION)) targets:"
	@echo "    _evt_connect_targets                - Connect targets to a rule"
	@echo "    _evt_create_rule                    - Create a new rule"
	@echo "    _evt_delete_rule                    - Delete an existing rule"
	@echo "    _evt_disable_rule                   - Disable a rule"
	@echo "    _evt_disconnect_target              - Disconnect a target from a rule"
	@echo "    _evt_emit_events                    - Emit events on the event bus"
	@echo "    _evt_enable_rule                    - Enable a rule"
	@echo "    _evt_grant_permission               - Allow another account to post events on bus"
	@echo "    _evt_revoke_permission              - Revoke the permission of another account to post events on bus"
	@echo "    _evt_show_bus                       - Show details of the account event bus"
	@echo "    _evt_show_rule                      - Show details of an existing rule"
	@echo "    _evt_test_event_pattern             - Test whether an event match an event pattern"
	@echo "    _evt_view_rule_targets              - View targets of an existing rule"
	@echo "    _evt_view_target_rules              - View rules of an existing resource"
	@echo "    _evt_view_rules                     - View all existing rules"
	@echo 

_aws_view_makefile_variables :: _evt_view_makefile_variables
_evt_view_makefile_variables:
	@echo "AWS::EVenTs ($(_AWS_EVENTS_MK_VERSION)) variables:"
	@echo "    EVT_ACTION=$(EVT_ACTION)"
	@echo "    EVT_BUS_NAME=$(EVT_BUS_NAME)"
	@echo "    EVT_BUS_ARN=$(EVT_BUS_ARN)"
	@echo "    EVT_EVENT=$(EVT_EVENT)"
	@echo "    EVT_EVENT_FILEPATH=$(EVT_EVENT_FILEPATH)"
	@echo "    EVT_EVENT_PATTERN=$(EVT_EVENT_PATTERN)"
	@echo "    EVT_EVENT_PATTERN_FILEPATH=$(EVT_EVENT_PATTERN_FILEPATH)"
	@echo "    EVT_EVENTS=$(EVT_EVENTS)"
	@echo "    EVT_EVENTS_FILEPATH=$(EVT_EVENTS_FILEPATH)"
	@echo "    EVT_PERMISSION=$(EVT_PERMISSION)"
	@echo "    EVT_PRINCIPAL=$(EVT_PRINCIPAL)"
	@echo "    EVT_RULE_DESCRIPTION=$(EVT_RULE_DESCRIPTION)"
	@echo "    EVT_RULE_NAME=$(EVT_RULE_NAME)"
	@echo "    EVT_RULE_ROLE_ARN=$(EVT_RULE_ROLE_ARN)"
	@echo "    EVT_RULE_STATE=$(EVT_RULE_STATE)"
	@echo "    EVT_RULE_TARGETS=$(EVT_RULE_TARGETS)"
	@echo "    EVT_SCHEDULE_EXPRESSION=$(EVT_SCHEDULE_EXPRESSION)"
	@echo "    EVT_STATEMENT_ID=$(EVT_STATEMENT_ID)"
	@echo "    EVT_TARGET_ARN=$(EVT_TARGET_ARN)"
	@echo "    EVT_TARGETS=$(EVT_TARGETS)"
	@echo "    EVT_TARGETS_FILEPATH=$(EVT_TARGETS_FILEPATH)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_evt_connect_targets:
	@$(INFO) "$(AWS_LABEL)Updating targets for rule '$(EVT_RULE_NAME)' ..."; $(NORMAL)
	$(AWS) events put-targets $(__EVT_RULE) $(__EVT_TARGETS)

_evt_create_rule:
	@$(INFO) "$(AWS_LABEL)Creating rule '$(EVT_RULE_NAME)' ..."; $(NORMAL)
	$(AWS) events put-rule $(__EVT_DESCRIPTION) $(__EVT_EVENT_PATTERN) $(__EVT_NAME) $(__EVT_ROLE_ARN) $(__EVT_SCHEDULE_EXPRESSION) $(__EVT_STATE)

_evt_delete_rule:
	@$(INFO) "$(AWS_LABEL)Deleting rule '$(EVT_RULE_NAME)' ..."; $(NORMAL)
	$(AWS) events delete-rule $(__EVT_NAME)

_evt_disable_rule:
	@$(INFO) "$(AWS_LABEL)Disabling rule '$(EVT_RULE_NAME)' ..."; $(NORMAL)
	$(AWS) events disable-rule $(__EVT_NAME)

_evt_disconnect_targets:
	@$(INFO) "$(AWS_LABEL)Disconnecting targets from the rule '$(EVT_RULE_NAME)' ..."; $(NORMAL)
	$(AWS) events remove-targets $(__EVT_IDS) $(__EVT_RULE)

_evt_emit_events:
	@$(INFO) "$(AWS_LABEL)Emitting events on event bus ..."; $(NORMAL)
	$(AWS) events put-events $(__EVT_ENTRIES)

_evt_enable_rule:
	@$(INFO) "$(AWS_LABEL)Enabling rule '$(EVT_RULE_NAME)' ..."; $(NORMAL)
	$(AWS) events enable-rule $(__EVT_NAME)

_evt_grant_permission:
	@$(INFO) "$(AWS_LABEL)Granting AWS account '$(EVT_PRINCIPAL)' the rights to post events ..."; $(NORMAL)
	$(AWS) events put-permission $(__EVT_ACTION) $(__EVT_PRINCIPAL) $(__EVT_STATEMENT_ID)

_evt_revoke_permission:
	@$(INFO) "$(AWS_LABEL)Forfeiting AWS account '$(EVT_PRINCIPAL)' permission to post events ..."; $(NORMAL)
	$(AWS) events remove-permission $(__EVT_STATEMENT_ID)

_evt_show_bus:
	@$(INFO) "$(AWS_LABEL)Show event bus for AWS account '$(AWS_ACCOUND_ID)' ..."; $(NORMAL)
	@$(WARN) "Account Identifiers: $(strip $(AWS_ACCOUNT_NAME) $(AWS_ACCOUNT_ID) $(AWS_PROFILE))"; $(NORMAL)
	$(AWS) events describe-event-bus

_evt_show_rule:
	@$(INFO) "$(AWS_LABEL)Show rule '$(EVT_RULE_NAME)' ..."; $(NORMAL)
	$(AWS) events describe-rule $(__EVT_NAME)

_evt_test_event_pattern:
	@$(INFO) "$(AWS_LABEL)Checking whether event matches event pattern ..."; $(NORMAL)
	@$(WARN) "Only one event can be tested at a time!"; $(NORMAL)
	$(AWS) events test-event-pattern $(__EVT_EVENT) $(__EVT_EVENT_PATTERN)

_evt_update_targets: _evt_connect_targets

_evt_view_rule_targets:
	@$(INFO) "$(AWS_LABEL)View resources targeted by a given rule ..."; $(NORMAL)
	$(AWS) events list-targets-by-rule $(__EVT_RULE)

_evt_view_target_rules:
	@$(INFO) "$(AWS_LABEL)View rules targeting a given resource ..."; $(NORMAL)
	$(AWS) events list-rule-names-by-target $(__EVT_TARGET_ARN)

_evt_view_rules:
	@$(INFO) "$(AWS_LABEL)View event rules ..."; $(NORMAL)
	$(AWS) events list-rules $(__EVT_NAME_PREFIX) --query "Rules[]$(EVT_VIEW_RULES_FIELDS)"
