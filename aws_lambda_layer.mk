_AWS_LAMBDA_LAYER_MK_VERSION= $(_AWS_LAMBDA_MK_VERSION)

# LBA_LAYER_COMPATIBLE_RUNTIME?= python2.7
# LBA_LAYER_NAME?= layer-name
# LBA_LAYERS_SET_NAME?= my-event-source-mapping-set

# Derived parameters
LBA_LAYER_COMPATIBLE_RUNTIME?= $(LBA_FUNCTION_RUNTIME)
LBA_LAYER_FUNCTION_NAME?= $(LBA_FUNCTION_NAME)

# Option parameters
__LBA_COMPATIBLE_RUNTIME= $(if $(LBA_LAYER_COMPATIBLE_RUNTIME),--compatible-runtime $(LBA_LAYER_COMPATIBLE_RUNTIME))
__LBA_LAYER_NAME= $(if $(LBA_LAYER_NAME), --layer-name $(LBA_LAYER_NAME))

# UI parameters
LBA_UI_SHOW_LAYER_FIELDS?=
LBA_UI_VIEW_LAYERS_FIELDS?=
LBA_UI_VIEW_LAYERS_SET_FIELDS?= $(LBA_UI_VIEW_LAYERS_FIELDS)
LBA_UI_VIEW_LAYERS_SET_QUERY_FILTER?=

#--- Utilities

#--- Macros
_lba_get_layer_version=

#----------------------------------------------------------------------
# USAGE
#

_lba_view_framework_macros ::
	@echo 'AWS::LamBdA::Layer ($(_AWS_LAMBDA_LAYER_MK_VERSION)) macros:'
	@echo

_lba_view_framework_parameters ::
	@echo 'AWS::LamBdA::Layer ($(_AWS_LAMBDA_LAYER_MK_VERSION)) parameters:'
	@echo '    LBA_LAYER_COMPATIBLE_RUNTIME=$(LBA_LAYER_COMPATIBLE_RUNTIME)'
	@echo '    LBA_LAYER_NAME=$(LBA_LAYER_NAME)'
	@echo '    LBA_LAYERS_SET_NAME=$(LBA_LAYERS_SET_NAME)'
	@echo

_lba_view_framework_targets ::
	@echo 'AWS::LamBdA::Layer ($(_AWS_LAMBDA_LAYER_MK_VERSION)) targets:'
	@echo '    _lba_create_layer                  - Create a new layer'
	@echo '    _lba_delete_layer                  - Delete an existing layer'
	@echo '    _lba_show_layer                    - Show everything related to a layer'
	@echo '    _lba_show_layer_versions           - Show all versions for a layer'
	@echo '    _lba_view_layers                   - View existing layers'
	@echo '    _lba_view_layers_set               - View a set of layers' 
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_lba_create_layer:
	@$(INFO) '$(AWS_UI_LABEL)Creating a new layer "$(LBA_LAYER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is deprecated, instead create a new layer-verstion'; $(NORMAL)

_lba_delete_layer:
	@$(INFO) '$(AWS_UI_LABEL)Deleting an existing layer "$(LBA_LAYER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is deprecated, instead delete all related layer-versions'; $(NORMAL)

_lba_show_layer: _lba_show_layer_versions

_lba_show_layer_versions:
	@$(INFO) '$(AWS_UI_LABEL)Showing all available versions for layer "$(LBA_LAYER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'All versions should be assumed to be in use at the same time'; $(NORMAL)
	$(AWS) lambda list-layer-versions $(__LBA_COMPATIBLE_RUNTIME) $(__LBA_LAYER_NAME)

_lba_view_layers:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all layers ...'; $(NORMAL)
	$(AWS) lambda list-layers # --query 'EventSourceMappings[]$(LBA_UI_VIEW_LAYERS_FIELDS)'

_lba_view_layers_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing layers-set "$(LBA_LAYERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Layers are grouped based on query filter, ...'; $(NORMAL)
	$(AWS) lambda list-layers # --query 'EventSourceMappings[$(LBA_UI_VIEW_LAYERS_SET_QUERY_FILTER)]$(LBA_UI_VIEW_LAYERS_SET_FIELDS)'
