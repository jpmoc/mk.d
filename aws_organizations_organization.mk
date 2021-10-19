_AWS_ORGANIZATIONS_ORGANIZATION_MK_VERSION= $(_AWS_ORGANIZATIONS_MK_VERSION)

OZS_ORGANIZATION_FEATURE_SET?= ALL

# Derived parameters 

# Option parameters
__OZS_FEATURE_SET= $(if $(OZS_ORGANIZATION_FEATURE_SET), --feature-set $(OZS_ORGANIZATION_FEATURE_SET))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ozs_view_framework_macros ::
	@echo 'AWS::OrganiZationS::Organization ($(_AWS_ORGANIZATIONS_ORGANIZATION_MK_VERSION)) targets:'
	@echo

_ozs_view_framework_parameters ::
	@echo 'AWS::OrganiZationS::Organization ($(_AWS_ORGANIZATIONS_ORGANIZATION_MK_VERSION)) parameters:'
	@echo

_ozs_view_framework_targets ::
	@echo 'AWS::OrganiZationS::Organization ($(_AWS_ORGANIZATIONS_ORGANIZATION_MK_VERSION)) targets:'
	@echo '    _ozs_show_organization             - Show organization the current AWS account is in'
	@echo '    _ozs_show_organization_accounts    - Show all AWS accounts in organization'
	@echo '    _ozs_show_organization_roots       - Show roots of the organization'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_ozs_create_organization:
	@$(INFO) '$(AWS_LABEL)Creating an organization ...'; $(NORMAL)
	@$(WARN) 'This account "$(AWS_ACCOUNT_ID)" is now the master account of the new organization'; $(NORMAL)
	$(AWS) organizations create-organization $(__OZS_FEATURE_SET)

_ozs_delete_organization:
	@$(INFO) '$(AWS_LABEL)Deleting an organization ...'; $(NORMAL)
	@$(WARN) 'This operation needs to be executed in the master account'; $(NORMAL)
	@$(WARN) 'This operation will succeed only if the organization is empty of member accounts, organizational units (OUs), and policies'; $(NORMAL)
	$(AWS) organizations create-organization $(__OZS_FEATURE_SET)

_ozs_show_organization: _ozs_show_organization_accounts _ozs_show_organization_roots _ozs_show_prganization_description

_ozs_show_organization_description:
	@$(INFO) '$(AWS_LABEL)Showing organization ...'; $(NORMAL)
	$(AWS) organizations describe-organization

_ozs_show_organization_accounts:
	@$(INFO) '$(AWS_LABEL)Showing accounts in organization ...'; $(NORMAL)
	$(AWS) organizations list-accounts

_ozs_show_organization_roots:
	@$(INFO) '$(AWS_LABEL)Showing roots of organization ...'; $(NORMAL)
	$(AWS) organizations list-roots

_ozs_view_organization:
