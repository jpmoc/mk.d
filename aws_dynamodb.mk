_AWS_DYNAMODB_MK_VERSION= 0.99.6

# DDB_ACCOUNT_ID?= 123456789012
# DDB_ENDPOINT_URL?= http://localhost:8000
DDB_LOCAL_DIR?= $(HOME)/dynamodb
DDB_LOCAL_PORT?= 8080
# DDB_MODE_DEBUG?=true
# DDB_REGION_ID?= us-west-2

# Derived
DDB_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)
DDB_REGION_ID?= $(AWS_REGION_ID)

# Options

# UI variables
DDB_UI_LABEL?= $(AWS_UI_LABEL)

#--- Utilities

__DYNAMODB_OPTIONS+= -port $(DDB_LOCAL_PORT)

DYNAMODB_BIN?= java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar
DYNAMODB?= $(strip $(__DYNAMODB_ENVIRONMENT) $(DYNAMODB_ENVIRONMENT) $(DYNAMODB_BIN) $(__DYNAMODB_OPTIONS) $(DYNAMODB_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#


_aws_view_framework_macros :: _ddb_view_framework_macros
_ddb_view_framework_macros ::
	@echo 'AWS::DynamoDB ($(_AWS_DYNAMODB_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _ddb_view_framework_parameters
_ddb_view_framework_parameters ::
	@echo 'AWS::DynamoDB ($(_AWS_DYNAMODB_MK_VERSION)) parameters:'
	@echo '    DDB_ACCOUNT_ID=$(DDB_ACCOUNT_ID)'
	@echo '    DDB_ENDPOINT_URL=$(DDB_ENDPOINT_URL)'
	@echo '    DDB_LOCAL_DIR=$(DDB_LOCAL_DIR)'
	@echo '    DDB_LOCAL_PORT=$(DDB_LOCAL_PORT)'
	@echo '    DDB_MODE_DEBUG=$(DDB_MODE_DEBUG)'
	@echo '    DDB_REGION_ID=$(DDB_REGION_ID)'
	@echo '    DYNAMODB=$(DYNAMODB)'
	@echo

_aws_view_framework_targets :: _ddb_view_framework_targets
_ddb_view_framework_targets ::
	@echo 'AWS::DynamoDB ($(_AWS_DYNAMODB_MK_VERSION)) targets:'
	@echo '    _ddb_install_dependencies       - Install dependencies'
	@echo '    _ddb_run_dynamodb               - Start local dynamodb database'
	@echo '    _ddb_view_datatypes             - View dynamodb data types'
	@echo '    _ddb_view_endpoints             - View regional-endpoints'
	@echo '    _ddb_view_limits                - View region/account limits'
	@echo '    _ddb_view_versions              - View versions of dependencies'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_dynamodb_backup.mk
-include $(MK_DIR)/aws_dynamodb_item.mk
# -include $(MK_DIR)/aws_dynamodb_globaltable.mk
-include $(MK_DIR)/aws_dynamodb_table.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_aws_install_dependencies :: _ddb_install_dependencies
_ddb_install_dependencies:
	@$(INFO) '$(DDB_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@echo 'AWS::DynamoDB ($(_AWS_DYNAMODB_MK_VERSION)) framework dependencies:'
	mkdir -p $(DDB_LOCAL_DB_DIR)
	cd $(DDB_DYNAMODB_LOCAL_DIR); \
		curl -O https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz
	@echo

_ddb_run_dynamodb:
	@$(INFO) '$(DDB_UI_LABEL)Starting local dynamodb process ...'; $(NORMAL)
	cd $(DDB_LOCAL_DIR); $(DYNAMODB) -help
	cd $(DDB_LOCAL_DIR); $(DYNAMODB) 

_ddb_view_endpoints:
	@$(INFO) '$(DDB_UI_LABEL)Viewing regional-endpoint ...'; $(NORMAL)
	$(AWS) dynamodb describe-endpoints --query 'Endpoints[]'

_ddb_view_datatypes:
	@$(INFO) '$(DDB_UI_LABEL)Viewing dynamodb data-types ...'; $(NORMAL)
	@echo ' B      --> blob             "dGhpcyB0ZXh0IGlzIGJhc2U2NC1lbmNvZGVk"'
	@echo ' BS     --> blob set         ["dGhpcyB0ZXh0IGlzIGJhc2U2NC1lbmNvZGVk", "dGhpcyB0ZXh0IGlzIGJhc2U2NC1lbmNvZGVk"]'
	@echo ' N      --> number           42.2'
	@echo ' NS     --> number set       ["42.2", "-19", "7.5", "3.14"]'
	@echo ' S      --> string           "Hello"'
	@echo ' SS     --> string set       ["Giraffe", "Hippo" ,"Zebra"]'
	@echo
	@echo ' Used for storing nested JSON:'
	@echo ' BOOL   --> boolean          true'
	@echo ' L      --> list             ["Cookies", "Coffee", 3.14159]'
	@echo ' M      --> map              {"Name": {"S": "Joe"}, "Age": {"N": "35"}}'
	@echo ' NULL   --> null'
	@echo

_aws_view_limits :: _ddb_view_limits
_ddb_view_limits:
	@$(INFO) '$(DDB_UI_LABEL)Viewing limits in region "$(DDB_REGION_ID)" ...'; $(NORMAL)
	@$(WARN) 'The limits are region specific, not for the whole AWS account'; $(NORMAL)
	$(AWS) dynamodb describe-limits

_aws_view_versions :: _ddb_view_versions
_ddb_view_versions:
	@$(INFO) '$(DDB_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)

