_AWS_ROUTE53_RECORD_MK_VERSION= $(_AWS_ROUTE53_MK_VERSION)

# R53_RECORD_CHANGEBATCH?=
# R53_RECORD_CHANGEBATCH_FILEPATH?=
# R53_RECORD_HOSTEDZONE_ID?=
# R53_RECORD_HOSTEDZONE_NAME?=
# R53_RECORD_NAME?=
R53_RECORD_TESTCLIENT_IP?= 192.0.2.0
R53_RECORD_TESTCLIENT_MASK?= 24
# R53_RECORD_TYPE?= A
# R53_RECORDS_CHANGEBATCH?=
# R53_RECORDS_CHANGEBATCH_FILEPATH?=

# Derived parameters
R53_RECORD_HOSTEDZONE_ID?= $(R53_HOSTEDZONE_ID)
R53_RECORD_HOSTEDZONE_NAME?= $(R53_HOSTEDZONE_NAME)
R53_RECORDS_CHANGEBATCH?= $(if $(R53_RECORDS_CHANGEBATCH_FILEPATH), file://$(R53_RECORDS_CHANGEBATCH_FILEPATH))
R53_RECORDS_CHANGEBATCH_FILEPATH?= $(R53_RECORD_CHANGEBATCH_FILEPATH)
R53_RECORDS_HOSTEDZONE_ID?= $(R53_RECORD_HOSTEDZONE_ID)
R53_RECORDS_HOSTEDZONE_NAME?= $(R53_RECORD_HOSTEDZONE_NAME)

# Option parameters 
__R53_CHANGE_BATCH= $(if $(R53_RECORDS_CHANGEBATCH), --change-batch $(R53_RECORDS_CHANGEBATCH))
__R53_EDNS0_CLIENT_SUBNET_IP= $(if $(R53_RECORD_TESTCLIENT_IP), --edns0-client-subnet-ip $(R53_RECORD_TESTCLIENT_IP))
__R53_EDNS0_CLIENT_SUBNET_MASK= $(if $(R53_RECORD_TESTCLIENT_MASK), --edns0-client-subnet-mask $(R53_RECORD_TESTCLIENT_MASK))
__R53_HOSTED_ZONE_ID__RECORD= $(if $(R53_RECORD_HOSTEDZONE_ID), --hosted-zone-id $(R53_RECORD_HOSTEDZONE_ID))
__R53_RECORD_NAME= $(if $(R53_RECORD_NAME), --record-name $(R53_RECORD_NAME))
__R53_RECORD_TYPE= $(if $(R53_RECORD_TYPE), --record-type $(R53_RECORD_TYPE))



# UI parameters

#--- Utilities

#--- Macro

#----------------------------------------------------------------------
# USAGE
#

_r53_view_framework_macros ::
	@echo 'AWS::Route53::Record ($(_AWS_ROUTE53_RECORD_MK_VERSION)) macros:'
	@echo

_r53_view_framework_parameters ::
	@echo 'AWS::Route53::Record ($(_AWS_ROUTE53_RECORD_MK_VERSION)) parameters:'
	@echo '    R53_RECORD_CHANGEBATCH=$(R53_RECORD_CHANGEBATCH)'
	@echo '    R53_RECORD_CHANGEBATCH_FILEPATH=$(R53_RECORD_CHANGEBATCH_FILEPATH)'
	@echo '    R53_RECORD_HOSTEDZONE_ID=$(R53_RECORD_HOSTEDZONE_ID)'
	@echo '    R53_RECORD_HOSTEDZONE_NAME=$(R53_RECORD_HOSTEDZONE_NAME)'
	@echo '    R53_RECORD_NAME=$(R53_RECORD_NAME)'
	@echo '    R53_RECORD_TESTCLIENT_IP=$(R53_RECORD_TESTCLIENT_IP)'
	@echo '    R53_RECORD_TESTCLIENT_MASK=$(R53_RECORD_TESTCLIENT_MASK)'
	@echo '    R53_RECORD_TYPE=$(R53_RECORD_TYPE)'
	@echo

_r53_view_framework_targets ::
	@echo 'AWS::Route53::Record ($(_AWS_ROUTE53_RECORD_MK_VERSION)) targets:'
	@echo '    _r53_create_record                    - Create a record'
	@echo '    _r53_delete_record                    - Delete a record'
	@echo '    _r53_show_record                      - Show everything related to a record'
	@echo '    _r53_test_record                      - Test a record'
	@echo '    _r53_view_records                     - View records'
	@echo '    _r53_view_records_set                 - View s set of records'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_r53_create_record: _r53_create_records
_r53_create_records:
	@$(INFO) '$(AWS_UI_LABEL)Creating records in hosted-zone "$(R53_RECORD_HOSTEDZONE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation updates record "$(R53_RECORD_NAME)", which can be used for validation'; $(NORMAL)
	$(AWS) route53 change-resource-record-sets $(__R53_CHANGE_BATCH) $(__R53_HOSTED_ZONE_ID_RECORD)

_r53_delete_record: _r53_delete_records
_r53_delete_records:

_r53_show_record:

_r53_test_record:
	@$(INFO) '$(AWS_UI_LABEL)Testing record "$(R53_RECORD_NAME)" of hosted-zone "$(R53_RECORD_HOSTEDZONE_NAME)" ...'; $(NORMAL)
	$(AWS) route53 test-dns-answer $(__R53_EDNS0_CLIENT_SUBNET_IP) $(__R53_EDNS0_CLIENT_SUBNET_MASK) $(__R53_HOSTEDZONE_ID__RECORD) $(__R53_RECORD_NAME) $(__R53_RECORD_TYPE) $(__R53_RESOLVER_IP)

_r53_update_record:

_r53_view_records:

_r53_view_records_set:
