_AWS_MK_VERSION= 0.99.4

# AWS_ACCESS_KEY_ID=
# AWS_ACCOUNT_ID?= 123456789012
# AWS_ACCOUNT_ALIAS?= my_account_alias
# AWS_CONFIG_FILEPATH?=
# AWS_CURL?= curl
# AWS_CREDENTIALS_FILEPATH?=
# AWS_DEFAULT_PROFILE?= default
# AWS_DIG?= dig
# AWS_INPUTS_DIRPATH?= ./in/
# AWS_MODE_DEBUG?= table
# AWS_OUTPUT_FORMAT?= table
# AWS_OUTPUTS_DIRPATH?= ./in/
AWS_PAGER_FLAG?= false
AWS_PROFILE_NAME?= default
# AWS_PROFILE_ACCESSKEY_ID?= ASIAMSDF43123456
# AWS_PROFILE_ASSUMEDROLE_ARN?= arn:aws:iam::123456789012:role/my-role
# AWS_PROFILE_CREDENTIALEXPIRATION_DATE?= 2021-09-17T18:11:39Z
# AWS_PROFILE_REGION_ID?= us-east-1
# AWS_PROFILE_SECRETACCESS_KEY?= 
# AWS_PROFILE_SESSION_TOKEN?=  FwoGZXIv...
AWS_PROFILES_REGEX?= '.*'
# AWS_PROFILES_SET_NAME?= profiles@*
# AWS_REGION_ID?= us-west-1
# AWS_REGIONS_IDS?= us-west-1 ...
# AWS_SECRET_ACCESS_KEY?= 
# AWS_SESSION_TOKEN?= 
# AWS_UI_LABEL?=  [aws]

# Derived parameters
AWS_CONFIG_FILEPATH= $(HOME)/.aws/config
AWS_CREDENTIALS_FILEPATH= $(HOME)/.aws/credentials
AWS_CURL?= $(CURL)
AWS_DIG?= $(DIG)
AWS_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
AWS_MODE_DEBUG?= $(CMN_MODE_DEBUG)
AWS_MODE_INTERACTIVE?= $(CMN_MODE_INTERACTIVE)
AWS_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)
AWS_REGIONS_IDS?= $(AWS_REGION_ID)
AWS_PROFILES_SET_NAME?= profiles@$(AWS_PROFILES_REGEX)
AWS_UI_LABEL?= [$(strip $(AWS_PROFILE_NAME) $(AWS_ACCOUNT_ID) $(AWS_REGION_ID))] #

# Options
__AWS_ACCOUNT_ALIAS= $(if $(AWS_ACCOUNT_ALIAS), --account-alias $(AWS_ACCOUNT_ALIAS))

# Customizations

#--- Utilities
__AWS_OPTIONS+= $(if $(filter true, $(AWS_MODE_DEBUG)),--debug)
__AWS_OPTIONS+= $(if $(AWS_OUTPUT_FORMAT),--output $(AWS_OUTPUT_FORMAT))
__AWS_OPTIONS+= $(if $(AWS_PROFILE_NAME),--profile $(AWS_PROFILE_NAME))
__AWS_OPTIONS+= $(if $(filter true, $(AWS_PAGER_FLAG)),,--no-cli-pager)
__AWS_OPTIONS+= $(if $(AWS_REGION_ID),--region $(AWS_REGION_ID))
AWS?= $(strip $(__AWS_ENVIRONMENT) $(AWS_ENVIRONMENT) aws $(__AWS_OPTIONS) $(AWS_OPTIONS))

# CRUDINI_BIN?= crudini
# CRUDINI?= $(strip $(__CRUDINI_ENVIRONMENT) $(CRUDINI_ENVIRONMENT) $(CRUDINI_BIN) $(__CRUDINI_OPTIONS) $(CRUDINI_OPTIONS))

#--- MACROS
_aws_get_account_id= $(call get_aws_account_id_P, $(AWS_PROFILE_NAME))
# _aws_get_account_id_P= $(shell $(AWS) --profile $(1) ec2 describe-security-groups --query 'SecurityGroups[0].OwnerId' --output text)
_aws_get_account_id_P= $(shell $(AWS) sts get-caller-identity --query 'Account' --output text)

