_AWS_RDS_DBCLUSTERPARAMETERGROUP_MK_VERSION= $(_AWS_RDS_MK_VERSION)

# RDS_DBCLUSTERPARAMETERGROUP_DESCRIPTION?= "This is my parameter-group description"
# RDS_DBCLUSTERPARAMETERGROUP_FAMILY?= aurora-mysql5.7
# RDS_DBCLUSTERPARAMETERGROUP_NAME?= my-parameter-group-name
# RDS_DBCLUSTERPARAMETERGROUP_PARAMETERS?= ParameterName=string,ParameterValue=string,Description=string,Source=string,ApplyType=string,DataType=string,AllowedValues=string,IsModifiable=boolean,MinimumEngineVersion=string,ApplyMethod=string ...
# RDS_DBCLUSTERPARAMETERGROUP_PARAMETERS_FILEPATH?= ./cluster-parameters.json
# RDS_DBCLUSTERPARAMETERGROUP_TAGS?= Key=string,Value=string ...

# Derived variables
RDS_DBCLUSTERPARAMETERGROUP_PARAMETERS?= $(if $(RDS_DBCLUSTERPARAMETERGROUP_PARAMETERS_FILEPATH), file://$(RDS_DBCLUSTERPARAMETERGROUP_PARAMETERS_FILEPATH))

# Options variables
__RDS_DB_CLUSTER_PARAMETER_GROUP_NAME= $(if $(RDS_DBCLUSTERPARAMETERGROUP_NAME), --db-cluster-parameter-group-name $(RDS_DBCLUSTERPARAMETERGROUP_NAME))
__RDS_DB_PARAMETER_GROUP_FAMILY= $(if $(RDS_DBCLUSTERPARAMETERGROUP_FAMILY), --db-parameter-group-family $(RDS_DBCLUSTERPARAMETERGROUP_FAMILY))
__RDS_DESCRIPTION_PARAMETERGROUP= $(if $(RDS_DBCLUSTERPARAMETERGROUP_DESCRIPTION), --description $(RDS_DBCLUSTERPARAMETERGROUP_DESCRIPTION))
__RDS_PARAMETERS= $(if $(RDS_DBCLUSTERPARAMETERGROUP_PARAMETERS), --parameters $(RDS_DBCLUSTERPARAMETERGROUP_PARAMETERS))
__RDS_TAGS_PARAMETERGROUP= $(if $(RDS_DBCLUSTERPARAMETERGROUP_TAGS), --tags $(RDS_DBCLUSTERPARAMETERGROUP_TAGS))

# UI variables
RDS_UI_VIEW_DBCLUSTERPARAMETERGROUPS_FIELDS?= .{DBClusterParameterGroupName:DBClusterParameterGroupName,dbParameterGroupFamily:DBParameterGroupFamily,description:Description}

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_rds_view_makefile_macros ::
	@#echo 'AWS::RDS::DbClusterParameterGroup ($(_AWS_RDS_DBCLUSTERPARAMETERGROUP_MK_VERSION)) macros:'
	@#echo

_rds_view_makefile_targets ::
	@echo 'AWS::RDS::DbClusterParameterGroup ($(_AWS_RDS_DBCLUSTERPARAMETERGROUP_MK_VERSION)) targets:'
	@echo '    _rds_create_dbclusterparametergroup                      - Create a db-cluster-parameter-group'
	@echo '    _rds_delete_dbclusterparametergroup                      - Delete a db-cluster-parameter-group'
	@echo '    _rds_reset_dbclusterparametergroup                       - Reset a db-cluster-parameter-group'
	@echo '    _rds_show_dbclusterparametergroup                        - Show a db-cluster-parameter-group'
	@echo '    _rds_view_dbclusterparametergroups                       - View db db-cluster-parameter-groups'
	@echo '    _rds_view_dbclusterparametergroups_set                   - View a set of db-cluster-parameter-groups'
	@echo

_rds_view_makefile_variables ::
	@echo 'AWS::RDS::DbClusterParameterGroup ($(_AWS_RDS_DBCLUSTERPARAMETERGROUP_MK_VERSION)) variables:'
	@echo '    RDS_DBCLUSTERPARAMETERGROUP_DESCRIPTION=$(RDS_DBCLUSTERPARAMETERGROUP_DESCRIPTION)'
	@echo '    RDS_DBCLUSTERPARAMETERGROUP_FAMILY=$(RDS_DBCLUSTERPARAMETERGROUP_FAMILY)'
	@echo '    RDS_DBCLUSTERPARAMETERGROUP_NAME=$(RDS_DBCLUSTERPARAMETERGROUP_NAME)'
	@echo '    RDS_DBCLUSTERPARAMETERGROUP_PARAMETERS=$(RDS_DBCLUSTERPARAMETERGROUP_PARAMETERS)'
	@echo '    RDS_DBCLUSTERPARAMETERGROUP_PARAMETERS_FILEPATH=$(RDS_DBCLUSTERPARAMETERGROUP_PARAMETERS_FILEPATH)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_rds_create_dbclusterparametergroup:
	@$(INFO) '$(AWS_UI_LABEL)Creating DB cluster parameter-group "$(RDS_DBCLUSTERPARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) rds create-db-cluster-parameter-group $(__RDS_DB_CLUSTER_PARAMETER_GROUP_NAME) $(__RDS_DB_PARAMETER_GROUP_FAMILY) $(__RDS_DESCRIPTION_PARAMETERGROUP) $(__RDS_TAGS_PARAMETERGROUP)

_rds_delete_dbclusterparametergroup:
	@$(INFO) '$(AWS_UI_LABEL)Deleting DB cluster parameter-group "$(RDS_DBCLUSTERPARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) rds delete-db-cluster-parameter-group $(__RDS_DB_CLUSTER_PARAMETER_GROUP_NAME)

_rds_reset_dbclusterparametergroup:
	@$(INFO) '$(AWS_UI_LABEL)Reseting DB cluster parameter-group "$(RDS_DBCLUSTERPARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(if $(RDS_DBCLUSTERPARAMETERGROUP_PARAMETERS_FILEPATH), cat $(RDS_DBCLUSTERPARAMETERGROUP_PARAMETERS_FILEPATH))
	$(AWS) rds reset-db-cluster-parameter-group $(__RDS_DB_CLUSTER_PARAMETER_GROUP_NAME) $(__RDS_PARAMETERS) $(__RDS_RESET_ALL_PARAMETERS)

_rds_show_dbclusterparametergroup:
	@$(INFO) '$(AWS_UI_LABEL)Showing DB cluster parameter-group "$(RDS_DBCLUSTERPARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) rds describe-db-cluster-parameter-groups $(__RDS_DB_CLUSTER_PARAMETER_GROUP_NAME) $(_X__RDS_FILTERS_PARAMETERGROUP)

_rds_view_dbclusterparametergroups:
	@$(INFO) '$(AWS_UI_LABEL)Viewing DB cluster parameter-groups ...'; $(NORMAL)
	$(AWS) rds describe-db-cluster-parameter-groups $(_X__RDS_DB_CLUSTER_PARAMETER_GROUP_NAME) $(_X__RDS_FILTERS_PARAMETERGROUP) --query "DBClusterParameterGroups[]$(RDS_UI_VIEW_DBCLUSTERPARAMETERGROUPS_FIELDS)"

_rds_view_dbclusterparametergroups_set:
