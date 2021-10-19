_AWS_ES_MK_VERSION= 0.99.4

# ES_ELASTICSEARCH_VERSION?= 6.3

# Derived variables

# Options
__ES_ELASTICSEARCH_VERSION?= $(if $(ES_ELASTICSEARCH_VERSION), --elasticsearch-version $(ES_ELASTICSEARCH_VERSION))

# UI variables

#--- Utilities

#--- Macros

_es_get_latest_es_version= $(shell $(AWS) es list-elasticsearch-versions  --query 'ElasticsearchVersions[0]' --output text)

#----------------------------------------------------------------------
# USAGE
#

_aws_install_framework_dependencies :: _es_install_framework_dependencies
_es_install_framework_dependencies ::

_aws_view_framework_macros :: _es_view_framework_macros
_es_view_framework_macros ::
	@echo 'AWS::ElasticSearch ($(_AWS_ES_MK_VERSION)) macros:' 
	@echo '    _es_get_latest_es_version           - Get the latest version of ES available on AWS'
	@echo

_aws_view_framework_parameters :: _es_view_framework_parameters
_es_view_framework_parameters ::
	@echo 'AWS::ElasticSearch ($(_AWS_ES_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _es_view_framework_targets
_es_view_framework_targets ::
	@echo 'AWS::ElasticSearch ($(_AWS_ES_MK_VERSION)) targets:' 
	@echo '    _es_view_instancetypes              - View available instance-types for a given ES version'
	@echo '    _es_view_versions                   - View supported ES versions'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_es_domain.mk
-include $(MK_DIR)/aws_es_proxy.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_es_view_instancetypes:
	@$(INFO) '$(AWS_UI_LABEL)View instance-types available for the ES version "$(ES_ELASTICSEARCH_VERSION)" ...'; $(NORMAL)
	@$(WARN) 'Newer version of ES support newer AWS instance-types'; $(NORMAL)
	$(AWS) es list-elasticsearch-instance-types $(_X__ES_DOMAIN_NAME) $(__ES_ELASTICSEARCH_VERSION)

_es_view_versions:
	@$(INFO) '$(AWS_UI_LABEL)View versions of elasticsearch available on AWS ...'; $(NORMAL)
	$(AWS) es list-elasticsearch-versions