_aws_get_profile_accesskey_id= $(call _aws_get_profile_accesskey_id_P, $(AWS_PROFILE_NAME))
_aws_get_profile_accesskey_id_P= $(call _aws_get_profile_accesskey_id_PF, $(1), $(AWS_CREDENTIALS_FILEPATH))
_aws_get_profile_accesskey_id_PF= $(shell crudini --get $(2) $(1) aws_access_key_id)

_aws_get_profile_assumedrole_arn= $(call _aws_get_profile_assumedrole_arn_P, $(AWS_PROFILE_NAME))
_aws_get_profile_assumedrole_arn_P= $(call _aws_get_profile_assumedrole_arn_PF, $(1), $(AWS_CREDENTIALS_FILEPATH))
_aws_get_profile_assumedrole_arn_PF= $(shell crudini --get $(2) $(1) aws_assumed_role_arn)

_aws_get_profile_credentialexpiration_date= $(call _aws_get_profile_credentialexpiration_date_P, $(AWS_PROFILE_NAME))
_aws_get_profile_credentialexpiration_date_P= $(call _aws_get_profile_credentialexpiration_date_PF, $(1), $(AWS_CREDENTIALS_FILEPATH))
_aws_get_profile_credentialexpiration_date_PF= $(shell crudini --get $(2) $(1) aws_credential_expiration)

_aws_get_profile_region_id= $(call _aws_get_profile_region_id_P, $(AWS_PROFILE_NAME))
_aws_get_profile_region_id_P= $(call _aws_get_profile_region_id_PF, $(1), $(AWS_CREDENTIALS_FILEPATH))
_aws_get_profile_region_id_PF= $(shell crudini --get $(2) $(1) region)

_aws_get_profile_secretaccess_key= $(call _aws_get_profile_secretaccess_key_P, $(AWS_PROFILE_NAME))
_aws_get_profile_secretaccess_key_P= $(call _aws_get_profile_secretaccess_key_PF, $(1), $(AWS_CREDENTIALS_FILEPATH))
_aws_get_profile_secretaccess_key_PF= $(shell crudini --get $(2) $(1) aws_secret_access_key)

_aws_get_profile_session_token= $(call _aws_get_profile_session_token_P, $(AWS_PROFILE_NAME))
_aws_get_profile_session_token_P= $(call _aws_get_profile_session_token_PF, $(1), $(AWS_CREDENTIALS_FILEPATH))
_aws_get_profile_session_token_PF= $(shell crudini --get $(2) $(1) aws_session_token)

_aws_get_user_arn= $(call _aws_get_user_arn_P, $(AWS_PROFILE_NAME))
_aws_get_user_arn_P= $(shell $(AWS) sts get-caller-identity --query 'UserArn' --output text)

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _aws_list_macros
_aws_list_macros ::
	@echo 'AWS:: ($(_AWS_MK_VERSION)) macros:'
	@echo '    _aws_get_account_id_{|P}                           - Get AWS account ID from AWS profile (Profile)'
	@echo '    _aws_get_profile_accesskey_id_{|P|PF}              - Get an AWS_ACCESS_KEY_ID (Profile, File)'
	@echo '    _aws_get_profile_assumedrole_arn_{|P|PF}           - Get the assumed-role ARN (Profile, File)'
	@echo '    _aws_get_profile_credentialexpiration_date_{|P|PF} - Get the credential expiration (Profile, File)'
	@echo '    _aws_get_profile_region_id{|P|PF}                  - Get an AWS_REGION_ID (Profile, File)'
	@echo '    _aws_get_profile_secretaccess_key_{|P|PF}          - Get an AWS_SECRET_ACCESS_KEY (Profile, File)'
	@echo '    _aws_get_profile_session_token_{|P|PF}             - Get an AWS_SESSION_TOKEN (Profile, File)'
	@echo '    _aws_get_user_arn_{|P}                             - Get a user ARN (Profile)'
	@echo


