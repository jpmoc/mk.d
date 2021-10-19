_AWS_KAFKA_MK_VERSION= 0.99.6

# KKA_INPUTS_DIRPATH?= ./in/

# Derived parameters
KKA_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)

# Option parameters

# UI parameters
KKA_UI_LABEL?= $(AWS_UI_LABEL)

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _kka_view_framework_macros
_kka_view_framework_macros ::
	@#echo 'AWS::Kafka ($(_AWS_KAFKA_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _kka_view_framework_parameters
_kka_view_framework_parameters ::
	@echo 'AWS::Kafka ($(_AWS_KAFKA_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _kka_view_framework_targets
_kka_view_framework_targets ::
	@echo 'AWS::Kafka ($(_AWS_KAFKA_MK_VERSION)) targets:'
	@echo '    _kka_view_kafkaversions          - View the offered versions'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_kafka_cluster.mk
-include $(MK_DIR)/aws_kafka_configuration.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kka_view_kafkaversions:
	@$(INFO) '$(KKA_UI_LABEL)Viewing offered kafka-versions ...'; $(NORMAL)
	$(AWS) kafka list-kafka-versions --query "KafkaVersions[]"
