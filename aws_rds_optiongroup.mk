_AWS_RDS_OPTIONGROUP_MK_VERSION= $(_AWS_RDS_MK_VERSION)

# RDS_OPTIONGROUP_DESCRIPTION?= "Oracle Database Manager Database Control"
# RDS_OPTIONGROUP_ENGINE_NAME?= oracle
# RDS_OPTIONGROUP_ENGINE_VERSION?= 11.2
# RDS_OPTIONGROUP_NAME?= my-optiongroup-name
# RDS_OPTIONGROUP_TAGS?= Key=string,Value=string ...

# Derived variables

# Options variables
__RDS_ENGINE_NAME_OPTIONGROUP= $(if $(RDS_OPTIONGROUP_ENGINE_NAME), --engine-name $(RDS_OPTIONGROUP_ENGINE_NAME))
__RDS_MAJOR_ENGINE_VERSION= $(if $(RDS_OPTIONGROUP_ENGINE_VERSION), --major-engine-version $(RDS_OPTIONGROUP_ENGINE_VERSION))
__RDS_OPTION_GROUP_DESCRIPTION= $(if $(RDS_OPTIONGROUP_DESCRIPTION), --option-group-description $(RDS_OPTIONGROUP_DESCRIPTION))
__RDS_OPTION_GROUP_NAME= $(if $(RDS_OPTIONGROUP_NAME), --option-group-name $(RDS_OPTIONGROUP_NAME))
__RDS_TAGS_OPTIONGROUP= $(if $(RDS_OPTIONGROUP_TAGS), --tags $(RDS_OPTIONGROUP_TAGS))

# UI variables
RDS_UI_SHOW_OPTIONGROUP_FIELDS?=
RDS_UI_VIEW_OPTIONGROUPS_FIELDS?= .{OptionGroupName:OptionGroupName,engineName:EngineName,majorEngineVersion:MajorEngineVersion,optionGroupDescription:OptionGroupDescription}
RDS_UI_VIEW_OPTIONGROUPS_SET_FIELDS?= $(RDS_UI_VIEW_OPTIONGROUPS_FIELDS)

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_rds_view_makefile_macros ::
	@#echo 'AWS::RDS::OptionGroup ($(_AWS_RDS_OPTIONGROUP_MK_VERSION)) macros:'
	@#echo

_rds_view_makefile_targets ::
	@echo 'AWS::RDS::OptionGroup ($(_AWS_RDS_OPTIONGROUP_MK_VERSION)) targets:'
	@echo '    _rds_create_optiongroup                      - Create a option-group'
	@echo '    _rds_delete_optiongroup                      - Delete a option-group'
	@echo '    _rds_show_optiongroup                        - Show a option-group'
	@echo '    _rds_view_optiongroups                       - View option-groups'
	@echo

_rds_view_makefile_variables ::
	@echo 'AWS::RDS::OptionGroup ($(_AWS_RDS_OPTIONGROUP_MK_VERSION)) variables:'
	@echo '    RDS_OPTIONGROUP_DESCRIPTION=$(RDS_OPTIONGROUP_DESCRIPTION)'
	@echo '    RDS_OPTIONGROUP_ENGINE_NAME=$(RDS_OPTIONGROUP_ENGINE_NAME)'
	@echo '    RDS_OPTIONGROUP_ENGINE_VERSION=$(RDS_OPTIONGROUP_ENGINE_VERSION)'
	@echo '    RDS_OPTIONGROUP_NAME=$(RDS_OPTIONGROUP_NAME)'
	@echo '    RDS_OPTIONGROUP_TAGS=$(RDS_OPTIONGROUP_TAGS)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_rds_create_optiongroup:
	@$(INFO) '$(AWS_UI_LABEL)Creating option-group "$(RDS_OPTIONGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) rds create-option-group $(__RDS_ENGINE_NAME_OPTIONGROUP) $(__RDS_MAJOR_ENGINE_VERSION) $(__RDS_OPTION_GROUP_DESCRIPTION) $(__RDS_OPTION_GROUP_NAME) $(__RDS_TAGS_OPTIONGROUP)

_rds_delete_optiongroup:
	@$(INFO) '$(AWS_UI_LABEL)Deleting option-group "$(RDS_OPTIONGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) rds delete-option-group $(__RDS_OPTION_GROUP_NAME)

_rds_show_optiongroup:
	@$(INFO) '$(AWS_UI_LABEL)Showing option-group "$(RDS_OPTIONGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) rds describe-option-groups $(__RDS_OPTION_GROUP_NAME) $(_X__RDS_FILTERS_OPTIONGROUP) --query "OptionGroupsList[]$(RDS_UI_SHOW_OPTIONGROUP_FIELDS)"

_rds_view_optiongroups:
	@$(INFO) '$(AWS_UI_LABEL)Viewing option-groups ...'; $(NORMAL)
	$(AWS) rds describe-option-groups $(_X__RDS_OPTION_GROUP_NAME) $(_X__RDS_FILTERS_OPTIONGROUP) --query "OptionGroupsList[]$(RDS_UI_VIEW_OPTIONGROUPS_FIELDS)"

_rds_view_optiongroups_set:
