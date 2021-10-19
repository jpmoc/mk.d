_AWS_CODEBUILD_BUILD_MK_VERSION= $(_AWS_CODEBUILD_MK_VERSION)

# CBD_BUILD_ARTIFACTS_OVERRIDE?=
# CBD_BUILD_BUILDSPEC_OVERRIDE?=
# CBD_BUILD_CACHE_OVERRIDE?=
# CBD_BUILD_COMPUTETYPE_OVERRIDE?=
# CBD_BUILD_ENVIRONMENTTYPE_OVERRIDE?=
# CBD_BUILD_ENVIRONMENTVARIABLES_OVERRIDE?=
# CBD_BUILD_GITCLONEDEPTH_OVERRIDE?=
# CBD_BUILD_GROUP_NAME?= /aws/codebuild/devops-webapp-project
# CBD_BUILD_ID?= devops-webapp-project:d26242cc-27f8-4138-b078-256a9be435f6
# CBD_BUILD_IDEMPOTENCY_TOKEN?=
# CBD_BUILD_IDS?= devops-webapp-project:d26242cc-27f8-4138-b078-256a9be435f6 ...
# CBD_BUILD_IMAGE_OVERRIDE?=
# CBD_BUILD_INDEX?= 0
# CBD_BUILD_INSECURESSL_OVERRIDE?= false
# CBD_BUILD_NAME?= my-build
# CBD_BUILD_PRIVILEDGEDMODE_OVERRIDE?= false
# CBD_BUILD_PROJECT_NAME?= my-build
# CBD_BUILD_REPORTBUILDSTATUS_OVERRIDE?= false
# CBD_BUILD_SERVICEROLE_OVERRIDE?=
# CBD_BUILD_SOURCEAUTH_OVERRIDE?=
# CBD_BUILD_SOURCELOCATION_OVERRIDE?=
# CBD_BUILD_SOURCETYPE_OVERRIDE?=
# CBD_BUILD_SOURCE_VERSION?=
# CBD_BUILD_STREAM_NAME?=
# CBD_BUILD_TIMEOUTINMINUTES_OVERRIDE?=

# Derived parameters
CBD_BUILD_INDEX?= $(CBD_PROJECT_BUILD_INDEX)
CBD_BUILD_NAME?= $(CBD_BUILD_PROJECT_NAME):$(CBD_BUILD_INDEX)
CBD_BUILD_PROJECT_NAME?= $(CBD_PROJECT_NAME)

# Options parameters
__CBD_ARTIFACTS_OVERRIDE= $(if $(CBD_BUILD_ARTIFACTS_OVERRIDE), --artifacts-override $(CBD_BUILD_ARTIFACTS_OVERRIDE))
__CBD_BUILDSPEC_OVERRIDE= $(if $(CBD_BUILD_BUILDSPEC_OVERRIDE), --buildspec-override $(CBD_BUILD_BUILDSPEC_OVERRIDE))
__CBD_CACHE_OVERRIDE= $(if $(CBD_BUILD_CACHE_OVERRIDE), --cache-override $(CBD_BUILD_CACHE_OVERRIDE))
__CBD_COMPUTE_TYPE_OVERRIDE= $(if $(CBD_BUILD_COMPUTETYPE_OVERRIDE), --compute-type-override $(CBD_BUILD_COMPUTETYPE_OVERRIDE))
__CBD_ENVIRONMENT_TYPE_OVERRIDE= $(if $(CBD_BUILD_ENVIRONMENTTYPE_OVERRIDE), --environment-type-override $(CBD_BUILD_ENVIRONMENTTYPE_OVERRIDE))
__CBD_ENVIRONMENT_VARIABLES_OVERRIDE= $(if $(CBD_BUILD_ENVIRONMENTVARIABLES_OVERRIDE), --environment-variables-override $(CBD_BUILD_ENVIRONMENTVARIABLES_OVERRIDE))
__CBD_GIT_CLONE_DEPTH_OVERRIDE= $(if $(CBD_BUILD_GITCLONEDEPTH_OVERRIDE), --git-clone-depth-override $(CBD_BUILD_GITCLONEDEPTH_OVERRIDE))
__CBD_ID__BUILD= $(if $(CBD_BUILD_ID), --id $(CBD_BUILD_ID))
__CBD_IDEMPOTENCY_TOKEN__BUILD= $(if $(CBD_BUILD_IDEMPOTENCY_TOKEN), --idempotency-token $(CBD_BUILD_IDEMPOTENCY_TOKEN))
__CBD_IDS__BUILD= $(if $(CBD_BUILD_IDS), --ids $(CBD_BUILD_IDS))
__CBD_IMAGE_OVERRIDE= $(if $(CBD_BUILD_IMAGE_OVERRIDE), --image-override $(CBD_BUILD_IMAGE_OVERRIDE))
__CBD_INSECURE_SSL_OVERRIDE= $(if $(filter true, $(CBD_BUILD_INSECURESSL_OVERRIDE)), --insecure-ssl-override, --no-insecure-ssl-override)
__CBD_PRIVILEGEDMODE_OVERRIDE= $(if $(filter true, $(CBD_BUILD_PRIVILEGEDMODE_OVERRIDE)), --privileged-mode-override, --no-privileged-mode-override)
__CBD_PROJECT_NAME__BUILD= $(if $(CBD_BUILD_PROJECT_NAME), --project-name $(CBD_BUILD_PROJECT_NAME))
__CBD_REPORTBUILDSTATUS_OVERRIDE= $(if $(filter true, $(CBD_BUILD_REPORTBUILDSTATUS_OVERRIDE)), --report-build-status-override, --no-report-build-status-override)
__CBD_SERVICE_ROLE_OVERRIDE= $(if $(CBD_BUILD_SERVICEROLE_OVERRIDE), --service-role-override $(CBD_BUILD_SERVICEROLE_OVERRIDE))
__CBD_SORT_ORDER__BUILD?=
__CBD_SOURCE_AUTH_OVERRIDE= $(if $(CBD_BUILD_SOURCEAUTH_OVERRIDE), --source-auth-override $(CBD_BUILD_SOURCEAUTH_OVERRIDE))
__CBD_SOURCE_LOCATION_OVERRIDE= $(if $(CBD_BUILD_SOURCELOCATION_OVERRIDE), --source-location-override $(CBD_BUILD_SOURCELOCATION_OVERRIDE))
__CBD_SOURCE_TYPE_OVERRIDE= $(if $(CBD_BUILD_SOURCETYPE_OVERRIDE), --source-type-override $(CBD_BUILD_SOURCETYPE_OVERRIDE))
__CBD_SOURCE_VERSION= $(if $(CBD_BUILD_SOURCE_VERSION), --source-version $(CBD_BUILD_SOURCE_VERSION))
__CBD_TIMEOUT_IN_MINUTES_OVERRIDE= $(if $(CBD_BUILD_TIMEOUTINMINUTES_OVERRIDE), --timeout-in-minutes-override $(CBD_BUILD_TIMEOUTINMINUTES_OVERRIDE))

# UI parameters
CBD_UI_SHOW_BUILD_PHASES_FIELDS?= .{PhaseType:phaseType,durationInSeconds:durationInSeconds,phaseStatus:phaseStatus}
CBD_UI_SHOW_BUILD_SUMMARY_FIELDS?= .{buildStatus:buildStatus,initiator:initiator,Id:id,currentPhase:currentPhase,startTime:startTime,endTime:endTime}
CBD_UI_VIEW_BUILDS_FIELDS?=
CBD_UI_VIEW_BUILDS_SET_FIELDS?= $(CBD_UI_VIEW_BUILDS_FIELDS)
CBD_UI_VIEW_BUILDS_SET_SLICE?= 0:10

#--- Utilities

#--- MACROS
_cbd_get_build_group_name= $(call _cbd_get_build_group_name_I, $(CBD_BUILD_ID))
# _cbd_get_build_group_name_I= $(shell $(AWS) codebuild batch-get-builds --id $(1) --query "builds[].logs.groupName" --output text)
_cbd_get_build_group_name_I= $(shell echo /aws/codebuild/$(firstword $(subst :,$(SPACE), $(CBD_BUILD_ID))))

_cbd_get_build_stream_name= $(call _cbd_get_build_stream_name_I, $(CBD_BUILD_ID))
# _cbd_get_build_stream_name_I= $(shell $(AWS) codebuild batch-get-builds --id $(1) --query "builds[].logs.streamName" --output text)
_cbd_get_build_stream_name_I= $(shell echo $(lastword $(subst :,$(SPACE), $(CBD_BUILD_ID))))

#----------------------------------------------------------------------
# USAGE
#

_cbd_view_framework_macros ::
	@echo 'AWS::CodeBuilD::Build ($(_AWS_CODEBUILD_BUILD_MK_VERSION)) macros:'
	@echo '    _cbd_get_build_group_name_{|I}      - Get the log group name of a build (Id)'
	@echo '    _cbd_get_build_stream_name_{|I}     - Get the log stream name of a build (Id)'
	@echo

_cbd_view_framework_parameters ::
	@echo 'AWS::CodeBuilD::Build ($(_AWS_CODEBUILD_BUILD_MK_VERSION)) parameters:'
	@echo '    CBD_BUILD_ARTIFACTS_OVERRIDE=$(CBD_BUILD_ARTIFACTS_OVERRIDE)'
	@echo '    CBD_BUILD_BUILDSPEC_OVERRIDE=$(CBD_BUILD_BUILDSPEC_OVERRIDE)'
	@echo '    CBD_BUILD_CACHE_OVERRIDE=$(CBD_BUILD_CACHE_OVERRIDE)'
	@echo '    CBD_BUILD_COMPUTETYPE_OVERRIDE=$(CBD_BUILD_COMPUTETYPE_OVERRIDE)'
	@echo '    CBD_BUILD_ENVIRONMENTTYPE_OVERRIDE=$(CBD_BUILD_ENVIRONMENTTYPE_OVERRIDE)'
	@echo '    CBD_BUILD_ENVIRONMENTVARIABLES_OVERRIDE=$(CBD_BUILD_ENVIRONMENTVARIABLES_OVERRIDE)'
	@echo '    CBD_BUILD_GITCLONEDEPTH_OVERRIDE=$(CBD_BUILD_GITCLONEDEPTH_OVERRIDE)'
	@echo '    CBD_BUILD_GROUP_NAME=$(CBD_BUILD_GROUP_NAME)'
	@echo '    CBD_BUILD_ID=$(CBD_BUILD_ID)'
	@echo '    CBD_BUILD_IDEMPOTENCY_TOKEN=$(CBD_BUILD_IDEMPOTENCY_TOKEN)'
	@echo '    CBD_BUILD_IDS=$(CBD_BUILD_IDS)'
	@echo '    CBD_BUILD_IMAGE_OVERRIDE=$(CBD_BUILD_IMAGE_OVERRIDE)'
	@echo '    CBD_BUILD_INDEX=$(CBD_BUILD_INDEX)'
	@echo '    CBD_BUILD_INSECURESSL_OVERRIDE=$(CBD_BUILD_INSECURESSL_OVERRIDE)'
	@echo '    CBD_BUILD_NAME=$(CBD_BUILD_NAME)'
	@echo '    CBD_BUILD_PROJECT_NAME=$(CBD_BUILD_PROJECT_NAME)'
	@echo '    CBD_BUILD_REPORTEDBUILDSTATUS_OVERRIDE=$(CBD_BUILD_REPORTEDBUILDSTATUS_OVERRIDE)'
	@echo '    CBD_BUILD_SERVICEROLE_OVERRIDE=$(CBD_BUILD_SERVICEROLE_OVERRIDE)'
	@echo '    CBD_BUILD_SOURCEAUTH_OVERRIDE=$(CBD_BUILD_SOURCEAUTH_OVERRIDE)'
	@echo '    CBD_BUILD_SOURCELOCATION_OVERRIDE=$(CBD_BUILD_SOURCELOCATION_OVERRIDE)'
	@echo '    CBD_BUILD_SOURCETYPE_OVERRIDE=$(CBD_BUILD_SOURCETYPE_OVERRIDE)'
	@echo '    CBD_BUILD_SOURCE_VERSION=$(CBD_BUILD_SOURCE_VERSION)'
	@echo '    CBD_BUILD_TIMEOUTINMINUTES_OVERRIDE=$(CBD_BUILD_TIMEOUTINMINUTES_OVERRIDE)'
	@echo

_cbd_view_framework_targets ::
	@echo 'AWS::CodeBuilD::Build ($(_AWS_CODEBUILD_BUILD_MK_VERSION)) targets:'
	@echo '    _cbd_show_build                     - Show everything related to a build'
	@echo '    _cbd_show_build_phases              - Show phases of a build'
	@echo '    _cbd_show_build_summary             - Show summary of a build'
	@echo '    _cbd_start_build                    - Start a project-build'
	@echo '    _cbd_stop_build                     - Stop a project-build'
	@echo '    _cbd_view_builds                    - View existing projects'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cbd_create_build:
_cbd_delete_build:

_cbd_show_build: _cbd_show_build_summary _cbd_show_build_phases _cbd_show_build_artifacts

_cbd_show_build_artifacts:
	@$(INFO) '$(AWS_UI_LABEL)Showing artifacts of build "$(CBD_BUILD_NAME)" ...'; $(NORMAL)
	$(AWS)  codebuild batch-get-builds $(_X__CBD_IDS__BUILD) --ids $(CBD_BUILD_ID) --query "builds[].artifacts"

_cbd_show_build_phases:
	@$(INFO) '$(AWS_UI_LABEL)Showing phases of build "$(CBD_BUILD_NAME)" ...'; $(NORMAL)
	$(AWS) codebuild batch-get-builds $(_X__CBD_IDS__BUILD) --ids $(CBD_BUILD_ID) --query "builds[].phases[]$(CBD_UI_SHOW_BUILD_PHASES_FIELDS)"

_cbd_show_build_summary:
	@$(INFO) '$(AWS_UI_LABEL)Showing summary of build "$(CBD_BUILD_NAME)" ...'; $(NORMAL)
	$(AWS) codebuild batch-get-builds $(_X__CBD_IDS__BUILD) --ids $(CBD_BUILD_ID) --query "builds[]$(CBD_UI_SHOW_BUILD_SUMMARY_FIELDS)"

_cbd_start_build:
	@$(INFO) '$(AWS_UI_LABEL)Starting a build of project"$(CBD_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) codebuild start-build $(__CBD_ARTIFACTS_OVERRIDE) $(__CBD_BUILDSPEC_OVERRIDE) $(__CBD_CACHE_OVERRIDE) $(__CBD_COMPUTE_TYPE_OVERRIDE) $(__CBD_ENVIRONMENT_TYPE_OVERRIDE) $(__CBD_ENVIRONMENT_VARIABLES_OVERRIDE) $(__CBD_GIT_CLONE_DEPTH_OVERRIDE) $(__CBD_IDEMPOTENCY_TOKEN) $(__CBD_IMAGE_OVERRIDE) $(__CBD_INSECURE_SSL_OVERRIDER) $(__CBD_PRIVILEGED_MODE_OVERRIDE) $(__CBD_PROJECT_NAME__BUILD) $(__CBD_REPORT_BUILD_STATUS_OVERRIDE) $(__CBD_SERVICE_ROLE_OVERRIDE) $(__CBD_SOURCE_AUTH_OVERRIDE) $(__CBD_SOURCE_LOCATION_OVERRIDE) $(__CBD_SOURCE_TYPE_OVERRIDE) $(__CBD_SOURCE_VERSION) $(__CBD_TIMEOUT_IN_MINUTES_OVERRIDE)

_cbd_stop_build:
	@$(INFO) '$(AWS_UI_LABEL)Starting a build of project"$(CBD_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) codebuild stop-build $(__CBD_ID__BUILD)

_cbd_view_builds:
	@$(INFO) '$(AWS_UI_LABEL)Viewing build history ...'; $(NORMAL)
	$(AWS)  codebuild list-builds $(__CBD_SORT_ORDER__BUILD) --query "ids[]$(CBD_UI_VIEW_BUILDS_FIELDS)"

_cbd_view_builds_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing builds-set "$(CBD_BUILDS_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'Builds are grouped based on the provided slice'; $(NORMAL)
	$(AWS)  codebuild list-builds $(__CBD_SORT_ORDER__BUILD) --query "ids[$(CBD_UI_VIEW_BUILDS_SET_SLICE)]$(CBD_UI_VIEW_BUILDS_FIELDS)"
