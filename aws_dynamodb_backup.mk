_AWS_DYNAMODB_BACKUP_MK_VERSION= $(_AWS_DYNAMODB_MK_VERSION)

# DDB_BACKUP_ARN?=
# DDB_BACKUP_NAME?= my_backup
# DDB_BACKUP_TABLE_NAME?= MusicCollection
# DDB_BACKUP_TAGS_KEYS?= OwnedBy DeployedBy
# DDB_BACKUP_TAGS_KEYVALUES?=
# DDB_BACKUPS_SET_NAME?=
# DDB_BACKUPS_TABLE_NAME?=

# Derived
DDB_BACKUP_TABLE_NAME?= $(DDB_TABLE_NAME)
DDB_BACKUPS_TABLE_NAME?= $(DDB_BACKUP_TABLE_NAME)

# Options
__DDB_BACKUP_ARN= $(if $(DDB_BACKUP_ARN), --backup-arn $(DDB_BACKUP_ARN))
__DDB_BACKUP_NAME= $(if $(DDB_BACKUP_NAME), --backup-name $(DDB_BACKUP_NAME))
__DDB_RESOURCE_ARN__BACKUP= $(if $(DDB_BACKUP_ARN),--resource-arn $(DDB_BACKUP_ARN))
__DDB_TABLE_NAME__BACKUP= $(if $(DDB_BACKUP_TABLE_NAME),--table-name $(DDB_BACKUP_TABLE_NAME))
__DDB_TABLE_NAME__BACKUPS= $(if $(DDB_BACKUPS_TABLE_NAME),--table-name $(DDB_BACKUPS_TABLE_NAME))
__DDB_TAG_KEYS__BACKUP= $(if $(DDB_BACKUP_TAGS_KEYS), --tag-keys $(DDB_BACKUP_TAGS_KEYS))
__DDB_TAGS__BACKUP= $(if $(DDB_BACKUP_TAGS_KEYVALUES), --tags $(DDB_BACKUP_TAGS_KEYVALUES))

# UI variables
DDB_UI_VIEW_BACKUPS_FIELDS?= .{_BackupArn:BackupArn,_BackupStatus:BackupStatus,BackupName:BackupName,BackupCreationDateTime:BackupCreationDateTime,_BackupSizeBytes:BackupSizeBytes}

#--- Utilities

#--- MACROS
# _ddb_get_oldest_backup_arn=$(call _ddb_get_backup_arn_I, 0)
# _ddb_get_newest_backup_arn=$(call _ddb_get_backup_arn_I, -1)
# _ddb_get_backup_arn_I=$(call _ddb_get_backup_arn_TI, $(DDB_TABLE_NAME), $(1))
# _ddb_get_backup_arn_TI=$(shell $(AWS) dynamodb list-backups --table-name $(1)   --query "BackupSummaries[$(strip $(2))].[BackupArn]" --output text)
# 
# _ddb_get_backup_arn=$(call _ddb_get_backup_arn_B, $(DDB_BACKUP_NAME))
# _ddb_get_backup_arn_B=$(call _ddb_get_backup_arn_BT, $(1), $(DDB_TABLE_NAME))
# _ddb_get_backup_arn_BT=$(call _ddb_get_backup_arn_BTI, $(1) , $(2), 0)
# _ddb_get_backup_arn_BTI=$(shell $(AWS) dynamodb list-backups --table-name $(2) --query "BackupSummaries[?BackupName=='$(strip $(1))']|[$(3)].[BackupArn]" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ddb_view_framework_macros ::
	@echo 'AWS::DynamoDB::Backup ($(_AWS_DYNAMODB_BACKUP_MK_VERSION)) macros:'
	# @echo '    _ddb_get_backup_arn_{I|TI}         - Get a backup ARN (TableName, Index)'
	# @echo '    _ddb_get_newest_backup_arn         - Get the newest backup ARN'
	# @echo '    _ddb_get_oldest_backup_arn         - Get the oldest backup ARN'
	@echo

_ddb_view_framework_parameters ::
	@echo 'AWS::DynamoDB::Backup ($(_AWS_DYNAMODB_BACKUP_MK_VERSION)) parameters:'
	@echo '    DDB_BACKUP_ARN=$(DDB_BACKUP_ARN)'
	@echo '    DDB_BACKUP_NAME=$(DDB_BACKUP_NAME)'
	@echo '    DDB_BACKUP_TABLE_NAME=$(DDB_BACKUP_TABLE_NAME)'
	@echo '    DDB_BACKUP_TAGS_KEYS=$(DDB_BACKUP_TAGS_KEYS)'
	@echo '    DDB_BACKUP_TAGS_KEYVALUES=$(DDB_BACKUP_TAGS_KEYVALUES)'
	@echo '    DDB_BACKUPS_SET_NAME=$(DDB_BACKUPS_SET_NAME)'
	@echo '    DDB_BACKUPS_TABLE_NAME=$(DDB_BACKUPS_TABLE_NAME)'
	@echo

_ddb_view_framework_targets ::
	@echo 'AWS::DynamoDB::Backup ($(_AWS_DYNAMODB_BACKUP_MK_VERSION)) targets:'
	@echo '    _ddb_create_backup              - Create a backup of a table'
	@echo '    _ddb_delete_backup              - Delete a backup of a table'
	@echo '    _ddb_show_backup                - Show everything related to a backup'
	@echo '    _ddb_show_backup_description    - Show description of a backup'
	@echo '    _ddb_view_backups               - View backups of a table'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ddb_create_backup:
	@$(INFO) '$(DDB_UI_LABEL)Creating backup "$(DDB_BACKUP_NAME)" ...'; $(NORMAL)
	$(AWS) dynamodb create-backup $(__DDB_BACKUP_NAME) $(__DDB_TABLE_NAME__BACKUP)

_ddb_delete_backup:
	@$(INFO) '$(DDB_UI_LABEL)Deleting a backup "$(DDB_BACKUP_NAME)" ...'; $(NORMAL)
	$(AWS) dynamodb delete-backup $(__DDB_BACKUP_ARN)

_ddb_show_backup: _ddb_show_backup_description

_ddb_show_backup_description:
	@$(INFO) '$(DDB_UI_LABEL)Show description of a backup "$(DDB_BACKUP_NAME)" ...'; $(NORMAL)
	$(AWS) dynamodb describe-backup $(__DDB_BACKUP_ARN)

_ddb_tag_backup:
	@$(INFO) '$(DDB_UI_LABEL)Tagging backup "$(DDB_BACKUP_NAME)" ...'; $(NORMAL)

_ddb_untag_backup:
	@$(INFO) '$(DDB_UI_LABEL)Untagging backup "$(DDB_BACKUP_NAME)" ...'; $(NORMAL)

_ddb_view_backups:
	@$(INFO) '$(DDB_UI_LABEL)Viewing backups of table "$(DDB_BACKUPS_TABLE_NAME)" ...'; $(NORMAL)
	$(AWS) dynamodb list-backups $(__DDB_EXCLUSIVE_START_BACKUP_ARN) $(__DDB_LIMIT) $(__DDB_TABLE_NAME__BACKUP) $(__DDB_TIME_RANGE_LOWER_BOUND) $(__DDB_TIME_RANGE_UPPER_BOUND) --query "BackupSummaries[]$(DDB_UI_VIEW_BACKUPS_FIELDS)"

_ddb_view_backups_set:
	@$(INFO) '$(DDB_UI_LABEL)Viewing backups-set "$(DDB_BACKUPS_SET_NAME)" of table "$(DDB_BACKUPS_TABLE_NAME)" ...'; $(NORMAL)
