_AWS_ELASTICTREANSCODER_PIPELINE_MK_VERSION = $(_AWS_ELASTICTRANSCODER_MK_VERSION)

# ETR_PIPELINE_CONTENT_CONFIG?=
# ETR_PIPELINE_ID?=
# ETR_PIPELINE_INPUT_BUCKET?=
# ETR_PIPELINE_NAME?=
# ETR_PIPELINE_NOTIFICATIONS?=
# ETR_PIPELINE_OUTPUT_BUCKET?=
# ETR_PIPELINE_ROLE?=
# ETR_PIPELINE_STATUS?=
# ETR_PIPELINE_THUMBNAIL_CONFIG?=

# Derived parameters
ETR_PIPELINE_NAMES?= $(ETR_PIPELINE_NAME)

# Option parameters
__ETR_ASCENDING=
__ETR_CONTENT_CONFIG= $(if $(ETR_PIPELINE_CONTENT_CONFIG), --content-config $(ETR_PIPELINE_CONTENT_CONFIG))
__ETR_ID__PIPELINE= $(if $(ETR_PIPELINE_ID), --id $(ETR_PIPELINE_ID))
__ETR_INPUT_BUCKET= $(if $(ETR_PIPELINE_INPUT_BUCKET), --input-bucket $(ETR_PIPELINE_INPUT_BUCKET))
__ETR_NAME__PIPELINE= $(if $(ETR_PIPELINE_NAME), --name $(ETR_PIPELINE_NAME))
__ETR_NOTIFICATIONS= $(if $(ETR_PIPELINE_NOTIFICATIONS), --notifications $(ETR_PIPELINE_NOTIFICATIONS))
__ETR_OUTPUT_BUCKET= $(if $(ETR_PIPELINE_OUTPUT_BUCKET), --output-bucket $(ETR_PIPELINE_OUTPUT_BUCKET))
__ETR_PIPELINE_ID= $(if $(ETR_PIPELINE_ID), --pipeline-id $(ETR_PIPELINE_ID))
__ETR_ROLE= $(if $(ETR_PIPELINE_ROLE), --role $(ETR_PIPELINE_ROLE))
__ETR_STATUS= $(if $(ETR_PIPELINE_STATUS), --status $(ETR_PIPELINE_STATUS))
__ETR_THUMBNAIL_CONFIG= $(if $(ETR_PIPELINE_THUMBNAIL_CONFIG), --thumbail-config $(ETR_PIPELINE_THUMBNAIL_CONFIG))

# UI parameters

#--- MACRO
_etr_get_pipeline_id=

#----------------------------------------------------------------------
# USAGE
#

_etr_view_framework_macros ::
	@echo 'AWS::ETR::ElasticTranscodeR ($(_AWS_ELASTICTREANSCODER_PIPELINE_MK_VERSION)) macros:'
	@echo '    _etr_get_pipeline_id              - Get ID of a byte-match-set'
	@echo

_etr_view_framework_parameters ::
	@echo 'AWS::ETR::ElasticTranscodeR ($(_AWS_ELASTICTREANSCODER_PIPELINE_MK_VERSION)) parameters:'
	@echo '    ETR_PIPELINE_CONTENT_CONFIG=$(ETR_PIPELINE_CONTENT_CONFIG)'
	@echo '    ETR_PIPELINE_ID=$(ETR_PIPELINE_ID)'
	@echo '    ETR_PIPELINE_INPUT_BUCKET=$(ETR_PIPELINE_INPUT_BUCKET)'
	@echo '    ETR_PIPELINE_NAME=$(ETR_PIPELINE_NAME)'
	@echo '    ETR_PIPELINE_NOTIFICATIONS=$(ETR_PIPELINE_NOTIFICATIONS)'
	@echo '    ETR_PIPELINE_OUTPUT_BUCKET=$(ETR_PIPELINE_OUTPUT_BUCKET)'
	@echo '    ETR_PIPELINE_ROLE=$(ETR_PIPELINE_ROLE)'
	@echo '    ETR_PIPELINE_STATUS=$(ETR_PIPELINE_STATUS)'
	@echo '    ETR_PIPELINE_THUMBNAIL_CONFIG=$(ETR_PIPELINE_THUMBNAIL_CONFIG)'
	@echo

_etr_view_framework_targets ::
	@echo 'AWS::ETR::ElasticTranscodeR ($(_AWS_ELASTICTREANSCODER_PIPELINE_MK_VERSION)) targets:'
	@echo '    _etr_create_pipeline                      - Create a pipeline'
	@echo '    _etr_delete_pipeline                      - Delete a pipeline'
	@echo '    _etr_show_pipeline                        - Show everything related to a pipeline'
	@echo '    _etr_show_pipeline_description            - Show description of a pipeline'
	@echo '    _etr_show_pipeline_jobs                   - Show jobs in a pipeline'
	@echo '    _etr_update_pipeline                      - Update a pipeline'
	@echo '    _etr_update_pipeline_notifications        - Update notifications of a pipeline'
	@echo '    _etr_update_pipeline_status               - Update the status of a pipeline'
	@echo '    _etr_view_pipelines                       - View existing pipelines'
	@echo '    _etr_view_pipelines_set                   - View a set of pipelines'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_etr_create_pipeline:
	@$(INFO) '$(AWS_UI_LABEL)Creating pipeline "$(ETR_PIPELINE_NAME)" ...'; $(NORMAL)
	$(AWS) elastictranscoder create-pipeline $(__ETR_CONTENT_CONFIG) $(__ETR_INPUT_BUCKET) $(__ETR_NAME__PIPELINE) $(__ETR_NOTIFICATIONS) $(__ETR_OUTPUT_BUCKET) $(__ETR_ROLE) $(__ETR_THUMBNAIL_CONGIF)

_etr_delete_pipeline:
	@$(INFO) '$(AWS_UI_LABEL)Deleting pipeline "$(ETR_PIPELINE_NAME)" ...'; $(NORMAL)
	$(AWS) elastictranscoder delete-pipeline $(__ETR_ID__PIPELINE)

_etr_show_pipeline: _etr_show_pipeline_jobs _etr_show_pipeline_description

_etr_show_pipeline_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of pipeline "$(ETR_PIPELINE_NAME)" ...'; $(NORMAL)
	$(AWS) elastictranscoder read-pipeline $(__ETR_ID__PIPELINE)

_etr_show_pipeline_jobs:
	@$(INFO) '$(AWS_UI_LABEL)Showing jobs of pipeline "$(ETR_PIPELINE_NAME)" ...'; $(NORMAL)
	$(AWS) elastictranscoder list-jobs-by-pipeline $(__ETR_ASCENDING) $(__ETR_PIPELINE_ID)

_etr_update_pipeline:
	@$(INFO) '$(AWS_UI_LABEL)Updating pipeline "$(ETR_PIPELINE_NAME)" ...'; $(NORMAL)
	$(AWS) elastictranscoder update-pipeline $(__ETR_CONTENT_CONFIG) $(__ETR_ID__PIPELINE) $(__ETR_INPUT_BUCKET) $(__ETR_NAME__PIPELINE) $(__ETR_NOTIFICATIONS) $(__ETR_OUTPUT_BUCKET) $(__ETR_ROLE) $(__ETR_THUMBNAIL_CONGIF)

_etr_update_pipeline_notifications:
	@$(INFO) '$(AWS_UI_LABEL)Updating notifications of pipeline "$(ETR_PIPELINE_NAME)" ...'; $(NORMAL)
	$(AWS) elastictranscoder update-pipeline-notifications $(__ETR_ID__PIPELINE) $(__ETR_NOTIFICATIONS)

_etr_update_pipeline_status:
	@$(INFO) '$(AWS_UI_LABEL)Updating status of pipeline "$(ETR_PIPELINE_NAME)" ...'; $(NORMAL)
	$(AWS) elastictranscoder update-pipeline-status $(__ETR_ID__PIPELINE) $(__ETR_STATUS)

_etr_view_pipelines:
	@$(INFO) '$(AWS_UI_LABEL)Viewing ALL pipelines ...'; $(NORMAL)
	$(AWS) elastictranscoder list-pipelines $(__ETR_ASCENDING)

_etr_view_pipelines_set:

