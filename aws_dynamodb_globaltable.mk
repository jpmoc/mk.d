_AWS_DYNAMODB_MK_VERSION=0.99.6

# DDB_BACKUP_NAME?= my_backup
# DDB_CONSISTENT_READ?= true
# DDB_DEBUG_MODE?=true
# DDB_ENDPOINT_URL?= http://localhost:8000
# DBB_EXPRESSION_ATTRIBUTE_NAME?= '{"#p": "pool"}'
# DDB_EXPRESSION_ATTRIBUTE_VALUES?= '{":artist":{"S":"No One You Know"},":beg_song":{"S":"Call M"}}'
# DDB_FILTER_EXPRESSION?= contains(info.genres,:gen)
# DDB_ITEM_FILEPATH?= ./item.json
# DDB_ITEM?= '{"hash":{"S":"xxxx-xxxx-xxxx-xxxx"}, "sort":{"N":"22345678"}, "val":{"S":"2234567890"}}'
# DDB_ITEM_KEY?= file://key.json
# DDB_ITEM_KEY?= '{"hash":{"S":"xxxx-xxxx-xxxx-xxxx"}, "sort":{"N":"12345678"}}'
# DDB_KEY_CONDITION_EXPRESSION?= "Artist = :artist and begin_with(SongTitle, :beg_song)"
DDB_LOCAL_DIR?= $(HOME)/dynamodb
DDB_LOCAL_PORT?= 8080
# DDB_PAGE_SIZE?= 5
# DDB_PROJECTION_EXPRESSION?= SongTitle
# DDB_REQUEST_ITEMS_FILEPATH?= ./updates.json
# DDB_SELECT?= ALL_ATTRIBUTES
# DDB_TABLE_ATTRIBUTE_DEFINITIONS?= AttributeName=Artist,AttributeType=S AttributeName=SongTitle,AttributeType=S
# DDB_TABLE_GLOBAL_SECONDARY_INDEXES?= IndexName=string,KeySchema=[{AttributeName=string,KeyType=string},{AttributeName=string,KeyType=string}],Projection={ProjectionType=string,NonKeyAttributes=[string,string]},ProvisionedThroughput={ReadCapacityUnits=long,WriteCapacityUnits=long} ...
# DDB_TABLE_KEY_SCHEMA?= AttributeName=Artist,KeyType=HASH AttributeName=SongTitle,KeyType=RANGE
# DDB_TABLE_LOCAL_SECONDARY_INDEXES+= IndexName=string,KeySchema=[{AttributeName=string,KeyType=string},{AttributeName=string,KeyType=string}],Projection={ProjectionType=string,NonKeyAttributes=[string,string]} ...
# DDB_TABLE_NAME?= MusicCollection
# DDB_TABLE_PROVISIONED_THROUGHPUT?= ReadCapacityUnits=5,WriteCapacityUnits=5
# DDB_TABLE_SSE_SPECIFICATION?= Enabled=true
# DDB_TABLE_STREAM_SPECIFICATION?= StreamEnabled=true,StreamViewType=NEW_AND_OLD_IMAGES
# DDB_TAG_KEYS?= OwnedBy DeployedBy
# DDB_TAGS?= Key=OwnedBy,Value='Emmanuel Mayssat' Key=DeployedBy,Value='Emmanuel Mayssat'

