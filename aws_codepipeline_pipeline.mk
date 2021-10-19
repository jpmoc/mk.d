_AWS_CODEPIPELINE_PIPELINE_MK_VERSION= $(_AWS_CODEPIPELINE_MK_VERSION)

# CPE_PIPELINE_CONFIG?=
# CPE_PIPELINE_CONFIG_FILEPATH?= ./pipeline-config.json
# CPE_PIPELINE_NAME?= DevopsWorkshopLab3
# CPE_PIPELINE_VERSION?= 3
# CPE_PIPELINES_SET_NAME?= my-pipelines-set

# Derived parameters
CPE_PIPELINE_CONFIG?= $(if $(CPE_PIPELINE_CONFIG_FILEPATH),file://$(CPE_PIPELINE_CONFIG_FILEPATH))

# Options parameters
__CPE_NAME__PIPELINE= $(if $(CPE_PIPELINE_NAME), --name $(CPE_PIPELINE_NAME))
__CPE_PIPELINE= $(if $(CPE_PIPELINE_CONFIG), --pipeline $(CPE_PIPELINE_CONFIG))
__CPE_PIPELINE_VERSION= $(if $(CPE_PIPELINE_VERSION), --pipeline-version $(CPE_PIPELINE_VERSION))

# UI parameters
CPE_UI_VIEW_PIPELINES_FIELDS?=
CPE_UI_VIEW_PIPELINES_SET_FIELDS?= $(CPE_UI_VIEW_PIPELINES_FIELDS)
CPE_UI_VIEW_PIPELINES_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_cpe_view_makefile_macros ::
	@#echo 'AWS::CodePipelinE::Pipeline ($(_AWS_CODEPIPELINE_PIPELINE_MK_VERSION)) macros:'
	@#echo

_cpe_view_makefile_parameters ::
	@echo 'AWS::CodePipelinE::Pipeline ($(_AWS_CODEPIPELINE_PIPELINE_MK_VERSION)) parameters:'
	@echo '    CPE_PIPELINE_NAME=$(CPE_PIPELINE_NAME)'
	@echo '    CPE_PIPELINE_VERSION=$(CPE_PIPELINE_VERSION)'
	@echo '    CPE_PIPELINES_SET_NAME=$(CPE_PIPELINES_SET_NAME)'
	@echo

_cpe_view_makefile_targets ::
	@echo 'AWS::CodePipelinE::Pipeline ($(_AWS_CODEPIPELINE_PIPELINE_MK_VERSION)) targets:'
	@echo '    _cpe_create_pipeline              - Create a new pipeline'
	@echo '    _cpe_delete_pipeline              - Delete an existing pipeline'
	@echo '    _cpe_show_pipeline                - Show details of a pipeline'
	@echo '    _cpe_view_pipelines               - View existing pipelines'
	@echo '    _cpe_view_pipelines_set           - View a set of pipelines'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cpe_create_pipeline:
	@$(INFO) '$(AWS_UI_LABEL)Creating pipeline "$(CPE_PIPELINE_NAME)" ...'; $(NORMAL)
	$(AWS) codepipeline create-pipeline $(__CPE_PIPELINE)

_cpe_delete_pipeline:
	@$(INFO) '$(AWS_UI_LABEL)Deleting pipeline "$(CPE_PIPELINE_NAME)" ...'; $(NORMAL)
	$(AWS) codepipeline delete-pipeline $(__CPE_NAME__PIPELINE)

_cpe_show_pipeline:
	@$(INFO) '$(AWS_UI_LABEL)Showing pipeline "$(CPE_PIPELINE_NAME)" ...'; $(NORMAL)
	$(AWS) codepipeline get-pipeline $(__CPE_NAME__PIPELINE) $(__CPE_PIPELINE_VERSION)

_cpe_view_pipelines:
	@$(INFO) '$(AWS_UI_LABEL)Viewing pipelines'; $(NORMAL)
	$(AWS) codepipeline list-pipelines --query "pipelines[]$(CPE_UI_VIEW_PIPELINES_FIELDS)"

_cpe_view_pipelines_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing pipelines-set "$(CPE_PIPELINES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Pipelines are grouped based on the provided slice'; $(NORMAL)
	$(AWS) codepipeline list-pipelines --query "pipelines[$(CPE_UI_VIEW_PIPELINES_SET_SLICE)]$(CPE_UI_VIEW_PIPELINES_SET_FIELDS)"
