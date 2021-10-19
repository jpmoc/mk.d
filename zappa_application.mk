_ZAPPA_APPLICATION_MK_VERSION= $(_ZAPPA_MK_VERSION)

# ZPA_APPLICATION_BUCKET_NAME= dev
ZPA_APPLICATION_CONFIGURATION_FILENAME= zappa_settings.json
# ZPA_APPLICATION_CONFIGURATION_FILEPATH= .../zappa_settings.json
# ZPA_APPLICATION_DIRPATH= ./apps/helloworld
# ZPA_APPLICATION_ENVIRONMENT_NAME= dev
# ZPA_APPLICATION_NAME= my-application
# ZPA_APPLICATION_STAGE_NAME= dev
# ZPA_APPLICATIONS_DIRPATH= ./apps

# Derived parameters
ZPA_APPLICATION_BUCKET_NAME?= $(S3_BUCKET_NAME)
ZPA_APPLICATION_CONFIGURATION_FILEPATH?= $(ZPA_APPLICATION_DIRPATH)/$(ZPA_APPLICATION_CONFIGURATION_FILENAME)
ZPA_APPLICATION_ENVIRONMENT_NAME?= $(VEV_ENVIRONMENT_NAME)
ZPA_APPLICATION_DIRPATH?= $(ZPA_APPLICATIONS_DIRPATH)/$(ZPA_APPLICATION_NAME)

# Options parameters

# Pipe parameters
|_ZPA_SHOW_APPLICATION_CONFIGURATION?= | jq --monochrome-output '.'
_ZPA_DEPLOY_APPLICATION_|?= cd $(ZPA_APPLICATION_DIRPATH) &&
_ZPA_INITIALIZE_APPLICATION_|?= cd $(ZPA_APPLICATION_DIRPATH) &&
_ZPA_SHOW_APPLICATION_STATUS_|?= cd $(ZPA_APPLICATION_DIRPATH) &&
_ZPA_TAIL_APPLICATION_LOGS_|?= cd $(ZPA_APPLICATION_DIRPATH) &&
_ZPA_UPDATE_APPLICATION_|?= cd $(ZPA_APPLICATION_DIRPATH) &&
_ZPA_UNDEPLOY_APPLICATION_|?= cd $(ZPA_APPLICATION_DIRPATH) &&
_ZPA_VIEW_APPLICATIONS_|?= cd $(ZPA_APPLICATIONS_DIRPATH) &&

# UI parameters
ZPA_UI_LABEL?= [zappa] #

#--- Utilities

