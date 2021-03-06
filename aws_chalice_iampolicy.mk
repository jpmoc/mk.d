_AWS_CHALICE_IAMPOLICY_MK_VERSION= $(_AWS_CHALICE_MK_VERSION)

# CLE_IAMPOLICY_NAME?= localapi::cle-app
# CLE_IAMPOLICY_PROJECT_DIRPATH?= ./projects/hello-chalice/
# CLE_IAMPOLICY_PROJECT_NAME?= hello-chalice 
# CLE_IAMPOLICY_PROJECT_RUNTIME?= python3.7

# Derived parameters
CLE_IAMPOLICY_NAME?= $(CLE_PROJECT_NAME)
CLE_IAMPOLICY_PROJECT_DIRPATH?= $(CLE_PROJECT_DIRPATH)
CLE_IAMPOLICY_PROJECT_NAME?= $(CLE_PROJECT_NAME)

# Options parameters

# Pipe parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_sam_view_framework_macros ::
	@echo 'AWS::Chalice::IamPolicy ($(_AWS_CHALICE_IAMPOLICY_MK_VERSION)) macros:'
	@echo

_sam_view_framework_parameters ::
	@echo 'AWS::Chalice::IamPolicy ($(_AWS_CHALICE_IAMPOLICY_MK_VERSION)) parameters:'
	@echo '    CLE_IAMPOLICY_NAME=$(CLE_IAMPOLICY_NAME)'
	@echo '    CLE_IAMPOLICY_PROJECT_DIRPATH=$(CLE_IAMPOLICY_PROJECT_DIRPATH)'
	@echo '    CLE_IAMPOLICY_PROJECT_NAME=$(CLE_IAMPOLICY_PROJECT_NAME)'
	@echo '    CLE_IAMPOLICY_PROJECT_RUNTIME=$(CLE_IAMPOLICY_PROJECT_RUNTIME)'
	@echo

_cle_view_framework_targets ::
	@echo 'AWS::Chalice::IamPolicy ($(_AWS_CHALICE_IAMPOLICY_MK_PROJECT_VERSION)) targets:'
	@echo '    _cle_view_iampolicies                 - View autogenerated iam policies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cle_view_iampolicies:
	@$(INFO) '$(CLE_UI_LABEL)IVewing IAM policies ...'; $(NORMAL)
	@$(WARN) 'THe IAM policies are grouped based on project'; $(NORMAL)
	$(_CLE_VIEW_IAMPOLICIES_|) $(CHALICE) gen...
