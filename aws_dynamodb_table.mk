_AWS_DYNAMODB_TABLE_MK_VERSION= $(_AWS_DYNAMODB_MK_VERSION)

# DDB_TABLE_ARN?=
# DDB_TABLE_ATTRIBUTEDEFINITIONS_NAMETYPES?= AttributeName=Artist,AttributeType=S AttributeName=SongTitle,AttributeType=S
# DDB_TABLE_BACKUP_ARN?=
# DDB_TABLE_CONSISTENTREAD_FLAG?= true
# DDB_TABLE_EXPRESSIONATTRIBUTE_NAMES=
# DDB_TABLE_EXPRESSIONATTRIBUTE_VALUES=
# DDB_TABLE_FILTER_EXPRESSION?= contains(info.genres,:gen)
# DDB_TABLE_GLOBALSECONDARYINDEXES_CONFIG?= IndexName=string,KeySchema=[{AttributeName=string,KeyType=string},{AttributeName=string,KeyType=string}],Projection={ProjectionType=string,NonKeyAttributes=[string,string]},ProvisionedThroughput={ReadCapacityUnits=long,WriteCapacityUnits=long} ...
# DDB_TABLE_KEYCONDITIONEXPRESSION?= "Artist = :artist and begin_with(SongTitle, :beg_song)"
# DDB_TABLE_KEYSCHEMA_NAMETYPES?= AttributeName=Artist,KeyType=HASH AttributeName=SongTitle,KeyType=RANGE
# DDB_TABLE_LOCALSECONDARYINDEXES_CONFIG= IndexName=string,KeySchema=[{AttributeName=string,KeyType=string},{AttributeName=string,KeyType=string}],Projection={ProjectionType=string,NonKeyAttributes=[string,string]} ...
# DDB_TABLE_NAME?= MusicCollection
# DDB_TABLE_PROJECTION_EXPRESSION?=
# DDB_TABLE_PROVISIONEDTHROUGHPUT_CONFIG?= ReadCapacityUnits=5,WriteCapacityUnits=5
# DDB_TABLE_SELECT?= ALL_ATTRIBUTES
# DDB_TABLE_SSE_SPECIFICATION?= Enabled=true
# DDB_TABLE_STREAMSPECIFICATION_CONFIG?= StreamEnabled=true,StreamViewType=NEW_AND_OLD_IMAGES
# DDB_TABLE_TAGS_KEYS?= OwnedBy DeployedBy
# DDB_TABLE_TAGS_KEYVALUES?= Key=OwnedBy,Value='Emmanuel Mayssat' Key=DeployedBy,Value='Emmanuel Mayssat'

# Derived
DDB_TABLE_ARN?= $(if $(DDB_TABLE_NAME),arn:aws:dynamodb:$(DDB_REGION_ID):$(DDB_ACCOUNT_ID):table/$(DDB_TABLE_NAME))

# Options
__DDB_ATTRIBUTE_DEFINITIONS= $(if $(DDB_TABLE_ATTRIBUTEDEFINITIONS_NAMETYPES),--attribute-definitions $(DDB_TABLE_ATTRIBUTEDEFINITIONS_NAMETYPES))
__DDB_ATTRIBUTES_TO_GET=
__DDB_BACKUP_ARN__TABLE= $(if $(DDB_TABLE_BACKUP_ARN),--backup-arn $(DDB_TABLE_BACKUP_ARN))
__DDB_BILLING_MODE=
__DDB_CONDITIONAL_OPERATOR=
__DDB_CONSISTENT_READ= $(if $(filter true, $(DDB_TABLE_CONSISTENTREAD)),--consistent-read, --no-consistent-read)
__DDB_EXPRESSION_ATTRIBUTE_NAMES= $(if $(DDB_TABLE_EXPRESSIONATTRIBUTE_NAMES),--expression-attribute-names $(DDB_TABLE_EXPRESSIONATTRIBUTE_NAMES))
__DDB_EXPRESSION_ATTRIBUTE_VALUES= $(if $(DDB_TABLE_EXPRESSIONATTRIBUTE_VALUES),--expression-attribute-values $(DDB_TABLE_EXPRESSIONATTRIBUTE_VALUES))
__DDB_FILTER_EXPRESSION= $(if $(DDB_TABLE_FILTER_EXPRESSION), --filter-expression $(DDB_TABLE_FILTER_EXPRESSION))
__DDB_GLOBAL_SECONDARY_INDEXES= $(if $(DDB_TABLE_GLOBALSECONDARYINDEXES_CONFIG),--global-secondary-indexes $(DDB_TABLE_GLOBALSECONDARYINDEXES_CONFIG))
__DDB_INDEX_NAME=
__DDB_KEY_CONDITIONS=
__DDB_KEY_CONDITION_EXPRESSION= $(if $(DDB_TABLE_KEYCONDITIONEXPRESSION),--key-condition-expression $(DDB_TABLE_KEYCONDITIONEXPRESSION))
__DDB_KEY_SCHEMA= $(if $(DDB_TABLE_KEYSCHEMA_NAMETYPES),--key-schema $(DDB_TABLE_KEYSCHEMA_NAMETYPES))
__DDB_LOCAL_SECONDARY_INDEXES= $(if $(DDB_TABLE_LOCALSECONDARYINDEXES_CONFIG),--local-secondary-indexes $(DDB_TABLE_LOCALSECONDARYINDEXES_CONFIG))
__DDB_PAGE_SIZE= $(if $(DDB_PAGE_SIZE), --page-size $(DDB_PAGE_SIZE))
__DDB_PROJECTION_EXPRESSION= $(if $(DDB_TABLE_PROJECTION_EXPRESSION),--projection-expression $(DDB_TABLE_PROJECTION_EXPRESSION))
__DDB_PROVISIONED_THROUGHPUT= $(if $(DDB_TABLE_PROVISIONEDTHROUGHPUT_CONFIG),--provisioned-throughput $(DDB_TABLE_PROVISIONEDTHROUGHPUT_CONFIG))
__DDB_PAGE_SIZE=
__DDB_POINT_IN_TIME_RECOVERY_SPECIFICATION=
__DDB_QUERY_FILTER=
__DDB_RESOURCE_ARN__TABLE= $(if $(DDB_TABLE_ARN),--resource-arn $(DDB_TABLE_ARN))
__DDB_RETURN_CONSUMED_CAPACITY__TABLE=
__DDB_SCAN_FILTER=
__DDB_SCAN_INDEX_FORWARD=
__DDB_SEGMENT=
__DDB_SELECT= $(if $(DDB_TABLE_SELECT), --select $(DDB_TABLE_SELECT))
__DDB_SSE_SPECIFICATION= $(if $(DDB_TABLE_SSE_SPECIFICATION), --sse-specification $(DDB_TABLE_SSE_SPECIFICATION))
__DDB_STREAM_SPECIFICATION= $(if $(DDB_TABLE_STREAMSPECIFICATION_CONFIG), --stream-specification $(DDB_TABLE_STREAMSPECIFICATION_CONFIG))
__DDB_TABLE_NAME= $(if $(DDB_TABLE_NAME), --table-name $(DDB_TABLE_NAME))
__DDB_TAG_KEYS__TABLE= $(if $(DDB_TABLE_TAGS_KEYS),--tag-keys $(DDB_TABLE_TAGS_KEYS))
__DDB_TAGS__TABLE= $(if $(DDB_TABLE_TAGS_KEYVALUES),--tags $(DDB_TABLE_TAGS_KEYVALUES))
__DDB_TARGET_TABLE_NAME= $(if $(DDB_TABLE_NAME),--target-table-name $(DDB_TABLE_NAME))
__DDB_TOTAL_SEGMENTS=


# UI variables
DDB_UI_SCAN_TABLE_FIELDS?=
DDB_UI_VIEW_TABLES_FIELDS?=
DDB_UI_VIEW_TABLES_SET_FIELDS?= $(DDB_UI_VIEW_TABLES_FIELDS)
DDB_UI_VIEW_TABLES_SET_QUERYFILTER?=

#--- Utilities

#--- MACROS

# _ddb_get_table_names_N=$(shell $(AWS) dynamodb list-tables --query "TableNames[?contains(@,'$(strip $(1))-')||@=='$(strip $(1))']" --output=text)

# _ddb_get_table_name_N=$(call get_table_name_NI, $(1), 0)
# _ddb_get_table_name_NI=$(call get_table_name_NIR, $(1), $(2), $(AWS_REGION))
# _ddb_get_table_name_NR=$(call get_table_name_NIR, $(1), 0, $(2))
# _ddb_get_table_name_NIR=$(shell $(AWS) --region $(3) dynamodb list-tables --query "TableNames[?contains(@,'$(strip $(1))-')||@=='$(strip $(1))'] | [$(strip $(2))]" --output=text)

#----------------------------------------------------------------------
# USAGE
#

_ddb_view_framework_macros ::
	@echo 'AWS::DynamoDB::Table ($(_AWS_DYNAMODB_TABLE_MK_VERSION)) macros:'
	@# echo '    _ddb_get_table_names_{|N}          - Get table names (N?)'
	@# echo '    _ddb_get_table_name_{N|NI|NR|NIR}  - Get a table name (Name, Index, Region)'
	@echo

_ddb_view_framework_parameters ::
	@echo 'AWS::DynamoDB::Table ($(_AWS_DYNAMODB_TABLE_MK_VERSION)) parameters:'
	@echo '    DDB_TABLE_ARN=$(DDB_TABLE_ARN)'
	@echo '    DDB_TABLE_ATTRIBUTEDEFINITIONS_NAMETYPES=$(DDB_TABLE_ATTRIBUTEDEFINITIONS_NAMETYPES)'
	@echo '    DDB_TABLE_BACKUP_ARN=$(DDB_TABLE_BACKUP_ARN)'
	@echo '    DDB_TABLE_CONSISTENTREAD_FLAG=$(DDB_TABLE_CONSISTENTREAD_FLAG)'
	@echo '    DDB_TABLE_EXPRESSIONATTRIBUTE_NAME=$(DDB_TABLE_EXPRESSIONATTRIBUTE_NAME)'
	@echo '    DDB_TABLE_EXPRESSIONATTRIBUTE_VALUE=$(DDB_TABLE_EXPRESSIONATTRIBUTE_VALUE)'
	@echo '    DDB_TABLE_FILTER_EXPRESSION=$(DDB_TABLE_FILTER_EXPRESSION)'
	@echo '    DDB_TABLE_GLOBAL_SECONDARY_INDEXES=$(DDB_TABLE_GLOBAL_SECONDARY_INDEXES)'
	@echo '    DDB_TABLE_KEYCONDITIONEXPRESSION=$(DDB_KEY_CONDITION_EXPRESSION)'
	@echo '    DDB_TABLE_KEYSCHEMA_NAMETYPES=$(DDB_TABLE_KEYSCHEMA_NAMETYPES)'
	@echo '    DDB_TABLE_LOCALSECONDARYINDEXES_CONFIG=$(DDB_TABLE_LOCALSECONDARYINDEXES_CONFIG)'
	@echo '    DDB_TABLE_NAME=$(DDB_TABLE_NAME)'
	@echo '    DDB_TABLE_PROJECTION_EXPRESSION=$(DDB_TABLE_PROJECTION_EXPRESSION)'
	@echo '    DDB_TABLE_PROVISIONEDTHROUGHPUT_CONFIG=$(DDB_TABLE_PROVISIONEDTHROUGHPUT_CONFIG)'
	@echo '    DDB_TABLE_SSE_SPECIFICATION=$(DDB_TABLE_SSE_SPECIFICATION)'
	@echo '    DDB_TABLE_STREAMSPECIFICATION_CONFIG=$(DDB_TABLE_STREAMSPECIFICATION_CONFIG)'
	@echo '    DDB_TABLE_TAGS_KEYS=$(DDB_TABLE_TAGS_KEYS)'
	@echo '    DDB_TABLE_TAGS_KEYVALUES=$(DDB_TABLE_TAGS_KEYVALUES)'
	@echo '    DDB_TABLES_SET_NAME=$(DDB_TABLES_SET_NAME)'
	@echo

_ddb_view_framework_targets ::
	@echo 'AWS::DynamoDB::Table ($(_AWS_DYNAMODB_TABLE_MK_VERSION)) targets:'
	@echo '    _ddb_create_table                 - Create a table'
	@echo '    _ddb_delete_table                 - Delete a table'
	@echo '    _ddb_disable_table_ttl            - Disable TTL-honoring for a table'
	@echo '    _ddb_enable_table_ttl             - Enable TTL-honoring for a table'
	@echo '    _ddb_query_table                  - Query a table from items'
	@echo '    _ddb_restore_table                - Restore a table'
	@echo '    _ddb_scan_table                   - Scan a whole table'
	@echo '    _ddb_show_table                   - Show details of a table'
	@echo '    _ddb_show_table_backupsettingis   - Show backup-settings of a table'
	@echo '    _ddb_show_table_description       - Show description of a table'
	@echo '    _ddb_show_table_itemttl           - Show item-TTL of a table'
	@echo '    _ddb_show_table_tags              - Show tags of a table'
	@echo '    _ddb_tag_table                    - Tag a table'
	@echo '    _ddb_untag_table                  - Untag a table'
	@echo '    _ddb_update_table_backupsettings  - Untag a table'
	@echo '    _ddb_view_tables                  - View tables'
	@echo '    _ddb_view_tables_set              - View set of tables'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ddb_create_table:
	@$(INFO) '$(DDB_UI_LABEL)Creating table "$(DDB_TABLE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This opeation fails if the table already exists'; $(NORMAL)
	$(AWS) dynamodb create-table $(strip $(__DDB_ATTRIBUTE_DEFINITIONS) $(__DDB_BILLING_MODE) $(__DDB_GLOBAL_SECONDARY_INDEXES) $(__DDB_KEY_SCHEMA) $(__DDB_LOCAL_SECONDARY_INDEXES) $(__DDB_PROVISIONED_THROUGHPUT) $(__DDB_SSE_SPECIFICATION) $(__DDB_STREAM_SPECIFICATION) $(__DDB_TABLE_NAME) $(__DDB_TAGS__TABLE)) --query "TableDescription"

_ddb_delete_table:
	@$(INFO) '$(DDB_UI_LABEL)Delete dynamodb table "$(DDB_TABLE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This opeation fails if the table does NOT already exist'; $(NORMAL)
	-$(AWS) dynamodb delete-table $(__DDB_TABLE_NAME) --query "TableDescription"

_ddb_disable_table_itemttl:
	@$(INFO) '$(DDB_UI_LABEL)Disabling item-TTL in table "$(DDB_TABLE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if TTL-honoring is already disabled or has just recently been enabled'; $(NORMAL)
	-$(AWS) dynamodb update-time-to-live $(__DDB_TABLE_NAME) --time-to-live-specification Enabled=false,AttributeName=ttl

_ddb_enable_table_itemttl:
	@$(INFO) '$(DDB_UI_LABEL)Enabling item-TTL in table "$(DDB_TABLE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if TTL-honoring is already enabled or has just recently been disabled'; $(NORMAL)
	-$(AWS) dynamodb update-time-to-live $(__DDB_TABLE_NAME) --time-to-live-specification Enabled=true,AttributeName=ttl --query "TimeToLiveSpecification"

_ddb_query_table:
	@$(INFO) '$(DDB_UI_LABEL)Querying dynamodb table "$(DDB_TABLE_NAME)" ...'; $(NORMAL)
	$(AWS) dynamodb query $(strip $(__DDB_ATTRIBUTES_TO_GET) $(__DDB_CONDITIONAL_OPERATOR) $(__DDB_CONSISTENT_READ) $(__DDB_EXPRESSION_ATTRIBUTE_NAMES) $(__DDB_EXPRESSION_ATTRIBUTE_VALUES) $(__DDB_FILTER_EXPRESSION) $(__DDB_KEY_CONDITION_EXPRESSION) $(__DDB_KEY_CONDITIONS) $(__DDB_INDEX_NAME) $(__DDB_PAGE_SIZE) $(__DDB_PROJECTION_EXPRESSION) $(__DDB_QUERY_FILTER) $(__DDB_RETURN_CONSUMED_CAPACITY__TABLE) $(__DDB_SCAN_INDEX_FORWARD) $(__DDB_SELECT) $(__DDB_TABLE_NAME))

_ddb_restore_table:
	@$(INFO) '$(DDB_UI_LABEL)Restoring table "$(DDB_TABLE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation cannot restore a backup in an existing table'; $(NORMAL)
	@$(WARN) 'This operation does NOT restore tags, auto scaling & IAM policies, cloudwatch metrics & alarms, stream & Time to live (TTL) settings'; $(NORMAL)
	$(AWS) dynamodb restore-table-from-backup $(__DDB_BACKUP_ARN__TABLE) $(__DDB_TARGET_TABLE_NAME)

