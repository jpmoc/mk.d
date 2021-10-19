_AWS_NEPTUNE_DBPARAMETERGROUP_MK_VERSION= $(_AWS_NEPTUNE_MK_VERSION)

# NTE_DBPARAMETERGROUP_DESCRIPTION?= "This is my db-parameter-group description"
# NTE_DBPARAMETERGROUP_FAMILY?=
# NTE_DBPARAMETERGROUP_NAME?= my-dbparametergroup-name
# NTE_DBPARAMETERGROUP_PARAMETERS?=
# NTE_DBPARAMETERGROUP_PARAMETERS_FILEPATH?= ./dbparametergroup-parameters.json
# NTE_DBPARAMETERGROUP_TAGS?= Key=string,Value=string ...

# Derived parameters
NTE_DBPARAMETERGROUP_PARAMETERS?= $(if $(NTE_DBPARAMETERGROUP_PARAMETERS_FILEPATH), file://$(NTE_DBPARAMETERGROUP_PARAMETERS_FILEPATH))

# Options parameters
__NTE_DB_PARAMETER_GROUP_NAME= $(if $(NTE_DBPARAMETERGROUP_NAME), --db--parameter-group-name $(NTE_DBPARAMETERGROUP_NAME))
__NTE_DB_PARAMETER_GROUP_FAMILY= $(if $(NTE_DBPARAMETERGROUP_FAMILY), --db-parameter-group-family $(NTE_DBPARAMETERGROUP_FAMILY))
__NTE_DESCRIPTION__DBPARAMETERGROUP= $(if $(NTE_DBPARAMETERGROUP_DESCRIPTION), --description $(NTE_DBPARAMETERGROUP_DESCRIPTION))
__NTE_FILTERS__DBPARAMETERGROUP=
__NTE_PARAMETERS= $(if $(NTE_DBPARAMETERGROUP_PARAMETERS), --parameters $(NTE_DBPARAMETERGROUP_PARAMETERS))
__NTE_RESET_ALL_PARAMETERS__DBPARAMETERGROUP=
__NTE_TAGS__DBPARAMETERGROUP= $(if $(NTE_DBPARAMETERGROUP_TAGS), --tags $(NTE_DBPARAMETERGROUP_TAGS))

# UI parameters
NTE_UI_VIEW_DBPARAMETERGROUPS_FIELDS?= .{DBClusterParameterGroupName:DBClusterParameterGroupName,dbParameterGroupFamily:DBParameterGroupFamily,description:Description}

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_nte_view_framework_macros ::
	@#echo 'AWS::NepTunE::DbParameterGroup ($(_AWS_NEPTUNE_DBPARAMETERGROUP_MK_VERSION)) macros:'
	@#echo

_nte_view_framework_parameters ::
	@echo 'AWS::NepTunE::DbParameterGroup ($(_AWS_NEPTUNE_DBPARAMETERGROUP_MK_VERSION)) parameters:'
	@echo '    NTE_DBPARAMETERGROUP_DESCRIPTION=$(NTE_DBPARAMETERGROUP_DESCRIPTION)'
	@echo '    NTE_DBPARAMETERGROUP_FAMILY=$(NTE_DBPARAMETERGROUP_FAMILY)'
	@echo '    NTE_DBPARAMETERGROUP_NAME=$(NTE_DBPARAMETERGROUP_NAME)'
	@echo '    NTE_DBPARAMETERGROUP_PARAMETERS=$(NTE_DBPARAMETERGROUP_PARAMETERS)'
	@echo '    NTE_DBPARAMETERGROUP_PARAMETERS_FILEPATH=$(NTE_DBPARAMETERGROUP_PARAMETERS_FILEPATH)'
	@echo

_nte_view_framework_targets ::
	@echo 'AWS::NepTunE::DbParameterGroup ($(_AWS_NEPTUNE_DBPARAMETERGROUP_MK_VERSION)) targets:'
	@echo '    _nte_create_dbparametergroup                      - Create a db-parameter-group'
	@echo '    _nte_delete_dbparametergroup                      - Delete a db-parameter-group'
	@echo '    _nte_reset_dbparametergroup                       - Reset a db-parameter-group'
	@echo '    _nte_show_dbparametergroup                        - Show everything related to db-parameter-group'
	@echo '    _nte_show_dbparametergroup_desription             - Show a db-parameter-group'
	@echo '    _nte_view_dbparametergroups                       - View db db-parameter-groups'
	@echo '    _nte_view_dbparametergroups_set                   - View a set of db-parameter-groups'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_nte_create_dbparametergroup:
	@$(INFO) '$(AWS_UI_LABEL)Creating DB-parameter-group "$(NTE_DBPARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) neptune create-db-parameter-group $(__NTE_DB_PARAMETER_GROUP_FAMILY) $(__NTE_DB_PARAMETER_GROUP_NAME) $(__NTE_DESCRIPTION__DBPARAMETERGROUP) $(__NTE_TAGS__DBPARAMETERGROUP)

_nte_delete_dbparametergroup:
	@$(INFO) '$(AWS_UI_LABEL)Deleting DB-parameter-group "$(NTE_DBPARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) neptune delete-db-parameter-group $(__NTE_DB_PARAMETER_GROUP_NAME)

_nte_reset_dbparametergroup:
	@$(INFO) '$(AWS_UI_LABEL)Reseting DB-parameter-group "$(NTE_DBPARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(if $(NTE_DBPARAMETERGROUP_PARAMETERS_FILEPATH), cat $(NTE_DBPARAMETERGROUP_PARAMETERS_FILEPATH))
	$(AWS) neptune reset-db-parameter-group $(__NTE_DB_PARAMETER_GROUP_NAME) $(__NTE_PARAMETERS) $(__NTE_RESET_ALL_PARAMETERS__DBPARAMETERGROUP)

_nte_show_dbparametergroup: _nte_show_dbparametergroup_description

_nte_show_dbparametergroup_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing DB-parameter-group "$(NTE_DBPARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) neptune describe-db-parameter-groups $(__NTE_DB_PARAMETER_GROUP_NAME) $(_X__NTE_FILTERS__DBPARAMETERGROUP)

_nte_view_dbparametergroups:
	@$(INFO) '$(AWS_UI_LABEL)Viewing DB-parameter-groups ...'; $(NORMAL)
	$(AWS) neptune describe-db-parameter-groups $(_X__NTE_DB_PARAMETER_GROUP_NAME) $(_X__NTE_FILTERS__DBPARAMETERGROUP) --query "DBClusterParameterGroups[]$(NTE_UI_VIEW_DBPARAMETERGROUPS_FIELDS)"

_nte_view_dbparametergroups_set:
