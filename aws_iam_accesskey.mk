_AWS_IAM_ACCESSKEY_MK_VERSION= $(_AWS_IAM_MK_VERSION)

# IAM_ACCESSKEY_NAME?= velero
# IAM_ACCESSKEY_USER?= velero

# Derived parameters
IAM_ACCESSKEY_NAME?= $(IAM_USER_NAME)
IAM_ACCESSKEY_USER_NAME?= $(IAM_USER_NAME)

# Option parameters
__IAM_USER_NAME__ACCESSKEY= $(if $(IAM_ACCESSKEY_USER_NAME),--user-name $(IAM_ACCESSKEY_USER_NAME))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#
_iam_list_macros ::
	@#echo 'AWS::IAM::AccessKey ($(_AWS_IAM_ACCESSKEY_MK_VERSION)) macros:'
	@#echo

_iam_list_parameters ::
	@echo 'AWS::IAM::AccessKey ($(_AWS_IAM_ACCESSKEY_MK_VERSION)) parameters:'
	@echo '    IAM_ACCESSKEY_NAME=$(IAM_ACCESSKEY_NAME)'
	@echo '    IAM_ACCESSKEY_USER_NAME=$(IAM_ACCESSKEY_USER_NAME)'
	@echo

_iam_list_targets ::
	@echo 'AWS::IAM::AccessKey ($(_AWS_IAM_ACCESSKEY_MK_VERSION)) targets:'
	@echo '    _iam_create_accesskey    - Create an access-key'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_iam_create_accesskey:
	@$(INFO) '$(IAM_UI_LABEL)Creating access-key "$(AWS_ACCESSKEY_NAME)" ...'; $(NORMAL)
	$(AWS) iam create-access-key $(__IAM_USER_NAME__ACCESSKEY)

_iam_list_accesskeys:
	@$(INFO) '$(IAM_UI_LABEL)Listing ALL access-keys for all users ...'; $(NORMAL)
	@$(WARN) 'User names: $(IAM_USER_NAMES)'; $(NORMAL)
	@$(foreach U, $(IAM_USER_NAMES), \
		$(MAKE) --no-print-directory --quiet IAM_USER_NAME=$(U) __iam_show_accesskeys; \
	)
