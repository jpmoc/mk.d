_AWS_IAM_MFADEVICE_MK_VERSION= $(_AWS_IAM_MK_VERSION)

# IAM_MFADEVICE_ARN?= arn:aws:iam::123456789012:mfa/BobMuller
# IAM_MFADEVICE_BOOTSTRAPMETHOD?= QRCodePNG
# IAM_MFADEVICE_NAME?= my-mfa-device
IAM_MFADEVICE_PATH?= /
# IAM_MFADEVICE_QRCODE_DIRPATH?= ./out/
# IAM_MFADEVICE_QRCODE_FILENAME?= QRcode.png
# IAM_MFADEVICE_QRCODE_FILEPATH?= ./out/QRcode.png
# IAM_MFADEVICE_TOKENCODE?= 123456
# IAM_MFADEVICE_TOKENCODE1?= 123456
# IAM_MFADEVICE_TOKENCODE2?= 123456
# IAM_MFADEVICE_USER_NAME?= emayssat
IAM_MFADEVICES_ASSIGNMENT_STATUS?= Any

# Derived parameters
IAM_MFADEVICE_ARN?= arn:aws:iam:$(AWS_ACCOUNT_ID):mfa/$(IAM_MFADEVICE_NAME)
IAM_MFADEVICE_NAME?= $(IAM_USER_NAME)
IAM_MFADEVICE_QRCODE_DIRPATH?= $(IAM_OUTPUTS_DIRPATH)
IAM_MFADEVICE_QRCODE_FILEPATH?= $(IAM_MFADEVICE_QRCODE_DIRPATH)$(IAM_MFADEVICE_QRCODE_FILENAME)
IAM_MFADEVICE_TOKENCODE1?= $(IAM_MFADEVICE_TOKENCODE)
IAM_MFADEVICE_TOKENCODE2?= $(IAM_MFADEVICE_TOKENCODE)
IAM_MFADEVICE_USER_NAME?= $(IAM_USER_NAME)

# Options
__IAM_ASSIGNMENT_STATUS= $(if $(IAM_MFADEVICES_ASSIGNMENT_STATUS),--assignment-status $(IAM_MFADEVICES_ASSIGNMENT_STATUS))
__IAM_AUTHENTICATION_CODE_1= $(if $(IAM_MFADEVICE_TOKENCODE1),--authentication-code-1 $(IAM_MFADEVICE_TOKENCODE1))
__IAM_AUTHENTICATION_CODE_2= $(if $(IAM_MFADEVICE_TOKENCODE2),--authentication-code-2 $(IAM_MFADEVICE_TOKENCODE2))
__IAM_BOOTSTRAP_METHOD= $(if $(IAM_MFADEVICE_BOOTSTRAPMETHOD),--bootstrap-method $(IAM_MFADEVICE_BOOTSTRAPMETHOD))
__IAM_OUTFILE= $(if $(IAM_MFADEVICE_QRCODE_FILEPATH),--outfile $(IAM_MFADEVICE_QRCODE_FILEPATH))
__IAM_PATH_MFADEVICE= $(if $(IAM_MFADEVICE_PATH),--path $(IAM_MFADEVICE_PATH))
__IAM_SERIAL_NUMBER= $(if $(IAM_USER_MFADEVICE_ARN),--serial-number $(IAM_USER_MFADEVICE_ARN))
__IAM_USER_NAME_MFADEVICE= $(if $(IAM_MFADEVICE_USER_NAME),--user-name $(IAM_MFADEVICE_USER_NAME))
__IAM_VIRTUAL_MFA_DEVICE_NAME= $(if $(IAM_MFADEVICE_NAME),--virtual-mfa-device-name $(IAM_MFADEVICE_NAME))

# Customizations
_IAM_LIST_MFADEVICES_FIELDS?= .{SerialNumber:SerialNumber,EnableDate:EnableDate}
_IAM_LIST_MFADEVICES_SET_FIELDS?= $(_IAM_LIST_MFADEVICES_FIELDS)
_IAM_LIST_MFADEVICES_SET_QUERYFILTER?=

# Macros
_iam_get_mfadevice_arn= $(call _iam_get_user_mfadevice_arn_U, $(IAM_MFADEVICE_NAME))
_iam_get_mfadevice_arn_U= $(shell echo arn:aws:iam::$(AWS_ACCOUNT_ID):mfa/$(strip $(1)))

#----------------------------------------------------------------------
# USAGE
#

_iam_list_macros ::
	@echo 'AWS::IAM::MfaDevice ($(_AWS_IAM_MFADEVICE_MK_VERSION)) macros:'
	@echo '    _iam_get_mfadevice_arn_{|U}     - Get the ARN of MFA-device of a user (Username)'
	@echo

