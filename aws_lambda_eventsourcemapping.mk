_AWS_LAMBDA_EVENTSOURCEMAPPING_MK_VERSION= $(_AWS_LAMBDA_MK_VERSION)

# LBA_EVENTSOURCEMAPPING_ARN?=
# LBA_EVENTSOURCEMAPPING_BATCH_SIZE?= 100
LBA_EVENTSOURCEMAPPING_ENABLED?= true
# LBA_EVENTSOURCEMAPPING_FUNCTION_NAME?=
# LBA_EVENTSOURCEMAPPING_NAME?= EventSourceMappings
# LBA_EVENTSOURCEMAPPING_STARTING_POSITION?= AT_TIMESTAMP
# LBA_EVENTSOURCEMAPPING_STARTING_TIMESTAMP?=
# LBA_EVENTSOURCEMAPPING_UUID?= 138ec296-2ea0-4ca9-aa2a-b7fb4a8ce7ff
# LBA_EVENTSOURCEMAPPINGS_SET_NAME?= my-event-source-mapping-set

# Derived parameters
LBA_EVENTSOURCEMAPPING_FUNCTION_NAME?= $(LBA_FUNCTION_NAME)

# Option parameters
__LBA_BATCH_SIZE= $(if $(LBA_EVENTSOURCEMAPPING_BATCH_SIZE),--batch-size $(LBA_EVENTSOURCEMAPPING_BATCH_SIZE))
__LBA_ENABLED__EVENTSOURCEMAPPING= $(if $(filter false, $(LBA_EVENTSOURCEMAPPING_ENABLE)), --no-enable, --enable)
__LBA_EVENT_SOURCE_ARN= $(if $(LBA_EVENTSOURCEMAPPING_ARN), --event-source-arn $(LBA_EVENTSOURCEMAPPING_ARN))
__LBA_FUNCTION_NAME__EVENTSOURCEMAPPING= $(if $(LBA_EVENTSOURCEMAPPING_FUNCTION_NAME), --function-name $(LBA_EVENTSOURCEMAPPING_FUNCTION_NAME))
__LBA_STARTING_POSITION= $(if $(LBA_EVENTSOURCEMAPPING_STARTING_POSITION),--starting-position $(LBA_EVENTSOURCEMAPPING_STARTING_POSITION))
__LBA_STARTING_POSITION_TIMESTAMP= $(if $(LBA_EVENTSOURCEMAPPING_STARTING_TIMESTAMP),--starting-position-timestamp $(LBA_EVENTSOURCEMAPPING_STARTING_TIMESTAMP))

# UI parameters
LBA_UI_SHOW_EVENTSOURCEMAPPING_FIELDS?=
LBA_UI_VIEW_EVENTSOURCEMAPPINGS_FIELDS?=
LBA_UI_VIEW_EVENTSOURCEMAPPINGS_SET_FIELDS?= $(LBA_UI_VIEW_EVENTSOURCEMAPPINGS_FIELDS)
LBA_UI_VIEW_EVENTSOURCEMAPPINGS_SET_QUERY_FILTER?=

#--- Utilities

#--- Macros

_lba_get_eventsourcemapping_uuid=

#----------------------------------------------------------------------
# USAGE
#

_lba_view_framework_macros ::
	@echo 'AWS::LamBdA::EventSourceMapping ($(_AWS_LAMBDA_EVENTSOURCEMAPPING_MK_VERSION)) macros:'
	@echo

_lba_view_framework_parameters ::
	@echo 'AWS::LamBdA::EventSourceMapping ($(_AWS_LAMBDA_EVENTSOURCEMAPPING_MK_VERSION)) parameters:'
	@echo '    LBA_EVENTSOURCEMAPPING_ARN=$(LBA_EVENTSOURCEMAPPING_ARN)'
	@echo '    LBA_EVENTSOURCEMAPPING_BATCH_SIZE=$(LBA_EVENTSOURCEMAPPING_BATCH_SIZE)'
	@echo '    LBA_EVENTSOURCEMAPPING_ENABLE=$(LBA_EVENTSOURCEMAPPING_ENABLE)'
	@echo '    LBA_EVENTSOURCEMAPPING_FUNCTION_NAME=$(LBA_EVENTSOURCEMAPPING_FUNCTION_NAME)'
	@echo '    LBA_EVENTSOURCEMAPPING_NAME=$(LBA_EVENTSOURCEMAPPING_NAME)'
	@echo '    LBA_EVENTSOURCEMAPPING_STARTING_POSITION=$(LBA_EVENTSOURCEMAPPING_STARTING_POSITION)'
	@echo '    LBA_EVENTSOURCEMAPPING_STARTING_TIMESTAMP=$(LBA_EVENTSOURCEMAPPING_STARTING_TIMESTAMP)'
	@echo '    LBA_EVENTSOURCEMAPPING_UUID=$(LBA_EVENTSOURCEMAPPING_UUID)'
	@echo '    LBA_EVENTSOURCEMAPPINGS_SET_NAME=$(LBA_EVENTSOURCEMAPPINGS_SET_NAME)'
	@echo

