_AWS_LAMBDA_FUNCTIONALIAS_MK_VERSION= $(_AWS_LAMBDA_MK_VERSION)

# LBA_FUNCTIONALIAS_ARN?= arn:aws:lambda:us-west-1:123456789012:function:my-function:my-alias
# LBA_FUNCTIONALIAS_DESCRIPTION?= 'My alias description'
# LBA_FUNCTIONALIAS_FUNCTION_NAME?= my-lambda-function
# LBA_FUNCTIONALIAS_FUNCTION_VERSION?= 2
# LBA_FUNCTIONALIAS_NAME?= my-alias-name
# LBA_FUNCTIONALIAS_NAMES?=
# LBA_FUNCTIONALIAS_ROUTING_CONFIG?= AdditionalVersionWeights={KeyName1=double,KeyName2=double}
# LBA_FUNCTIONALIASES_SET_NAME?=

# Derived parameters
LBA_FUNCTIONALIAS_FUNCTION_NAME?= $(LBA_FUNCTION_NAME)
LBA_FUNCTIONALIAS_FUNCTION_VERSION?= $(value LBA_FUNCTION_VERSION)
LBA_FUNCTIONALIAS_NAMES?= $(LBA_FUNCTIONALIAS_NAME)

# Options
__LBA_DESCRIPTION__FUNCTIONALIAS= $(if $(LBA_FUNCTIONALIAS_DESCRIPTION), --description $(LBA_FUNCTIONALIAS_DESCRIPTION))
__LBA_FUNCTION_NAME__FUNCTIONALIAS= $(if $(LBA_FUNCTIONALIAS_FUNCTION_NAME), --function-name $(LBA_FUNCTIONALIAS_FUNCTION_NAME))
__LBA_FUNCTION_VERSION__FUNCTIONALIAS= $(if $(LBA_FUNCTIONALIAS_FUNCTION_VERSION), --function-version '$(LBA_FUNCTIONALIAS_FUNCTION_VERSION)')
__LBA_NAME__FUNCTIONALIAS= $(if $(LBA_FUNCTIONALIAS_NAME), --name $(LBA_FUNCTIONALIAS_NAME))
__LBA_ROUTING_CONFIG= $(if $(LBA_FUNCTIONALIAS_ROUTING_CONFIG), --routing-config $(LBA_FUNCTIONALIAS_ROUTING_CONFIG))

# Customizations

# Macros
_lba_get_functionalias_arn=$(call _lba_get_functionalias_arn_N, $(LBA_FUNCTIONALIAS_NAME))
_lba_get_functionalias_arn_N=$(call _lba_get_functionalias_arn_NF, $(1), $(LBA_FUNCTION_NAME))
# _lba_get_functionalias_arn_NF=$(shell $(AWS) lambda list-functionaliases --function-name $(2) --query "Aliases[?Name=='$(strip $(1))'].AliasArn" --output text)
_lba_get_functionalias_arn_NF= $(shell echo arn:aws:lambda:$(AWS_REGION):$(AWS_ACCOUNT_ID):function:$(strip $(2)):$(strip $(1)))

#----------------------------------------------------------------------
# USAGE
#

_lba_list_macros ::
	@echo 'AWS::LamBdA::FunctionAlias ($(_AWS_LAMBDA_FUNCTIONALIAS_MK_VERSION)) macros:'
	@echo '    _lba_get_functionalias_arn_{|N|NF}            - Get the ARN of an alias resource (Name,Function)'
	@echo

_lba_list_parameters ::
	@echo 'AWS::LamBdA::FunctionAlias ($(_AWS_LAMBDA_FUNCTIONALIAS_MK_VERSION)) parameters:'
	@echo '    LBA_FUNCTIONALIAS_ARN=$(LBA_FUNCTIONALIAS_ARN)'
	@echo '    LBA_FUNCTIONALIAS_DESCRIPTION=$(LBA_FUNCTIONALIAS_DESCRIPTION)'
	@echo '    LBA_FUNCTIONALIAS_FUNCTION_NAME=$(LBA_FUNCTIONALIAS_FUNCTION_NAME)'
	@echo '    LBA_FUNCTIONALIAS_FUNCTION_VERSION=$(LBA_FUNCTIONALIAS_FUNCTION_VERSION)'
	@echo '    LBA_FUNCTIONALIAS_NAME=$(LBA_FUNCTIONALIAS_NAME)'
	@echo '    LBA_FUNCTIONALIAS_NAMES=$(LBA_FUNCTIONALIAS_NAMES)'
	@echo '    LBA_FUNCTIONALIAS_ROUTING_CONFIG=$(LBA_FUNCTIONALIAS_ROUTING_CONFIG)'
	@echo '    LBA_FUNCTIONALIASES_SET_NAME=$(LBA_FUNCTIONALIASES_SET_NAME)'
	@echo

_lba_list_targets ::
	@echo 'AWS::LamBdA::FunctionAlias ($(_AWS_LAMBDA_FUNCTIONALIAS_MK_VERSION)) targets:'
	@echo '    _lba_create_functionalias                     - Create a function-alias'
	@echo '    _lba_delete_functionalias                     - Delete a function-alias'
	@echo '    _lba_list_functionaliases                     - List all function-aliases'
	@echo '    _lba_list_functionaliases_set                 - List a set of function-aliases'
	@echo '    _lba_show_functionalias                       - Show everything related to a function-alias'
	@echo '    _lba_show_functionalias_description           - Show description of a function-alias'
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_lba_create_functionalias:
	@$(INFO) '$(LBA_UI_LABEL)Creating functionalias "$(LBA_FUNCTIONALIAS_NAME)" to version "$(LBA_FUNCTION_VERSION)" of lambda-function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	$(AWS) lambda create-alias $(__LBA_DESCRIPTION__FUNCTIONALIAS) $(__LBA_FUNCTION_NAME) $(__LBA_FUNCTION_VERSION__FUNCTIONALIAS) $(__LBA_NAME__FUNCTIONALIAS) $(__LBA_ROUTING_CONFIG)

_lba_delete_functionalias:
	@$(INFO) '$(LBA_UI_LABEL)Deleting alias "$(LBA_FUNCTIONALIAS_NAME)" of lambda-function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	$(AWS) lambda delete-alias $(__LBA_FUNCTION_NAME) $(__LBA_NAME__FUNCTIONALIAS)

_lba_list_functionaliases:
	@$(INFO) '$(LBA_UI_LABEL)Listing ALL aliases of lambda-function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	$(AWS) lambda list-aliases $(__LBA_FUNCTION_NAME__FUNCTIONALIAS) $(_X__LBA_FUNCTION_VERSION__FUNCTIONALIAS)

_lba_list_functionaliases_set:
	@$(INFO) '$(LBA_UI_LABEL)Listing function-aliases-set "$(LBA_FUNCTIONALIASES_SET_NAME)" ...'; $(NORMAL)
	$(AWS) lambda list-aliases $(__LBA_FUNCTION_NAME__FUNCTIONALIAS) $(__LBA_FUNCTION_VERSION__FUNCTIONALIAS)

_lba_show_functionalias: _lba_show_functionalias_description

_lba_show_functionalias_description:
	@$(INFO) '$(LBA_UI_LABEL)Showing alias "$(LBA_FUNCTIONALIAS_NAME)" of lambda-function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	# $(AWS) lambda list-aliases $(__LBA_FUNCTION_NAME__FUNCTIONALIAS) $(__LBA_FUNCTION_VERSION__FUNCTIONALIAS) --query "Aliases[?Name=='$(LBA_FUNCTIONALIAS_NAME)']"
	$(AWS) lambda get-alias $(__LBA_FUNCTION_NAME__FUNCTIONALIAS) $(__LBA_NAME__FUNCTIONALIAS)
