_AWS_KMS_FILE_MK_VERSION= $(_AWS_KMS_MK_VERSION)

# KMS_FILE_CIPHERTEXT_FILEPATH?= ./ciphertext.txt
# KMS_FILE_KEY_ID?=
# KMS_FILE_PLAINTEXT_FILEPATH?= ./plaintext.txt

# Derived parmeters
KMS_FILE_CIPHERTEXT?= $(if $(KMS_FILE_CIPHERTEXT_FILEPATH),fileb://$(KMS_FILE_CIPHERTEXT_FILEPATH))
KMS_FILE_KEY_ID?= $(KMS_KEY_ID)
KMS_FILE_PLAINTEXT?= $(if $(KMS_FILE_PLAINTEXT_FILEPATH),fileb://$(KMS_FILE_PLAINTEXT_FILEPATH))

# Options parmeters
__KMS_CIPHERTEXT_BLOB= $(if $(KMS_CIPHERTEXT),--ciphertext-blob $(KMS_CIPHERTEXT))
__KMS_ENCRYPTION_CONTEXT=
__KMS_KEY_ID__FILE= $(if $(KMS_FILE_KEY_ID),--key-id $(KMS_FILE_KEY_ID))
__KMS_PLAINTEXT= $(if $(KMS_PLAINTEXT),--plaintext $(KMS_PLAINTEXT))

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_kms_view_framework_macros ::
	@echo 'AWS::KMS::File ($(_AWS_KMS_FILE_MK_VERSION)) macros:'
	@echo

_kms_view_framework_parmeters ::
	@echo 'AWS::KMS::File ($(_AWS_KMS_FILE_MK_VERSION)) parmeters:'
	@echo '    KMS_FILE_CIPHERTEXT_FILEPATH=$(KMS_FILE_CIPHERTEXT_FILEPATH)'
	@echo '    KMS_FILE_CIPHERTEXT=$(KMS_FILE_CIPHERTEXT)'
	@echo '    KMS_FILE_KEY_ID=$(KMS_FILE_KEY_ID)'
	@echo '    KMS_FILE_NAME=$(KMS_FILE_NAME)'
	@echo '    KMS_FILE_PLAINTEXT_FILEPATH=$(KMS_FILE_PLAINTEXT_FILEPATH)'
	@echo '    KMS_FILE_PLAINTEXT=$(KMS_FILE_PLAINTEXT)'
	@echo

_kms_view_framework_targets ::
	@echo 'AWS::KMS::File ($(_AWS_KMS_FILE_MK_VERSION)) targets:'
	@echo '    _kms_decrypt_file       - Decrypt a ciphertext document with a KMS key'
	@echo '    _kms_encrypt_file       - Encrypt a plaintext document with a KMS key'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kms_decrypt_file:
	@$(INFO) '$(KMS_UI_LABEL)Decrypting ciphertext file "$(KMS_FILE_NAME)" ...'; $(NORMAL)
	$(AWS) kms decrypt $(__KMS_CIPHERTEXT_BLOB) $(__KMS_ENCRYPTION_CONTEXT) $(__KMS_KEY_ID__FILE) --query PaintextBlob --output text $(__KMS_>_PLAINTEXT)

_kms_encrypt_file:
	@$(INFO) '$(KMS_UI_LABEL)Encrypting plaintext file "$(KMS_FILE_NAME)" ...'; $(NORMAL)
	$(AWS) kms encrypt $(__KMS_KEY_ID__FILE) $(__KMS_PLAINTEXT) --query CiphertextBlob --output text $(__KMS_>_CIPHERTEXT)
