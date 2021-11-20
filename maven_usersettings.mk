_MAVEN_USERSETTINGS_MK_VERSION= $(_MAVEN_MK_VERSION)

# MVN_USERSETTINGS_DIRPATH?= ./m2/
MVN_USERSETTINGS_FILENAME?= settings.xml
# MVN_USERSETTINGS_FILEPATH?= ./m2/settings.xml
MVN_USERSETTINGS_NAME?= user-settings

# Derived parameters
MVN_USERSETTINGS_DIRPATH?= $(MVN_M2_DIRPATH)
MVN_USERSETTINGS_FILEPATH?= $(MVN_USERSETTINGS_DIRPATH)$(MVN_USERSETTINGS_FILENAME)

# Options

# Customizations
_MVN_SHOW_USERSETTINGS_CONTENT_|?= $(_MVN_SHOW_USERSETTINGS_DESCRIPTION_|)
_MVN_SHOW_USERSETTINGS_DESCRIPTION_|?= [ ! -f $(MVN_USERSETTINGS_FILEPATH) ] || #
|_MVN_SHOW_USERSETTINGS_CONTENT?= | head -10; echo '...'
|_MVN_SHOW_USERSETTINGS_GLOBAL?= | head -10; echo '...'

# Macros

#----------------------------------------------------------------------
# USAGE
#

_mvn_list_macros ::
	@#echo 'MaVeN::UserSettings ($(_MAVEN_USERSETTINGS_MK_VERSION)) macros:'
	@#echo

_mvn_list_parameters ::
	@echo 'MaVeN::UserSettings ($(_MAVEN_USERSETTINGS_MK_VERSION)) parameters:'
	@echo '    MVN_USERSETTINGS_DIRPATH=$(MVN_USERSETTINGS_DIRPATH)'
	@echo '    MVN_USERSETTINGS_FILENAME=$(MVN_USERSETTINGS_FILENAME)'
	@echo '    MVN_USERSETTINGS_FILEPATH=$(MVN_USERSETTINGS_FILEPATH)'
	@echo '    MVN_USERSETTINGS_NAME=$(MVN_USERSETTINGS_NAME)'
	@echo

_mvn_list_targets ::
	@echo 'MaVeN::UserSettings ($(_MAVEN_USERSETTING_MK_VERSION)) targets:'
	@echo '    _mvn_create_usersettings             - Create a user-settings'
	@echo '    _mvn_delete_usersettings             - Delete a user-settings'
	@echo '    _mvn_show_usersettings               - Show everything related to a user-settings'
	@echo '    _mvn_show_usersettings_content       - Show the content of a user-settings'
	@echo '    _mvn_show_usersettings_description   - Show the description of a user-settings'
	@echo '    _mvn_write_usersettings              - Write a user-settings'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

define _MVN_USERSETTINGS_CONTENT
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
export _MVN_USERSETTINGS_CONTENT

_mvn_create_usersettings:
	@$(INFO) '$(MVN_UI_LABEL)Creating user-settings "$(MVN_USERSETTINGS_NAME)" ...'; $(NORMAL)
	mkdir -p $(MVN_USERSETTINGS_DIRPATH) && echo "$${_MVN_USERSETTINGS_CONTENT}" >> $(MVN_USERSETTINGS_FILEPATH)

_mvn_delete_usersettings:
	@$(INFO) '$(MVN_UI_LABEL)Deleting settings "$(MVN_USERSETTINGS_NAME)" ...'; $(NORMAL)
	# rm $(MVN_USERSETTINGS_FILEPATH)

_mvn_list_usersettings:
	@$(INFO) '$(MVN_UI_LABEL)Listing ALL settings ...'; $(NORMAL)

_mvn_list_usersettings_set:
	@$(INFO) '$(MVN_UI_LABEL)Listing settings-set "$(MVN_USERSETTINGS_SET_NAME)" ...'; $(NORMAL)

_MVN_SHOW_USERSETTINGS_TARGETS?= _mvn_show_usersettings_content _mvn_show_usersettings_description
_mvn_show_usersettings: $(_MVN_SHOW_USERSETTINGS_TARGETS)

_mvn_show_usersettings_content:
	@$(INFO) '$(MVN_UI_LABEL)Showing content of user-settings "$(MVN_USERSETTINGS_NAME)" ...'; $(NORMAL)
	$(_MVN_SHOW_USERSETTINGS_CONTENT_|)cat $(MVN_USERSETTINGS_FILEPATH) $(|_MVN_SHOW_USERSETTINGS_CONTENT)

_mvn_show_usersettings_description:
	@$(INFO) '$(MVN_UI_LABEL)Showing description of user-settings "$(MVN_USERSETTINGS_NAME)" ...'; $(NORMAL)
	$(_MVN_SHOW_USERSETTINGS_DESCRIPTION_|)ls -al $(MVN_USERSETTINGS_FILEPATH)

_mvn_write_usersettings:
	@$(INFO) '$(MVN_UI_LABEL)Writing user-settings "$(MVN_USERSETTINGS_NAME)" ...'; $(NORMAL)
	$(WRITER) $(MVN_USERSETTINGS_FILEPATH)
