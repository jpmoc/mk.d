_AWS_EC2_KEYPAIR_MK_VERSION= $(_AWS_EC2_MK_VERSION)

EC2_KEYPAIR_DIRPATH?= $(HOME)/.ssh/
# EC2_KEYPAIR_NAME?= my-keypair
# EC2_KEYPAIR_PRIVATEKEY_DIRPATH?= ./in/
# EC2_KEYPAIR_PRIVATEKEY_FILENAME?=
# EC2_KEYPAIR_PRIVATEKEY_FILEPATH?=
# EC2_KEYPAIR_PUBLICKEY_DIRPATH?= ./in/
# EC2_KEYPAIR_PUBLICKEY_FILENAME?=
# EC2_KEYPAIR_PUBLICKEY_FILEPATH?=
# EC2_KEYPAIRS_DIRPATH?=
# EC2_KEYPAIRS_NAMES?=
# EC2_KEYPAIRS_SET_NAME?= my-keypairs-set

# Derived parameters 
EC2_KEYPAIR_NAME?= $(SSH_KEYPAIR_NAME)
EC2_KEYPAIR_PRIVATEKEY_DIRPATH?= $(EC2_KEYPAIR_DIRPATH)
EC2_KEYPAIR_PRIVATEKEY_FILENAME?= $(EC2_KEYPAIR_NAME)
EC2_KEYPAIR_PRIVATEKEY_FILEPATH?= $(EC2_KEYPAIR_PRIVATEKEY_DIRPATH)$(EC2_KEYPAIR_PRIVATEKEY_FILENAME)
EC2_KEYPAIR_PUBLICKEY_DIRPATH?= $(EC2_KEYPAIR_DIRPATH)
EC2_KEYPAIR_PUBLICKEY_FILENAME?= $(if $(EC2_KEYPAIR_NAME),$(EC2_KEYPAIR_NAME).pub)
EC2_KEYPAIR_PUBLICKEY_FILEPATH?= $(EC2_KEYPAIR_PUBLICKEY_DIRPATH)$(EC2_KEYPAIR_PUBLICKEY_FILENAME)
# EC2_KEYPAIRS_NAME?= $(EC2_KEYPAIR_NAME)
EC2_KEYPAIRS_DIRPATH?= $(EC2_KEYPAIR_DIRPATH)

# Options
__EC2_PUBLIC_KEY_MATERIAL= $(if $(EC2_KEYPAIR_PUBLICKEY_FILEPATH),--public-key-material "$$(cat $(EC2_KEYPAIR_PUBLICKEY_FILEPATH))")
__EC2_KEY_NAME= $(if $(EC2_KEYPAIR_NAME),--key-name $(EC2_KEYPAIR_NAME))
__EC2_KEY_NAMES__KEYPAIR= $(if $(EC2_KEYPAIR_NAME),--key-names $(EC2_KEYPAIR_NAME))
__EC2_KEY_NAMES__KEYPAIRS= $(if $(EC2_KEYPAIRS_NAMES),--key-names $(EC2_KEYPAIRS_NAMES))

# Customizations
_EC2_LIST_KEYPAIRS_FIELDS?= .{KeyName:KeyName,keyPairId:KeyPairId,keyFingerprint:KeyFingerprint,tags:''}
_EC2_LIST_KEYPAIRS_SET_FIELDS?= $(_EC2_LIST_KEYPAIRS_FIELDS)
_EC2_LIST_KEYPAIRS_SET_QUERYFILTER?=

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_ec2_list_macros ::
	@#echo 'AWS::EC2::Keypair ($(_AWS_EC2_KEYPAIR_MK_VERSION)) targets:'
	@#echo

