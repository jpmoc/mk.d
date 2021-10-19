_AWS_GLUE_DATABASE_MK_VERSION=$(_AWS_GLUE_MK_VERSION)

# GLE_DATABASE_DESCRIPTION?= 'This is my database-description'
# GLE_DATABASE_INPUT_FILEPATH?= ./database-input.json
# GLE_DATABASE_INPUT?= Name=$(GLE_DATABASE_NAME),Description=$(GLE_DATABASE_DESCRIPTION),LocationUri=$(GLE_DATABASE_LOCATION_URI),Parameters={KeyName1=string,KeyName2=string}
# GLE_DATABASE_LOCATION_URI?= s3://crawler-public-us-east-1/flight/2016/csv/
# GLE_DATABASE_NAME?= my-database
# GLE_TABLE_INPUT_FILEPATH?= ./table-input.json
# GLE_TABLE_INPUT?=
# GLE_TABLE_VERSION_ID?= 0
# GLE_TABLESET_REGEX?=

# Derived variables
GLE_DATABASE_INPUT= $(if $(GLE_DATABASE_INPUT_FILEPATH), file://$(GLE_DATABASE_INPUT_FILEPATH))
GLE_TABLE_INPUT= $(if $(GLE_TABLE_INPUT_FILEPATH), file://$(GLE_TABLE_INPUT_FILEPATH))

# Options variables
__GLE_DATABASE_INPUT= $(if $(GLE_DATABASE_INPUT), --database-input $(GLE_DATABASE_INPUT))
__GLE_DATABASE_NAME= $(if $(GLE_DATABASE_NAME), --database-name $(GLE_DATABASE_NAME))
__GLE_EXPRESSION= $(if $(GLE_TABLESET_REGEX), --expression $(GLE_TABLESET_REGEX))
__GLE_NAME_DATABASE= $(if $(GLE_DATABASE_NAME), --name $(GLE_DATABASE_NAME))
__GLE_NAME_TABLE= $(if $(GLE_TABLE_NAME), --name $(GLE_TABLE_NAME))
__GLE_TABLE_NAME= $(if $(GLE_TABLE_NAME), --table-name $(GLE_TABLE_NAME))

# UI variables
GLE_UI_SHOW_DATABASE_TABLES_FIELDS?= $(GLE_UI_VIEW_TABLES_FIELDS)
GLE_UI_SHOW_TABLESET_FIELDS?= $(GLE_UI_VIEW_TABLES_FIELDS)
GLE_UI_SHOW_TABLE_VERSIONS_FIELDS?= .{VersionId:VersionId,Name:Table.Name,_Location:Table.StorageDescriptor.Location}
GLE_UI_VIEW_DATABASES_FIELDS?=
GLE_UI_VIEW_TABLES_FIELDS?= .{Name:Name,_Classification:Parameters.classification,_CrawledBy:Parameters.UPDATED_BY_CRAWLER,_Location:StorageDescriptor.Location}

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_gle_view_makefile_macros ::
	@#echo 'AWS::GLuE::Database ($(_AWS_GLUE_DATABASE_MK_VERSION)) macros:'
	@#echo

_gle_view_makefile_targets ::
	@echo 'AWS::GLuE::Database ($(_AWS_GLUE_DATABASE_MK_VERSION)) targets:'
	@echo '    _gle_create_database                - Create a database in the data-catalog'
	@echo '    _gle_create_table                   - Create a table in a database of the data-catalog'
	@echo '    _gle_delete_database                - Delete a database in the data-catalog'
	@echo '    _gle_delete_table                   - Delete a table in a database of the data-catalog'
	@echo '    _gle_show_database                  - Show details of a database of the data-catalog'
	@echo '    _gle_show_database_table            - Show details of a database table'
	@echo '    _gle_show_tableset                  - Show a tableset of a database in the data-catalog'
	@echo '    _gle_show_database_tables           - Show all the tables in a catalog database'
	@echo '    _gle_view_databases                 - View all the databases in the data-catalog'
	@echo '    _gle_view_tables                    - View all tables in a database of the data-catalog'
	@echo 

_gle_view_makefile_variables ::
	@echo 'AWS::GLuE::Database ($(_AWS_GLUE_DATABASE_MK_VERSION)) variables:'
	@echo '    GLE_DATABASE_DESCRIPTION=$(GLE_DATABASE_DESCRIPTION)'
	@echo '    GLE_DATABASE_INPUT_FILEPATH=$(GLE_DATABASE_INPUT_FILEPATH)'
	@echo '    GLE_DATABASE_INPUT=$(GLE_DATABASE_INPUT)'
	@echo '    GLE_DATABASE_NAME=$(GLE_DATABASE_NAME)'
	@echo '    GLE_TABLE_EXPRESSION=$(GLE_TABLE_EXPRESSION)'
	@echo '    GLE_TABLE_INPUT_FILEPATH=$(GLE_TABLE_INPUT_FILEPATH)'
	@echo '    GLE_TABLE_INPUT=$(GLE_TABLE_INPUT)'
	@echo '    GLE_TABLE_VERSION_ID=$(GLE_TABLE_VERSION_ID)'
	@echo '    GLE_TABLESET_NAME=$(GLE_TABLESET_NAME)'
	@echo '    GLE_TABLESET_REGEX=$(GLE_TABLESET_REGEX)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_gle_create_database:
	@$(INFO) '$(AWS_LABEL)Creating database "$(GLE_DATABASE_NAME)" in the data-catalog ...'; $(NORMAL)
	$(AWS) glue create-database $(__GLE_CATALOG_ID) $(__GLE_DATABASE_INPUT)

_gle_create_table:
	@$(INFO) '$(AWS_LABEL)Creating table "$(GLE_TABLE_NAME)" in database "$(GLE_DATABASE_NAME)" of the data-catalog ...'; $(NORMAL)
	$(AWS) glue create-table $(__GLE_CATALOG_ID) $(__GLE_DATABASE_NAME) $(__GLE_TABLE_INPUT)

_gle_delete_database:
	@$(INFO) '$(AWS_LABEL)Deleting database "$(GLE_DATABASE_NAME)" from data-catalog ...'; $(NORMAL)
	$(AWS) glue delete-database $(__GLE_CATALOG_ID) $(__GLE_NAME_DATABASE)

_gle_delete_table:
	@$(INFO) '$(AWS_LABEL)Deleting table "$(GLE_TABLE_NAME)" in database "$(GLE_DATABASE_NAME)" of the data-catalog ...'; $(NORMAL)
	$(AWS) glue delete-table $(__GLE_CATALOG_ID) $(__GLE_DATABASE_NAME) $(__GLE_NAME_TABLE)

_gle_show_database:
	@$(INFO) '$(AWS_LABEL)Showing database "$(GLE_DATABASE_NAME)" in data-catalog ...'; $(NORMAL)
	$(AWS) glue get-database $(__GLE_CATALOG_ID) $(__GLE_NAME_DATABASE)

_gle_show_database_table:
	@$(INFO) '$(AWS_LABEL)Showing table "$(GLE_TABLE_NAME)" in database "$(GLE_DATABASE_NAME)" of the data-catalog ...'; $(NORMAL)
	$(AWS) glue get-table $(__GLE_CATALOG_ID) $(__GLE_DATABASE_NAME) $(__GLE_NAME_TABLE)

_gle_show_database_tables:
	@$(INFO) '$(AWS_LABEL)Showing tables of database "$(GLE_DATABASE_NAME)" in data-catalog ...'; $(NORMAL)
	$(AWS) glue get-tables $(__GLE_CATALOG_ID)  $(__GLE_DATABASE_NAME) $(_X__GLE_EXPRESSION) --query "TableList[]$(GLE_UI_SHOW_DATABASE_TABLES_FIELDS)"

_gle_show_table: _gle_show_database_table

_gle_show_table_versions:
	@$(INFO) '$(AWS_LABEL)Showing versions of table "$(GLE_TABLE_NAME)" in database "$(GLE_DATABASE_NAME)" of the data-catalog ...'; $(NORMAL)
	$(AWS) glue get-table-versions $(__GLE_CATALOG_ID)  $(__GLE_DATABASE_NAME) $(__GLE_TABLE_NAME) --query "TableVersions[]$(GLE_UI_SHOW_TABLE_VERSIONS_FIELDS)"

_gle_show_tableset:
	@$(INFO) '$(AWS_LABEL)Showing tableset '$(GLE_TABLESET_NAME)' in database '$(GLE_DATABASE_NAME)' in data-catalog ...'; $(NORMAL)
	@$(WARN) 'Table-set regex = $(GLE_TABLESET_REGEX)'; $(NORMAL)
	$(AWS) glue get-tables $(__GLE_CATALOG_ID) $(__GLE_DATABASE_NAME) $(__GLE_EXPRESSION) --query "TableList[]$(GLE_UI_SHOW_TABLESET_FIELDS)"

_gle_view_databases:
	@$(INFO) '$(AWS_LABEL)Viewing databases in data-catalog ...'; $(NORMAL)
	$(AWS) glue get-databases $(__GLE_CATALOG_ID) --query "DatabaseList[]$(GLE_UI_VIEW_DATABASES_FIELDS)"


_gle_view_tables:
	@$(INFO) '$(AWS_LABEL)Viewing tables in database '$(GLE_DATABASE_NAME)' in data-catalog ...'; $(NORMAL)
	$(AWS) glue get-tables $(__GLE_CATALOG_ID) $(__GLE_DATABASE_NAME) $(_X__GLE_EXPRESSION) --query "TableList[]$(GLE_UI_VIEW_TABLES_FIELDS)"
