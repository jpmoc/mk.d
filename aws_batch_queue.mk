_AWS_BATCH_QUEUE_MK_VERSION=$(_AWS_BATCH_MK_VERSION)

# BCH_QUEUE_ENVIRONMENT_ORDER?= order=10,computeEnvironment=m4spot ...
# BCH_QUEUE_ENVIRONMENT_ORDER_FIELAPTH?= ./my-queue-environment-order.json
# BCH_QUEUE_NAME?= my-job-queue
# BCH_QUEUE_PRIORITY?= 10
# BCH_QUEUE_STATE?= ENABLED

# Derived variables
BCH_QUEUE_ENVIRONMENT_ORDER?= $(if $(BCH_QUEUE_ENVIRONMENT_ORDER_FILEPATH), file://$(BCH_QUEUE_ENVIRONMENT_ORDER_FILEPATH))

# Options variables
__BCH_COMPUTE_ENVIRONMENT_ORDER= $(if $(BCH_QUEUE_ENVIRONMENT_ORDER), --compute-environment-order $(BCH_QUEUE_ENVIRONMENT_ORDER))
__BCH_JOB_QUEUE= $(if $(BCH_QUEUE_NAME), --job-queue $(BCH_QUEUE))
__BCH_JOB_QUEUE_NAME= $(if $(BCH_QUEUE_NAME), --job-queue-name $(BCH_QUEUE_NAME))
__BCH_PRIORITY= $(if $(BCH_QUEUE_PRIORITY), --priority $(BCH_QUEUE_PRIORITY))
__BCH_STATE_QUEUE= $(if $(BCH_QUEUE_STATE), --state $(BCH_QUEUE_STATE))

# UI variables

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_bch_view_makefile_macros ::  
	@echo "AWS::BatCH::Queue ($(_AWS_BATCH_QUEUE_MK_VERSION)) macros:"
	@echo "    _bch_get_environment_status_{|N}    - Get the status of an environment (Name)"
	@echo

_bch_view_makefile_targets ::
	@echo "AWS::BatCH::Queue ($(_AWS_BATCH_QUEUE_MK_VERSION)) targets:"
	@echo "    _bch_create_queue                   - Create a job queue"
	@echo "    _bch_delete_queue                   - Delete an existing job queue"
	@echo "    _bch_disable_queue                  - Disable an existing queue"
	@echo "    _bch_enable_queue                   - Enable an existing queue"
	@echo "    _bch_view_queues                    - View available job queues"
	@echo

_bch_view_makefile_variables ::
	@echo "AWS::BatCH::Queue ($(_AWS_BATCH_QUEUE_MK_VERSION)) variables:"
	@echo "    BCH_QUEUE_ENVIRONMENT_ORDER=$(BCH_QUEUE_ENVIRONMENT_ORDER)"
	@echo "    BCH_QUEUE_NAME=$(BCH_QUEUE_NAME)"
	@echo "    BCH_QUEUE_PRIORITY=$(BCH_QUEUE_PRIORITY)"
	@echo "    BCH_QUEUE_STATE=$(BCH_QUEUE_STATE)"
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_bch_create_queue:
	@$(INFO) "$(AWS_LABEL)Creating a new job queues '$(BCH_QUEUE_NAME)' ..."; $(NORMAL)
	@$(WARN) "All compute environments need first to report a VALID status!"; $(NORMAL)
	$(AWS) batch create-job-queue $(__BCH_COMPUTE_ENVIRONMENT_ORDER) $(__BCH_JOB_QUEUE_NAME) $(__BCH_PRIORITY) $(__BCH_STATE_QUEUE)

_bch_delete_queue:
	@$(INFO) "$(AWS_LABEL)Deleting job queues '$(BCH_QUEUE_NAME)' ..."; $(NORMAL)
	$(AWS) batch delete-job-queue $(__BCH_JOB_QUEUE)

_bch_view_queues:
	@$(INFO) "$(AWS_LABEL)Viewing available job queues ..."; $(NORMAL)
	$(AWS) batch describe-job-queues $(__BCH_JOB_QUEUES)
