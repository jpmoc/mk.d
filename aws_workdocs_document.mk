_AWS_WORKDOCS_DOCUMENT_MK_VERSION= $(_AWS_WORKDOCS_MK_VERSION)

# WDS_DOCUMENT_ID?= 5be8e7acf4da5bab82515ac0543e1ef575cacd8ab18471d980d0a5f3ccd7b48a
# WDS_DOCUMENT_NAME?= my-document-name.pdf
# WDS_DOCUMENTS_SET_NAME?=

# Derived parameters
WDS_DOCUMENT_NAME?= $(WDS_DOCUMENT_EMAIL)

# Option parameters
__WDS_DOCUMENT_ID= $(if $(WDS_DOCUMENT_ID), --document-id $(WDS_DOCUMENT_ID))

# UI parameters
WDS_UI_VIEW_DOCUMENTS_FIELDS?=
WDS_UI_VIEW_DOCUMENTS_SET_FIELDS?= $(WDS_UI_VIEW_DOCUMENTS_FIELDS)
WDS_UI_VIEW_DOCUMENTS_SET_SLICE?=

#--- Utilities

#--- MACROS

_wds_get_document_id= $(call _wds_get_document_id_N, $(WDS_DOCUMENT_NAME))
_wds_get_document_id_N= $(call _wds_get_document_id_NO, $(1), $(WDS_DOCUMENT_ORGANIZATION_ID))
_wds_get_document_id_NO= "$(shell $(AWS) workdocs describe-documents --organization-id $(2) --query "Users[?Username=='$(strip $(1))'].Id" --output text)"

#----------------------------------------------------------------------
# USAGE
#

_wds_view_framework_macros ::
	@echo 'AWS::WorkDocS::User ($(_AWS_WORKDOCS_DOCUMENT_MK_VERSION)) macros:'
	@echo '    _wds_get_document_id_{|N|NO}                     - Get the ID of a document (Name,OrganizationId)'
	@echo

_wds_view_framework_parameters ::
	@echo 'AWS::WorkDocS::User ($(_AWS_WORKDOCS_DOCUMENT_MK_VERSION)) parameters:'
	@echo '    WDS_DOCUMENT_ID=$(WDS_DOCUMENT_ID)'
	@echo '    WDS_DOCUMENT_NAME=$(WDS_DOCUMENT_NAME)'
	@echo '    WDS_DOCUMENTS_SET_NAME=$(WDS_DOCUMENTS_SET_NAME)'
	@echo

_wds_view_framework_targets ::
	@echo 'AWS::WorkDocS::User ($(_AWS_WORKDOCS_DOCUMENT_MK_VERSION)) targets:'
	@echo '    _wds_create_document                           - Create a new document'
	@echo '    _wds_delete_document                           - Delete an existing document'
	@echo '    _wds_show_document                             - Show everything related to a document'
	@echo '    _wds_update_document                           - Update a document'
	@echo '    _wds_view_documents                            - View documents'
	@echo '    _wds_view_documents_set                        - View a set of documents'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_wds_create_document:
	@$(INFO) '$(AWS_UI_LABEL)Creating document "$(WDS_DOCUMENT_NAME)" ...'; $(NORMAL)
	$(AWS) workdocs create-document $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_NAME__DOCUMENT) $(__WDS_PARENT_DOCUMENT_ID)

_wds_delete_document:
	@$(INFO) '$(AWS_UI_LABEL)Deleting document "$(WDS_DOCUMENT_NAME)" ...'; $(NORMAL)
	$(AWS) workdocs delete-document $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_DOCUMENT_ID)

_wds_show_document: _wds_show_document_versions

_wds_show_document_versions:
	@$(INFO) '$(AWS_UI_LABEL)Showing versions of document "$(WDS_DOCUMENT_NAME)" ...'; $(NORMAL)
	$(AWS)  workdocs describe-document-versions  $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_DOCUMENT_ID) $(__WDS_FIELDS) $(__WDS_INCLUDE) 

_wds_view_documents:
	@$(INFO) '$(AWS_UI_LABEL)Viewing documents ...'; $(NORMAL)
	#$(AWS) workdocs describe-documents $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_FIELDS) $(__WDS_INCLUDE) $(__WDS_ORDER) $(__WDS_ORGANIZATION_ID) $(__WDS_SORT) $(__WDS_DOCUMENT_IDS) $(__WDS_DOCUMENT_QUERY) --query "Users[$(WDS_UI_VIEW_DOCUMENTS_SET_SLICE)]$(WDS_UI_VIEW_DOCUMENTS_SET_FIELDS)"

_wds_view_documents_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing documents-set "$(WDS_DOCUMENTS_SET_NAME)" ...'; $(NORMAL)
	@#$(WARN) 'Users are grouped based on the provided document-ids, organization-id, slice'; $(NORMAL)
	#$(AWS) workdocs describe-documents $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_FIELDS) $(__WDS_INCLUDE) $(__WDS_ORDER) $(__WDS_ORGANIZATION_ID) $(__WDS_SORT) $(__WDS_DOCUMENT_IDS) $(__WDS_DOCUMENT_QUERY) --query "Users[$(WDS_UI_VIEW_DOCUMENTS_SET_SLICE)]$(WDS_UI_VIEW_DOCUMENTS_SET_FIELDS)"
