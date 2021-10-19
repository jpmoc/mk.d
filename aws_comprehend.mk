_AWS_COMPREHEND_MK_VERSION= 0.99.0

# CPD_TEXT?= It is raining today in Seattle
# CPD_TEXT_LANGUAGE_CODE?= en
# # CPD_TOPICJOB_ID?= ce743335c9b0427f3d438a0f5d5fcb37
CPD_TOPICJOB_INDEX?= -1
# CPD_TOPICJOB_INPUT_CONFIG?= S3Uri=string,InputFormat=ONE_DOC_PER_FILE
# CPD_TOPICJOB_NAME?= my-topics-detection-job
CPD_TOPICJOB_NUMBER_TOPICS?= 10
# CPD_TOPICJOB_OUTPUT_CONFIG?= S3Uri=string
# CPD_TOPICJOB_ROLE_ARN?= 
# CPD_TOPICJOBSET_NAME?= my-topic-job-set

# Derived parameters
$(CPD_TOPICJOBSET_NAME?= $(CPD_TOPICJOB_NAME)

# Options parameters
__CPD_DATA_ACCESS_ROLE_ARN= $(if $(CPD_TOPICJOB_ROLE_ARN), --data-access-role-arn $(CPD_TOPICJOB_ROLE_ARN))
__CPD_INPUT_DATA_CONFIG= $(if $(CPD_TOPICJOB_INPUT_CONFIG), --input-data-config $(CPD_TOPICJOB_INPUT_CONFIG))
__CPD_JOB_ID= $(if $(CPD_TOPICJOB_ID), --job-id $(CPD_TOPICJOB_ID))
__CPD_JOB_NAME= $(if $(CPD_TOPICJOB_NAME), --job-name $(CPD_TOPICJOB_NAME))
__CPD_LANGUAGE_CODE= $(if $(CPD_TEXT_LANGUAGE_CODE), --language-code $(CPD_TEXT_LANGUAGE_CODE))
__CPD_OUTPUT_DATA_CONFIG= $(if $(CPD_TOPICJOB_OUTPUT_CONFIG), --output-data-config $(CPD_TOPICJOB_OUTPUT_CONFIG))
__CPD_NUMBER_OF_TOPICS= $(if $(CPD_TOPICJOB_NUMBER_TOPICS), --number-of-topics $(CPD_TOPICJOB_NUMBER_TOPICS))
__CPD_TEXT= $(if $(CPD_TEXT), --text '$(CPD_TEXT)')

# UI parameters
CPD_UI_LABEL?= $(AWS_UI_LABEL)
CPD_UI_VIEW_TOPICJOBS_FIELDS?= .{JobId:JobId,JobName:JobName,jobStatus:JobStatus,submitTime:SubmitTime,endTime:EndTime}
CPD_UI_VIEW_TOPICJOBSET_FIELDS?= $(CPD_UI_VIEW_TOPICJOBS_FIELDS)

#--- Utilities

#--- MACRO
_cpd_get_last_submitted_topicjob_id_N=$(shell $(AWS) comprehend list-topics-detection-jobs  --query "TopicsDetectionJobPropertiesList[-1].JobId" --output text)

_cpd_get_topicjob_id=$(call _cpd_get_topicjob_id_N, $(CPD_TOPICJOB_NAME))
_cpd_get_topicjob_id_N=$(call _cpd_get_topicjob_id_NI, $(1), $(CPD_TOPICJOB_INDEX))
_cpd_get_topicjob_id_NI=$(shell $(AWS) comprehend list-topics-detection-jobs  --query "TopicsDetectionJobPropertiesList[?JobName=='$(strip $(1))'] | [$(2)].JobId" --output text)

_cpd_get_s3_output_uri=$(call _cpd_get_s3_output_uri_I, $(CPD_TOPICJOB_ID))
_cpd_get_s3_output_uri_I=$(shell $(AWS) comprehend describe-topics-detection-job --job-id $(1) --query "TopicsDetectionJobProperties.OutputDataConfig.S3Uri" --output text)

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _cpd_view_framework_macros
_cpd_view_framework_macros ::  
	@echo 'AWS::ComPrehenD ($(_AWS_COMPREHEND_MK_VERSION)) macros:'
	@echo '    _cpd_get_last_submitted_topicjob_id_{|N}        - Get the ID of the last submitted topics-detectino job'
	@echo '    _cpd_get_s3_output_uri_{|I}                     - Get the S3 URI of the output.tar.gz file'
	@echo '    _cpd_get_topicjob_id_{|N}                       - Get the ID of the last submitted topics-detection job in a set'
	@echo

_aws_view_framework_parameters :: _cpd_view_framework_parameters
_cpd_view_framework_parameters ::
	@echo 'AWS::ComPrehenD ($(_AWS_COMPREHEND_MK_VERSION)) parameters:'
	@echo '    CPD_TEXT=$(CPD_TEXT)'
	@echo '    CPD_TEXT_LANGUAGE_CODE=$(CPD_TEXT_LANGUAGE_CODE)'
	@echo '    CPD_TOPICJOB_ID=$(CPD_TOPICJOB_ID)'
	@echo '    CPD_TOPICJOB_INDEX=$(CPD_TOPICJOB_INDEX)'
	@echo '    CPD_TOPICJOB_INPUT_CONFIG=$(CPD_TOPICJOB_INPUT_CONFIG)'
	@echo '    CPD_TOPICJOB_NAME=$(CPD_TOPICJOB_NAME)'
	@echo '    CPD_TOPICJOB_NUMBER_TOPICS=$(CPD_TOPICJOB_NUMBER_TOPICS)'
	@echo '    CPD_TOPICJOB_OUTPUT_CONFIG=$(CPD_TOPICJOB_OUTPUT_CONFIG)'
	@echo '    CPD_TOPICJOB_ROLE_ARN=$(CPD_TOPICJOB_ROLE_ARN)'
	@echo '    CPD_TOPICJOBSET_NAME=$(CPD_TOPICJOBSET_NAME)'
	@echo

_aws_view_framework_targets :: _cpd_view_framework_targets
_cpd_view_framework_targets ::
	@echo 'AWS::ComPrehenD ($(_AWS_COMPREHEND_MK_VERSION)) targets:'
	@echo '    _cpd_detect_entities                            - Detect all the entities in the text'
	@echo '    _cpd_detect_keyphrase                           - Detect key-phrases from text'
	@echo '    _cpd_detect_language                            - Detect the fomaint language used in text'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cpd_detect_entities:
	@$(INFO) '$(CPD_UI_LABEL)Detecting entities from text ...'; $(NORMAL)
	$(AWS) comprehend detect-entities $(__CPD_LANGUAGE_CODE) $(__CPD_TEXT) --query "Entities[]"

_cpd_detect_keyphrases:
	@$(INFO) '$(CPD_UI_LABEL)Detecting key-phrases from text ...'; $(NORMAL)
	$(AWS) comprehend detect-key-phrases $(__CPD_LANGUAGE_CODE) $(__CPD_TEXT) --query "KeyPhrases[]"

_cpd_detect_language:
	@$(INFO) '$(CPD_UI_LABEL)Detecting dominant language from text ...'; $(NORMAL)
	$(AWS) comprehend detect-dominant-language $(__CPD_TEXT) --query "Languages[]"

_cpd_detect_sentiment:
	@$(INFO) '$(CPD_UI_LABEL)Detecting sentiment from text ...'; $(NORMAL)
	$(AWS) comprehend detect-sentiment $(__CPD_LANGUAGE_CODE) $(__CPD_TEXT) --query "@"

_cpd_show_topicjob:
	@$(INFO) '$(CPD_UI_LABEL)Showing details of topics-detection job ...'; $(NORMAL)
	$(AWS) comprehend describe-topics-detection-job $(__CPD_JOB_ID) --query "TopicsDetectionJobProperties"

_cpd_start_topicjob:
	@$(INFO) '$(CPD_UI_LABEL)Start a topics-detection job ...'; $(NORMAL)
	$(AWS) comprehend start-topics-detection-job $(__CPD_DATA_ACCESS_ROLE_ARN) $(__CPD_INPUT_DATA_CONFIG) $(__CPD_JOB_NAME) $(__CPD_NUMBER_OF_TOPICS) $(__CPD_OUTPUT_DATA_CONFIG) --query "@"

_cpd_view_topicjobs:
	@$(INFO) '$(CPD_UI_LABEL)Viewing topics-detection jobs ...'; $(NORMAL)
	$(AWS) comprehend list-topics-detection-jobs $(__CPD_FILTER_JOBS) --query "TopicsDetectionJobPropertiesList[]$(CPD_UI_VIEW_TOPICJOBS_FIELDS)"

_cpd_view_topicjobset:
	@$(INFO) '$(CPD_UI_LABEL)Viewing topics-detection jobs in set '$(CPD_TOPICJOBSET_NAME)' ...'; $(NORMAL)
	$(AWS) comprehend list-topics-detection-jobs $(__CPD_FILTER_JOBS) --query "TopicsDetectionJobPropertiesList[?JobName=='$(CPD_TOPICJOB_NAME)']$(CPD_UI_VIEW_TOPICJOBSET_FIELDS)"