_iam_list_parameters ::
	@echo 'AWS::IAM::MfaDevice ($(_AWS_IAM_MFADEVICE_MK_VERSION)) parameters:'
	@echo '    IAM_MFADEVICE_ARN=$(IAM_MFADEVICE_ARN)'
	@echo '    IAM_MFADEVICE_BOOTSTRAPMETHOD=$(IAM_MFADEVICE_BOOTSTRAPMETHOD)'
	@echo '    IAM_MFADEVICE_NAME=$(IAM_MFADEVICE_NAME)'
	@echo '    IAM_MFADEVICE_PATH=$(IAM_MFADEVICE_PATH)'
	@echo '    IAM_MFADEVICE_QRCODE_DIRPATH=$(IAM_MFADEVICE_QRCODE_DIRPATH)'
	@echo '    IAM_MFADEVICE_QRCODE_FILENAME=$(IAM_MFADEVICE_QRCODE_FILENAME)'
	@echo '    IAM_MFADEVICE_QRCODE_FILEPATH=$(IAM_MFADEVICE_QRCODE_FILEPATH)'
	@echo '    IAM_MFADEVICE_TOKENCODE=$(IAM_MFADEVICE_TOKENCODE)'
	@echo '    IAM_MFADEVICE_TOKENCODE1=$(IAM_MFADEVICE_TOKENCODE1)'
	@echo '    IAM_MFADEVICE_TOKENCODE2=$(IAM_MFADEVICE_TOKENCODE2)'
	@echo '    IAM_MFADEVICE_USER_NAME=$(IAM_MFADEVICE_USER_NAME)'
	@echo

_iam_list_targets ::
	@echo 'AWS::IAM::MfaDevice ($(_AWS_IAM_MFADEVICE_MK_VERSION)) targets:'
	@echo '    _iam_attach_mfadevice                - Attach a MFA-device to a user'
	@echo '    _iam_create_mfadevice                - Create a MFA-device'
	@echo '    _iam_delete_mfadevice                - Delete a MFA-device'
	@echo '    _iam_detach_mfadevice                - Detach a MFA-device from a user'
	@echo '    _iam_list_mfadevices                 - List all existing MFA-devices'
	@echo '    _iam_list_mfadevices_set             - List a set of MFA-devices'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_iam_attach_mfadevice:
	@$(INFO) '$(IAM_UI_LABEL)Attaching MFA-device "$(IAM_MFADEVICE_NAME)" to user "$(IAM_MFADEVICE_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam deactivate-mfa-device $(__IAM_SERIAL_NUMBER) $(__IAM_USER_NAME_MFADEVICE)

_iam_create_mfadevice:
	@$(INFO) '$(IAM_UI_LABEL)Creating MFA-device "$(IAM_MFADEVICE_NAME)" ...'; $(NORMAL)
	$(AWS) iam create-virtual-mfa-device $(__IAM_BOOTSTRAP_METHOD) $(__IAM_OUTFILE) $(__IAM_PATH_MFADEVICE) $(__IAM_VIRTUAL_MFA_DEVICE_NAME) --query "VirtualMFADevice"

_iam_delete_mfadevice:
	@$(INFO) '$(IAM_UI_LABEL)Deleting MFA-device "$(IAM_MFADEVICE_NAME)" ...'; $(NORMAL)
	$(AWS) iam delete-virtual-mfa-device $(__IAM_SERIAL_NUMBER)

_iam_detach_mfadevice:
	@$(INFO) '$(IAM_UI_LABEL)Detaching MFA-device from user "$(IAM_MFADEVICE_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam deactivate-mfa-device $(__IAM_SERIAL_NUMBER) $(__IAM_USER_NAME_MFADEVICE)

_iam_resync_mfadevice:
	@$(INFO) '$(IAM_UI_LABEL)Resyncing MFA-device "$(IAM_MFADEVICE_NAME)" from user "$(IAM_MFADEVICE_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam deactivate-mfa-device $(__IAM_AUTHENTICATION_CODE_1) $(__IAM_AUTHENTICATION_CODE_2) $(__IAM_SERIAL_NUMBER) $(__IAM_USER_NAME_MFADEVICE)

_iam_list_mfadevices:
	@$(INFO) '$(IAM_UI_LABEL)Listing ALL MFA-devices ...'; $(NORMAL)
	$(AWS) iam list-virtual-mfa-devices $(_X__IAM_ASSIGNMENT_STATUS) --query "VirtualMFADevices[]$(_IAM_LIST_MFADEVICES_FIELDS)"

_iam_list_mfadevices_set:
	@$(INFO) '$(IAM_UI_LABEL)List all MFA-devices ...'; $(NORMAL)
	@$(WARN) 'MFA devices are split in 2+ sets: Assigned, Unassigned, and Any'; $(NORMAL)
	$(AWS) iam list-virtual-mfa-devices $(__IAM_ASSIGNMENT_STATUS) --query "VirtualMFADevices[$(_IAM_LIST_MFADEVICES_SET_QUERYFILTER)]$(_IAM_LIST_MFADEVICES_SET_FIELDS)"
