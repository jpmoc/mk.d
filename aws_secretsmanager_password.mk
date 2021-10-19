_AWS_SECRETSMANAGER_PASSWORD_MK_VERSION= $(_AWS_SECRETSMANAGER_MK_VERSION)

# SMR_PASSWORD_EXCLUDE_CHARACTERS?= false
SMR_PASSWORD_EXCLUDE_LOWERCASE?= false
SMR_PASSWORD_EXCLUDE_NUMBERS?= false
SMR_PASSWORD_EXCLUDE_PUNCTUATION?= false
SMR_PASSWORD_EXCLUDE_UPPERCASE?= false
SMR_PASSWORD_INCLUDE_SPACE?= false
SMR_PASSWORD_LENGTH?= 32
SMR_PASSWORD_REQUIRE_INCLUDED?= true

# Derived parameters

# Options parameters
__SMR_EXCLUDE_CHARACTERS= $(if $(SMR_PASSWORD_EXCLUDE_CHARACTERS),--exclude-characters $(SMR_PASSWORD_EXCLUDE_CHARACTERS))
__SMR_EXCLUDE_LOWERCASE= $(if $(filter true, $(SMR_PASSWORD_EXCLUDE_LOWERCASE)),--exclude-lowercase, --no-exclude-lowercase)
__SMR_EXCLUDE_NUMBERS= $(if $(filter true, $(SMR_PASSWORD_EXCLUDE_NUMBERS)),--exclude-numbers, --no-exclude-numbers)
__SMR_EXCLUDE_PUNCTUATION= $(if $(filter true, $(SMR_PASSWORD_EXCLUDE_PUNCTUATION)),--exclude-punctuation, --no-exclude-punctuation)
__SMR_EXCLUDE_UPPERCASE= $(if $(filter true, $(SMR_PASSWORD_EXCLUDE_UPPERCASE)),--exclude-uppercase, --no-exclude-uppercase)
__SMR_PASSWORD_LENGTH= $(if $(SMR_PASSWORD_LENGTH),--password-length $(SMR_PASSWORD_LENGTH))
__SMR_REQUIRE_EACH_INCLUDED_TYPE= $(if $(filter false, $(SMR_PASSWORD_REQUIRE_INCLUDED)),--no-require-each-included-type, --require-each-included-type)

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_smr_view_framework_macros ::
	@echo 'AWS::SecretMnageR::Password ($(_AWS_SECRETSMANAGER_PASSWORD_MK_VERSION)) macros:'
	@echo

_smr_view_framework_parameters ::
	@echo 'AWS::SecretManageR::Password ($(_AWS_SECRETSMANAGER_PASSWORD_MK_VERSION)) parameters:'
	@echo '    SMR_PASSWORD_EXCLUDE_CHARACTERS=$(SMR_PASSWORD_EXCLUDE_CHARACTERS)'
	@echo '    SMR_PASSWORD_EXCLUDE_LOWERCASE=$(SMR_PASSWORD_EXCLUDE_LOWERCASE)'
	@echo '    SMR_PASSWORD_EXCLUDE_NUMBERS=$(SMR_PASSWORD_EXCLUDE_NUMBERS)'
	@echo '    SMR_PASSWORD_EXCLUDE_PUNCTUATION=$(SMR_PASSWORD_EXCLUDE_PUNCTUATION)'
	@echo '    SMR_PASSWORD_EXCLUDE_UPPERCASE=$(SMR_PASSWORD_EXCLUDE_UPPERCASE)'
	@echo '    SMR_PASSWORD_INCLUDE_SPACE=$(SMR_PASSWORD_INCLUDE_SPACE)'
	@echo '    SMR_PASSWORD_LENGTH=$(SMR_PASSWORD_LENGTH)'
	@echo '    SMR_PASSWORD_REQUIRE_INCLUDED=$(SMR_PASSWORD_REQUIRE_INCLUDED)'
	@echo

_smr_view_framework_targets ::
	@echo 'AWS::SecretManageR::Password ($(_AWS_SECRETSMANAGER_PASSWORD_MK_VERSION)) targets:'
	@echo '    _smr_generate_password                     - Generate a random password'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_smr_generate_password:
	@$(INFO) '$(SMR_UI_LABEL)Generating a random password ...'; $(NORMAL)
	$(AWS) secretsmanager get-random-password $(__SMR_EXCLUDE_CHARACTERS) $(__SMR_EXCLUDE_LOWERCASE) $(__SMR_EXCLUDE_NUMBERS) $(__SMR_EXCLUDE_PUNCTUATION) $(__SMR_EXCLUDE_UPPERCASE) $(__SMR_INCLUDE_SPACE) $(__SMR_PASSWORD_LENGTH) $(__SMR_REQUIRE_EACH_INCLUDED_TYPE)