_list_parameters :: _aws_list_parameters
_aws_list_parameters ::
	@echo 'AWS:: ($(_AWS_MK_VERSION)) parameters:'
	@echo '    AWS=$(AWS)'
	@echo '    AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID)'
	@echo '    AWS_ACCOUNT_ID=$(AWS_ACCOUNT_ID)'
	@echo '    AWS_ACCOUNT_ALIAS=$(AWS_ACCOUNT_ALIAS)'
	@echo '    AWS_CONFIG_FILEPATH=$(AWS_CONFIG_FILEPATH)'
	@echo '    AWS_CREDENTIALS_FILEPATH=$(AWS_CREDENTIALS_FILEPATH)'
	@echo '    AWS_DEFAULT_PROFILE=$(AWS_DEFAULT_PROFILE)'
	@echo '    AWS_INPUTS_DIRPATH=$(AWS_INPUTS_DIRPATH)'
	@#echo '    AWS_MODE_ASYNC=$(AWS_MODE_ASYNC)'
	@echo '    AWS_MODE_DEBUG=$(AWS_MODE_DEBUG)'
	@echo '    AWS_MODE_INTERACTIVE=$(AWS_MODE_INTERACTIVE)'
	@echo '    AWS_OUTPUT_FORMAT=$(AWS_OUTPUT_FORMAT)'
	@echo '    AWS_OUTPUTS_DIRPATH=$(AWS_OUTPUTS_DIRPATH)'
	@echo '    AWS_PAGER_FLAG=$(AWS_PAGER_FLAG)'
	@echo '    AWS_PROFILE_ACCESSKEY_ID=$(AWS_PROFILE_ACCESSKEY_ID)'
	@echo '    AWS_PROFILE_ASSUMEDROLE_ARN=$(AWS_PROFILE_ASSUMEDROLE_ARN)'
	@echo '    AWS_PROFILE_CREDENTIALEXPIRATION_DATE=$(AWS_PROFILE_CREDENTIALEXPIRATION_DATE)'
	@echo '    AWS_PROFILE_SECRETACCESS_KEY=$(AWS_PROFILE_SECRETACCESS_KEY)'
	@echo '    AWS_PROFILE_SESSION_TOKEN=$(AWS_PROFILE_SESSION_TOKEN)'
	@echo '    AWS_PROFILE_NAME=$(AWS_PROFILE_NAME)'
	@echo '    AWS_PROFILES_REGEX=$(AWS_PROFILES_REGEX)'
	@echo '    AWS_PROFILES_SET_NAME=$(AWS_PROFILES_SET_NAME)'
	@echo '    AWS_REGION_ID=$(AWS_REGION_ID)'
	@echo '    AWS_REGION_NAME=$(AWS_REGION_NAME)'
	@echo '    AWS_REGIONS_IDS=$(AWS_REGIONS_IDS)'
	@echo '    AWS_REGIONS_NAMES=$(AWS_REGIONS_NAMES)'
	@echo '    AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY)'
	@echo '    AWS_SESSION_TOKEN=$(AWS_SESSION_TOKEN)'
	@echo

_list_targets :: _aws_list_targets
_aws_list_targets ::
	@echo 'AWS ($(_AWS_MK_VERSION)) targets:'
	@echo '    _aws_install_dependencies              - Install dependencies'
	@echo '    _aws_view_limits                       - List ALL limits'
	@echo '    _aws_view_versions                     - View versions of dependencies '
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
# Command Line Utilities
-include $(MK_DIR)/aws_cdk.mk
-include $(MK_DIR)/aws_chalice.mk
-include $(MK_DIR)/aws_ecscli.mk
-include $(MK_DIR)/aws_sam.mk

