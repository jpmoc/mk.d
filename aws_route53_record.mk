_AWS_ROUTE53_RECORD_MK_VERSION= $(_AWS_ROUTE53_MK_VERSION)

# R53_RECORD_HOSTEDZONE_ID?= ZXJ2RX3IST30W
# R53_RECORD_HOSTEDZONE_NAME?= cp.horizon.vmware.com.
# R53_RECORD_NAME?= 
R53_RECORD_TESTCLIENT_IP?= 192.0.2.0
R53_RECORD_TESTCLIENT_MASK?= 24
# R53_RECORD_TYPE?= A
# R53_RECORDS_CHANGEBATCH?=
# R53_RECORDS_CHANGEBATCH_DIRPATH?= ./in/
# R53_RECORDS_CHANGEBATCH_FILENAME?= change-batch.json
# R53_RECORDS_CHANGEBATCH_FILEPATH?= ./in/change-batch.json
# R53_RECORDS_HOSTEDZONE_ID?= ZXJ2RX3IST30W
# R53_RECORDS_HOSTEDZONE_NAME?= cp.horizon.vmware.com.

# Derived parameters
R53_RECORD_CHANGEBATCH?= $(if $(R53_RECORD_CHANGEBATCH_FILEPATH),file://$(R53_RECORD_CHANGEBATCH_FILEPATH))
R53_RECORD_CHANGEBATCH_DIRPATH?= $(R53_INPUTS_DIRPATH)
R53_RECORD_CHANGEBATCH_FILEPATH?= $(R53_RECORD_CHANGEBATCH_DIRPATH)$(R53_RECORD_CHANGEBATCH_FILENAME)
R53_RECORD_HOSTEDZONE_ID?= $(R53_HOSTEDZONE_ID)
R53_RECORD_HOSTEDZONE_NAME?= $(R53_HOSTEDZONE_NAME)
R53_RECORDS_CHANGEBATCH?= $(if $(R53_RECORDS_CHANGEBATCH_FILEPATH),file://$(R53_RECORDS_CHANGEBATCH_FILEPATH))
R53_RECORDS_CHANGEBATCH_DIRPATH?= $(R53_INPUTS_DIRPATH)
R53_RECORDS_CHANGEBATCH_FILEPATH?= $(R53_RECORDS_CHANGEBATCH_FILEPATH)$(R53_RECORDS_CHANGEBATCH_FILENAME)
R53_RECORDS_HOSTEDZONE_ID?= $(R53_RECORD_HOSTEDZONE_ID)
R53_RECORDS_HOSTEDZONE_NAME?= $(R53_RECORD_HOSTEDZONE_NAME)

# Options
__R53_CHANGE_BATCH__RECORD= $(if $(R53_RECORD_CHANGEBATCH),--change-batch $(R53_RECORD_CHANGEBATCH))
__R53_CHANGE_BATCH__RECORDS= $(if $(R53_RECORDS_CHANGEBATCH),--change-batch $(R53_RECORDS_CHANGEBATCH))
__R53_EDNS0_CLIENT_SUBNET_IP= $(if $(R53_RECORD_TESTCLIENT_IP),--edns0-client-subnet-ip $(R53_RECORD_TESTCLIENT_IP))
__R53_EDNS0_CLIENT_SUBNET_MASK= $(if $(R53_RECORD_TESTCLIENT_MASK),--edns0-client-subnet-mask $(R53_RECORD_TESTCLIENT_MASK))
__R53_HOSTED_ZONE_ID__RECORD= $(if $(R53_RECORD_HOSTEDZONE_ID),--hosted-zone-id $(R53_RECORD_HOSTEDZONE_ID))
__R53_HOSTED_ZONE_ID__RECORDS= $(if $(R53_RECORDS_HOSTEDZONE_ID),--hosted-zone-id $(R53_RECORDS_HOSTEDZONE_ID))
__R53_RECORD_NAME= $(if $(R53_RECORD_NAME),--record-name $(R53_RECORD_NAME))
__R53_RECORD_TYPE= $(if $(R53_RECORD_TYPE),--record-type $(R53_RECORD_TYPE))


# Customizations

#--- Macro

#----------------------------------------------------------------------
# USAGE
#

_r53_list_macros ::
	@#echo 'AWS::Route53::Record ($(_AWS_ROUTE53_RECORD_MK_VERSION)) macros:'
	@#echo

_r53_list_parameters ::
	@echo 'AWS::Route53::Record ($(_AWS_ROUTE53_RECORD_MK_VERSION)) parameters:'
	@echo '    R53_RECORD_CHANGEBATCH=$(R53_RECORD_CHANGEBATCH)'
	@echo '    R53_RECORD_CHANGEBATCH_DIRPATH=$(R53_RECORD_CHANGEBATCH_DIRPATH)'
	@echo '    R53_RECORD_CHANGEBATCH_FILENAME=$(R53_RECORD_CHANGEBATCH_FILENAME)'
	@echo '    R53_RECORD_CHANGEBATCH_FILEPATH=$(R53_RECORD_CHANGEBATCH_FILEPATH)'
	@echo '    R53_RECORD_HOSTEDZONE_ID=$(R53_RECORD_HOSTEDZONE_ID)'
	@echo '    R53_RECORD_HOSTEDZONE_NAME=$(R53_RECORD_HOSTEDZONE_NAME)'
	@echo '    R53_RECORD_NAME=$(R53_RECORD_NAME)'
	@echo '    R53_RECORD_TESTCLIENT_IP=$(R53_RECORD_TESTCLIENT_IP)'
	@echo '    R53_RECORD_TESTCLIENT_MASK=$(R53_RECORD_TESTCLIENT_MASK)'
	@echo '    R53_RECORD_TYPE=$(R53_RECORD_TYPE)'
	@echo '    R53_RECORDS_CHANGEBATCH_DIRPATH=$(R53_RECORDS_CHANGEBATCH_DIRPATH)'
	@echo '    R53_RECORDS_CHANGEBATCH_FILENAME=$(R53_RECORDS_CHANGEBATCH_FILENAME)'
	@echo '    R53_RECORDS_CHANGEBATCH_FILEPATH=$(R53_RECORDS_CHANGEBATCH_FILEPATH)'
	@echo '    R53_RECORDS_HOSTEDZONE_ID=$(R53_RECORDS_HOSTEDZONE_ID)'
	@echo '    R53_RECORDS_HOSTEDZONE_NAME=$(R53_RECORDS_HOSTEDZONE_NAME)'
	@echo

_r53_list_targets ::
	@echo 'AWS::Route53::Record ($(_AWS_ROUTE53_RECORD_MK_VERSION)) targets:'
	@echo '    _r53_create_record                    - Create a record'
	@echo '    _r53_create_records                   - Create records'
	@echo '    _r53_delete_record                    - Delete a record'
	@echo '    _r53_list_records                     - List all records'
	@echo '    _r53_list_records_set                 - List a set of records'
	@echo '    _r53_show_record                      - Show everything related to a record'
	@echo '    _r53_show_record_desription           - Show description of a record'
	@echo '    _r53_test_record                      - Test a record'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_r53_create_record:
	@$(INFO) '$(R53_UI_LABEL)Creating record "$(R53_RECORD_NAME)" in hosted-zone "$(R53_RECORD_HOSTEDZONE_NAME)" ...'; $(NORMAL)
	$(AWS) route53 change-resource-record-sets $(__R53_CHANGE_BATCH__RECORD) $(__R53_HOSTED_ZONE_ID__RECORD)

_r53_create_records:
	@$(INFO) '$(R53_UI_LABEL)Creating records in hosted-zone "$(R53_RECORDS_HOSTEDZONE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation will update record "$(R53_RECORD_NAME)", which can be used for validation'; $(NORMAL)
	$(AWS) route53 change-resource-record-sets $(__R53_CHANGE_BATCH__RECORDS) $(__R53_HOSTED_ZONE_ID__RECORDS)

_r53_delete_record:
	@$(INFO) '$(R53_UI_LABEL)Deleting record "$(R53_RECORD_NAME)" from hosted-zone "$(R53_RECORD_HOSTEDZONE_NAME)" ...'; $(NORMAL)

_r53_delete_records:
	@$(INFO) '$(R53_UI_LABEL)Deleting records from hosted-zone "$(R53_RECORDS_HOSTEDZONE_NAME)" ...'; $(NORMAL)

_r53_list_records:

_r53_list_records_set:

_R53_SHOW_RECORD_TARGETS?= _r53_show_record_description
_r53_show_record: $(_R3_SHOW_RECORD_TARGETS)

_r53_show_record_description:

_r53_test_record:
	@$(INFO) '$(R53_UI_LABEL)Testing record "$(R53_RECORD_NAME)" of hosted-zone "$(R53_RECORD_HOSTEDZONE_NAME)" ...'; $(NORMAL)
	$(AWS) route53 test-dns-answer $(__R53_EDNS0_CLIENT_SUBNET_IP) $(__R53_EDNS0_CLIENT_SUBNET_MASK) $(__R53_HOSTEDZONE_ID__RECORD) $(__R53_RECORD_NAME) $(__R53_RECORD_TYPE) $(__R53_RESOLVER_IP)

_r53_update_record:
