_AWS_GLUE_JOB_MK_VERSION=$(_AWS_GLUE_MK_VERSION)

GLE_JOB_ALLOCATED_CAPACITY?= 10
# GLE_JOB_COMMAND?= Name=glueetl,ScriptLocation=s3://aws-glue-scripts-123456789012-us-west-2/emayssat/my-job
# GLE_JOB_CONNECTIONS?= Connections=string,string
# GLE_JOB_DEFAULT_ARGUMENTS?= KeyName1=string,KeyName2=string
# GLE_JOB_DESCRIPTION?= "my job description"
# GLE_JOB_EXECUTION_PROPERTY?= MaxConcurrentRuns=1
# GLE_JOB_LOG_URI?=
# GLE_JOB_NAME?= my-job
# GLE_JOB_ROLE_ARN?= arn:aws:iam::123456789012:role/service-role/AWSGlueServiceRole-Mongo
# GLE_JOB_S3SCRIPT_URI?= s3://aws-glue-scripts-123456789012-us-east-1/me/my-job
GLE_JOB_SCRIPT_DIR?= $(realpath ./etl-scripts)
# GLE_JOB_SCRIPT_FILENAME?= my-job.py
# GLE_JOB_SCRIPT_FILEPATH?= /tmp/my-job.py
GLE_JOB_SCRIPT_LANGUAGE?= python
GLE_JOB_TIMEOUT?= 2880
# GLE_JOBRUN_ARGUMENTS?=
# GLE_JOBRUN_ID?= jr_7a38bfacfdaba2e9b34009eb63f4fdc4b94ded4be37f56440609988b64a5bd4f
GLE_JOBRUN_INDEX?= 0
# GLE_PREDECESSORS_INCLUDED?= false
# GLE_JOBRUN_TIMEOUT?= 2880

# Derived variables
GLE_JOB_COMMAND?= $(if $(GLE_JOB_S3SCRIPT_URI), Name=glueetl,ScriptLocation=$(GLE_JOB_S3SCRIPT_URI))
GLE_JOB_CONNECTIONS?= $(GLE_CONNECTION_NAME)
GLE_JOB_NAMES?= $(GLE_JOB_NAME)
GLE_JOB_SCRIPT_FILENAME?= $(if $(filter scala, $(GLE_JOB_SCRIPT_LANGUAGE)),$(GLE_JOB_NAME).scala,$(GLE_JOB_NAME).py)
GLE_JOB_SCRIPT_FILEPATH?= $(if $(GLE_JOB_SCRIPT_DIR),$(GLE_JOB_SCRIPT_DIR)/$(GLE_JOB_SCRIPT_FILENAME))
GLE_JOBRUN_ALLOCATED_CAPACITY?= $(GLE_JOB_ALLOCATED_CAPACITY)
GLE_JOBRUN_ARGUMENTS?= $(GLE_JOB_DEFAULT_ARGUMENTS)
GLE_JOBRUN_TIMEOUT?= $(GLE_JOB_TIMEOUT)

# Options variables
__GLE_ALLOCATED_CAPACITY_JOB= $(if $(GLE_JOB_ALLOCATED_CAPACITY), --allocated-capacity $(GLE_JOB_ALLOCATED_CAPACITY))
__GLE_ALLOCATED_CAPACITY_JOBRUN= $(if $(GLE_JOBRUN_ALLOCATED_CAPACITY), --allocated-capacity $(GLE_JOBRUN_ALLOCATED_CAPACITY))
__GLE_ARGUMENTS= $(if $(GLE_JOBRUN_ARGUMENTS), --arguments=$(GLE_JOBRUN_ARGUMENTS))
__GLE_COMMAND= $(if $(GLE_JOB_COMMAND), --command $(GLE_JOB_COMMAND))
__GLE_CONNECTIONS= $(if $(GLE_JOB_CONNECTIONS), --connections $(GLE_JOB_CONNECTIONS))
__GLE_DEFAULT_ARGUMENTS= $(if $(GLE_JOB_DEFAULT_ARGUMENTS), --default-arguments=$(GLE_JOB_DEFAULT_ARGUMENTS))
__GLE_DESCRIPTION_JOB= $(if $(GLE_JOB_DESCRIPTION), --description $(GLE_JOB_DESCRIPTION))
__GLE_EXECUTION_PROPERTY= $(if $(GLE_JOB_EXECUTION_PROPERTY), --execution-property $(GLE_JOB_EXECUTION_PROPERTY))
__GLE_JOB_NAME= $(if $(GLE_JOB_NAME), --job-name $(GLE_JOB_NAME))
__GLE_JOB_RUN_ID= $(if $(GLE_JOBRUN_ID), --job-run-id $(GLE_JOBRUN_ID))
__GLE_LOG_URI= $(if $(GLE_JOB_LOG_URI), --log-uri $(GLE_LOG_URI))
__GLE_NAME_JOB= $(if $(GLE_JOB_NAME), --name $(GLE_JOB_NAME))
__GLE_PREDECESSORS_INCLUDED= $(if $(filter true, $(GLE_JOBRUN_PREDECESOORS_INCLUDED)), --predecessors-included, --no-predecessors-included)
__GLE_ROLE_JOB= $(if $(GLE_JOB_ROLE_ARN), --role $(GLE_JOB_ROLE_ARN))
__GLE_RUN_ID= $(if $(GLE_JOBRUN_ID), --run-id $(GLE_JOBRUN_ID))
__GLE_TIMEOUT_JOB= $(if $(GLE_JOB_TIMEOUT), --timeout $(GLE_JOB_TIMEOUT))
__GLE_TIMEOUT_JOBRUN= $(if $(GLE_JOBRUN_TIMEOUT), --timeout $(GLE_JOBRUN_TIMEOUT))

# UI variables
GLE_UI_SHOW_JOB_FIELDS?=
GLE_UI_SHOW_JOB_RUNS_FIELDS?= .{Id:Id,_JobName:JobName,_JobRunState:JobRunState,_StartedOn:StartedOn,_CompletedOn:CompletedOn,_Attempt:Attempt}
GLE_UI_VIEW_JOBS_FIELDS?= .{Name:Name,_AllocatedCapacity:AllocatedCapacity,_CreatedOn:CreatedOn,_Description:Description}

#--- Utilities

#--- MACROS
_gle_get_jobrun_id= $(call _gle_get_jobrun_id_N, $(GLE_JOB_NAME))
_gle_get_jobrun_id_N= $(call _gle_get_jobrun_id_NI, $(1), $(GLE_JOBRUN_INDEX))
_gle_get_jobrun_id_NI= $(shell $(AWS) glue get-job-runs --job-name $(1) --query "JobRuns[$(2)].Id" --output text)

_gle_get_job_s3script_uri=$(call _gle_get_job_s3script_uri_N, $(GLE_JOB_NAME))
_gle_get_job_s3script_uri_N= $(shell $(AWS) glue get-job --job-name $(1) --query "Job.Command.ScriptLocation" --output text)

#----------------------------------------------------------------------
# USAGE
#

_gle_view_makefile_macros ::
	@echo 'AWS::GLuE::Job ($(_AWS_GLUE_JOB_MK_VERSION)) macros:'
	@echo '    _gle_get_job_run_id_{|N}        - Get a run ID for a given job (Name)'
	@echo '    _gle_get_job_s3script_uri_{|N}  - Get the script URI on S3 of a given job (Name)'
	@echo

_gle_view_makefile_targets ::
	@echo 'AWS::GLuE::Job ($(_AWS_GLUE_JOB_MK_VERSION)) targets:'
	@echo '    _gle_create_job                 - Create an ETL job'
	@echo '    _gle_delete_job                 - Delete an ETL job'
	@echo '    _gle_retry_job                  - Retry run of an ETL job'
	@echo '    _gle_show_job                   - Show details of an ETL job'
	@echo '    _gle_show_job_run               - Show details on a run of an ETL job'
	@echo '    _gle_show_job_runs              - Show runs of an ETL job'
	@echo '    _gle_show_job_script            - Show script to be executed by an ETL job'
	@echo '    _gle_start_job                  - Starting an ETL job'
	@echo '    _gle_update_job                 - Update an existing ETL job'
	@echo '    _gle_view_jobs                  - View ETL jobs'
	@echo 

_gle_view_makefile_variables ::
	@echo 'AWS::GLuE::Job ($(_AWS_GLUE_JOB_MK_VERSION)) variables:'
	@echo '    GLE_JOB_ALLOCATED_CAPACITY=$(GLE_JOB_ALLOCATED_CAPACITY) [Between 2 and 100 DPUs]'
	@echo '    GLE_JOB_COMMAND=$(GLE_JOB_COMMAND)'
	@echo '    GLE_JOB_CONNECTIONS=$(GLE_JOB_CONNECTIONS)'
	@echo '    GLE_JOB_DEFAULT_ARGUMENTS=$(GLE_JOB_DEFAULT_ARGUMENTS)'
	@echo '    GLE_JOB_DESCRIPTION=$(GLE_JOB_DESCRIPTION)'
	@echo '    GLE_JOB_EXECUTION_PROPERTY=$(GLE_JOB_EXECUTION_PROPERTY)'
	@echo '    GLE_JOB_LOG_URI=$(GLE_JOB_LOG_URI)'
	@echo '    GLE_JOB_NAME=$(GLE_JOB_NAME)'
	@echo '    GLE_JOB_NAMES=$(GLE_JOB_NAMES)'
	@echo '    GLE_JOB_ROLE_ARN=$(GLE_JOB_ROLE_ARN)'
	@echo '    GLE_JOB_S3SCRIPT_URI=$(GLE_JOB_S3SCRIPT_URI)'
	@echo '    GLE_JOB_SCRIPT_DIR=$(GLE_JOB_SCRIPT_DIR)'
	@echo '    GLE_JOB_SCRIPT_FILENAME=$(GLE_JOB_SCRIPT_FILENAME)'
	@echo '    GLE_JOB_SCRIPT_FILEPATH=$(GLE_JOB_SCRIPT_FILEPATH)'
	@echo '    GLE_JOB_SCRIPT_LANGUAGE=$(GLE_JOB_SCRIPT_LANGUAGE)'
	@echo '    GLE_JOB_TIMEOUT=$(GLE_JOB_TIMEOUT) [Minutes]'
	@echo '    GLE_JOBRUN_ALLOCATED_CAPACITY=$(GLE_JOBRUN_ALLOCATED_CAPACITY) [Between 2 and 100 DPUs]'
	@echo '    GLE_JOBRUN_ARGUMENTS=$(GLE_JOBRUN_ARGUMENTS)'
	@echo '    GLE_JOBRUN_ID=$(GLE_JOBRUN_ID)'
	@echo '    GLE_JOBRUN_INDEX=$(GLE_JOBRUN_INDEX)'
	@echo '    GLE_JOBRUN_PREDECESSORS_INCLUDED=$(GLE_JOBRUN_PREDECESSORS_INCLUDED)'
	@echo '    GLE_JOBRUN_TIMEOUT=$(GLE_JOBRUN_TIMEOUT)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#


_gle_create_job:
	@$(INFO) '$(AWS_LABEL)Creating ETL job "$(GLE_JOB_NAME)" ...'; $(NORMAL)
	$(AWS) glue create-job $(__GLE_ALLOCATED_CAPACITY_JOB) $(__GLE_COMMAND) $(__GLE_CONNECTIONS) $(__GLE_DEFAULT_ARGUMENTS) $(__GLE_DESCRIPTION_JOB) $(__GLE_EXECUTION_PROPERTY) $(__GLE_LOG_URI) $(__GLE_NAME_JOB) $(__GLE_ROLE_JOB) $(__GLE_TIMEOUT_JOB)

_gle_delete_job:
	@$(INFO) '$(AWS_LABEL)Deleting ETL job "$(GLE_JOB_NAME)" ...'; $(NORMAL)
	$(AWS) glue delete-job $(__GLE_JOB_NAME)

_gle_retry_job:
	@$(INFO) '$(AWS_LABEL)Retrying run "$(GLE_JOBRUN_ID)" for ETL job "$(GLE_JOB_NAME)" ...'; $(NORMAL)
	@$(WARN) 'At any given time, a job can only be running once!'; $(NORMAL)
	$(AWS) glue start-job-run $(__GLE_ALLOCATED_CAPACITY_JOBRUN) $(__GLE_ARGUMENTS) $(__GLE_JOB_NAME) $(__GLE_JOB_RUN_ID) $(__GLE_TIMEOUT_JOBRUN)

_gle_show_job:
	@$(INFO) '$(AWS_LABEL)Showing details of ETL job "$(GLE_JOB_NAME)" ...'; $(NORMAL)
	$(AWS) glue get-job $(__GLE_JOB_NAME) --query "Job$(GLE_UI_SHOW_JOB_FIELDS)"

_gle_show_job_run:
	@$(INFO) '$(AWS_LABEL)Showing run "last-$(GLE_JOBRUN_INDEX)" of ETL job "$(GLE_JOB_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Job Run ID: $(GLE_JOBRUN_ID)'; $(NORMAL)
	$(AWS) glue get-job-run $(__GLE_JOB_NAME) $(__GLE_PREDECESSORS_INCLUDED) $(__GLE_RUN_ID)

_gle_show_job_runs:
	@$(INFO) '$(AWS_LABEL)Showing runs of ETL job "$(GLE_JOB_NAME)" ...'; $(NORMAL)
	$(AWS) glue get-job-runs $(__GLE_JOB_NAME) --query "JobRuns[]$(GLE_UI_SHOW_JOB_RUNS_FIELDS)"

_gle_show_job_script:
	@$(INFO) '$(AWS_LABEL)Showing ETL script of job "$(GLE_JOB_NAME)" from S3 ...'; $(NORMAL)
	@$(WARN) 'Fetching the current version from S3'; $(NORMAL)
	$(AWS) s3 cp $(GLE_JOB_S3SCRIPT_URI) $(GLE_JOB_SCRIPT_FILEPATH)
	[ -f $(GLE_JOB_SCRIPT_FILEPATH) ] && cat $(GLE_JOB_SCRIPT_FILEPATH)

_gle_start_job:
	@$(INFO) '$(AWS_LABEL)Starting ETL job "$(GLE_JOB_NAME)" ...'; $(NORMAL)
	@$(WARN) 'At any given time, a job can only be running once!'; $(NORMAL)
	$(AWS) glue start-job-run $(__GLE_ALLOCATED_CAPACITY_JOBRUN) $(__GLE_ARGUMENTS) $(__GLE_JOB_NAME) $(_X__GLE_JOB_RUN_ID) $(__GLE_TIMEOUT_JOBRUN)

_gle_update_job:

_gle_view_jobs:
	@$(INFO) '$(AWS_LABEL)Viewing ETL jobs ...'; $(NORMAL)
	$(AWS) glue get-jobs --query "Jobs[]$(GLE_UI_VIEW_JOBS_FIELDS)"