# Services
-include $(MK_DIR)/aws_accessanalyzer.mk
-include $(MK_DIR)/aws_acm.mk
# -include $(MK_DIR)/aws_acm_pca.mk ==> folded in aws_acm.mk
-include $(MK_DIR)/aws_alexaforbusiness.mk
-include $(MK_DIR)/aws_amp.mk
-include $(MK_DIR)/aws_amplify.mk
-include $(MK_DIR)/aws_amplifybackend.mk
-include $(MK_DIR)/aws_apigateway.mk
-include $(MK_DIR)/aws_apigatewaymanagementapi.mk
-include $(MK_DIR)/aws_apigatewayv2.mk
-include $(MK_DIR)/aws_appconfig.mk
-include $(MK_DIR)/aws_appflow.mk
-include $(MK_DIR)/aws_appintegrations.mk
-include $(MK_DIR)/aws_applicationautoscaling.mk
-include $(MK_DIR)/aws_applicationinsights.mk
-include $(MK_DIR)/aws_applicationcostprofiler.mk
-include $(MK_DIR)/aws_appmesh.mk
-include $(MK_DIR)/aws_apprunner.mk
-include $(MK_DIR)/aws_appstream.mk
-include $(MK_DIR)/aws_appsync.mk
-include $(MK_DIR)/aws_athena.mk
-include $(MK_DIR)/aws_auditmanager.mk
-include $(MK_DIR)/aws_autoscaling.mk
-include $(MK_DIR)/aws_autoscalingplans.mk
-include $(MK_DIR)/aws_backup.mk
-include $(MK_DIR)/aws_batch.mk
-include $(MK_DIR)/aws_braket.mk
-include $(MK_DIR)/aws_budgets.mk
-include $(MK_DIR)/aws_ce.mk
-include $(MK_DIR)/aws_chime.mk
-include $(MK_DIR)/aws_chimesdkidentity.mk
-include $(MK_DIR)/aws_chimesdkmessaging.mk
-include $(MK_DIR)/aws_cloud9.mk
-include $(MK_DIR)/aws_clouddirectory.mk
-include $(MK_DIR)/aws_cloudformation.mk
-include $(MK_DIR)/aws_cloudfront.mk
-include $(MK_DIR)/aws_cloudhsm.mk
-include $(MK_DIR)/aws_cloudhsmv2.mk
-include $(MK_DIR)/aws_cloudsearch.mk
-include $(MK_DIR)/aws_cloudsearchdomain.mk
-include $(MK_DIR)/aws_cloudtrail.mk
-include $(MK_DIR)/aws_cloudwatch.mk
-include $(MK_DIR)/aws_codeartifact.mk
-include $(MK_DIR)/aws_codebuild.mk
-include $(MK_DIR)/aws_codecommit.mk
-include $(MK_DIR)/aws_codeguruprofiler.mk
-include $(MK_DIR)/aws_codegurureviewer.mk
-include $(MK_DIR)/aws_codepipeline.mk
-include $(MK_DIR)/aws_codestar.mk
-include $(MK_DIR)/aws_codestarconnections.mk
-include $(MK_DIR)/aws_codestarnotifications.mk
-include $(MK_DIR)/aws_cognito.mk
# -include $(MK_DIR)/aws_cognito_identity.mk
# -include $(MK_DIR)/aws_cognito_idp.mk     ==> folded in aws_cognito.mk
# -include $(MK_DIR)/aws_cognito_sync.mk    ==> folder in aws_cognito.mk
-include $(MK_DIR)/aws_comprehend.mk
-include $(MK_DIR)/aws_comprehendmedical.mk
-include $(MK_DIR)/aws_computeoptimizer.mk
-include $(MK_DIR)/aws_configservice.mk
-include $(MK_DIR)/aws_configure.mk
-include $(MK_DIR)/aws_connect.mk
-include $(MK_DIR)/aws_connectcontactlens.mk
-include $(MK_DIR)/aws_connectparticipant.mk
-include $(MK_DIR)/aws_cur.mk
-include $(MK_DIR)/aws_customerprofiles.mk
-include $(MK_DIR)/aws_databrew.mk
-include $(MK_DIR)/aws_dataexchange.mk
-include $(MK_DIR)/aws_datapipeline.mk
-include $(MK_DIR)/aws_datasync.mk
-include $(MK_DIR)/aws_dax.mk
-include $(MK_DIR)/aws_deploy.mk
-include $(MK_DIR)/aws_detective.mk
-include $(MK_DIR)/aws_devicefarm.mk
-include $(MK_DIR)/aws_devopsguru.mk
-include $(MK_DIR)/aws_directconnect.mk
-include $(MK_DIR)/aws_discovery.mk
-include $(MK_DIR)/aws_dlm.mk
-include $(MK_DIR)/aws_dms.mk
-include $(MK_DIR)/aws_docdb.mk
-include $(MK_DIR)/aws_ds.mk
-include $(MK_DIR)/aws_dynamodb.mk
# -include $(MK_DIR)/aws_dynamodbstreams.mk ==> folded in aws_dynamodb.mk as aws_dynamodb_stream.mk
-include $(MK_DIR)/aws_ebs.mk
-include $(MK_DIR)/aws_ec2.mk
-include $(MK_DIR)/aws_ec2instanceconnect.mk
-include $(MK_DIR)/aws_ecr.mk
-include $(MK_DIR)/aws_ecrpublic.mk
-include $(MK_DIR)/aws_ecs.mk
-include $(MK_DIR)/aws_efs.mk
-include $(MK_DIR)/aws_eks.mk
-include $(MK_DIR)/aws_elasticache.mk
-include $(MK_DIR)/aws_elasticbeanstalk.mk
-include $(MK_DIR)/aws_elastic_inference.mk
-include $(MK_DIR)/aws_elastictranscoder.mk
-include $(MK_DIR)/aws_elb.mk
-include $(MK_DIR)/aws_elbv2.mk
-include $(MK_DIR)/aws_emr.mk
-include $(MK_DIR)/aws_emrcontainers.mk
-include $(MK_DIR)/aws_es.mk
-include $(MK_DIR)/aws_events.mk
-include $(MK_DIR)/aws_finspace.mk
-include $(MK_DIR)/aws_finspacedata.mk
-include $(MK_DIR)/aws_firehose.mk
-include $(MK_DIR)/aws_fis.mk
-include $(MK_DIR)/aws_fms.mk
-include $(MK_DIR)/aws_forecast.mk
-include $(MK_DIR)/aws_forecastquery.mk
-include $(MK_DIR)/aws_frauddetector.mk
-include $(MK_DIR)/aws_fsx.mk
-include $(MK_DIR)/aws_gamelift.mk
-include $(MK_DIR)/aws_glacier.mk
-include $(MK_DIR)/aws_globalaccelerator.mk
-include $(MK_DIR)/aws_glue.mk
-include $(MK_DIR)/aws_greengrass.mk
-include $(MK_DIR)/aws_greengrassv2.mk
-include $(MK_DIR)/aws_groundstation.mk
-include $(MK_DIR)/aws_guardduty.mk
-include $(MK_DIR)/aws_health.mk
-include $(MK_DIR)/aws_healthlake.mk
-include $(MK_DIR)/aws_history.mk
-include $(MK_DIR)/aws_honeycode.mk
-include $(MK_DIR)/aws_iam.mk
-include $(MK_DIR)/aws_identitystore.mk
-include $(MK_DIR)/aws_imagebuilder.mk
-include $(MK_DIR)/aws_importexport.mk
-include $(MK_DIR)/aws_inspector.mk
-include $(MK_DIR)/aws_iot.mk
-include $(MK_DIR)/aws_iot_data.mk
-include $(MK_DIR)/aws_iot_jobs_data.mk
-include $(MK_DIR)/aws_iot1click.mk
# -include $(MK_DIR)/aws_iot1click_devices.mk  ==> folded into aws_iot1click.mk
# -include $(MK_DIR)/aws_iot1click_projects.mk ==> foldef into aws_iot1click.mk
-include $(MK_DIR)/aws_iotanalytics.mk
-include $(MK_DIR)/aws_iotdeviceadvisor.mk
-include $(MK_DIR)/aws_iotevents.mk
-include $(MK_DIR)/aws_iotevents_data.mk
-include $(MK_DIR)/aws_iotfleethub.mk
-include $(MK_DIR)/aws_iotsecuretunneling.mk
-include $(MK_DIR)/aws_iotsitewise.mk
-include $(MK_DIR)/aws_iotthinggraph.mk
-include $(MK_DIR)/aws_iotwireless.mk
-include $(MK_DIR)/aws_ivs.mk
-include $(MK_DIR)/aws_kafka.mk
-include $(MK_DIR)/aws_kendra.mk
-include $(MK_DIR)/aws_kinesis.mk
-include $(MK_DIR)/aws_kinesis_video_archived_media.mk
-include $(MK_DIR)/aws_kinesis_video_media.mk
-include $(MK_DIR)/aws_kinesisanalytics.mk
-include $(MK_DIR)/aws_kinesisvideo.mk
-include $(MK_DIR)/aws_kms.mk
-include $(MK_DIR)/aws_lambda.mk
-include $(MK_DIR)/aws_lex.mk
# -include $(MK_DIR)/aws_lex_models.mk  ==> folded in aws_lex.mk
# -include $(MK_DIR)/aws_lex_runtime.mk ==> folded in aws_lex.mk
-include $(MK_DIR)/aws_lightsail.mk
-include $(MK_DIR)/aws_logs.mk
-include $(MK_DIR)/aws_machinelearning.mk
-include $(MK_DIR)/aws_macie.mk
-include $(MK_DIR)/aws_macie2.mk
-include $(MK_DIR)/aws_managedblockchain.mk
-include $(MK_DIR)/aws_marketplace_catalog.mk
-include $(MK_DIR)/aws_marketplace_entitlement.mk
-include $(MK_DIR)/aws_marketplacecommerceanalytics.mk
-include $(MK_DIR)/aws_mediaconnect.mk
-include $(MK_DIR)/aws_mediaconvert.mk
-include $(MK_DIR)/aws_medialive.mk
-include $(MK_DIR)/aws_mediapackage.mk
-include $(MK_DIR)/aws_mediastore.mk
-include $(MK_DIR)/aws_mediastore_data.mk
-include $(MK_DIR)/aws_mediatailor.mk
-include $(MK_DIR)/aws_memorydb.mk
-include $(MK_DIR)/aws_meteringmarketplace.mk
-include $(MK_DIR)/aws_mgh.mk
-include $(MK_DIR)/aws_mobile.mk
-include $(MK_DIR)/aws_mq.mk
-include $(MK_DIR)/aws_mturk.mk
-include $(MK_DIR)/aws_mwaa.mk
-include $(MK_DIR)/aws_neptune.mk
-include $(MK_DIR)/aws_network_firewall.mk
-include $(MK_DIR)/aws_networkmanager.mk
-include $(MK_DIR)/aws_nimble.mk
-include $(MK_DIR)/aws_opswork.mk
-include $(MK_DIR)/aws_opswork_cm.mk
-include $(MK_DIR)/aws_organizations.mk
-include $(MK_DIR)/aws_outposts.mk
-include $(MK_DIR)/aws_personalize.mk
-include $(MK_DIR)/aws_personalize_events.mk
-include $(MK_DIR)/aws_personalize_runtime.mk
-include $(MK_DIR)/aws_pi.mk
-include $(MK_DIR)/aws_pinpoint.mk
-include $(MK_DIR)/aws_pinpoint_email.mk
-include $(MK_DIR)/aws_pinpoint_sms_voice.mk
-include $(MK_DIR)/aws_polly.mk
-include $(MK_DIR)/aws_pricing.mk
-include $(MK_DIR)/aws_proton.mk
-include $(MK_DIR)/aws_qldb.mk
-include $(MK_DIR)/aws_qldb_session.mk
-include $(MK_DIR)/aws_quicksight.mk
-include $(MK_DIR)/aws_ram.mk
-include $(MK_DIR)/aws_rds.mk
-include $(MK_DIR)/aws_rds_data.mk
-include $(MK_DIR)/aws_redshift.mk
-include $(MK_DIR)/aws_redshift_data.mk
-include $(MK_DIR)/aws_rekognition.mk
-include $(MK_DIR)/aws_resource_groups.mk
-include $(MK_DIR)/aws_resourcegroupstaggingapi.mk
-include $(MK_DIR)/aws_robomaker.mk
-include $(MK_DIR)/aws_route53.mk
-include $(MK_DIR)/aws_route53_recovery_cluster.mk
-include $(MK_DIR)/aws_route53_recovery_control_config.mk
-include $(MK_DIR)/aws_route53_recovery_readiness.mk
-include $(MK_DIR)/aws_route53domains.mk
-include $(MK_DIR)/aws_route53resolver.mk
-include $(MK_DIR)/aws_s3.mk
-include $(MK_DIR)/aws_s3api.mk
-include $(MK_DIR)/aws_s3control.mk
-include $(MK_DIR)/aws_s3outposts.mk
-include $(MK_DIR)/aws_sagemaker.mk
-include $(MK_DIR)/aws_sagemaker_a2i_runtime.mk
-include $(MK_DIR)/aws_sagemaker_edge.mk
-include $(MK_DIR)/aws_sagemaker_featurestore_runtime.mk
-include $(MK_DIR)/aws_sagemaker_runtime.mk
-include $(MK_DIR)/aws_savingsplns.mk
-include $(MK_DIR)/aws_schemas.mk
-include $(MK_DIR)/aws_sdb.mk
-include $(MK_DIR)/aws_secretsmanager.mk
-include $(MK_DIR)/aws_securityhub.mk
-include $(MK_DIR)/aws_serverlessrepo.mk
-include $(MK_DIR)/aws_service_quotas.mk
-include $(MK_DIR)/aws_servicecatalog.mk
-include $(MK_DIR)/aws_servicecatalog_appregistry.mk 
-include $(MK_DIR)/aws_servicediscovery.mk
-include $(MK_DIR)/aws_ses.mk
-include $(MK_DIR)/aws_sesv2.mk
-include $(MK_DIR)/aws_shield.mk
-include $(MK_DIR)/aws_signer.mk
-include $(MK_DIR)/aws_sms.mk
-include $(MK_DIR)/aws_snow_device_management.mk
-include $(MK_DIR)/aws_snowball.mk
-include $(MK_DIR)/aws_sns.mk
-include $(MK_DIR)/aws_sqs.mk
-include $(MK_DIR)/aws_ssm.mk
-include $(MK_DIR)/aws_ssm_contacts.mk
-include $(MK_DIR)/aws_ssm_incidents.mk
-include $(MK_DIR)/aws_sso.mk
# -include $(MK_DIR)/aws_sso_admin.mk  ==> folded into aws_sso.mk
# -include $(MK_DIR)/aws_sso_oidc.mk   ==> folded into aws_sso.mk
-include $(MK_DIR)/aws_stepfunctions.mk
-include $(MK_DIR)/aws_storagegateway.mk
-include $(MK_DIR)/aws_sts.mk
-include $(MK_DIR)/aws_support.mk
-include $(MK_DIR)/aws_swf.mk
-include $(MK_DIR)/aws_synthetics.mk
-include $(MK_DIR)/aws_textract.mk
-include $(MK_DIR)/aws_timestream_query.mk
-include $(MK_DIR)/aws_timestream_write.mk
-include $(MK_DIR)/aws_transcribe.mk
-include $(MK_DIR)/aws_transfer.mk
-include $(MK_DIR)/aws_translate.mk
-include $(MK_DIR)/aws_waf.mk
# -include $(MK_DIR)/aws_waf_regional.mk ==> folded in aws_waf.mk
-include $(MK_DIR)/aws_wafv2.mk
-include $(MK_DIR)/aws_wellarchitected.mk
-include $(MK_DIR)/aws_workdocs.mk
-include $(MK_DIR)/aws_worklink.mk
-include $(MK_DIR)/aws_workmail.mk
-include $(MK_DIR)/aws_workmailmessageflow.mk
-include $(MK_DIR)/aws_workspaces.mk
-include $(MK_DIR)/aws_xray.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_dependencies :: _aws_install_dependencies
_aws_install_dependencies ::
	@$(INFO) '$(AWS_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	$(SUDO) $(PIP) install awscli
	which aws
	aws --version
	$(SUDO) $(PIP) install crudini
	which crudini
	crudini --version

_aws_view_limits ::
	@$(INFO) '$(AWS_UI_LABEL)Viewing ALL the AWS-limits ...'; $(NORMAL)
	@$(WARN) 'This operation returns soft and hard limits'; $(NORMAL)
	@$(WARN) 'Limits can be for the account or the region'; $(NORMAL)
	@$(WARN) 'AWS Service Limits @ https://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html'; $(NORMAL)

_view_versions :: _aws_view_versions
_aws_view_versions ::
	@$(INFO) '$(AWS_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	aws --version
	crudini --version
