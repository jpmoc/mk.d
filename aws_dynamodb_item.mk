_AWS_DYNAMODB_MK_VERSION=0.99.6

# DDB_ITEM_FILEPATH?= ./item.json
# DDB_ITEM?= '{"hash":{"S":"xxxx-xxxx-xxxx-xxxx"}, "sort":{"N":"22345678"}, "val":{"S":"2234567890"}}'
# DDB_ITEM_KEY?=
# DDB_ITEM_KEY_CONFIG?= '{"hash":{"S":"xxxx-xxxx-xxxx-xxxx"}, "sort":{"N":"12345678"}}'
# DDB_ITEM_KEY_FILEPATH?= file://key.json
DDB_ITEM_RETURNCONSUMEDCAPACITY_ENUM?= NONE
DDB_ITEM_RETURNITEMCOLLECTIONMETRICS_ENUM?= NONE
DDB_ITEM_RETURNVALUES_ENUM?= NONE
# DDB_ITEM_TABLE_NAME?= MusicCollection
# DDB_ITEMS_REQUEST?=
# DDB_ITEMS_REQUEST_FILEPATH?= ./in/item-request.json
# DDB_ITEMS_TABLE_NAME?= MusicCollection

# Derived
DDB_ITEM?= $(if $(DDB_ITEM_FILEPATH), file://$(DDB_ITEM_FILEPATH))
DDB_ITEM_KEY?= $(if $(DDB_ITEM_KEY_FILEPATH),file://$(DDB_ITEM_KEY_FILEPATH))$(DDB_ITEM_KEY_CONFIG)
DDB_ITEM_TABLE_NAME?= $(DDB_TABLE_NAME)
DDB_ITEMS_REQUEST?= $(if $(DDB_ITEMS_REQUEST_FILEPATH),file://$(DDB_ITEMS_REQUEST_FILEPATH))

# Options
__DDB_CONDITIONAL_OPERATOR=
__DDB_EXPECTED=
__DDB_EXPRESSION_ATTRIBUTE_NAMES=
__DDB_EXPRESSION_ATTRIBUTE_VALUES=
__DDB_ITEM= $(if $(DDB_ITEM),--item $(DDB_ITEM))
__DDB_KEY= $(if $(DDB_ITEM_KEY),--key $(DDB_ITEM_KEY))
__DDB_REQUEST_ITEMS= $(if $(DDB_ITEMS_REQUEST),--request-items $(DDB_ITEMS_REQUEST))
__DDB_RETURN_CONSUMED_CAPACITY= $(if $(DDB_ITEM_RETURNCONSUMEDCAPACITY_ENUM),--return-consumed-capacity $(DDB_ITEM_RETURNCONSUMEDCAPACITY_ENUM))
__DDB_RETURN_ITEM_COLLECTION_METRICS= $(if $(DDB_ITEM_RETURNITEMCOLLECTIONMETRICS_ENUM),--return-item-collection-metrics $(DDB_ITEM_RETURNITEMCOLLECTIONMETRICS_ENUM))
__DDB_RETURN_VALUES= $(if $(DDB_ITEM_RETURNVALUES_ENUM),--return-values $(DDB_ITEM_RETURNVALUES_ENUM))
__DDB_TABLE_NAME__ITEM= $(if $(DDB_ITEM_TABLE_NAME),--table-name $(DDB_ITEM_TABLE_NAME))
__DDB_TABLE_NAME__ITEMS= $(if $(DDB_ITEMS_TABLE_NAME),--table-name $(DDB_ITEMS_TABLE_NAME))


# UI variables
DDB_UI_VIEW_ITEMS_FIELDS?=.[pool.S, address.S]

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ddb_view_framework_macros ::
	@echo 'AWS::DynamoDB::Item ($(_AWS_DYNAMODB_MK_VERSION)) macros:'
	@echo

_ddb_view_framework_parameters ::
	@echo 'AWS::DynamoDB::Item ($(_AWS_DYNAMODB_MK_VERSION)) variables:'
	@echo '    DDB_ITEM_KEY=$(DDB_ITEM_KEY)'
	@echo '    DDB_ITEM_KEY_CONFIG=$(DDB_ITEM_KEY_CONFIG)'
	@echo '    DDB_ITEM_KEY_FILEPATH=$(DDB_ITEM_KEY_FILEPATH)'
	@echo '    DDB_ITEM_RETURNCONSUMEDCAPACITY_ENUM=$(DDB_ITEM_RETURNCONSUMEDCAPACITY_ENUM)'
	@echo '    DDB_ITEM_RETURNITEMCOLLECTIONMETRICS_ENUM=$(DDB_ITEM_RETURNITEMCOLLECTIONMETRICS_ENUM)'
	@echo '    DDB_ITEM_RETURNVALUES_ENUM=$(DDB_ITEM_RETURNVALUES_ENUM)'
	@echo '    DDB_ITEM_TABLE_NAME=$(DDB_ITEM_TABLE_NAME)'
	@echo '    DDB_ITEMS_REQUEST=$(DDB_ITEMS_REQUEST)'
	@echo '    DDB_ITEMS_REQUEST_FILEPATH=$(DDB_ITEMS_REQUEST_FILEPATH)'
	@echo '    DDB_ITEMS_SET_NAME=$(DDB_ITEMS_SET_NAME)'
	@echo '    DDB_ITEMS_TABLE_NAME=$(DDB_ITEMS_TABLE_NAME)'
	@echo

_ddb_view_framework_targets ::
	@echo 'AWS::DynamoDB::Item ($(_AWS_DYNAMODB_MK_VERSION)) targets:'
	@echo '    _ddb_create_item               - Create 1 item'
	@echo '    _ddb_create_items              - Create multiple items'
	@echo '    _ddb_delete_item               - Delete 1 item'
	@echo '    _ddb_delete_items              - Delete multiple items'
	@echo '    _ddb_show_item                 - Show everything related to an item'
	@echo '    _ddb_show_item_description     - Show description of an item'
	@echo '    _ddb_update_item               - Update an existing item'
	@echo '    _ddb_update_items              - Update existing items'
	@echo '    _ddb_view_items                - View items in a table'
	@echo '    _ddb_view_items_set            - View set of items in a table'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ddb_create_item:
	@$(INFO) '$(DDB_UI_LABEL)Creating/updating 1 item in table "$(DDB_TABLE_NAME)" ...'; $(NORMAL)
	$(if $(DDB_ITEM_FILEPATH),  cat $(DDB_ITEM_FILEPATH))
	$(AWS) dynamodb put-item $(__DDB_CONDITIONAL_EXPRESSION) $(__DDB_CONDITIONAL_OPERATOR) $(__DDB_EXPECTED) $(__DDB_EXPRESSION_ATTRIBUTE_NAMES) $(__DDB_EXPRESSION_ATTRIBUTE_VALUES) $(__DDB_ITEM) $(__DDB_RETURN_CONSUMED_CAPACITY) $(__DDB_RETURN_ITEM_COLLECTION_METRICS) $(__DDB_RETURN_VALUES) $(__DDB_TABLE_NAME__ITEM)

_ddb_create_items:
	@$(INFO) '$(DDB_UI_LABEL)Creating/updating items in one or more tables ...'; $(NORMAL)
	$(if $(DDB_ITEMS_REQUEST_FILEPATH), cat $(DDB_ITEMS_REQUEST_FILEPATH))
	$(AWS) dynamodb batch-write-item $(__DDB_REQUEST_ITEMS) $(__DDB_RETURN_CONSUMED_CAPACITY) $(__DDB_RETURN_ITEM_COLLECTION_METRICS)

_ddb_delete_item:
	@$(INFO) '$(DDB_UI_LABEL)Deleting item in table "$(DDB_ITEM_TABLE_NAME)" ...'; $(NORMAL)
	$(if $(DDB_ITEM_KEY_FILEPATH),  cat $(DDB_ITEM_KEY_FILEPATH))
	-$(AWS) dynamodb delete-item $(strip $(__DDB_CONDITION_EXPRESSION) $(__DDB_CONDITIONAL_OPERATOR) $(__DDB_EXPECTED) $(__DDB_EXPRSSION_ATTRIBUTES_NAMES) $(__DDB_EXPRESSION_ATTRIBUTE_VALUES) $(__DDB_KEY) $(__DDB_RETURN_CONSUMER_CAPACITY) $(__DDB_RETURN_ITEM_COLLECTION_METRICS) $(__DDB_TABLE_NAME__ITEM))

_ddb_delete_items:
	@$(INFO) "$(DDB_UI_LABEL)Deleting multiple items ..."; $(NORMAL)

_ddb_show_item: _ddb_show_item_description

_ddb_show_item_description:
	@$(INFO) '$(DDB_UI_LABEL)Showing item from table "$(DDB_ITEM_TABLE_NAME)" ...'; $(NORMAL)
	$(AWS) dynamodb get-item $(__DDB_TABLE_NAME__ITEM) $(__DDB_KEY) --query "Item.{add: address.S, pool: pool.S}"

_ddb_update_item: _ddb_create_item

_ddb_update_items: _ddb_create_items

_ddb_view_items:
	@$(INFO) '$(DDB_UI_LABEL)Viewing items from table "$(DDB_ITEMS_TABLE_NAME)" ...'; $(NORMAL)

_ddb_view_items_set:
	@$(INFO) '$(DDB_UI_LABEL)Viewing items-set "$(DDB_ITEMS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Items are grouped based on the primary key'; $(NORMAL)

_ddb_view_items_megaset:
	@$(INFO) '$(DDB_UI_LABEL)Viewing items-set "$(DDB_ITEMS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Items are grouped based on the request which may spawn several tables'; $(NORMAL) 
	$(AWS) dynamodb batch-get-item $(__DDB_REQUEST_ITEMS)
	# [ -f $(DDB_REQUEST_ITEMS_FILEPATH) ] && cat $(DDB_REQUEST_ITEMS_FILEPATH)
	# $(AWS) dynamodb batch-get-item $(__DDB_REQUEST_ITEMS) $(__DDB_RETURN_CONSUMED_CAPACITY)
