_AWS_WORKMAIL_ORGANIZATION_MK_VERSION= $(_AWS_WORKMAIL_MK_VERSION)

# WML_ORGANIZATION_DIRECTORY_ID?=
# WML_ORGANIZATION_ID?= m-637f623935dc457e91720e5036eefb62
# WML_ORGANIZATION_MAILDOMAIN?= subdomain.awsapps.com
# WML_ORGANIZATION_NAME?= subdomain
# WML_ORGANIZATIONS_SET_NAME?= my-organizations-set

# Derived parameters
WML_ORGANIZATION_MAILDOMAIN?= $(if $(WML_ORGANIZATION_NAME),$(WML_ORGANIZATION_NAME).awsapps.com)

# Option parameters
__WML_ORGANIZATION_ID?= $(if $(WML_ORGANIZATION_ID), --organization-id $(WML_ORGANIZATION_ID))

# UI parameters

#--- Utilities

#--- MACROS
_wml_get_organization_directory_id= $(call _wml_get_organization_directory_id_I, $(WML_ORGANIZATION_ID))
_wml_get_organization_directory_id_I= $(shell $(AWS) workmail describe-organization --organization-id $(1) --query "DirectoryId" --output text)

_wml_get_organization_id= $(call _wml_get_organization_id_N, $(WML_ORGANIZATION_NAME))
_wml_get_organization_id_N= $(shell $(AWS) workmail list-organizations --query "OrganizationSummaries[?Alias=='$(strip $(1))'].OrganizationId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_wml_view_framework_macros ::
	@echo 'AWS::WorkMaiL::Organization ($(_AWS_WORKMAIL_ORGANIZATION_MK_VERSION)) macros:'
	@echo '    _wml_get_organization_directory_id_{|I}        - Get the ID of the directory used by an organization'
	@echo '    _wml_get_organization_id_{|N}                  - Get the ID of an organization'
	@echo

_wml_view_framework_parameters ::
	@echo 'AWS::WorkMaiL::Organization ($(_AWS_WORKMAIL_ORGANIZATION_MK_VERSION)) parameters:'
	@echo '    WML_ORGANIZATION_DIRECTORY_ID=$(WML_ORGANIZATION_DIRECTORY_ID)'
	@echo '    WML_ORGANIZATION_ID=$(WML_ORGANIZATION_ID)'
	@echo '    WML_ORGANIZATION_MAILDOMAIN=$(WML_ORGANIZATION_MAILDOMAIN)'
	@echo '    WML_ORGANIZATION_NAME=$(WML_ORGANIZATION_NAME)'
	@echo '    WML_ORGANIZATIONS_SET_NAME=$(WML_ORGANIZATIONS_SET_NAME)'
	@echo

_wml_view_framework_targets ::
	@echo 'AWS::WorkMaiL::Organization ($(_AWS_WORKMAIL_ORGANIZATION_MK_VERSION)) targets:'
	@echo '    _wml_show_organization               - Show everythig related to an organization'
	@echo '    _wml_view_organizations              - View organizations'
	@echo '    _wml_view_organizations_set          - View a set of organizations'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_wml_show_organization:
	@$(INFO) '$(AWS_UI_LABEL)Show organization "$(WML_ORGANIZATION_NAME)" ...'; $(NORMAL)
	$(AWS) workmail describe-organization $(__WML_ORGANIZATION_ID)

_wml_view_organizations:
	@$(INFO) '$(AWS_UI_LABEL)View organizations ...'; $(NORMAL)
	$(AWS) workmail list-organizations --query "OrganizationSummaries[]"

_wml_view_organizations_set:
	@$(INFO) '$(AWS_UI_LABEL)View organizations-set "$(WML_ORGANIZATIONS_SET_NAME)" ...'; $(NORMAL)
	$(AWS) workmail list-organizations --query "OrganizationSummaries[]"
