_AWS_SMS_REPLICATIONJOB_MK_VERSION = $(_AWS_SMS_MK_VERSION)

# SMS_REPLICATIONJOB_DESCRIPTION?=
# SMS_REPLICATIONJOB_FREQUENCY?=
# SMS_REPLICATIONJOB_ID?=
# SMS_REPLICATIONJOB_LICENSE_TYPE?=
# SMS_REPLICATIONJOB_NAME?=
# SMS_REPLICATIONJOB_ROLE_NAME?=
# SMS_REPLICATIONJOB_SEEDREPLICATIONTIME?=
# SMS_REPLICATIONJOB_SERVER_ID?=

# Derived parameters

# Option parameters
__SMS_DESCRIPTION__REPLICATIONJOB= $(if $(SMS_REPLICATIONJOB_DESCRIPTION), --description $(SMS_REPLICATIONJOB_DESCRIPTION))
__SMS_FREQUENCY= $(if $(SMS_REPLICATIONJOB_FREQUENCY), --frequency $(SMS_REPLICATIONJOB_REQUENCY))
__SMS_LICENSE_TYPE= $(if $(SMS_REPLICATIONJOB_LICENSE_TYPE), --license-type $(SMS_REPLICATIONJOB_LICENSE_TYPE))
__SMS_REPLICATION_JOB_ID= $(if $(SMS_REPLICATIONJOB_ID), --replcaition-job-id $(SMS_REPLICATIONJOB_ID))
__SMS_ROLE_NAME= $(if $(SMS_REPLICATIONJOB_ROLE_NAME), --role-name $(SMS_REPLICATIONJOB_ROLE_NAME))
__SMS_SEED_REPLICATION_TIME= $(if $(SMS_REPLICATIONJOB_SEEDREPLICATIONTIME), --seed-replication-time $(SMS_REPLICATIONJOB_SEEDREPLICATIONTIME))
__SMS_SERVER_ID__REPLICATIONJOB= $(if $(SMS_REPLICATIONJOB_SERVER_ID), --server-id $(SMS_REPLICATIONJOB_SERVER_ID))

# UI parameters

#--- MACRO
_sms_get_replicationjob_id=

#----------------------------------------------------------------------
# USAGE
#

_sms_view_makefile_macros ::
	@echo 'AWS::SMS::ReplicationJob ($(_AWS_SMS_REPLICATIONJOB_MK_VERSION)) macros:'
	@echo '    _sms_get_replicationjob_id               - Get the ID of a replication-job'
	@echo

_sms_view_makefile_parameters ::
	@echo 'AWS::SMS::ReplicationJob ($(_AWS_SMS_REPLICATIONJOB_MK_VERSION)) parameters:'
	@echo '    SMS_REPLICATIONJOB_DESCRIPTION=$(SMS_REPLICATIONJOB_DESCRIPTION)'
	@echo '    SMS_REPLICATIONJOB_FREQUENCY=$(SMS_REPLICATIONJOB_FREQUENCY)'
	@echo '    SMS_REPLICATIONJOB_ID=$(SMS_REPLICATIONJOB_ID)'
	@echo '    SMS_REPLICATIONJOB_LICENSE_TYPE=$(SMS_REPLICATIONJOB_LICENSE_TYPE)'
	@echo '    SMS_REPLICATIONJOB_NAME=$(SMS_REPLICATIONJOB_NAME)'
	@echo '    SMS_REPLICATIONJOB_ROLE_NAME=$(SMS_REPLICATIONJOB_ROLE_NAME)'
	@echo '    SMS_REPLICATIONJOB_SEEDREPLICATIONTIME=$(SMS_REPLICATIONJOB_SEEDREPLICATIONTIME)'
	@echo '    SMS_REPLICATIONJOB_SERVER_ID=$(SMS_REPLICATIONJOB_SERVER_ID)'
	@echo

_sms_view_makefile_targets ::
	@echo 'AWS::SMS::ReplicationJob ($(_AWS_SMS_REPLICATIONJOB_MK_VERSION)) targets:'
	@echo '    _sms_create_replicationjob              - Create a replication-job'
	@echo '    _sms_delete_replicationjob              - Delete a replication-job'
	@echo '    _sms_show_replicationjob                - Show everything related to a replication-job'
	@echo '    _sms_update_replicationjob              - Update a replication-job'
	@echo '    _sms_view_replicationjobs               - View existing replication-jobs'
	@echo '    _sms_view_replicationjobs_set           - View a set of replication-jobs'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_sms_create_replicationjob:
	@$(INFO) '$(AWS_UI_LABEL)Creating replication-job "$(SMS_REPLICATIONJOB_NAME)" ...'; $(NORMAL)
	$(AWS) sms create-replication-job $(__SMS_DESCRIPTION__REPLICATIONJOB) $(__SMS_FREQUENCY) $(__SMS_LICENSE_TYPE) $(__SMS_ROLE_NAME) $(__SMS_SEED_REPLICATION_TIME) $(__SMS_SERVER_ID__REPLICATIONJOB)

_sms_delete_replicationjob:
	@$(INFO) '$(AWS_UI_LABEL)Deleting replication-job "$(SMS_REPLICATIONJOB_NAME)" ...'; $(NORMAL)
	$(AWS) sms delete-replication-job $(__SMS_REPLICATIONJOB_ID)

_sms_show_replicationjob:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of replication-job "$(SMS_REPLICATIONJOB_NAME)" ...'; $(NORMAL)
	$(AWS) sms get-replication-jobs $(__SMS_REPLICATIONJOB_ID)

_sms_update_replicationjob:
	@$(INFO) '$(AWS_UI_LABEL)Updating replication-job "$(SMS_REPLICATIONJOB_NAME)" ...'; $(NORMAL)
	$(AWS) sms update-replication-job $(__SMS_DESCRIPTION__REPLICATIONJOB) $(__SMS_FREQUENCY) $(__SMS_LICENSE_TYPE) $(__SMS_REPLICATIONJOB_ID) $(__SMS_ROLE_NAME)

_sms_view_replicationjobs:
	@$(INFO) '$(AWS_UI_LABEL)Viewing ALL replication-job ...'; $(NORMAL)
	$(AWS) sms list-replication-jobs

_sms_view_replicationjobs_set:

