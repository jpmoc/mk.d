_AWS_APIGATEWAY_MK_VERSION= 0.99.0

# AGY_INPUTS_DIRPATH?= ./in
# AGY_OUTPUTS_DIRPATH?= ./in

# Derived parameters

# Options

# Display

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#
_aws_view_framework_macros :: _agy_user_view_framework_macros
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY ($(_AWS_APIGATEWAY_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _agy_view_framework_parameters
_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY ($(_AWS_APIGATEWAY_MK_VERSION)) parameters:'
	@echo '    AGY_INPUTS_DIRPATH=$(AGY_INPUTS_DIRPATH)'
	@echo '    AGY_OUTPUTS_DIRPATH=$(AGY_OUTPUTS_DIRPATH)'
	@echo

_aws_view_framework_targets :: _agy_view_framework_targets
_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY ($(_AWS_APIGATEWAY_MK_VERSION)) targets:'
	@echo '    _agy_view_account_limits           - View account limits on this service'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

MK_DIR?= .
-include $(MK_DIR)/aws_apigateway_apikey.mk
-include $(MK_DIR)/aws_apigateway_authorizer.mk
-include $(MK_DIR)/aws_apigateway_basepathmapping.mk
-include $(MK_DIR)/aws_apigateway_clientcertificate.mk
-include $(MK_DIR)/aws_apigateway_deployment.mk
-include $(MK_DIR)/aws_apigateway_documentationpart.mk
-include $(MK_DIR)/aws_apigateway_documentationversion.mk
-include $(MK_DIR)/aws_apigateway_domainname.mk
-include $(MK_DIR)/aws_apigateway_gatewayresponse.mk
-include $(MK_DIR)/aws_apigateway_integration.mk
-include $(MK_DIR)/aws_apigateway_integrationresponse.mk
-include $(MK_DIR)/aws_apigateway_method.mk
-include $(MK_DIR)/aws_apigateway_methodresponse.mk
-include $(MK_DIR)/aws_apigateway_model.mk
-include $(MK_DIR)/aws_apigateway_requestvalidator.mk
-include $(MK_DIR)/aws_apigateway_resource.mk
-include $(MK_DIR)/aws_apigateway_restapi.mk
-include $(MK_DIR)/aws_apigateway_stage.mk
-include $(MK_DIR)/aws_apigateway_usageplan.mk
-include $(MK_DIR)/aws_apigateway_usageplankey.mk
-include $(MK_DIR)/aws_apigateway_vpclink.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_aws_view_account_limits :: _agy_view_account_limits
_agy_view_account_limits:
	@$(INFO) '$(AWS_UI_LABEL)Viewing account limits for API gateways ...'; $(NORMAL)
	$(AWS) apigateway get-account
