_JENKINS_BUILD_MK_VERSION= $(_JENKINS_MK_VERSION)

# JKS_BUILD_JOB_NAME?=
# JKS_BUILD_JOB_URL?=
# JKS_BUILD_NAME?= my-job/12
# JKS_BUILD_NEXTNUMBER?= 3
JKS_BUILD_NUMBER?= lastBuild
# JKS_BUILD_PARAMETERS?=
JKS_BUILD_TAIL_COUNT?= 9999
# JKS_BUILD_URL?= https://jenkins.example.com/job/job-name/1/
# JKS_BUILDS_SET_NAME?=

# Derived
JKS_BUILD_NAME?= $(JKS_BUILD_JOB_NAME)/$(JKS_BUILD_NUMBER)
JKS_BUILD_JOB_NAME?= $(JKS_JOB_NAME)
JKS_BUILD_JOB_URL?= $(JKS_JOB_URL)
JKS_BUILD_URL?= $(JKS_BUILD_JOB_URL)/$(JKS_BUILD_NUMBER)
JKS_BUILDS_SET_NAME?= builds@last-10

# Options
__JKS_P__BUILD= $(strip $(foreach P, $(JKS_BUILD_PARAMETERS), -p $(P)) )
__JKS_S__BUILD= -s
__JKS_V__BUILD= -v

# UI
#
# Pipe
|_JKS_SHOW_BUILD?= | jq -r '.number, .displayName, .url, .result, .culprits'
|_JKS_VIEW_BUILDS_SET?= | head -10

# VIEW_BUILD_PARAMETERS_FIELDS= [.name, .description, .defaultParameterValue.value]

_jks_get_build_nextnumber= $(shell $(JKSCURL) -X POST "$(JKS_BUILD_JOB_URL)/api/json" | jq -r '.nextBuildNumber' 2>/dev/null)

#----------------------------------------------------------------------
# Usage
#

_jks_view_framework_macros ::
	@echo 'Jenkins::Build ($(_JENKINS_BUILD_MK_VERSION)) macros:'
	@echo '    _jks_get_build_nextnumber        - Get the nubmer of the build that is next'
	@echo

_jks_view_framework_parameters ::
	@echo 'Jenkins::Build ($(_JENKINS_BUILD_MK_VERSION)) parameters:'
	@echo '    JKS_BUILD_JOB_NAME=$(JKS_BUILD_JOB_NAME)'
	@echo '    JKS_BUILD_JOB_URL=$(JKS_BUILD_JOB_URL)'
	@echo '    JKS_BUILD_NAME=$(JKS_BUILD_NAME)'
	@echo '    JKS_BUILD_NEXTNUMBER=$(JKS_BUILD_NEXTNUMBER)'
	@echo '    JKS_BUILD_NUMBER=$(JKS_BUILD_NUMBER)'
	@echo '    JKS_BUILD_PARAMETERS=$(JKS_BUILD_PARAMETERS)'
	@echo '    JKS_BUILD_TAIL_COUNT=$(JKS_BUILD_TAIL_COUNT)'
	@echo '    JKS_BUILD_URL=$(JKS_BUILD_URL)'
	@echo '    JKS_BUILDS_SET_NAME=$(JKS_BUILDS_SET_NAME)'
	@echo

_jks_view_framework_targets ::
	@echo 'Jenkins::Build ($(_JENKINS_BUILD_MK_VERSION)) targets:'
	@echo '     _jks_abort_build               - Abort a running build'
	@echo '     _jks_show_build                - Show everything related to a build'
	@echo '     _jks_show_build_description    - Show the description of a build'
	@echo '     _jks_show_build_parameters     - Show the parameters of a build'
	@echo '     _jks_start_build               - Start a preconfigured build'
	@echo '     _jks_tail_build                - Tail the console of a build'
	@echo '     _jks_view_builds               - View builds'
	@echo '     _jks_view_builds_set           - View a set of builds'
	@echo '     _jks_watch_build               - Watch the console of the current/last build'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

__jks_watch_build_header ::

__jks_watch_build_footer ::

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_jks_abort_build:
	@$(INFO) '$(JKS_UI_LABEL)Aborting build "$(JKS_BUILD_NAME)" ...'; $(NORMAL)
	$(CURL) -X POST $(JKS_BUILD_URL)/stop

_jks_create_build: _jks_start_build

_jks_delete_build:
	@$(INFO) '$(JKS_UI_LABEL)Deleting build "$(JKS_BUILD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This opeation fails if the user does NOT have the Run/Delete permission'; $(NORMAL)
	$(JENKINS) delete-builds $(JKS_BUILD_JOB_NAME) $(JKS_BUILD_NUMBER)

_jks_show_build :: _jks_show_build_parameters _jks_show_build_description

_jks_show_build_description:
	@$(INFO) '$(JKS_UI_LABEL)Showing description of build "$(JKS_BUILD_NAME)" ...'; $(NORMAL)
	$(JKSCURL) -X POST  $(JKS_BUILD_URL)/api/json | jq -r '.' $(|_JKS_SHOW_BUILD)

_jks_show_build_parameters:
	@$(INFO) '$(JKS_UI_LABEL)Showing description of build "$(JKS_BUILD_NAME)" ...'; $(NORMAL)
	$(JKSCURL) -X POST $(JKS_BUILD_URL)/api/json | jq '.actions[] | select(._class=="hudson.model.ParametersAction").parameters[]'

_jks_start_build:
	@$(INFO) '$(JKS_UI_LABEL)Starting build "$(JKS_BUILD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Build URL: $(JKS_BUILD_URL)'; $(NORMAL)
	# $(JKSCURL) -X POST "$(JKS_JOB_URL)/buildWithParameters?$(subst $(SPACE),&,$(JKS_BUILD_PARAMETERS))"
	@$(WARN) 'This operation validates the input parameters based on their definition'; $(NORMAL)
	@$(WARN) 'This operation updates parameters, but the server configuration can enforce a parameter value'; $(NORMAL)
	$(JENKINS) build $(JKS_BUILD_JOB_NAME) $(__JKS_P__BUILD) $(__JKS_S__BUILD) $(__JKS_V__BUILD)

_jks_tail_build:
	@$(INFO) '$(JKS_UI_LABEL)Tailing build "$(JKS_BUILD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Build URL is $(JKS_BUILD_URL)/console'; $(NORMAL)
	@echo
	@#$(JKSCURL) -X POST $(JKS_BUILD_URL)/logText/progressiveText | tail -$(JKS_BUILD_TAIL_COUNT)
	@$(JKSCURL) -X POST  $(JKS_BUILD_URL)/consoleText | tail -$(JKS_BUILD_TAIL_COUNT)

_jks_view_builds:
	@$(INFO) '$(JKS_UI_LABEL)Viewing builds ...'; $(NORMAL)
	$(JKSCURL) -X POST $(JKS_BUILD_JOB_URL)/api/json | jq -r '.builds[] | "\(.number) \t \(.url)"'

_jks_view_builds_set:
	@$(INFO) '$(JKS_UI_LABEL)Viewing builds-set "$(JKS_BUILDS_SET_NAME)" ...'; $(NORMAL)
	$(JKSCURL) -X POST '$(JKS_BUILD_JOB_URL)/api/json' | jq -r '.builds[] | "\(.number) \t \(.url)"' $(|_JKS_VIEW_BUILDS_SET)

_jks_wait_build:
	@$(INFO) '$(JKS_UI_LABEL)Waiting for completion of build "$(JKS_BUILD_NAME)" ...'
	@while [ "$${_RESULT}" != "SUCCESS" ] && [ "$${_RESULT}" != "FAILURE" ] && [ "$${_RESULT}" != "UNSTABLE"] ; do \
		_RESULT=`$(JKSCURL) -X POST "$(JKS_BUILD_URL)/api/json" | jq -r '.result' 2>/dev/null`; \
		echo -n '.'; sleep 1; \
		done; echo;  $(WARN) "Job completed with status: $${_RESULT}"; $(NORMAL)

_jks_watch_build:
	watch  -n 5 --color "make --quiet __jks_watch_build_header _jks_tail_build __jks_watch_build_footer"