_lba_view_framework_targets ::
	@echo 'AWS::LamBdA::EventSourceMapping ($(_AWS_LAMBDA_EVENTSOURCEMAPPING_MK_VERSION)) targets:'
	@echo '    _lba_create_eventsourcemapping                  - Create a new event-source-mapping'
	@echo '    _lba_delete_eventsourcemapping                  - Delete an existing event-source-mapping'
	@echo '    _lba_show_eventsourcemapping                    - Show everything related to an event-source-mapping'
	@echo '    _lba_show_eventsourcemapping_description        - Show description of an event-source-mapping'
	@echo '    _lba_update_eventsourcemapping_configuration    - Update configuration of an event-source-mapping'
	@echo '    _lba_view_eventsourcemappings                   - View existing event-source-mappings'
	@echo '    _lba_view_eventsourcemappings_set               - View a set of event-source-mappings' 
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_lba_create_eventsourcemapping:
	@$(INFO) '$(AWS_UI_LABEL)Creating a new event-source-mapping "$(LBA_EVENTSOURCEMAPPING_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Possible event-sources: Kinesis, DynamoDb stream, SQS'; $(NORMAL)
	$(AWS) lambda create-event-source-mapping $(strip $(__LBA_BATCH_SIZE) $(__LBA_ENABLED__EVENTSOURCEMAPPING) $(__LBA_EVENT_SOURCE_ARN) $(__LBA_FUNCTION_NAME__EVENTSOURCEMAPPING) $(__LBA_STARTING_POSITION) $(__LBA_STARTING_POSITION_TIMESTAMP) )

_lba_delete_eventsourcemapping:
	@$(INFO) '$(AWS_UI_LABEL)Deleting an existing event-source-mapping "$(LBA_EVENTSOURCEMAPPING_NAME)" ...'; $(NORMAL)
	$(AWS) lambda event-source-mapping $(__LBA_EVENTSOURCEMAPPINGCTION_NAME)

_lba_show_eventsourcemapping: _lba_show_eventsourcemapping_description

_lba_show_eventsourcemapping_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing event-source-mapping "$(LBA_EVENTSOURCEMAPPING_NAME)" ...'; $(NORMAL)
	$(AWS) lambda get-function-configuration  $(__LBA_EVENTSOURCEMAPPING_NAME) $(__LBA_QUALIFIER)

_lba_update_eventsourcemapping_configuration:
	@$(INFO) '$(AWS_UI_LABEL)Updating configuration of an event-source-mapping "$(LBA_EVENTSOURCEMAPPING_NAME)" ...'; $(NORMAL)
	$(AWS) lambda update-event-source-mapping $(__LBA_BATCH_SIZE) $(__LBA_ENABLED__EVENTSOURCEMAPPING) $(__LBA_FUNCTION_NAME__EVENTSOURCEMAPPING) $(__LBA_UUID)

_lba_view_eventsourcemappings:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all event-source-mappings ...'; $(NORMAL)
	$(AWS) lambda list-event-source-mappings --query 'EventSourceMappings[]$(LBA_UI_VIEW_EVENTSOURCEMAPPINGS_FIELDS)'

_lba_view_eventsourcemappings_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing event-source-mappings-set "$(LBA_EVENTSOURCEMAPPINGS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Event-source-mappings  are grouped based on query filter, ...'; $(NORMAL)
	$(AWS) lambda list-event-source-mappings --query 'EventSourceMappings[$(LBA_UI_VIEW_EVENTSOURCEMAPPINGS_SET_QUERY_FILTER)]$(LBA_UI_VIEW_EVENTSOURCEMAPPINGS_SET_FIELDS)'