ZAPPA_BIN?= zappa
ZAPPA?= $(strip $(__ZAPPA_ENVIRONMENT) $(ZAPPA_ENVIRONMENT) $(ZAPPA_BIN) $(__ZAPPA_OPTIONS) $(ZAPPA_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _zpa_view_framework_macros
_zpa_view_framework_macros ::
	@echo 'ZaPpa::Application ($(_ZAPPA_APPLICATION_MK_VERSION)) targets:'
	@echo

_view_framework_parameters :: _zpa_view_framework_parameters
_zpa_view_framework_parameters ::
	@echo 'ZaPpa::Application ($(_ZAPPA_APPLICATION_MK_VERSION)) parameters:'
	@echo '    ZPA_APPLICATION_BUCKET_NAME=$(ZPA_APPLICATION_BUCKET_NAME)'
	@echo '    ZPA_APPLICATION_CONFIGURATION_FILENAME=$(ZPA_APPLICATION_CONFIGURATION_FILENAME)'
	@echo '    ZPA_APPLICATION_CONFIGURATION_FILEPATH=$(ZPA_APPLICATION_CONFIGURATION_FILEPATH)'
	@echo '    ZPA_APPLICATION_DIRPATH=$(ZPA_APPLICATION_DIRPATH)'
	@echo '    ZPA_APPLICATION_ENVIRONMENT_NAME=$(ZPA_APPLICATION_ENVIRONMENT_NAME)'
	@echo '    ZPA_APPLICATION_NAME=$(ZPA_APPLICATION_NAME)'
	@echo '    ZPA_APPLICATION_STAGE_NAME=$(ZPA_APPLICATION_STAGE_NAME)'
	@echo '    ZPA_APPLICATIONS_DIRPATH=$(ZPA_APPLICATIONS_DIRPATH)'
	@echo

_view_framework_targets :: _zpa_view_framework_targets
_zpa_view_framework_targets ::
	@echo 'ZaPpa::Application ($(_ZAPPA_MK_APPLICATION_VERSION)) targets:'
	@echo '    _zpa_delete_application_configuration    - Delete configuration of application'
	@echo '    _zpa_deploy_application                  - Deploy application'
	@echo '    _zpa_initialize_application              - Initialize application'
	@echo '    _zpa_show_application                    - Show everything related to an application'
	@echo '    _zpa_show_application_configuration      - Show the configuration of an application'
	@echo '    _zpa_show_application_description        - Show the description of an application'
	@echo '    _zpa_tail_application_logs               - Tail the logs of an application'
	@echo '    _zpa_update_application                  - Update an application'
	@echo '    _zpa_undeploy_application                - Undeploy an application'
	@echo '    _zpa_view_applications                   - View applications'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_zpa_delete_application_configuration:
	@$(INFO) '$(ZPA_UI_LABEL)Deleting configuration of application "$(ZPA_APPLICATION_NAME)" ...'; $(NORMAL)
	@read -p 'Are you sure you want to delete "$(ZPA_APPLICATION_CONFIGURATION_FILEPATH)" ? (Ctrl-C to abort)' yesNo
	rm -f $(ZPA_APPLICATION_CONFIGURATION_FILEPATH)

_zpa_deploy_application:
	@$(INFO) '$(ZPA_UI_LABEL)Deploying application "$(ZPA_APPLICATION_NAME)" ...'; $(NORMAL)
	$(_ZPA_DEPLOY_APPLICATION_|) $(ZAPPA) deploy $(ZPA_APPLICATION_STAGE_NAME)

_zpa_edit_application_configuration:
	@$(INFO) '$(ZPA_UI_LABEL)Editing configuration of application "$(ZPA_APPLICATION_NAME)" ...'; $(NORMAL)
	$(EDITOR) $(ZPA_APPLICATION_CONFIGURATION_FILEPATH)

_zpa_initialize_application:
	@$(INFO) '$(ZPA_UI_LABEL)Initializing application "$(ZPA_APPLICATION_NAME)" ...'; $(NORMAL)
	$(_ZPA_INITIALIZE_APPLICATION_|) $(ZAPPA) init
	@$(WARN) 'The initialization does not enable xray_tracing by default!'; $(NORMAL)
	@$(WARN) 'See https://docs.aws.amazon.com/xray/latest/devguide/xray-sdk-python-serverless.html'; $(NORMAL)

_zpa_show_application:: _zpa_show_application_configuration _zpa_show_application_description

_zpa_show_application_configuration:
	@$(INFO) '$(ZPA_UI_LABEL)Showing configuration of application "$(ZPA_APPLICATION_NAME)" ...'; $(NORMAL)
	ls -al $(ZPA_APPLICATION_CONFIGURATION_FILEPATH)
	cat $(ZPA_APPLICATION_CONFIGURATION_FILEPATH) $(|_ZPA_SHOW_APPLICATION_CONFIGURATION)

_zpa_show_application_description: 
	@$(INFO) '$(ZPA_UI_LABEL)Showing description of application "$(ZPA_APPLICATION_NAME)" ...'; $(NORMAL)
	ls -al $(ZPA_APPLICATION_DIRPATH)

_zpa_show_application_status: 
	@$(INFO) '$(ZPA_UI_LABEL)Showing status of application "$(ZPA_APPLICATION_NAME)" ...'; $(NORMAL)
	$(_ZPA_SHOW_APPLICATION_STATUS_|) $(ZAPPA) status

_zpa_tail_application_logs:
	@$(INFO) '$(ZPA_UI_LABEL)Tailing logs of application "$(ZPA_APPLICATION_NAME)" ...'; $(NORMAL)
	$(_ZPA_TAIL_APPLICATION_LOGS_|) $(ZAPPA) tail

_zpa_update_application:
	@$(INFO) '$(ZPA_UI_LABEL)Updating application "$(ZPA_APPLICATION_NAME)" ...'; $(NORMAL)
	$(_ZPA_UPDATE_APPLICATION_|) $(ZAPPA) update $(ZPA_APPLICATION_STAGE_NAME)

_zpa_undeploy_application:
	@$(INFO) '$(ZPA_UI_LABEL)Undeploying application "$(ZPA_APPLICATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation deletes the associated cloudformation stack'; $(NORMAL)
	$(_ZPA_UNDEPLOY_APPLICATION_|) $(ZAPPA) undeploy $(ZPA_APPLICATION_STAGE_NAME)

_zpa_view_applications:
	@$(INFO) '$(ZPA_UI_LABEL)Viewing applications ...'; $(NORMAL)
	$(_ZPA_VIEW_APPLICATIONS_|) ls -adl *
