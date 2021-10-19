_AWS_SSM_DOCUMENT_MK_VERSION =$(_AWS_SSM_MK_VERSION)

# SSM_DOCUMENT_CONTENT?=
# SSM_DOCUMENT_CONTENT_FILEPATH?= ./document-content.json
# SSM_DOCUMENT_FILTER_LIST?= key=string,value=string ...
SSM_DOCUMENT_FORMAT?= JSON
# SSM_DOCUMENT_NAME?= my-document
# SSM_DOCUMENT_PERMISSION_TYPE?= Share
# SSM_DOCUMENT_SHARE_ACCOUNTIDS?= All
# SSM_DOCUMENT_TARGET_TYPE?= /AWS::EC2::Instance
# SSM_DOCUMENT_TYPE?= Command
# SSM_DOCUMENT_VERSION?= 1
# SSM_DOCUMENTS_SET_NAME?= my-documents-set
# SSM_DOCUMENTS_SET_OWNER?= 123456789012
# SSM_DOCUMENTS_SET_PLATFORMTYPES?= Linux
# SSM_DOCUMENTS_SET_TYPE?= Command

# Derived variables
SSM_DOCUMENT_CONTENT?=  $(if $(SSM_DOCUMENT_CONTENT_FILEPATH),file://$(SSM_DOCUMENT_CONTENT_FILEPATH))
SSM_DOCUMENT_FILTER_LIST+= $(if $(SSM_DOCUMENTS_SET_NAME), key=Name$(COMMA)value=$(SSM_DOCUMENTS_SET_NAME))
SSM_DOCUMENT_FILTER_LIST+= $(if $(SSM_DOCUMENTS_SET_OWNER), key=Owner$(COMMA)value=$(SSM_DOCUMENTS_SET_OWNER))
SSM_DOCUMENT_FILTER_LIST+= $(if $(SSM_DOCUMENTS_SET_PLATFORMTYPES), key=PlatformTypes$(COMMA)value=$(SSM_DOCUMENTS_SET_PLATFORMTYPES))
SSM_DOCUMENT_FILTER_LIST+= $(if $(SSM_DOCUMENTS_SET_TYPE), key=DocumentType$(COMMA)value=$(SSM_DOCUMENTS_SET_TYPE))

# Option variables
__SSM_ACCOUNT_IDS_TO_ADD= $(if $(SSM_DOCUMENT_SHARE_ACCOUNTIDS), --account-ids-to-add $(SSM_DOCUMENT_SHARE_ACCOUNTIDS))
__SSM_ACCOUNT_IDS_TO_REMOVE= $(if $(SSM_DOCUMENT_SHARE_ACCOUNTIDS), --account-ids-to-remove $(SSM_DOCUMENT_SHARE_ACCOUNTIDS))
__SSM_CONTENT= $(if $(SSM_DOCUMENT_CONTENT), --content $(SSM_DOCUMENT_CONTENT))
__SSM_DOCUMENT_FILTER_LIST= $(if $(SSM_DOCUMENT_FILTER_LIST), --document-filter-list $(SSM_DOCUMENT_FILTER_LIST))
__SSM_DOCUMENT_FORMAT= $(if $(SSM_DOCUMENT_FORMAT), --document-format $(SSM_DOCUMENT_FORMAT))
__SSM_DOCUMENT_TYPE= $(if $(SSM_DOCUMENT_TYPE), --document-type $(SSM_DOCUMENT_TYPE))
__SSM_DOCUMENT_VERSION= $(if $(SSM_DOCUMENT_VERSION), --document-version $(SSM_DOCUMENT_VERSION))
__SSM_FILTERS_DOCUMENT=
__SSM_NAME_DOCUMENT= $(if $(SSM_DOCUMENT_NAME), --name $(SSM_DOCUMENT_NAME))
__SSM_PERMISSION_TYPE= $(if $(SSM_DOCUMENT_PERMISSION_TYPE), --permission-type $(SSM_DOCUMENT_PERMISSION_TYPE))
__SSM_TARGET_TYPE= $(if $(SSM_DOCUMENT_TARGET_TYPE), --target-type $(SSM_DOCUMENT_TARGET_TYPE))

# UI variables
SSM_UI_SHOW_DOCUMENT_OVERVIEW_FIELDS?= .{CreatedDate:CreatedDate,DefaultVersion:DefaultVersion,Desription:Description,DocumentFormat:DocumentFormat,DocumentVersion:DocumentVersion,Hash:Hash,HashType:HashType,LatestVersion:LatestVersion,Owner:Owner,SchemaVersion:SchemaVersion,Status:Status,PlatformTypes:PlatformTypes,Tags:Tags,Parameters:Parameters[].{Name:Name,defaultValue:DefaultValue,type:Type}}
SSM_UI_VIEW_DOCUMENTS_FIELDS?= .{document_FVT:join(' ',[DocumentFormat,DocumentVersion,DocumentType]),Name:Name,owner:Owner,schemaVersion:SchemaVersion,targetType:TargetType,platformTypes:join(' ',PlatformTypes)}

#--- Utilities

#--- MACRO
_ssm_get_document_format= $(call _ssm_get_document_format_N, $(SSM_DOCUMENT_NAME))
_ssm_get_document_format_N= $(shell $(AWS) ssm describe-document --name $(1) --query "Document.DocumentFormat" --output text)

_ssm_get_document_version= $(call _ssm_get_document_version_N, $(SSM_DOCUMENT_NAME))
_ssm_get_document_version_N= $(shell $(AWS) ssm describe-document --name $(1) --query "Document.DocumentVersion" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ssm_view_makefile_macros ::
	@echo 'AWS::SSM::Document ($(_AWS_SSM_DOCUMENT_MK_VERSION)) macros:'
	@echo '    _ssm_get_document_format_{|N}               - Get format of document (Name)'
	@echo '    _ssm_get_document_version_{|N}              - Get current version of document (Name)'
	@echo

_ssm_view_makefile_targets ::
	@echo 'AWS::SSM::Document ($(_AWS_SSM_DOCUMENT_MK_VERSION)) targets:'
	@echo '    _ssm_create_document                        - Create a document'
	@echo '    _ssm_delete_document                        - Delete a document'
	@echo '    _ssm_share_document                         -  a document'
	@echo '    _ssm_show_document                          - Show details about a document'
	@echo '    _ssm_show_document_content                  - Show content of a document'
	@echo '    _ssm_show_document_overview                 - Show overview of a document'
	@echo '    _ssm_show_document_shares                   - Show accounts with which the document has been shared'
	@echo '    _ssm_show_document_versions                 - Show versions of a document'
	@echo '    _ssm_unshare_document                       - Unshare a document'
	@echo '    _ssm_view_documents                         - View documents'
	@echo '    _ssm_view_documents_aws                     - View documents owned by AWS'
	@echo '    _ssm_view_documents_self                    - View documents ovnwed by self'
	@echo '    _ssm_view_documents_set                     - View a set of documents'
	@echo

_ssm_view_makefile_variables ::
	@echo 'AWS::SSM::Document ($(_AWS_SSM_DOCUMENT_MK_VERSION)) variables:'
	@echo '    SSM_DOCUMENT_FORMAT=$(SSM_DOCUMENT_FORMAT)'
	@echo '    SSM_DOCUMENT_NAME=$(SSM_DOCUMENT_NAME)'
	@echo '    SSM_DOCUMENT_PERMISSION_TYPE=$(SSM_DOCUMENT_PERMISSION_TYPE)'
	@echo '    SSM_DOCUMENT_SHARE_ACCOUNTIDS=$(SSM_DOCUMENT_SHARE_ACCOUNTIDS)'
	@echo '    SSM_DOCUMENT_TARGET_TYPE=$(SSM_DOCUMENT_TARGET_TYPE)'
	@echo '    SSM_DOCUMENT_TYPE=$(SSM_DOCUMENT_TYPE)'
	@echo '    SSM_DOCUMENT_VERSION=$(SSM_DOCUMENT_NAME)'
	@echo '    SSM_DOCUMENTS_NAME=$(SSM_DOCUMENTS_NAME)'
	@echo '    SSM_DOCUMENTS_SET_NAME=$(SSM_DOCUMENTS_SET_NAME)'
	@echo '    SSM_DOCUMENTS_SET_OWNER=$(SSM_DOCUMENTS_SET_OWNER)'
	@echo '    SSM_DOCUMENTS_SET_PLATFORMTYPES=$(SSM_DOCUMENTS_SET_PLATFORMTYPES)'
	@echo '    SSM_DOCUMENTS_SET_TYPE=$(SSM_DOCUMENTS_SET_TYPE)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ssm_create_document:
	@$(INFO) '$(AWS_UI_LABEL)Creating document "$(SSM_DOCUMENT_NAME)" ...'; $(NORMAL)
	$(AWS) ssm create-document $(__SSM_CONTENT) $(__SSM_DOCUMENT_FORMAT) $(__SSM_DOCUMENT_TYPE) $(__SSM_NAME_DOCUMENT) $(__SSM_TARGET_TYPE)

_ssm_delete_document:
	@$(INFO) '$(AWS_UI_LABEL)Deleting document "$(SSM_DOCUMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation will fail if the document to delete is still shared!'; $(NORMAL)
	$(AWS) ssm delete-document $(__SSM_NAME_DOCUMENT)

_ssm_share_document:
	@$(INFO) '$(AWS_UI_LABEL)Updating permission of document "$(SSM_DOCUMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation will fail (1) if you are not the owner of the document!'; $(NORMAL)
	@$(WARN) '                         (2) if the document has already been share with the same accounts!'; $(NORMAL)
	-$(AWS) ssm modify-document-permission $(__SSM_ACCOUNT_IDS_TO_ADD) $(_X__SSM_ACCOUNT_IDS_TO_REMOVE) $(__SSM_NAME_DOCUMENT) $(_X__SSM_PERMISSION_TYPE) --permission-type Share

_ssm_show_document: _ssm_show_document_versions _ssm_show_document_shares _ssm_show_document_content _ssm_show_document_parameters_descriptions _ssm_show_document_overview

_ssm_show_document_content:
	@$(INFO) '$(AWS_UI_LABEL)Showing content of document "$(SSM_DOCUMENT_NAME)" ...'; $(NORMAL)
	$(HIGHLIGHT); $(AWS) ssm get-document $(__SSM_DOCUMENT_FORMAT) $(__SSM_DOCUMENT_VERSION) $(__SSM_NAME_DOCUMENT) --query "Content" --output text; $(NORMAL)

_ssm_show_document_overview:
	@$(INFO) '$(AWS_UI_LABEL)Showing overview of document "$(SSM_DOCUMENT_NAME)" ...'; $(NORMAL)
	$(AWS) ssm describe-document $(__SSM_DOCUMENT_VERSION) $(__SSM_NAME_DOCUMENT) --query "Document$(SSM_UI_SHOW_DOCUMENT_OVERVIEW_FIELDS)"

_ssm_show_document_parameters_descriptions:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of parameters in document "$(SSM_DOCUMENT_NAME)" ...'; $(NORMAL)
	$(AWS) ssm describe-document $(__SSM_DOCUMENT_VERSION) $(__SSM_NAME_DOCUMENT) --query "Document.Parameters[].{Name:Name,description:Description}"

_ssm_show_document_shares:
	@$(INFO) '$(AWS_UI_LABEL)Showing accounts with which the document "$(SSM_DOCUMENT_NAME)" is shared ...'; $(NORMAL)
	$(AWS) ssm describe-document-permission $(__SSM_NAME_DOCUMENT) $(_X__SSM_PERMISSION_TYPE) --permission-type Share

_ssm_show_document_versions:
	@$(INFO) '$(AWS_UI_LABEL)Showing versions of document "$(SSM_DOCUMENT_NAME)" ...'; $(NORMAL)
	$(AWS) ssm list-document-versions $(__SSM_NAME_DOCUMENT)

_ssm_unshare_document:
	@$(INFO) '$(AWS_UI_LABEL)Unsharing document "$(SSM_DOCUMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation will fail if you are not the owner of the document!'; $(NORMAL)
	-$(AWS) ssm modify-document-permission $(_X__SSM_ACCOUNT_IDS_TO_ADD) $(__SSM_ACCOUNT_IDS_TO_REMOVE) $(__SSM_NAME_DOCUMENT) $(_X__SSM_PERMISSION_TYPE) --permission-type Share

_ssm_view_documents:
	@$(INFO) '$(AWS_UI_LABEL)Viewing documents ...'; $(NORMAL)
	$(AWS) ssm list-documents $(_X__SSM_DOCUMENT_FILTER_LIST) $(_X__SSM_FILTERS_DOCUMENT) --query "DocumentIdentifiers[]$(SSM_UI_VIEW_DOCUMENTS_FIELDS)"

_ssm_view_documents_aws: SSM_DOCUMENTS_OWNER= Amazon
_ssm_view_documents_aws:
	@$(INFO) '$(AWS_UI_LABEL)Viewing documents owned by "$(SSM_DOCUMENTS_OWNER)" ...'; $(NORMAL)
	$(AWS) ssm list-documents $(_X__SSM_DOCUMENT_FILTER_LIST) $(_X__SSM_FILTERS_DOCUMENT) --document-filter-list key=Owner,value=$(SSM_DOCUMENTS_OWNER) --query "DocumentIdentifiers[]$(SSM_UI_VIEW_DOCUMENTS_FIELDS)"

_ssm_view_documents_self: SSM_DOCUMENTS_OWNER= self
_ssm_view_documents_self:
	@$(INFO) '$(AWS_UI_LABEL)Viewing documents owned by "$(SSM_DOCUMENTS_OWNER)" ...'; $(NORMAL)
	$(AWS) ssm list-documents $(_X__SSM_DOCUMENT_FILTER_LIST) $(_X__SSM_FILTERS_DOCUMENT) --document-filter-list key=Owner,value=$(SSM_DOCUMENTS_OWNER)  --query "DocumentIdentifiers[]$(SSM_UI_VIEW_DOCUMENTS_FIELDS)"

_ssm_view_documents_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing documents-set "$(SSM_DOCUMENTS_SET_NAME)" ...'; $(NORMAL)
	$(AWS) ssm list-documents $(__SSM_DOCUMENT_FILTER_LIST) $(__SSM_FILTERS_DOCUMENT) --query "DocumentIdentifiers[]$(SSM_UI_VIEW_DOCUMENTS_FIELDS)"