# Derived
DDB_GLOBAL_TABLE_NAME?= $(DDB_TABLE_NAME)
DDB_GLOBAL_TABLE_REPLICATION_GROUP+= RegionName=$(AWS_REGION)
DDB_ITEM?= $(if $(DDB_ITEM_FILEPATH), file://$(DDB_ITEM_FILEPATH))
DDB_REQUEST_ITEMS?= $(if $(DDB_REQUEST_ITEMS_FILEPATH), file://$(DDB_REQUEST_ITEMS_FILEPATH))
DDB_TABLE_ARN?= arn:aws:dynamodb:$(AWS_REGION):$(AWS_ACCOUNT_ID):table/$(DDB_TABLE_NAME)
DDB_TABLE_TAG_KEYS?= $(DDB_TAG_KEYS)
DDB_TABLE_TAGS?= $(DDB_TAGS)
DDB_TARGET_TABLE_NAME?= $(DDB_TABLE_NAME)_restore

# Options
__DDB_ATTRIBUTE_DEFINITIONS= $(if $(DDB_TABLE_ATTRIBUTE_DEFINITIONS), --attribute-definitions $(DDB_TABLE_ATTRIBUTE_DEFINITIONS))
__DDB_ATTRIBUTES_TO_GET=
__DDB_BACKUP_ARN= $(if $(DDB_BACKUP_ARN), --backup-arn $(DDB_BACKUP_ARN))
__DDB_BACKUP_NAME= $(if $(DDB_BACKUP_NAME), --backup-name $(DDB_BACKUP_NAME))
__DDB_CONDITION_EXPRESSION=
__DDB_CONDITIONAL_OPERATOR=
__DDB_CONSISTENT_READ= $(if $(filter true, $(DDB_CONSISTENT_READ)), --consistent-read, --no-consistent-read)
__DDB_ENDPOINT_URL= $(if $(DDB_ENPOINT_URL), --endpoint-url $(DDB_ENDPOINT_URL))
__DDB_EXCLUSIVE_START_BACKUP_ARN=
__DDB_EXCLUSIVE_START_GLOBAL_TABLE_NAME=
__DDB_EXPECTED=
__DDB_EXPRESSION_ATTRIBUTE_NAMES= $(if $(DDB_EXPRESSION_ATTRIBUTE_NAMES), --expression-attribute-names $(DDB_EXPRESSION_ATTRIBUTE_NAMES))
__DDB_EXPRESSION_ATTRIBUTE_VALUES= $(if $(DDB_EXPRESSION_ATTRIBUTE_VALUES), --expression-attribute-values $(DDB_EXPRESSION_ATTRIBUTE_VALUES))
__DDB_FILTER_EXPRESSION= $(if $(DDB_FILTER_EXPRESSION), --filter-expression '$(DDB_FILTER_EXPRESSION)')
__DDB_GLOBAL_SECONDARY_INDEXES= $(if $(DDB_TABLE_GLOBAL_SECONDARY_INDEXES), --global-secondary-indexes $(DDB_TABLE_GLOBAL_SECONDARY_INDEXES))
__DDB_GLOBAL_TABLE_NAME= $(if $(DDB_TABLE_GLOBAL_TABLE_NAME), --global-table-name $(DDB_TABLE_GLOBAL_TABLE_NAME))
__DDB_INDEX_NAME=
__DDB_ITEM= $(if $(DDB_ITEM), --item $(DDB_ITEM))
__DDB_KEY= $(if $(DDB_ITEM_KEY), --key $(DDB_ITEM_KEY))
__DDB_KEY_CONDITIONS=
__DDB_KEY_CONDITION_EXPRESSION= $(if $(DDB_KEY_CONDITION_EXPRESSION), --key-condition-expression $(DDB_KEY_CONDITION_EXPRESSION))
__DDB_KEY_SCHEMA= $(if $(DDB_TABLE_KEY_SCHEMA), --key-schema $(DDB_TABLE_KEY_SCHEMA))
__DDB_LOCAL_SECONDARY_INDEXES= $(if $(DDB_TABLE_LOCAL_SECONDARY_INDEXES), --local-secondary-indexes $(DDB_TABLE_LOCAL_SECONDARY_INDEXES))
__DDB_PAGE_SIZE= $(if $(DDB_PAGE_SIZE), --page-size $(DDB_PAGE_SIZE))
__DDB_PROJECTION_EXPRESSION= $(if $(DDB_PROJECTION_EXPRESSION), --projection-expression "$(DDB_PROJECTION_EXPRESSION)")
__DDB_PROVISIONED_THROUGHPUT= $(if $(DDB_TABLE_PROVISIONED_THROUGHPUT), --provisioned-throughput $(DDB_TABLE_PROVISIONED_THROUGHPUT))
__DDB_QUERY_FILTER=
__DDB_REGION_NAME=
__DDB_REPLICATION_GROUP= $(if $(DDB_GLOBAL_TABLE_REPLICATION_GROUP), --replication-group $(DDB_GLOBAL_TABLE_REPLICATION_GROUP))
__DDB_REQUEST_ITEMS= $(if $(DDB_REQUEST_ITEMS), --request-items $(DDB_REQUEST_ITEMS))
__DDB_RESOURCE_ARN= $(if $(DDB_RESOURCE_ARN), --resource-arn $(DDB_RESOURCE_ARN))
__DDB_RETURN_CONSUMED_CAPACITY=
__DDB_RETURN_ITEM_COLLECTION_METRICS=
__DDB_RETURN_VALUES=
__DDB_SCAN_FILTER=
__DDB_SCAN_INDEX_FORWARD=
__DDB_SEGMENT=
__DDB_SELECT= $(if $(DDB_SELECT), --select $(DDB_SELECT))
__DDB_SSE_SPECIFICATION= $(if $(DDB_TABLE_SSE_SPECIFICATION), --sse-specification $(DDB_TABLE_SSE_SPECIFICATION))
__DDB_STREAM_SPECIFICATION= $(if $(DDB_TABLE_STREAM_SPECIFICATION), --stream-specification $(DDB_TABLE_STREAM_SPECIFICATION))
__DDB_TABLE_NAME= $(if $(DDB_TABLE_NAME), --table-name $(DDB_TABLE_NAME))
__DDB_TAG_KEYS= $(if $(DDB_TAG_KEYS), --tag-keys $(DDB_TAG_KEYS))
__DDB_TAGS= $(if $(DDB_TAGS), --tags $(DDB_TAGS))
__DDB_TARGET_TABLE_NAME= $(if $(DDB_TARGET_TABLE_NAME), --target-table-name $(DDB_TARGET_TABLE_NAME))
__DDB_TIME_RANGE_LOWER_BOUND=
__DDB_TIME_RANGE_UPPER_BOUND=
__DDB_TIME_TO_LIVE_SPECIFICATION= $(if $(DDB_TABLE_TTL), --time-to-live-specification $(DDB_TABLE_TTL))
__DDB_TOTAL_SEGMENTS=


# UI variables
DDB_UI_SHOW_TABLE_FIELDS?=
DDB_UI_VIEW_BACKUPS_FIELDS?=.{_BackupArn:BackupArn,_BackupStatus:BackupStatus,BackupName:BackupName,BackupCreationDateTime:BackupCreationDateTime,_BackupSizeBytes:BackupSizeBytes}
DDB_UI_VIEW_ITEMS_FIELDS?=.[pool.S, address.S]

#--- Utilities
__DYNAMODB_OPTIONS+= -port $(DDB_LOCAL_PORT)
DYNAMODB_BIN?= java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar
DYNAMODB?=$(__DYNAMODB_ENVIRONMENT) $(DYNAMODB_ENVIRONMENT) $(DYNAMODB_BIN) $(__DYNAMODB_OPTIONS) $(DYNAMODB_OPTIONS)

#--- MACROS
_ddb_get_oldest_backup_arn=$(call _ddb_get_backup_arn_I, 0)
_ddb_get_newest_backup_arn=$(call _ddb_get_backup_arn_I, -1)
_ddb_get_backup_arn_I=$(call _ddb_get_backup_arn_TI, $(DDB_TABLE_NAME), $(1))
_ddb_get_backup_arn_TI=$(shell $(AWS) dynamodb list-backups --table-name $(1)   --query "BackupSummaries[$(strip $(2))].[BackupArn]" --output text)

_ddb_get_backup_arn=$(call _ddb_get_backup_arn_B, $(DDB_BACKUP_NAME))
_ddb_get_backup_arn_B=$(call _ddb_get_backup_arn_BT, $(1), $(DDB_TABLE_NAME))
_ddb_get_backup_arn_BT=$(call _ddb_get_backup_arn_BTI, $(1) , $(2), 0)
_ddb_get_backup_arn_BTI=$(shell $(AWS) dynamodb list-backups --table-name $(2) --query "BackupSummaries[?BackupName=='$(strip $(1))']|[$(3)].[BackupArn]" --output text)

_ddb_get_table_names_N=$(shell $(AWS) dynamodb list-tables --query "TableNames[?contains(@,'$(strip $(1))-')||@=='$(strip $(1))']" --output=text)

_ddb_get_table_name_N=$(call get_table_name_NI, $(1), 0)
_ddb_get_table_name_NI=$(call get_table_name_NIR, $(1), $(2), $(AWS_REGION))
_ddb_get_table_name_NR=$(call get_table_name_NIR, $(1), 0, $(2))
_ddb_get_table_name_NIR=$(shell $(AWS) --region $(3) dynamodb list-tables --query "TableNames[?contains(@,'$(strip $(1))-')||@=='$(strip $(1))'] | [$(strip $(2))]" --output=text)

#----------------------------------------------------------------------
# USAGE
#

_aws_view_account_limits :: _ddb_view_region_limits

_aws_install_framework_dependencies :: _ddb_install_framework_dependencies
_ddb_install_framework_dependencies:
	@echo 'AWS::DynamoDB ($(_AWS_DYNAMODB_MK_VERSION)) framework dependencies:'
	mkdir -p $(DDB_LOCAL_DB_DIR)
	cd $(DDB_DYNAMODB_LOCAL_DIR); \
		curl -O https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz
	@echo

_aws_view_framework_macros :: _ddb_view_framework_macros
_ddb_view_framework_macros ::
	@echo 'AWS::DynamoDB ($(_AWS_DYNAMODB_MK_VERSION)) macros:'
	@echo '    _ddb_get_backup_arn_{I|TI}         - Get a backup ARN (TableName, Index)'
	@echo '    _ddb_get_newest_backup_arn         - Get the newest backup ARN'
	@echo '    _ddb_get_oldest_backup_arn         - Get the oldest backup ARN'
	@echo '    _ddb_get_table_names_N             - Get table names'
	@echo '    _ddb_get_table_name_{N|NI|NR|NIR}  - Get a table name (Name, Index, Region)'
	@echo

_aws_view_framework_variables :: _ddb_view_framework_parameters
_ddb_view_framework_parameters ::
	@echo 'AWS::DynamoDB ($(_AWS_DYNAMODB_MK_VERSION)) variables:'
	@echo '    DDB_BACKUP_ARN=$(DDB_BACKUP_ARN)'
	@echo '    DDB_BACKUP_NAME=$(DDB_BACKUP_NAME)'
	@echo '    DDB_CONSISTENT_READ=$(DDB_CONSISTENT_READ)'
	@echo '    DDB_DEBUG_MODE=$(DDB_DEBUG_MODE)'
	@echo '    DDB_ENDPOINT_URL=$(DDB_ENDPOINT_URL)'
	@echo '    DDB_EXPRESSION_ATTRIBUTE_NAME=$(DDB_EXPRESSION_ATTRIBUTE_NAME)'
	@echo '    DDB_EXPRESSION_ATTRIBUTE_VALUE=$(DDB_EXPRESSION_ATTRIBUTE_VALUE)'
	@echo '    DDB_FILTER_EXPRESSION=$(DDB_FILTER_EXPRESSION)'
	@echo '    DDB_GLOBAL_TABLE_NAME=$(DDB_GLOCAL_TABLE_NAME)'
	@echo '    DDB_GLOBAL_TABLE_REPLICATION_GROUP=$(DDB_GLOCAL_TABLE_REPLICATION_GROUP)'
	@echo '    DDB_ITEM_ATTRIBUTES=$(DDB_ITEM_ATTRIBUTES)'
	@echo '    DDB_ITEM_KEY=$(DDB_ITEM_KEY)'
	@echo '    DDB_KEY_CONDITION_EXPRESSION=$(DDB_KEY_CONDITION_EXPRESSION)'
	@echo '    DDB_LOCAL_DIR=$(DDB_LOCAL_DIR)'
	@echo '    DDB_LOCAL_PORT=$(DDB_LOCAL_PORT)'
	@echo '    DDB_PAGE_SIZE=$(DDB_PAGE_SIZE)'
	@echo '    DDB_PROJECTION_EXPRESSION=$(DDB_PROJECTION_EXPRESSION)'
	@echo '    DDB_REQUEST_ITEMS=$(DDB_REQUEST_ITEMS)'
	@echo '    DDB_TABLE_ARN=$(DDB_TABLE_ARN)'
	@echo '    DDB_TABLE_ATTRIBUTE_DEFINITIONS=$(DDB_TABLE_ATTRIBUTE_DEFINITIONS)'
	@echo '    DDB_TABLE_GLOBAL_SECONDARY_INDEXES=$(DDB_TABLE_GLOBAL_SECONDARY_INDEXES)'
	@echo '    DDB_TABLE_KEY_SCHEMA=$(DDB_TABLE_KEY_SCHEMA)'
	@echo '    DDB_TABLE_LOCAL_SECONDARY_INDEXES=$(DDB_TABLE_LOCAL_SECONDARY_INDEXES)'
	@echo '    DDB_TABLE_NAME=$(DDB_TABLE_NAME)'
	@echo '    DDB_TABLE_PROVISIONED_THROUGHPUT=$(DDB_TABLE_PROVISIONED_THROUGHPUT)'
	@echo '    DDB_TABLE_SSE_SPECIFICATION=$(DDB_TABLE_SSE_SPECIFICATION)'
	@echo '    DDB_TABLE_STREAM_SPECIFICATION=$(DDB_TABLE_STREAM_SPECIFICATION)'
	@echo '    DDB_TABLE_TAG_KEYS=$(DDB_TABLE_TAG_KEYS)'
	@echo '    DDB_TABLE_TAGS=$(DDB_TABLE_TAGS)'
	@echo '    DDB_TABLE_TTL=$(DDB_TABLE_TTL)'
	@echo '    DDB_TAG_KEYS=$(DDB_TAG_KEYS)'
	@echo '    DDB_TAGS=$(DDB_TAGS)'
	@echo '    DDB_TARGET_TABLE_NAME=$(DDB_TARGET_TABLE_NAME)'
	@echo '    DYNAMODB=$(DYNAMODB)'
	@echo

_aws_view_framework_targets :: _ddb_view_framework_targets
_ddb_view_framework_targets ::
	@echo 'AWS::DynamoDB ($(_AWS_DYNAMODB_MK_VERSION)) targets:'
	@echo '    _ddb_batch_gets                 - Batch get requests to one or more tables'
	@echo '    _ddb_batch_updates              - Batch put and delete requests to one or more tables'
	@echo '    _ddb_check_backup_settings      - Check whether backups/restores are enabled on a table'
	@echo '    _ddb_create_backup              - Create a backup of a dynamodb table'
	@echo '    _ddb_create_global_table        - Create a glabol dynamodb table'
	@echo '    _ddb_create_table               - Create a dynamodb table'
	@echo '    _ddb_delete_backup              - Delete a backup of a table'
	@echo '    _ddb_delete_item                - Delete an item from a table'
	@echo '    _ddb_delete_table               - Delete a dynamodb table'
	@echo '    _ddb_disable_ttl                - Disable TTL of a dynamodb table'
	@echo '    _ddb_enable_ttl                 - Enable TTL of a dynamodb table'
	@echo '    _ddb_get_item                   - Get an item from a dynamodb table'
	@echo '    _ddb_get_items                  - Get one or more items from one or more dynamodb tables'
	@echo '    _ddb_put_item                   - Put an item in a dynamodb table'
	@echo '    _ddb_query_table                - Query a dynamodb table from items'
	@echo '    _ddb_restore_backup             - Restore a backup on a target dynamodb table'
	@echo '    _ddb_scan_table                 - Scan a whole dynamodb table'
	@echo '    _ddb_show_backup                - Show details of a dynamodb table backup'
	@echo '    _ddb_show_global_table          - Show details of a global dynamodb table'
	@echo '    _ddb_show_table                 - Show details of a dynamodb table'
	@echo '    _ddb_show_table_tags            - Show tags of a dynamodb table'
	@echo '    _ddb_start_local_dynamodb       - Start local dynamodb database'
	@echo '    _ddb_tag_table                  - Tag a dynamodb table'
	@echo '    _ddb_update_item                - Update an existing item'
	@echo '    _ddb_view_backups               - View backups for a dynamodb table'
	@echo '    _ddb_view_data_types            - View dynamodb data types'
	@echo '    _ddb_view_region_limits         - Describe regional dynamodb limits'
	@echo '    _ddb_view_tables                - View dynamodb tables'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ddb_batch_gets:
	@$(INFO) "$(AWS_LABEL)Sending a batch of get requests to one or more tables ..."; $(NORMAL)
	[ -f $(DDB_REQUEST_ITEMS_FILEPATH) ] && cat $(DDB_REQUEST_ITEMS_FILEPATH)
	$(AWS) dynamodb batch-get-item $(__DDB_REQUEST_ITEMS) $(__DDB_RETURN_CONSUMED_CAPACITY)

_ddb_batch_updates:
	@$(INFO) "$(AWS_LABEL)Sending a batch of put and delete requests to one or more tables ..."; $(NORMAL)
	[ -f $(DDB_REQUEST_ITEMS_FILEPATH) ] && cat $(DDB_REQUEST_ITEMS_FILEPATH)
	$(AWS) dynamodb batch-write-item $(__DDB_REQUEST_ITEMS) $(__DDB_RETURN_CONSUMED_CAPACITY) $(__DDB_RETURN_ITEM_COLLECTION_METRICS)

_ddb_check_backup_settings:
	@$(INFO) "$(AWS_LABEL)Checking backup/restore setting on dynamodb table '$(DDB_TABLE_NAME)' ..."; $(NORMAL)
	@$(WARN) "If backups are enabled, ContinuousBackupsStatus will bet set to ENABLED"; $(NORMAL)
	$(AWS) dynamodb describe-continuous-backups $(__DDB_TABLE_NAME)

_ddb_create_backup:
	@$(INFO) "$(AWS_LABEL)Backup a dynamodb table '$(DDB_TABLE_NAME)' ..."; $(NORMAL)
	$(AWS) dynamodb create-backup $(__DDB_BACKUP_NAME) $(__DDB_TABLE_NAME)

_ddb_create_global_table:
	@$(INFO) "$(AWS_LABEL)Create global dynamodb table '$(DDB_GLOBAL_TABLE_NAME)' ..."; $(NORMAL)
	$(AWS) dynamodb create-global-table $(__DDB_GLOBAL_TABLE_NAME) $(__DDB_REPLICATION_GROUP)

_ddb_create_table:
	@$(INFO) "$(AWS_LABEL)Create dynamodb table '$(DDB_TABLE_NAME)' ..."; $(NORMAL)
	$(AWS) dynamodb create-table $(__DDB_ATTRIBUTE_DEFINITIONS) $(__DDB_GLOBAL_SECONDARY_INDEXES) $(__DDB_KEY_SCHEMA) $(__DDB_LOCAL_SECONDARY_INDEXES) $(__DDB_PROVISIONED_THROUGHPUT) $(__DDB_SSE_SPECIFICATION) $(__DDB_STREAM_SPECIFICATION) $(__DDB_TABLE_NAME) 

_ddb_delete_backup:
	@$(INFO) "$(AWS_LABEL)Deleting a backup from the dynamodb table '$(DDB_TABLE_NAME)' ..."; $(NORMAL)
	$(AWS) dynamodb delete-backup $(__DDB_BACKUP_ARN)

_ddb_delete_item:
	@$(INFO) "$(AWS_LABEL)Deleting item from dynamodb ..."; $(NORMAL)
	@$(WARN) "Table: $(DDB_TABLE_NAME)"; $(NORMAL)
	-$(AWS) dynamodb delete-item $(__DDB_TABLE_NAME) $(__DDB_KEY) $(__DDB_DEBUG)

_ddb_delete_table:
	@$(INFO) "$(AWS_LABEL)Delete dynamodb table '$(DDB_TABLE_NAME)' ..."; $(NORMAL)
	-$(AWS) dynamodb delete-table $(__DDB_TABLE_NAME)

_ddb_disable_ttl:
	@$(INFO) "$(AWS_LABEL)Ignore TTL settings in table '$(DDB_TABLE_NAME)' ..."; $(NORMAL)
	@$(WARN) "This operation will succeed if (1) TTL is not already disabled, (2) TTL has not be just recently enabled"; $(NORMAL)
	-$(AWS) dynamodb update-time-to-live $(__DDB_TABLE_NAME) --time-to-live-specification Enabled=false,AttributeName=ttl

_ddb_enable_ttl:
	@$(INFO) "$(AWS_LABEL)Honor TTL settings in table '$(DDB_TABLE_NAME)' ..."; $(NORMAL)
	@$(WARN) "This operation will succeed if (1) TTL is not already enabled, (2) TTL has not be just recently disabled"; $(NORMAL)
	-$(AWS) dynamodb update-time-to-live $(__DDB_TABLE_NAME) --time-to-live-specification Enabled=true,AttributeName=ttl

# _ddb_get_item: __QUERY=--query "Item.{add: address.S, pool: pool.S}"
_ddb_get_item:
	@$(INFO) "$(AWS_LABEL)Fetching item from dynamodb ..."; $(NORMAL)
	@$(WARN) "Table: $(DDB_TABLE_NAME)"; $(NORMAL)
	$(AWS) dynamodb get-item $(__DDB_TABLE_NAME) $(__DDB_KEY) $(__QUERY)

_ddb_get_items:
	@$(INFO) "$(AWS_LABEL)Fetching items for one or many dynamodb tables ..."; $(NORMAL)
	$(AWS) dynamodb batch-get-item $(__DDB_REQUEST_ITEMS)

_ddb_put_item:
	@$(INFO) "$(AWS_LABEL)Adding 1 item in dynamodb table '$(DDB_TABLE_NAME)' ..."; $(NORMAL)
	[ -f $(DDB_ITEM_FILEPATH) ] && cat $(DDB_ITEM_FILEPATH)
	$(AWS) dynamodb put-item $(__DDB_CONDITIONAL_EXPRESSION) $(__DDB_CONDITIONAL_OPERATOR) $(__DDB_EXPECTED) $(__DDB_EXPRESSION_ATTRIBUTE_NAMES) $(__DDB_EXPRESSION_ATTRIBUTE_VALUES) $(__DDB_ITEM) $(__DDB_RETURN_CONSUMED_CAPACITY) $(__DDB_RETURN_ITEM_COLLECTION_METRICS) $(__DDB_RETURN_VVALUES) $(__DDB_TABLE_NAME)

_ddb_update_item: _ddb_put_item

__DDB_QUERY_TABLE_OPTIONS+= $(__DDB_ATTRIBUTES_TO_GET) $(__DDB_CONDITIONAL_OPERATOR) $(__DDB_CONSISTENT_READ) $(__DDB_EXPRESSION_ATTRIBUTE_NAMES) $(__DDB_EXPRESSION_ATTRIBUTE_VALUES) $(__DDB_FILTER_EXPRESSION) $(__DDB_KEY_CONDITION_EXPRESSION) $(__DDB_PAGE_SIZE)$(__DDB_PROJECTION_EXPRESSION) $(__DDB_RETURN_CONSUMED_CAPACITY) $(__DDB_SCAN_INDEX_FORWARD) $(__DDB_SELECT) $(__DDB_TABLE_NAME) 
_ddb_query_table:
	@$(INFO) "$(AWS_LABEL)Querying dynamodb table '$(DDB_TABLE_NAME)' ..."; $(NORMAL)
	$(AWS) dynamodb query $(__DDB_QUERY_TABLE_OPTIONS)

_ddb_restore_backup:
	@$(INFO) "$(AWS_LABEL)Restoring backup '$(DDB_BACKUP_NAME)' on dynamodb table '$(DDB_TARGET_TABLE_NAME)' ..."; $(NORMAL)
	@$(WARN) "You cannot restore a backup in an existing table"; $(NORMAL)
	@$(WARN) "This operation doesn't restore Tags, Auto scaling & IAM policies, Cloudwatch metrics & alarms, Stream & Time to Live (TTL) settings"; $(NORMAL)
	$(AWS) dynamodb restore-table-from-backup $(__DDB_BACKUP_ARN) $(__DDB_TARGET_TABLE_NAME)

# _dbb_scan_table: __QUERY= --query 'Items[].[pool.S, address.S]
__DDB_SCAN_TABLE_OPTIONS+= $(__DDB_ATTRIBUTES_TO_GET) $(__DDB_CONDITIONAL_OPERATOR) $(__DDB_CONSISTENT_READ) $(__DDB_EXPRESSION_ATTRIBUTE_NAMES) $(__DDB_EXPRESSION_ATTRIBUTE_VALUES) $(__DDB_FILTER_EXPRESSION) $(__DDB_INDEX_NAME) $(__DDB_PAGE_SIZE) $(__DDB_PROJECTION_EXPRESSION) $(__DDB_RETURN_CONSUMED_CAPACITY) $(__DDB_SCAN_FILTER) $(__DDB_SEGMENT) $(__DDB_SELECT) $(__DDB_TABLE_NAME) $(__DDB_TOTAL_SEGMENTS)
_ddb_scan_table:
	@$(INFO) "$(AWS_LABEL)Scaning dynamodb table '$(DDB_TABLE_NAME)' ..."; $(NORMAL)
	$(AWS) dynamodb scan $(__DDB_SCAN_TABLE_OPTIONS)

_ddb_show_backup:
	@$(INFO) "$(AWS_LABEL)Show details of a backup of table '$(DDB_TABLE_NAME)' ..."; $(NORMAL)
	$(AWS) dynamodb describe-backup $(__DDB_BACKUP_ARN)

_ddb_show_global_table:
	@$(INFO) "$(AWS_LABEL)Show details of a global dynamodb table '$(DDB_GLOBAL_TABLE_NAME)' ..."; $(NORMAL)
	$(AWS) dynamodb describe-global-table $(__DDB_GLOBAL_TABLE_NAME)

_ddb_show_table:
	@$(INFO) "$(AWS_LABEL)Show details of dynamodb table '$(DDB_TABLE_NAME)' ..."; $(NORMAL)
	$(AWS) dynamodb describe-table $(__DDB_TABLE_NAME) --query "Table$(DDB_UI_SHOW_TABLE_FIELDS)"

_ddb_show_table_tags: DDB_RESOURCE_ARN=$(DDB_TABLE_ARN)
_ddb_show_table_tags:
	@$(INFO) "$(AWS_LABEL)Show tags of dynamodb table '$(DDB_TABLE_NAME)' ..."; $(NORMAL)
	$(AWS) dynamodb list-tags-of-resource $(__DDB_RESOURCE_ARN) 

_ddb_start_local_dynamodb:
	@$(INFO) "$(AWS_LABEL)Starting dynamodb locally ..."; $(NORMAL)
	cd $(DDB_LOCAL_DIR); $(DYNAMODB) -help
	cd $(DDB_LOCAL_DIR); $(DYNAMODB) 

_ddb_tag_table: DDB_RESOURCE_ARN=$(DDB_TABLE_ARN)
_ddb_tag_table: DDB_TAGS=$(DDB_TABLE_TAGS)
_ddb_tag_table:
	@$(INFO) "$(AWS_LABEL)Tagging the dynamodb table '$(DDB_TABLE_NAME)' ..."; $(NORMAL)
	$(AWS) dynamodb tag-resource $(__DDB_RESOURCE_ARN) $(__DDB_TAGS)

_ddb_untag_table: DDB_RESOURCE_ARN=$(DDB_TABLE_ARN)
_ddb_untag_table: DDB_TAG_KEYS=$(DDB_TABLE_TAG_KEYS)
_ddb_untag_table:
	@$(INFO) "$(AWS_LABEL)Untagging the dynamodb table '$(DDB_TABLE_NAME)' ..."; $(NORMAL)
	$(AWS) dynamodb untag-resource $(__DDB_RESOURCE_ARN) $(__DDB_TAG_KEYS)

_ddb_view_backups:
	@$(INFO) "$(AWS_LABEL)View backups of dynamodb table '$(DDB_TABLE_NAME)' ..."; $(NORMAL)
	$(AWS) dynamodb list-backups $(__DDB_EXCLUSIVE_START_BACKUP_ARN) $(__DDB_LIMIT) $(__DDB_TABLE_NAME) $(__DDB_TIME_RANGE_LOWER_BOUND) $(__DDB_TIME_RANGE_UPPER_BOUND) --query "BackupSummaries[]$(DDB_UI_VIEW_BACKUPS_FIELDS)"

_ddb_view_data_types:
	@$(INFO) "$(AWS_LABEL)List dynamodb data types ..."; $(NORMAL)
	@echo " B      --> blob             'dGhpcyB0ZXh0IGlzIGJhc2U2NC1lbmNvZGVk'"
	@echo " BS     --> blob set         ['dGhpcyB0ZXh0IGlzIGJhc2U2NC1lbmNvZGVk', 'dGhpcyB0ZXh0IGlzIGJhc2U2NC1lbmNvZGVk']"
	@echo " N      --> number           42.2"
	@echo " NS     --> number set       ["42.2", "-19", "7.5", "3.14"]"
	@echo " S      --> string           'Hello'"
	@echo " SS     --> string set       ['Giraffe', 'Hippo' ,'Zebra']"
	@echo
	@echo " Used for storing nested JSON:"
	@echo " BOOL   --> boolean          'true'"
	@echo " L      --> list             ['Cookies', 'Coffee', 3.14159]"
	@echo " M      --> map              {'Name': {'S': 'Joe'}, 'Age': {'N': '35'}}"
	@echo " NULL   --> null"
	@echo

_ddb_view_global_tables:
	@$(INFO) "$(AWS_LABEL)View global dynamodb tables ..."; $(NORMAL)
	$(AWS) dynamodb list-global-tables $(__DDB_EXCLUSIVE_START_GLOBAL_TABLE_NAME) $(__DDB_REGION_NAME)

_ddb_view_region_limits:
	@$(INFO) "$(AWS_LABEL)View dynamodb limits in region '$(AWS_REGION)' ..."; $(NORMAL)
	@$(WARN) "The limits are region specific, not for the whole AWS account"; $(NORMAL)
	$(AWS) dynamodb describe-limits

_ddb_view_tables:
	@$(INFO) "$(AWS_LABEL)View existing dynamodb tables ..."; $(NORMAL)
	$(AWS) dynamodb list-tables
