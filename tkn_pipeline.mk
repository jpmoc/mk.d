_TKN_PIPELINE_MK_VERSION= $(_TKN_MK_VERSION)

# TKN_PIPELINE_CURL_BIN?= time curl
# TKN_PIPELINE_NAME?= helloworld-go
# TKN_PIPELINE_NAMESPACE_NAME?= eventing-example
# TKN_PIPELINE_PARAMETERS_KEYVALUES?=
# TKN_PIPELINE_SERVICEACCOUNT_NAME?=
# TKN_PIPELINE_SHOWLOG_FLAG?= false
# TKN_PIPELINES_NAMESPACE_NAME?= eventing-example
# TKN_PIPELINES_SET_NAME?= my-pipelines-set

# Derived parameters
TKN_PIPELINE_NAMESPACE_NAME?= $(TKN_NAMESPACE_NAME)
TKN_PIPELINE_SHOWLOG_FLAG?= $(TKN_SHOWLOG_FLAG)
TKN_PIPELINES_NAMESPACE_NAME?= $(TKN_PIPELINE_NAMESPACE_NAME)
TKN_PIPELINES_SET_NAME?= tekton-pipelines@@@$(TKN_PIPELINES_NAMESPACE_NAME)

# Options
__TKN_NAMESPACE__PIPELINE= $(if $(TKN_PIPELINE_NAMESPACE_NAME),--namespace $(TKN_PIPELINE_NAMESPACE_NAME))
__TKN_NAMESPACE__PIPELINES= $(if $(TKN_PIPELINES_NAMESPACE_NAME),--namespace $(TKN_PIPELINES_NAMESPACE_NAME))
__TKN_PARAM__PIPELINE= $(if $(TKN_PIPELINE_PARAMETERS_KEYVALUES),--param $(TKN_PIPELINE_PARAMETERS_KEYVALUES))
__TKN_SERVICEACCOUNT__PIPELINE= $(if $(TKN_PIPELINE_SERVICEACCOUNT_NAME),--serviceaccount $(TKN_PIPELINE_SERVICEACCOUNT_NAME))
__TKN_SHOWLOG__PIPELINE= $(if $(filter true,$(TKN_PIPELINE_SHOWLOG_FLAG)),--showlog)

# Customizations

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_tkn_list_macros ::
	@#echo 'TKN::Pipeline ($(_TKN_PIPELINE_MK_VERSION)) macros:'
	@#echo

_tkn_list_parameters ::
	@echo 'TKN::Pipeline ($(_TKN_PIPELINE_MK_VERSION)) parameters:'
	@echo '    TKN_PIPELINE_NAME=$(TKN_PIPELINE_NAME)'
	@echo '    TKN_PIPELINE_NAMESPACE_NAME=$(TKN_PIPELINE_NAMESPACE_NAME)'
	@echo '    TKN_PIPELINE_PARAMETERS_KEYVALUES=$(TKN_PIPELINE_PARAMETERS_KEYVALUES)'
	@echo '    TKN_PIPELINE_SHOWLOG_FLAG=$(TKN_PIPELINE_SHOWLOG_FLAG)'
	@echo '    TKN_PIPELINE_SERVICEACCOUNT_NAME=$(TKN_PIPELINE_SERVICEACCOUNT_NAME)'
	@echo '    TKN_PIPELINES_NAMESPACE_NAME=$(TKN_PIPELINES_NAMESPACE_NAME)'
	@echo '    TKN_PIPELINES_SET_NAME=$(TKN_PIPELINES_SET_NAME)'
	@echo

