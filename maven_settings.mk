_MAVEN_SETTINGS_MK_VERSION= $(_MAVEN_MK_VERSION)

# MVN_SETTINGS_DIRPATH?= ./m2/
MVN_SETTINGS_FILENAME?= settings.xml
# MVN_SETTINGS_FILEPATH?= ./m2/settings.xml
MVN_SETTINGS_NAME?= user-settings

# Derived parameters
MVN_SETTINGS_DIRPATH?= $(MVN_M2_DIRPATH)
MVN_SETTINGS_FILEPATH?= $(MVN_SETTINGS_DIRPATH)$(MVN_SETTINGS_FILENAME)

# Options

# Customizations
_MVN_SHOW_SETTINGS_CONTENT_|?= $(_MVN_SHOW_SETTINGS_DESCRIPTION_|)
_MVN_SHOW_SETTINGS_DESCRIPTION_|?= [ ! -f $(MVN_SETTINGS_FILEPATH) ] || #
|_MVN_SHOW_SETTINGS_CONTENT?= | head -10; echo '...'

# Macros

#----------------------------------------------------------------------
# USAGE
#

_mvn_list_macros ::
	@#echo 'MaVeN::Settings ($(_MAVEN_SETTINGS_MK_VERSION)) macros:'
	@#echo

_mvn_list_parameters ::
	@echo 'MaVeN::Settings ($(_MAVEN_SETTINGS_MK_VERSION)) parameters:'
	@echo '    MVN_SETTINGS_DIRPATH=$(MVN_SETTINGS_DIRPATH)'
	@echo '    MVN_SETTINGS_FILENAME=$(MVN_SETTINGS_FILENAME)'
	@echo '    MVN_SETTINGS_FILEPATH=$(MVN_SETTINGS_FILEPATH)'
	@echo '    MVN_SETTINGS_NAME=$(MVN_SETTINGS_NAME)'
	@echo

_mvn_list_targets ::
	@echo 'MaVeN::Settings ($(_MAVEN_SETTING_MK_VERSION)) targets:'
	@echo '    _mvn_create_settings             - Create a settings'
	@echo '    _mvn_delete_settings             - Delete a settings'
	@echo '    _mvn_show_settings               - Show everything related to a settings'
	@echo '    _mvn_show_settings_content       - Show the content of a settings'
	@echo '    _mvn_show_settings_description   - Show the description of a settings'
	@echo '    _mvn_write_settings              - Write a settings'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

define _MVN_SETTINGS_CONTENT
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                        https://maven.apache.org/xsd/settings-1.0.0.xsd">
    <localRepository/>
    <interactiveMode/>
    <offline/>
    <pluginGroups/>
    <servers/>
    <mirrors/>
    <proxies/>
    <profiles/>
    <activeProfiles/>
</settings>
endef
export _MVN_SETTINGS_CONTENT

_mvn_create_settings:
	@$(INFO) '$(MVN_UI_LABEL)Creating settings "$(MVN_SETTINGS_NAME)" ...'; $(NORMAL)
	mkdir -p $(MVN_SETTINGS_DIRPATH) && echo "$${_MVN_SETTINGS_CONTENT}" >> $(MVN_SETTINGS_FILEPATH)

_mvn_delete_settings:
	@$(INFO) '$(MVN_UI_LABEL)Deleting settings "$(MVN_SETTINGS_NAME)" ...'; $(NORMAL)
	# rm $(MVN_SETTINGS_FILEPATH)

_mvn_list_settings:
	@$(INFO) '$(MVN_UI_LABEL)Listing ALL settings ...'; $(NORMAL)

_mvn_list_settings_set:
	@$(INFO) '$(MVN_UI_LABEL)Listing settings-set "$(MVN_SETTINGS_SET_NAME)" ...'; $(NORMAL)

_MVN_SHOW_SETTINGS_TARGETS?= _mvn_show_settings_content _mvn_show_settings_description
_mvn_show_settings: $(_MVN_SHOW_SETTINGS_TARGETS)

_mvn_show_settings_content:
	@$(INFO) '$(MVN_UI_LABEL)Showing content of settings "$(MVN_SETTINGS_NAME)" ...'; $(NORMAL)
	$(_MVN_SHOW_SETTINGS_CONTENT_|)cat $(MVN_SETTINGS_FILEPATH) $(|_MVN_SHOW_SETTINGS_CONTENT)

_mvn_show_settings_description:
	@$(INFO) '$(MVN_UI_LABEL)Showing description of settings "$(MVN_SETTINGS_NAME)" ...'; $(NORMAL)
	$(_MVN_SHOW_SETTINGS_DESCRIPTION_|)ls -al $(MVN_SETTINGS_FILEPATH)

_mvn_write_settings:
	@$(INFO) '$(MVN_UI_LABEL)Writing settings "$(MVN_SETTINGS_NAME)" ...'; $(NORMAL)
	$(WRITER) $(MVN_SETTINGS_FILEPATH)
