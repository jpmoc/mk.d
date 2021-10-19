_TERRAFORM_GRAPH_MK_VERSION= $(_TERRAFORM_MK_VERSION)

# TFM_GRAPH_COLOR_FLAG?= true
# TFr_GRAPH_DIRPATH?=
# TFr_GRAPH_DRAWCYCLES_FLAG?= true
# TFM_GRAPH_ENVIRONMENT_DIRPATH?=
# TFM_GRAPH_FILENAME?=
# TFM_GRAPH_FILEPATH?=
TFM_GRAPH_MODULE_DEPTH?= -1
# TFM_GRAPH_NAME?= my-graph
# TFM_GRAPH_TEMPLATE_DIRPATH?=
TFM_GRAPH_TYPE?= plan
# TFM_GRAPHS_DIRPATH?=
TFM_GRAPHS_REGEX?= *tfgraph
# TFM_GRAPHS_SET_NAME?= my-graphs-set

# Derived variables
TFM_GRAPH_COLOR_FLAG?= $(TFM_COLOR_FLAG)
TFM_GRAPH_DIRPATH?= $(TFM_GRAPH_ENVIRONMENT_DIRPATH)
TFM_GRAPH_ENVIRONMENT_DIRPATH?= $(TFM_ENVIRONMENT_DIRPATH)
TFM_GRAPH_FILENAME?= $(if $(TFM_GRAPH_NAME),$(TFM_GRAPH_NAME).tfgraph)
TFM_GRAPH_FILEPATH?= $(TFM_GRAPH_DIRPATH)$(TFM_GRAPH_FILENAME)
TFM_GRAPH_TEMPLATE_DIRPATH?= $(TFM_TEMPLATE_DIRPATH)
TFM_GRAPHS_DIRPATH?= $(TFM_GRAPH_DIRPATH)

# Options variables
__TFM_DRAW_CYCLES?= $(if $(filter true, $(TFM_GRAPH_DRAWCYCLES_FLAG)),-draw-cycles)
__TFM_MODULE_DEPTH?= $(if $(TFM_GRAPH_MODULE_DEPTH),-module-depth $(TFM_GRAPH_MODULE_DEPTH))
__TFM_NO_COLOR__GRAPH?= $(if $(filter false, $(TFM_GRAPH_COLOR_FLAG)),-no-color)
__TFM_TYPE?= $(if $(TFM_GRAPH_TYPE),-type=$(TFM_GRAPH_TYPE))

# Utilities

# Pipe
_TFM_CREATE_GRAPH_|?= cd $(TFM_GRAPH_ENVIRONMENT_DIRPATH) &&
_TFM_DELETE_GRAPH_|?= [ ! -f $(TFM_GRAPH_FILEPATH) ] || 
_TFM_SHOW_GRAPH_CONTENT|?= [ ! -f $(TFM_GRAPH_FILEPATH) ] || 
_TFM_SHOW_GRAPH_DESCRIPTION_|?= [ ! -f $(TFM_GRAPH_FILEPATH) ] || 
_TFM_VIEW_GRAPHS_|?= [ ! -d $(TFM_GRAPHS_DIRPATH) ] ||#
_TFM_VIEW_GRAPHS_SET_|?= [ ! -d $(TFM_GRAPHS_DIRPATH) ] ||#
|_TFM_CREATE_GRAPH?= $(if $(TFM_GRAPH_FILEPATH), | tee $(TFM_GRAPH_FILEPATH))
|_TFM_SHOW_GRAPH_CONTENT?= | head -10

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_tfm_view_framework_macros ::
	@echo 'TerraForM::Graph ($(_TERRAFORM_GRAPH_MK_VERSION)) macros:'
	@echo

_tfm_view_framework_parameters ::
	@echo 'TerraForM::Graph ($(_TERRAFORM_GRAPH_MK_VERSION)) parameters:'
	@echo '    TFM_GRAPH_COLOR_FLAG=$(TFM_GRAPH_COLOR_FLAG)'
	@echo '    TFM_GRAPH_DIRPATH=$(TFM_GRAPH_DIRPATH)'
	@echo '    TFM_GRAPH_DRAWCYCLES_FLAG=$(TFM_GRAPH_DRAWCYCLES_FLAG)'
	@echo '    TFM_GRAPH_ENVIRONMENT_DIRPATH=$(TFM_GRAPH_ENVIRONMENT_DIRPATH)'
	@echo '    TFM_GRAPH_FILENAME=$(TFM_GRAPH_FILENAME)'
	@echo '    TFM_GRAPH_FILEPATH=$(TFM_GRAPH_FILEPATH)'
	@echo '    TFM_GRAPH_MODULE_DEPTH=$(TFM_GRAPH_MODULE_DEPTH)'
	@echo '    TFM_GRAPH_NAME=$(TFM_GRAPH_NAME)'
	@echo '    TFM_GRAPH_TEMPLATE_DIRPATH=$(TFM_GRAPH_TEMPLATE_DIRPATH)'
	@echo '    TFM_GRAPH_TYPE=$(TFM_GRAPH_TYPE)'
	@echo '    TFM_GRAPHS_DIRPATH=$(TFM_GRAPHS_DIRPATH)'
	@echo '    TFM_GRAPHS_REGEX=$(TFM_GRAPHS_REGEX)'
	@echo '    TFM_GRAPHS_SET_NAME=$(TFM_GRAPHS_SET_NAME)'
	@echo

_tfm_view_framework_targets ::
	@echo 'TerraForM::Graph ($(_TERRAFORM_GRAPH_MK_VERSION)) targets:'
	@echo '    _tfm_create_graph                  - Create a graph'
	@echo '    _tfm_delete_graph                  - Delete an existing graph'
	@echo '    _tfm_show_graph                    - Show everything related to a graph'
	@echo '    _tfm_show_graph_content            - Show content of a graph'
	@echo '    _tfm_show_graph_description        - Show description of a graph'
	@echo '    _tfm_view_graphs                   - View graphs'
	@echo '    _tfm_view_graphs_set               - View set of graphs'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tfm_create_graph:
	@$(INFO) '$(TFM_UI_LABEL)Creating graph "$(TFM_GRAPH_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation generates the graph based on information in the template and state files'; $(NORMAL)
	$(_TFM_CREATE_GRAPH_|) $(TERRAFORM) graph $(__TFM_DRAW_CYCLES) $(__TFM_MODULE_DEPTH) $(__TFN_NO_COLOR__GRAPH) $(__TFM_TYPE) $(realpath $(TFM_GRAPH_TEMPLATE_DIRPATH)) $(|_TFM_CREATE_GRAPH)

_tfm_delete_graph:
	@$(INFO) '$(TFM_UI_LABEL)Deleting graph "$(TFM_GRAPH_NAME)" ...'; $(NORMAL)
	$(_TFM_DELETE_GRAPH_|) rm $(TFM_GRAPH_FILEPATH)

_tfm_show_graph: _tfm_show_graph_content _tfm_show_graph_description

_tfm_show_graph_content:
	@$(INFO) '$(TFM_UI_LABEL)Showing content of graph "$(TFM_GRAPH_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation only show partial content'; $(NORMAL)
	$(_TFM_SHOW_GRAPH_CONTENT_|) cat $(TFM_GRAPH_FILEPATH) $(|_TFM_SHOW_GRAPH_CONTENT)

_tfm_show_graph_description:
	@$(INFO) '$(TFM_UI_LABEL)Showing description of graph "$(TFM_GRAPH_NAME)" ...'; $(NORMAL)
	$(_TFM_SHOW_GRAPH_DESCRIPTION_|) ls -l $(TFM_GRAPH_FILEPATH)

_tfm_view_graphs:
	@$(INFO) '$(TFM_UI_LABEL)Viewing graphs ...'; $(NORMAL)
	$(_TFM_VIEW_GRAPHS_|) ls $(TFM_GRAPHS_DIRPATH)*

_tfm_view_graphs_set:
	@$(INFO) '$(TFM_UI_LABEL)Viewing graphs-set "$(TFM_GRAPHS_SET_NAME)" ...'; $(NORMAL)
	$(_TFM_VIEW_GRAPHS_SET_|) ls $(TFM_GRAPHS_DIRPATH)$(TFM_GRAPHS_REGEX)

_tfm_visualize_graph:
	@$(INFO) '$(TFM_UI_LABEL)Visualizing graph "$(TFM_GRAPH_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Zoom in and out:      <arrow up> and <arrow down>"
	@$(WARN) "Move in pane:         Ctrl + <arrow direction>"
	@$(WARN) "Fast Move in pane:    Option + <arrow direction>"; $(NORMAL)
	dot -Tpng $(TFM_GRAPH_FILEPATH) | feh