_ec2_list_parameters ::
	@echo 'AWS::EC2::Keypair ($(_AWS_EC2_KEYPAIR_MK_VERSION)) parameters:'
	@echo '    EC2_KEYPAIR_NAME=$(EC2_KEYPAIR_NAME)'
	@echo '    EC2_KEYPAIR_PRIVATEKEY_DIRPATH=$(EC2_KEYPAIR_PRIVATEKEY_DIRPATH)'
	@echo '    EC2_KEYPAIR_PRIVATEKEY_FILENAME=$(EC2_KEYPAIR_PRIVATEKEY_FILENAME)'
	@echo '    EC2_KEYPAIR_PRIVATEKEY_FILEPATH=$(EC2_KEYPAIR_PRIVATEKEY_FILEPATH)'
	@echo '    EC2_KEYPAIR_PUBLICKEY_DIRPATH=$(EC2_KEYPAIR_PUBLICKEY_DIRPATH)'
	@echo '    EC2_KEYPAIR_PUBLICKEY_FILENAME=$(EC2_KEYPAIR_PUBLICKEY_FILENAME)'
	@echo '    EC2_KEYPAIR_PUBLICKEY_FILEPATH=$(EC2_KEYPAIR_PUBLICKEY_FILEPATH)'
	@echo '    EC2_KEYPAIRS_NAMES=$(EC2_KEYPAIRS_NAMES)'
	@echo '    EC2_KEYPAIRS_SET_NAME=$(EC2_KEYPAIRS_SET_NAME)'
	@echo

_ec2_list_targets ::
	@echo 'AWS::EC2::Keypair ($(_AWS_EC2_KEYPAIR_MK_VERSION)) targets:'
	@echo '    _ec2_create_keypair                     - Create a keypair on AWS'
	@echo '    _ec2_delete_keypair                     - Delete an existing keypair'
	@echo '    _ec2_import_keypair                     - Import a local keypair'
	@echo '    _ec2_show_keypair                       - Showing details of a keypair'
	@echo '    _ec2_list_keypairs                      - List all keypairs'
	@echo '    _ec2_list_keypairs_set                  - List a set of keypairs'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ec2_create_keypair:
	@$(INFO) '$(EC2_UI_LABEL)Creating keypair "$(EC2_KEYPAIR_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT overwrite existing keys'; $(NORMAL)
	mkdir -vp $(EC2_KEYPAIR_DIRPATH)
	[ -e $(EC2_KEYPAIR_PRIVATEKEY_FILEPATH) ] || $(AWS) ec2 create-key-pair $(__EC2_KEY_NAME) --query 'KeyMaterial' --output text > $(EC2_KEYPAIR_PRIVATEKEY_FILEPATH)
	cat $(EC2_KEYPAIR_PRIVATEKEY_FILEPATH)
	chmod 600 $(EC2_KEYPAIR_PRIVATEKEY_FILEPATH)
	ls -al $(EC2_KEYPAIR_PRIVATEKEY_FILEPATH)

_ec2_delete_keypair:
	@$(INFO) '$(EC2_UI_LABEL)Deleting keypair "$(EC2_KEYPAIR_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 delete-key-pair $(__EC2_KEY_NAME) 

_ec2_import_keypair:
	@$(INFO) '$(EC2_UI_LABEL)Importing keypair "$(EC2_KEYPAIR_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation errors if the key already exists, but this error is ignored!'; $(NORMAL)
	-$(AWS) ec2 import-key-pair $(__EC2_KEY_NAME) $(__EC2_PUBLIC_KEY_MATERIAL) 

_ec2_list_keypairs:
	@$(INFO) '$(EC2_UI_LABEL)Listing ALL keypairs ...'; $(NORMAL)
	$(AWS) ec2 describe-key-pairs $(_X__EC2_KEY_NAMES) --query "KeyPairs[]$(_EC2_LIST_KEYPAIRS_FIELDS)"

_ec2_list_keypairs_set:
	@$(INFO) '$(EC2_UI_LABEL)Listing keypairs-set "$(EC2_KEYPAIRS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Keypairs are grouped based on the provided key-names and query-filter'; $(NORMAL)
	$(AWS) ec2 describe-key-pairs $(__EC2_KEY_NAMES__KEYPAIRS) --query "KeyPairs[$(_EC2_LIST_KEYPAIRS_SET_QUERYFILTER)]$(_EC2_LIST_KEYPAIRS_SET_FIELDS)"

_EC2_SHOW_KEYPAIR_TARGETS?= _ec2_show_keypair_description
_ec2_show_keypair: $(_EC2_SHOW_KEYPAIR_TARGETS)

_ec2_show_keypair_description:
	@$(INFO) '$(EC2_UI_LABEL)Showing description of keypair "$(EC2_KEYPAIR_NAME)"  ...'; $(NORMAL)
	$(AWS) ec2 describe-key-pairs $(__EC2_KEY_NAMES__KEYPAIR) --query "KeyPairs[]"