_ddb_scan_table:
	@$(INFO) '$(DDB_UI_LABEL)Scaning table "$(DDB_TABLE_NAME)" ...'; $(NORMAL)
	$(AWS) dynamodb scan $(strip $(__DDB_ATTRIBUTES_TO_GET) $(__DDB_CONDITIONAL_OPERATOR) $(__DDB_CONSISTENT_READ) $(__DDB_EXPRESSION_ATTRIBUTE_NAMES) $(__DDB_EXPRESSION_ATTRIBUTE_VALUES) $(__DDB_FILTER_EXPRESSION) $(__DDB_INDEX_NAME) $(__DDB_PAGE_SIZE) $(__DDB_PROJECTION_EXPRESSION) $(__DDB_RETURN_CONSUMED_CAPACITY__TABLE) $(__DDB_SCAN_FILTER) $(__DDB_SEGMENT) $(__DDB_SELECT) $(__DDB_TABLE_NAME) $(__DDB_TOTAL_SEGMENTS)) --query "Items[]$(DDB_UI_SCAN_TABLE_FIELDS)"

_ddb_show_table :: _ddb_show_table_backupsettings _ddb_show_table_itemttl _ddb_show_table_tags _ddb_show_table_description

_ddb_show_table_backupsettings:
	@$(INFO) '$(DDB_UI_LABEL)Showing backup-settings of table "$(DDB_TABLE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If backups are enabled, ContinuousBackupsStatus will bet set to ENABLED'; $(NORMAL)
	$(AWS) dynamodb describe-continuous-backups $(__DDB_TABLE_NAME) --query "ContinuousBackupsDescription"

_ddb_show_table_description:
	@$(INFO) '$(DDB_UI_LABEL)Showing description of table "$(DDB_TABLE_NAME)" ...'; $(NORMAL)
	$(AWS) dynamodb describe-table $(__DDB_TABLE_NAME) --query "Table"

_ddb_show_table_itemttl:
	@$(INFO) '$(DDB_UI_LABEL)Showing item-TTL in table "$(DDB_TABLE_NAME)" ...'; $(NORMAL)
	$(AWS) dynamodb describe-time-to-live $(__DDB_TABLE_NAME) --query "TimeToLiveDescription"


_ddb_show_table_tags:
	@$(INFO) '$(DDB_UI_LABEL)Showing tags of table "$(DDB_TABLE_NAME)" ...'; $(NORMAL)
	$(AWS) dynamodb list-tags-of-resource $(__DDB_RESOURCE_ARN__TABLE) --query "Tags"

_ddb_tag_table:
	@$(INFO) '$(DDB_UI_LABEL)Tagging table "$(DDB_TABLE_NAME)" ...'; $(NORMAL)
	$(AWS) dynamodb tag-resource $(__DDB_RESOURCE_ARN__TABLE) $(__DDB_TAGS__TABLE)

_ddb_untag_table:
	@$(INFO) '$(DDB_UI_LABEL)Untagging table "$(DDB_TABLE_NAME)" ...'; $(NORMAL)
	$(AWS) dynamodb untag-resource $(__DDB_RESOURCE_ARN__TABLE) $(__DDB_TAG_KEYS__TABLE)

_ddb_update_table_backupsettings:
	@$(INFO) '$(DDB_UI_LABEL)Updating backup-settings of table "$(DDB_TABLE_NAME)" ...'; $(NORMAL)
	$(AWS) dynamodb update-continuous-backups $(__DDB_POINT_IN_TIME_RECOVERY_SPECIFICATION) $(__DDB_TABLE_NAME)

_ddb_view_tables:
	@$(INFO) '$(DDB_UI_LABEL)Viewing tables ...'; $(NORMAL)
	$(AWS) dynamodb list-tables --query "TableNames"

_ddb_view_tables_set:
	@$(INFO) '$(DDB_UI_LABEL)Viewing tables-set "$(DDB_TABLES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Tables are grouped based on provided query-filter'; $(NORMAL)
	$(AWS) dynamodb list-tables --query "TableNames"