_tkn_list_targets ::
	@echo 'TKN::Pipeline ($(_TKN_PIPELINE_MK_VERSION)) targets:'
	@echo '    _tkn_create_pipeline                  - Create a new pipeline'
	@echo '    _tkn_delete_pipeline                  - Delete an existing pipeline'
	@echo '    _tkn_list_pipelines                   - List all pipelines'
	@echo '    _tkn_list_pipelines_set               - List a set of pipelines'
	@echo '    _tkn_show_pipeline                    - Show everything related to a pipeline'
	@echo '    _tkn_show_pipeline_description        - Show the description of a pipeline'
	@echo '    _tkn_show_pipeline_parameters         - Show the parameters of a pipeline'
	@echo '    _tkn_show_pipeline_pipelineruns       - Show the pipeline-runs of a pipeline'
	@echo '    _tkn_show_pipeline_tasks              - Show the tasks in a pipeline'
	@echo '    _tkn_show_pipeline_workspaces         - Show the workspaces of a pipeline'
	@echo '    _tkn_start_pipeline                   - Start a pipelines'
	@#echo '    _tkn_watch_pipelines                  - Watch pipelines'
	@#echo '    _tkn_watch_pipelines_set              - Watch a set of pipelines'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tkn_create_pipeline:
	@$(INFO) '$(TKN_UI_LABEL)Creating pipeline "$(TKN_PIPELINE_NAME)" ...'; $(NORMAL)
	$(TKN) source pipelineate ... $(__TKN_NAMESPACE__PIPELINE)

_tkn_delete_pipeline:
	@$(INFO) '$(TKN_UI_LABEL)Deleting pipeline "$(TKN_PIPELINE_NAME)" ...'; $(NORMAL)

_tkn_list_pipelines:
	@$(INFO) '$(TKN_UI_LABEL)Listing ALL pipelines ...'; $(NORMAL)
	$(TKN) pipeline list --all-namespaces=true $(_X__TKN_NAMESPACE__PIPELINES)

_tkn_list_pipelines_set:
	@$(INFO) '$(TKN_UI_LABEL)Listing pipelines-set "$(KN_PIPELINES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Pipelines are grouped based on the provided namespace, and ...'; $(NORMAL)
	$(TKN) pipeline list --all-namespaces=false $(__TKN_NAMESPACE__PIPELINES)

_TKN_SHOW_PIPELINE_TARGETS?= _tkn_show_pipeline_parameters _tkn_show_pipeline_pipelineruns _tkn_show_pipeline_tasks _tkn_show_pipeline_workspaces _tkn_show_pipeline_description
_tkn_show_pipeline: $(_TKN_SHOW_PIPELINE_TARGETS)

_tkn_show_pipeline_description:
	@$(INFO) '$(TKN_UI_LABEL)Showing description pipeline "$(TKN_PIPELINE_NAME)" ...'; $(NORMAL)
	$(TKN) pipeline describe $(__TKN_NAMESPACE__PIPELINE) $(TKN_PIPELINE_NAME)

_tkn_show_pipeline_parameters:
	@$(INFO) '$(TKN_UI_LABEL)Showing parameters of pipeline "$(TKN_PIPELINE_NAME)" ...'; $(NORMAL)

_tkn_show_pipeline_pipelineruns:
	@$(INFO) '$(TKN_UI_LABEL)Showing inscantiation of pipeline "$(TKN_PIPELINE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Instanciations are also known as pipeline-runs'; $(NORMAL)

_tkn_show_pipeline_tasks:
	@$(INFO) '$(TKN_UI_LABEL)Showing tasks in pipeline "$(TKN_PIPELINE_NAME)" ...'; $(NORMAL)

_tkn_show_pipeline_workspaces:
	@$(INFO) '$(TKN_UI_LABEL)Showing workspaces in pipeline "$(TKN_PIPELINE_NAME)" ...'; $(NORMAL)

_tkn_start_pipeline:
	@$(INFO) '$(TKN_UI_LABEL)Starting pipeline "$(TKN_PIPELINE_NAME)" ...'; $(NORMAL)
	$(TKN) pipeline start $(__TKN_LABELS__PIPELINES) $(__TKN_PARAM__PIPELINE) $(__TKN_SERVICEACCCOUNT__PIPELINE) $(__TKN_SHOWLOG__PIPELINE) $(__TKN_WORKSPACE__PIPELINE) $(TKN_PIPELINE_NAME)

_tkn_update_pipeline:
	@$(INFO) '$(TKN_UI_LABEL)Updating pipeline "$(KN_PIPELINE_NAME)" ...'; $(NORMAL)

_tkn_watch_pipelines:
	@$(INFO) '$(TKN_UI_LABEL)Watching pipelines ...'; $(NORMAL)

_tkn_watch_pipelines_set:
	@$(INFO) '$(TKN_UI_LABEL)Watching pipelines ...'; $(NORMAL)
