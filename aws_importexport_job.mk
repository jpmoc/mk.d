_AWS_IMPORTEXPORT_JOB_MK_VERSION= $(_AWS_IMPORTEXPORT_MK_VERSION)

# IET_JOB_API_VERSION?=
# IET_JOB_ID?=
# IET_JOB_IDS?=
# IET_JOB_MANIFEST?=
# IET_JOB_MANIFEST_ADDENDUM?=
# IET_JOB_NAME?=
# IET_JOB_STATUS?=
# IET_JOB_TYPE?=
IET_JOB_VALIDATE_ONLY?= false
# IET_JOBS_SET_NAME?=

# Derived parameters
IET_JOB_IDS?= $(IET_JOB_ID)

# Option parameters
__IET_API_VERSION= $(if $(IET_JOB_API_VERSION), --api-version $(IET_JOB_API_VERSION))
__IET_JOB_TYPE= $(if $(IET_JOB_TYPE), --job-type $(IET_JOB_TYPE))
__IET_MANIFEST= $(if $(IET_JOB_MANIFEST), --manifest $(IET_JOB_MANIFEST))
__IET_MANIFEST_ADDENDUM= $(if $(IET_JOB_MANIFEST_ADDENDUM), --manifest-addendum $(IET_JOB_MANIFEST_ADDENDUM))
__IET_VALIDATE_ONLY= $(if $(filter true, $(IET_JOB_VALIDATE_ONLY)), --validate-only, --no-validate-only)

# UI parameters
IET_UI_VIEW_JOBS_FIELDS?=
IET_UI_VIEW_JOBS_SET_FIELDS?= $(IET_UI_VIEW_JOBS_FIELDS)
IET_UI_VIEW_JOBS_SET_SLICE?=

#--- Utilities

#--- MACROS

_iet_get_job_id=

_iet_get_job_status= $(_iet_get_job_status_I, $(IET_JOB_ID))
_iet_get_job_status_I= $(shell $(AWS) importexport get-status $(__IET_API_VERSION) --job-id $(1) --output text)

#----------------------------------------------------------------------
# USAGE
#

_iet_view_framework_macros ::
	@echo 'AWS::ImportExporT::Job ($(_AWS_IMPORTEXPORT_JOB_MK_VERSION)) macros:'
	@echo '    _iet_get_job_id                             -'
	@echo '    _iet_get_job_status_{|I}                    -'
	@echo

_iet_view_framework_parameters ::
	@echo 'AWS::ImportExporT::Job ($(_AWS_IMPORTEXPORT_JOB_MK_VERSION)) parameters:'
	@echo '    IET_JOB_API_VERSION=$(IET_JOB_API_VERSION)'
	@echo '    IET_JOB_ID=$(IET_JOB_ID)'
	@echo '    IET_JOB_IDS=$(IET_JOB_IDS)'
	@echo '    IET_JOB_MANIFEST=$(IET_JOB_MANIFEST)'
	@echo '    IET_JOB_MANIFEST_ADDENDUM=$(IET_JOB_MANIFEST_ADDENDUM)'
	@echo '    IET_JOB_NAME=$(IET_JOB_NAME)'
	@echo '    IET_JOB_STATUS=$(IET_JOB_STATUS)'
	@echo '    IET_JOB_TYPE=$(IET_JOB_TYPE)'
	@echo '    IET_JOB_VALIDATE_ONLY=$(IET_JOB_VALIDATE_ONLY)'
	@echo '    IET_JOBS_SET_NAME=$(IET_JOBS_SET_NAME)'
	@echo

_iet_view_framework_targets ::
	@echo 'AWS::ImportExporT::Job ($(_AWS_IMPORTEXPORT_JOB_MK_VERSION)) targets:'A
	@echo '    _iet_create_job                           - Create a new job'
	@echo '    _iet_delete_job                           - Delete an existing job'
	@echo '    _iet_show_job                             - Show everything related to a job'
	@echo '    _iet_update_job                           - Update a job'
	@echo '    _iet_view_jobs                            - View jobs'
	@echo '    _iet_view_jobs_set                        - View a set of jobs'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_iet_create_job:
	@$(INFO) '$(AWS_UI_LABEL)Creating job "$(IET_JOB_NAME)" ...'; $(NORMAL)
	$(AWS) importexport create-job $(__IET_API_VERSION) $(__IET_JOB_TYPE) $(__IET_MANIFEST) $(__IET_MANIFEST_ADDENDUM) $(__IET_VALIDATE_ONLY)

_iet_delete_job:
	@$(INFO) '$(AWS_UI_LABEL)Deleting job "$(IET_JOB_NAME)" ...'; $(NORMAL)
	$(AWS) importexport cancel-job $(__IET_API_VERSION) $(__IET_JOB_ID)

_iet_show_job:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of job "$(IET_JOB_NAME)" ...'; $(NORMAL)
	$(AWS) importexport list-jobs $(__IET_API_VERSION) --query "Jobs[?Id=='$(IET_JOB_ID)']"

_iet_update_job:
	@$(INFO) '$(AWS_UI_LABEL)Updating job "$(IET_JOB_NAME)" ...'; $(NORMAL)
	$(AWS) importexport update-job $(__IET_API_VERSION) $(__IET_JOB_ID) $(__IET_JOB_TYPE) $(__IET_MANIFEST) $(__IET_VALIDATE_ONLY)

_iet_view_jobs:
	@$(INFO) '$(AWS_UI_LABEL)Viewing jobs ...'; $(NORMAL)
	$(AWS) importexport list-jobs $(__IET_API_VERSION) # --query "StreamDescriptionSummary"

_iet_view_jobs_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing jobs-set "$(IET_JOBS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Jobs are grouped based on the provided slice'; $(NORMAL)
	$(AWS) importexport list-jobs $(__IET_API_VERSION) # --query "StreamDescriptionSummary"
