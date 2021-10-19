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
_iam_view_framework_macros ::
	@echo 'AWS::IAM::AccessKey ($(_AWS_IAM_ACCESSKEY_MK_VERSION)) macros:'
	@echo

_iam_view_framework_parameters ::
	@echo 'AWS::IAM::AccessKey ($(_AWS_IAM_ACCESSKEY_MK_VERSION)) parameters:'
	@echo '    IAM_ACCESSKEY_NAME=$(IAM_ACCESSKEY_NAME)'
	@echo '    IAM_ACCESSKEY_USER_NAME=$(IAM_ACCESSKEY_USER_NAME)'
	@echo

_iam_view_framework_targets ::
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


_iam_view_accesskeys:
	@$(INFO) '$(IAM_UI_LABEL)Viewing access-keys for all users ...'; $(NORMAL)
	@$(WARN) 'User names: $(IAM_USER_NAMES)'; $(NORMAL)
	@$(foreach U, $(IAM_USER_NAMES), \
		$(MAKE) --no-print-directory --quiet IAM_USER_NAME=$(U) __iam_show_accesskeys; \
	)
