_AWS_NEPTUNE_DBCLUSTERPARAMETERGROUP_MK_VERSION= $(_AWS_NEPTUNE_MK_VERSION)

# NTE_DBCLUSTERPARAMETERGROUP_DESCRIPTION?= "This is my parameter-group description"
# NTE_DBCLUSTERPARAMETERGROUP_FAMILY?= aurora-mysql5.7
# NTE_DBCLUSTERPARAMETERGROUP_NAME?= my-parameter-group-name
# NTE_DBCLUSTERPARAMETERGROUP_PARAMETERS?= ParameterName=string,ParameterValue=string,Description=string,Source=string,ApplyType=string,DataType=string,AllowedValues=string,IsModifiable=boolean,MinimumEngineVersion=string,ApplyMethod=string ...
# NTE_DBCLUSTERPARAMETERGROUP_PARAMETERS_FILEPATH?= ./cluster-parameters.json
# NTE_DBCLUSTERPARAMETERGROUP_TAGS?= Key=string,Value=string ...

# Derived parameters
NTE_DBCLUSTERPARAMETERGROUP_PARAMETERS?= $(if $(NTE_DBCLUSTERPARAMETERGROUP_PARAMETERS_FILEPATH), file://$(NTE_DBCLUSTERPARAMETERGROUP_PARAMETERS_FILEPATH))

# Options parameters
__NTE_DB_CLUSTER_PARAMETER_GROUP_NAME= $(if $(NTE_DBCLUSTERPARAMETERGROUP_NAME), --db-cluster-parameter-group-name $(NTE_DBCLUSTERPARAMETERGROUP_NAME))
__NTE_DB_PARAMETER_GROUP_FAMILY= $(if $(NTE_DBCLUSTERPARAMETERGROUP_FAMILY), --db-parameter-group-family $(NTE_DBCLUSTERPARAMETERGROUP_FAMILY))
__NTE_DESCRIPTION__DBCLUSTERPARAMETERGROUP= $(if $(NTE_DBCLUSTERPARAMETERGROUP_DESCRIPTION), --description $(NTE_DBCLUSTERPARAMETERGROUP_DESCRIPTION))
__NTE_FILTERS__DBLUSTERPARAMETERGROUP=
__NTE_PARAMETERS__DBCLUSTERPARAMETERGROUP= $(if $(NTE_DBCLUSTERPARAMETERGROUP_PARAMETERS), --parameters $(NTE_DBCLUSTERPARAMETERGROUP_PARAMETERS))
__NTE_RESET_ALL_PARAMETERS__DBCLUSTERPARAMETERGROUP=
__NTE_TAGS__DBCLUSTERPARAMETERGROUP= $(if $(NTE_DBCLUSTERPARAMETERGROUP_TAGS), --tags $(NTE_DBCLUSTERPARAMETERGROUP_TAGS))

# UI parameters
NTE_UI_VIEW_DBCLUSTERPARAMETERGROUPS_FIELDS?= .{DBClusterParameterGroupName:DBClusterParameterGroupName,dbParameterGroupFamily:DBParameterGroupFamily,description:Description}

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_nte_view_framework_macros ::
	@#echo 'AWS::NepTunE::DbClusterParameterGroup ($(_AWS_NEPTUNE_DBCLUSTERPARAMETERGROUP_MK_VERSION)) macros:'
	@#echo

_nte_view_framework_parameters ::
	@echo 'AWS::NepTunE::DbClusterParameterGroup ($(_AWS_NEPTUNE_DBCLUSTERPARAMETERGROUP_MK_VERSION)) parameters:'
	@echo '    NTE_DBCLUSTERPARAMETERGROUP_DESCRIPTION=$(NTE_DBCLUSTERPARAMETERGROUP_DESCRIPTION)'
	@echo '    NTE_DBCLUSTERPARAMETERGROUP_FAMILY=$(NTE_DBCLUSTERPARAMETERGROUP_FAMILY)'
	@echo '    NTE_DBCLUSTERPARAMETERGROUP_NAME=$(NTE_DBCLUSTERPARAMETERGROUP_NAME)'
	@echo '    NTE_DBCLUSTERPARAMETERGROUP_PARAMETERS=$(NTE_DBCLUSTERPARAMETERGROUP_PARAMETERS)'
	@echo '    NTE_DBCLUSTERPARAMETERGROUP_PARAMETERS_FILEPATH=$(NTE_DBCLUSTERPARAMETERGROUP_PARAMETERS_FILEPATH)'
	@echo

_nte_view_framework_targets ::
	@echo 'AWS::NepTunE::DbClusterParameterGroup ($(_AWS_NEPTUNE_DBCLUSTERPARAMETERGROUP_MK_VERSION)) targets:'
	@echo '    _nte_create_dbclusterparametergroup                      - Create a db-cluster-parameter-group'
	@echo '    _nte_delete_dbclusterparametergroup                      - Delete a db-cluster-parameter-group'
	@echo '    _nte_reset_dbclusterparametergroup                       - Reset a db-cluster-parameter-group'
	@echo '    _nte_show_dbclusterparametergroup                        - Show a db-cluster-parameter-group'
	@echo '    _nte_view_dbclusterparametergroups                       - View db db-cluster-parameter-groups'
	@echo '    _nte_view_dbclusterparametergroups_set                   - View a set of db-cluster-parameter-groups'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_nte_create_dbclusterparametergroup:
	@$(INFO) '$(NTE_UI_LABEL)Creating DB cluster parameter-group "$(NTE_DBCLUSTERPARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) neptune create-db-cluster-parameter-group $(__NTE_DB_CLUSTER_PARAMETER_GROUP_NAME) $(__NTE_DB_PARAMETER_GROUP_FAMILY) $(__NTE_DESCRIPTION__DBCLUSTERPARAMETERGROUP) $(__NTE_TAGS__DBCLUSTERPARAMETERGROUP)

_nte_delete_dbclusterparametergroup:
	@$(INFO) '$(NTE_UI_LABEL)Deleting DB cluster parameter-group "$(NTE_DBCLUSTERPARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) neptune delete-db-cluster-parameter-group $(__NTE_DB_CLUSTER_PARAMETER_GROUP_NAME)

_nte_reset_dbclusterparametergroup:
	@$(INFO) '$(NTE_UI_LABEL)Reseting DB cluster parameter-group "$(NTE_DBCLUSTERPARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(if $(NTE_DBCLUSTERPARAMETERGROUP_PARAMETERS_FILEPATH), cat $(NTE_DBCLUSTERPARAMETERGROUP_PARAMETERS_FILEPATH))
	$(AWS) neptune reset-db-cluster-parameter-group $(__NTE_DB_CLUSTER_PARAMETER_GROUP_NAME) $(__NTE_PARAMETERS__DBCLUSTERPARAMETERGROUP) $(__NTE_RESET_ALL_PARAMETERS__DBCLUSTERPARAMETERGROUP)

_nte_show_dbclusterparametergroup: _nte_show_dbclusterparametergroup_description

_nte_show_dbclusterparametergroup_description:
	@$(INFO) '$(NTE_UI_LABEL)Showing DB cluster parameter-group "$(NTE_DBCLUSTERPARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) neptune describe-db-cluster-parameter-groups $(__NTE_DB_CLUSTER_PARAMETER_GROUP_NAME) $(_X__NTE_FILTERS__DBCLUSTERPARAMETERGROUP) --query "DBClusterParameterGroups[]"

_nte_view_dbclusterparametergroups:
	@$(INFO) '$(NTE_UI_LABEL)Viewing DB cluster parameter-groups ...'; $(NORMAL)
	$(AWS) neptune describe-db-cluster-parameter-groups $(_X__NTE_DB_CLUSTER_PARAMETER_GROUP_NAME) $(_X__NTE_FILTERS__DBCLUSTERPARAMETERGROUP) --query "DBClusterParameterGroups[]$(NTE_UI_VIEW_DBCLUSTERPARAMETERGROUPS_FIELDS)"

_nte_view_dbclusterparametergroups_set:
