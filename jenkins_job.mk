_JENKINS_JOB_MK_VERSION= $(_JENKINS_MK_VERSION)

# JKS_JOB_BUILD_NUMBER?= lastBuild
# JKS_JOB_CONFIGGRV_DIRPATH?= ./grv/
# JKS_JOB_CONFIGGRV_FILENAME?= job.grv
# JKS_JOB_CONFIGGRV_FILEPATH?= grv/job-name.grv
# JKS_JOB_CONFIGXML_DIRPATH?= ./xml/
# JKS_JOB_CONFIGXML_FILENAME?= job-name.xml
# JKS_JOB_CONFIGXML_FILEPATH?= ./xml/job-name.xml
JKS_JOB_LOGROTATOR?= -1 10
# JKS_JOB_NAME?= my-job
# JKS_JOB_URL?= https://jenkins.example.com/job/job-name
# JKS_JOB_NAMES?= my-job ...
# JKS_XML_XPATH?= ?xpath=concat(//crumbRequestField,':',//crumb)'

# Derived
JKS_JOB_CONFIGGRV_DIRPATH?= $(JKS_INPUTS_DIRPATH)
JKS_JOB_CONFIGGRV_FILENAME?= $(JKS_JOB_NAME).grv
JKS_JOB_CONFIGGRV_FILEPATH?= $(JKS_JOB_CONFIGGRV_DIRPATH)$(JKS_JOB_CONFIGGRV_FILENAME)
JKS_JOB_CONFIGXML_DIRPATH?= $(JKS_INPUTS_DIRPATH)
JKS_JOB_CONFIGXML_FILENAME?= $(JKS_JOB_NAME).xml
JKS_JOB_CONFIGXML_FILEPATH?= $(JKS_JOB_CONFIGXML_DIRPATH)$(JKS_JOB_CONFIGXML_FILENAME)
JKS_JOB_URL?= $(JENKINS_SERVER_URL)/job/$(JKS_JOB_NAME)

# Option parameters
#
# Pipe parameters
|_JKS_SHOW_JOB?= | jq -r '.description, .displayName, .nextBuildNumber, .url '

# UI parameters

# Macros
_jks_get_job_nextbuild_number= $(shell $(JKSCURL) -X POST $(JENKINS_JOB_URL)/api/json | jq -r '.nextBuildNumber' 2>/dev/null)

#----------------------------------------------------------------------
# Usage
#

_jks_view_framwork_macros ::
	@echo 'Jenkins::Job ($(_JENKINS_JOB_MK_VERSION)) macros:'
	@echo '    _jks_get_job_nextbuild_number       - Get the next build number'
	@echo

_jks_view_framework_parameters ::
	@echo 'Jenkins::Job ($(_JENKINS_JOB_MK_VERSION)) parameters:'
	@echo '    JKS_JOB_BUILD_NUMBER=$(JKS_JOB_BUILT_NUMBER)'
	@echo '    JKS_JOB_CONFIGGRV_DIRPATH=$(JKS_JOB_CONFIGGRV_DIRPATH)'
	@echo '    JKS_JOB_CONFIGGRV_FILENAME=$(JKS_JOB_CONFIGGRV_FILENAME)'
	@echo '    JKS_JOB_CONFIGGRV_FILEPATH=$(JKS_JOB_CONFIGGRV_FILEPATH)'
	@echo '    JKS_JOB_CONFIGXML_DIRPATH=$(JKS_JOB_CONFIGXML_DIRPATH)'
	@echo '    JKS_JOB_CONFIGXML_FILENAME=$(JKS_JOB_CONFIGXML_FILENAME)'
	@echo '    JKS_JOB_CONFIGXML_FILEPATH=$(JKS_JOB_CONFIGXML_FILEPATH)'
	@echo '    JKS_JOB_NAME=$(JKS_JOB_NAME)'
	@echo '    JKS_JOB_URL=$(JKS_JOB_URL)'
	@echo '    JKS_JOB_LOGROTATOR=$(JKS_JOB_LOGROTATOR)'
	@echo '    JKS_JOBS_REGEX=$(JKS_JOBS_REGEX)'
	@echo

_jks_view_framework_targets ::
	@echo 'Jenkins::Job ($(_JENKINS_JOB_MK_VERSION)) targets:'
	@echo '     _jks_create_job                   - Create a job'
	@echo '     _jks_delete_job                   - Delete an existing job'
	@echo '     _jks_download_job                 - Download the XML-config of a job'
	@echo '     _jks_edit_job                     - Edit the XML-config of a job'
	@echo '     _jks_rename_job                   - Rename an existing job'
	@echo '     _jks_show_job                     - Show everything related to a job'
	@echo '     _jks_show_job_configxml           - Show the XML-config of a job'
	@echo '     _jks_show_job_builds              - Show the builds of a job'
	@echo '     _jks_show_job_description         - Show the builds description of a job'
	@echo '     _jks_show_job_parameters          - Show parameters of a job'
	@echo '     _jks_upload_job                   - Upload XML-config of a job'
	@echo '     _jks_view_jobs                    - View all jobs'
	@echo '     _jks_view_jobs_set                - View a set of jobs'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

_jks_create_job:
	@$(INFO) '$(JKS_UI_LABEL)Creating job "$(JKS_JOB_NAME)" ...'; $(NORMAL)
	cat $(JKS_JOB_CONFIGXML_FILEPATH); echo
	$(JKSCURL) --data-binary @$(JKS_JOB_CONFIGXML_FILEPATH) -H 'Content-Type: application/xml' -X POST '$(JKS_JOB_URL)/config.xml'
	# $(JENKINS) update-job $(JKS_JOB_NAME)

_jks_delete_job:
	@$(INFO) '$(JKS_UI_LABEL)Deleting the job '$(JENKINS_JOB_NAME)' ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the user does NOT have the Job/Delete permission'; $(NORMAL)
	# $(JKSCURL) -X POST '$(JKS_JOB_URL)/doDelete'
	# $(JENKINS) delete-job $(JKS_JOB_NAME)
	
_jks_download_job:
	@$(INFO) '$(JKS_UI_LABEL)Download XML-configuration of job '$(JENKINS_JOB_NAME)' ...'; $(NORMAL)
	@$(WARN) 'This operation overwrites the destination file'; $(NORMAL)
	$(JENKINS) get-job $(JKS_JOB_NAME) | tee $(JKS_JOB_CONFIGXML_FILEPATH)

_jks_rename_job:
	@$(INFO) '$(JKS_UI_LABEL)Renaming job "$(JKS_JOB_NAME)" ...'; $(NORMAL)
	# Possible from the UI... but from the CLI? Update?

_jks_show_job :: _jks_show_job_configxml _jks_show_job_builds _jks_show_job_parameters _jks_show_job_description

_jks_show_job_configxml:
	@$(INFO) '$(JKS_UI_LABEL)Showing XML-configuration of job "$(JKS_JOB_NAME)" ...'; $(NORMAL)
	# $(JKSCURL) '$(JKS_JOB_URL)/config.xml'; echo
	$(JENKINS) get-job $(JKS_JOB_NAME)

_jks_show_job_builds:
	@$(INFO) '$(JKS_UI_LABEL)Showing build-history of job '$(JENKINS_JOB_NAME)' ...'; $(NORMAL)
	$(JKSCURL) -X POST '$(JKS_JOB_URL)/api/json' | jq -r '.builds[] | "\(.number) \t \(.url)"' | head -$(word 2,$(JKS_JOB_LOGROTATOR))

_jks_show_job_description:
	@$(INFO) '$(JKS_UI_LABEL)Showing description of job "$(JKS_JOB_NAME)" ...'; $(NORMAL)
	$(JKSCURL) -X POST '$(JKS_JOB_URL)/api/json' | jq -r '.' $(|_JKS_SHOW_JOB)

_jks_show_job_parameters:
	@$(INFO) '$(JKS_UI_LABEL)Showing parameters of job "$(JKS_JOB_NAME)" ...'; $(NORMAL)
	@#$(WARN) 'This operation fails if ...'; $(NORMAL)
	-@#$(JKSCURL) -X POST '$(JKS_JOB_URL)/api/json' | jq '.actions[] | if (. | length) > 0 then .parameterDefinitions[] else empty end | {name:.name , description:.description, default_value:.defaultParameterValue.value}'
	$(JKSCURL) -X POST '$(JKS_JOB_URL)/api/json' | jq -r '.property[] | select(._class == "hudson.model.ParametersDefinitionProperty").parameterDefinitions[]'

_jks_update_job:
	@$(INFO) '$(JKS_UI_LABEL)Updating job "$(JKS_JOB_NAME)" ...'; $(NORMAL)
	cat $(JKS_JOB_CONFIGXML_FILEPATH); echo
	# $(JKSCURL) --data-binary @$(JKS_JOB_CONFIGXML_FILEPATH) -H 'Content-Type: application/xml' -X POST '$(JKS_JOB_URL)/config.xml'
	$(JENKINS) update-job $(JKS_JOB_NAME) < $(JKS_JOB_CONFIGXML_FILEPATH)

_jks_view_jobs:
	@$(INFO) '$(JKS_UI_LABEL)View jobs ...'; $(NORMAL)
	$(JENKINS) list-jobs

_jks_view_jobs_set:
	@$(INFO) '$(JKS_UI_LABEL)View jobs-set "$(JKS_JOBS_SET_NAME)" ...'; $(NORMAL)
	$(JENKINS) list-jobs | grep $(JKS_JOBS_REGEX)
