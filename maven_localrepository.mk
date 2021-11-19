_MAVEN_LOCALREPOSITORY_MK_VERSION= $(_MAVEN_MK_VERSION)

# MVN_LOCALREPOSITORY_DIRPATH?= ./m2/repository/
MVN_LOCALREPOSITORY_NAME?= local-repository

# Derived parameters
MVN_LOCALREPOSITORY_DIRPATH?= $(MVN_M2_DIRPATH)repository/

# Options

# Customizations
|_MVN_SHOW_LOCALREPOSITORY_CONTENT?= | head -10; echo '...'

# Macros

#----------------------------------------------------------------------
# USAGE
#

_mvn_list_macros ::
	@#echo 'MaVeN::LocalRepository ($(_MAVEN_MK_VERSION)) macros:'
	@#echo

_mvn_list_parameters ::
	@echo 'MaVeN::LocalRepository ($(_MAVEN_LOCALREPOSITORY_MK_VERSION)) parameters:'
	@echo '    MVN_LOCALREPOSITORY_DIRPATH=$(MVN_LOCALREPOSITORY_DIRPATH)'
	@echo '    MVN_LOCALREPOSITORY_NAME=$(MVN_LOCALREPOSITORY_NAME)'
	@echo

_mvn_list_targets ::
	@echo 'MaVeN::LocalRepository ($(_MAVEN_LOCALREPOSITORY_MK_VERSION)) targets:'
	@echo '    _mvn_show_localrepository               - Show everything related to a local-repository'
	@echo '    _mvn_show_localrepository_content       - Show the content of a local-repository'
	@echo '    _mvn_show_localrepository_description   - Show the description of a local-repository'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_mvn_list_localrepositories:
	@$(INFO) '$(MVN_UI_LABEL)Listing ALL local-rpositories ...'; $(NORMAL)

_mvn_list_localrepositories_set:
	@$(INFO) '$(MVN_UI_LABEL)Listing local-repositories-set "$(MVN_LOCALREPOSITORIESS_SET)" ...'; $(NORMAL)

_MVN_SHOW_LOCALREPOSITORY_TARGETS?= _mvn_show_localrepository_content _mvn_show_localrepository_description
_mvn_show_localrepository: $(_MVN_SHOW_LOCALREPOSITORY_TARGETS)

_mvn_show_localrepository_content:
	@$(INFO) '$(MVN_UI_LABEL)Showing content of local-repository "$(MVN_LOCALREPOSITORY_NAME)" ...'; $(NORMAL)
	tree -L 1 $(MVN_LOCALREPOSITORY_DIRPATH) $(|_MVN_SHOW_LOCALREPOSITORY_CONTENT)

_mvn_show_localrepository_description:
	@$(INFO) '$(MVN_UI_LABEL)Showing description of local-repository "$(MVN_LOCALREPOSITORY_NAME)" ...'; $(NORMAL)
	ls -ald $(MVN_LOCALREPOSITORY_DIRPATH)
