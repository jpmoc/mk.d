_AWS_ATHENA_NAMEDQUERY_MK_VERSION=$(_AWS_ATHENA_MK_VERSION)

# ATA_NAMEDQUERY_DATABASE?= my-database
# ATA_NAMEDQUERY_DESCRIPTION?= "This is my named-query description!"
# ATA_NAMEDQUERY_ID?= 08431e57-5651-4ec2-9500-a7163f3b899a
# ATA_NAMEDQUERY_IDS?= 08431e57-5651-4ec2-9500-a7163f3b899a ...
# ATA_NAMEDQUERY_NAME?= my-named-query
ATA_NAMEDQUERY_SLICE?= 0:10:1
# ATA_NAMEDQUERY_SQL?=
# ATA_NAMEDQUERY_SQL_FILEPATH?=

# Derived variables
ATA_NAMEDQUERY_IDS?= $(ATA_NAMEDQUERY_ID)
ATA_NAMEDQUERY_SQL?= $(if $(ATA_NAMEDQUERY_SQL_FILEPATH), file://$(ATA_NAMEDQUERY_SQL_FILEPATH))

# Options variables
__ATA_DATABASE_NAMEDQUERY= $(if $(ATA_NAMEDQUERY_DATABASE), --database $(ATA_NAMEDQUERY_DATABASE))
__ATA_DESCRIPTION_NAMEDQUERY= $(if $(ATA_NAMEDQUERY_DESCRIPTION), --description $(ATA_NAMEDQUERY_DESCRIPTION))
__ATA_NAME_NAMEDQUERY= $(if $(ATA_NAMEDQUERY_NAME), --name $(ATA_NAMEDQUERY_NAME))
__ATA_NAMED_QUERY_ID= $(if $(ATA_NAMEDQUERY_ID), --named-query-id $(ATA_NAMEDQUERY_ID))
__ATA_NAMED_QUERY_IDS= $(if $(ATA_NAMEDQUERY_IDS), --named-query-id $(ATA_NAMEDQUERY_IDS))
__ATA_QUERY_STRING_NAMEDQUERY= $(if $(ATA_NAMEDQUERY_SQL), --query-string $(ATA_NAMEDQUERY_SQL))

# UI variables
ATA_UI_SHOW_NAMEDQUERY_SUMMARY_FIELDS?= .{database:Database,Name:Name,description:Description,NamedQueryId:NamedQueryId}
# ATA_UI_VIEW_NAMEDQUERIES_SET_FIELDS?= .{database:Database,Name:Name,NameQueryId:NamedQueryId,description:Description}
ATA_UI_VIEW_NAMEDQUERIES_SET_FIELDS?= .{database:Database,Name:Name,NameQueryId:NamedQueryId}

#--- Utilities

#--- MACROS
_ata_get_namedquery_ids= $(call _ata_get_namedquery_ids_S, $(ATA_NAMEDQUERY_SLICE))
_ata_get_namedquery_ids_S= $(shell $(AWS) athena list-named-queries --query "NamedQueryIds[$(1)]"  --output text)

_ata_get_namedquery_name= $(call _ata_get_namedquery_name_I, $(ATA_NAMEDQUERY_ID))
_ata_get_namedquery_name_I= $(shell $(AWS)  athena get-named-query  --named-query-id $(1) --query "NamedQuery.Name" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ata_view_makefile_macros ::
	@echo 'AWS::AThenA::NamedQuery ($(_AWS_ATHENA_NAMEDQUERY_MK_VERSION)) macros:'
	@echo '    _ata_get_namedquery_name_{|I}        - Get the name of a named-query (Id)'
	@echo

_ata_view_makefile_targets ::
	@echo 'AWS::AThenA::NamedQuery ($(_AWS_ATHENA_NAMEDQUERY_MK_VERSION)) targets:'
	@echo '    _ata_create_namedquery               - Create a new named-query'
	@echo '    _ata_delete_namedquery               - Delete an existing named-query'
	@echo '    _ata_show_namedquery                 - Show details of a named-query'
	@echo '    _ata_show_namedquery_sql             - Show SQL statement of a named-query'
	@echo '    _ata_show_namedquery_summary         - Show summary of a named-query'
	@echo 

_ata_view_makefile_variables ::
	@echo 'AWS::AThenA::NamedQuery ($(_AWS_ATHENA_NAMEDQUERY_MK_VERSION)) variables:'
	@echo '    ATA_NAMEDQUERY_DATABASE=$(ATA_NAMEDQUERY_DATABASE)'
	@echo '    ATA_NAMEDQUERY_DESCRIPTION=$(ATA_NAMEDQUERY_DESCRIPTION)'
	@echo '    ATA_NAMEDQUERY_ID=$(ATA_NAMEDQUERY_ID)'
	@echo '    ATA_NAMEDQUERY_IDS=$(ATA_NAMEDQUERY_IDS)'
	@echo '    ATA_NAMEDQUERY_NAME=$(ATA_NAMEDQUERY_NAME)'
	@echo '    ATA_NAMEDQUERY_SQL=$(ATA_NAMEDQUERY_SQL)'
	@echo '    ATA_NAMEDQUERY_SQL_FILEPATH=$(ATA_NAMEDQUERY_SQL_FILEPATH)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ata_create_namedquery:
	@$(INFO) '$(AWS_UI_LABEL)Creating named-query "$(ATA_NAMEDQUERY_NAME)" ...'; $(NORMAL)
	$(if $(ATA_NAMEDQUERY_SQL_FILEPATH), echo; cat $(ATA_NAMEDQUERY_SQL_FILEPATH); echo)
	$(AWS) athena create-named-query $(__ATA_DATABASE_NAMEDQUERY) $(__ATA_DESCRIPTION_NAMEDQUERY) $(__ATA_NAME_NAMEDQUERY) $(__ATA_QUERY_STRING_NAMEDQUERY)

_ata_delete_namedquery:
	@$(INFO) '$(AWS_UI_LABEL)Creating named-query "$(ATA_NAMEDQUERY_NAME)" ...'; $(NORMAL)
	$(AWS) athena delete-named-query $(__ATA_NAMED_QUERY_ID)

_ata_show_namedquery: _ata_show_namedquery_sql _ata_show_namedquery_summary

_ata_show_namedquery_sql:
	@$(INFO) '$(AWS_UI_LABEL)Showing SQL Query of named-query "$(ATA_NAMEDQUERY_NAME)" ...'; $(NORMAL)
	$(CYAN); $(AWS) athena get-named-query  $(__ATA_NAMED_QUERY_ID) --query "NamedQuery.QueryString" --output text; $(WHITE)

_ata_show_namedquery_summary:
	@$(INFO) '$(AWS_UI_LABEL)Showing summary of named-query "$(ATA_NAMEDQUERY_NAME)" ...'; $(NORMAL)
	$(AWS) athena get-named-query $(__ATA_NAMED_QUERY_ID) --query "NamedQuery$(ATA_UI_SHOW_NAMEDQUERY_SUMMARY_FIELDS)"

_ata_view_namedqueries: _ata_view_namedqueries_ids _ata_view_namedqueries_set

_ata_view_namedqueries_ids:
	@$(INFO) '$(AWS_UI_LABEL)Viewing IDs of all named-queries ...'; $(NORMAL)
	@$(WARN) 'IDs are ordered by creation date: most recent one at the top, oldest one at the bottom'; $(NORMAL)
	$(AWS) athena list-named-queries --query "NamedQueryIds[]"

_ata_view_namedqueries_set: ATA_NAMEDQUERY_IDS= $(call _ata_get_namedquery_ids)
_ata_view_namedqueries_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing named-query set ...'; $(NORMAL)
	@$(WARN) 'Named-query slice: $(ATA_NAMEDQUERY_SLICE)'; $(NORMAL)
	@$(WARN) 'The order of the returned Named-query is consistent, but not based on creation date or command line param order!!!'; $(NORMAL)
	$(AWS) athena batch-get-named-query $(__ATA_NAMED_QUERY_IDS) --query "NamedQueries[]$(ATA_UI_VIEW_NAMEDQUERIES_SET_FIELDS)"
