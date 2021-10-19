_AWS_LAMBDA_LAYERVERSION_MK_VERSION= $(_AWS_LAMBDA_MK_VERSION)

# LBA_LAYERVERSION_ARN?= arn:aws:lambda:us-east-2:123456789012:layer:my-layer:2
# LBA_LAYERVERSION_COMPATIBLE_RUNTIMES?= python2.7 python3.6 python3.7
# LBA_LAYERVERSION_CONTENT?= S3Bucket=lambda-layers-us-east-2-123456789012,S3Key=layer.zip
# LBA_LAYERVERSION_DESCRIPTION?= 'My desciption'
# LBA_LAYERVERSION_LAYER_NAME?= EventSourceMappings
# LBA_LAYERVERSION_LICENSE_INFO?= MIT
# LBA_LAYERVERSION_NUMVER?= 2
# LBA_LAYERVERSION_ZIP_FILEPATH?= ./content.zip
# LBA_LAYERVERSIONS_SET_NAME?= my-event-source-mapping-set

# Derived parameters
LBA_LAYERVERSION_LAYER_NAME?= $(LBA_LAYER_NAME)

# Option parameters
__LBA_ACTION__LAYERVERSION=
__LBA_COMPATIBLE_RUNTIMES= $(if $(LBA_LAYERVERSION_COMAPTIBLE_RUNTIMES),--compatible-runtimes $(LBA_LAYERVERSION_COMPATIBLE_RUNTIMES))
__LBA_CONTENT= $(if $(LBA_LAYERVERSION_CONTENT),--content $(LBA_LAYERVERSION_CONTENT))
__LBA_DESCRIPTION_LAYERVERSION= $(if $(LBA_LAYERVERSION_DESCRIPTION), --description $(LBA_LAYERVERSION_DESCRIPTION))
__LBA_LAYER_NAME__LAYERVERSION= $(if $(LBA_LAYERVERSION_LAYER_NAME), --layer-name $(LBA_LAYERVERSION_LAYER_NAME))
__LBA_LICENSE_INFO= $(if $(LBA_LAYERVERSION_LICENSE_INFO), --license-info $(LBA_LAYERVERSION_LICENSE_INFO))
__LBA_ORGANIZATION_ID=
__LBA_REVISION_ID=
__LBA_STATEMENT_ID__LAYERVERSION=
__LBA_VERSION_NUMBER= $(if $(LBA_LAYERVERSION_VERSION_NUMBER),--version-number $(LBA_LAYERVERSION_VERSION_NUMBER))
__LBA_ZIP_FILE__LAYERVERSION= $(if $(LBA_LAYERVERSION_ZIP_FILEPATH),--zip-file fileb://$(LBA_LAYERVERSION_ZIP_FILEPATH))

# UI parameters
LBA_UI_SHOW_LAYERVERSION_FIELDS?=
LBA_UI_VIEW_LAYERVERSIONS_FIELDS?=
LBA_UI_VIEW_LAYERVERSIONS_SET_FIELDS?= $(LBA_UI_VIEW_LAYERVERSIONS_FIELDS)
LBA_UI_VIEW_LAYERVERSIONS_SET_QUERY_FILTER?=

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_lba_view_framework_macros ::
	@echo 'AWS::LamBdA::LayerVersion ($(_AWS_LAMBDA_LAYERVERSION_MK_VERSION)) macros:'
	@echo

_lba_view_framework_parameters ::
	@echo 'AWS::LamBdA::LayerVersion ($(_AWS_LAMBDA_LAYERVERSION_MK_VERSION)) parameters:'
	@echo '    LBA_LAYERVERSION_ARN=$(LBA_LAYERVERSION_ARN)'
	@echo '    LBA_LAYERVERSION_COMPATIBLE_RUNTIMES=$(LBA_LAYERVERSION_COMPATIBLE_RUNTIMES)'
	@echo '    LBA_LAYERVERSION_DESCRIPTION=$(LBA_LAYERVERSION_DESCRIPTION)'
	@echo '    LBA_LAYERVERSION_LAYER_NAME=$(LBA_LAYERVERSION_LAYER_NAME)'
	@echo '    LBA_LAYERVERSION_LICENSE_INFO=$(LBA_LAYERVERSION_LICENSE_INFO)'
	@echo '    LBA_LAYERVERSION_NUMBER=$(LBA_LAYERVERSION_NUMBER)'
	@echo '    LBA_LAYERVERSION_ZIP_FILEPATH=$(LBA_LAYERVERSION_ZIP_FILEPATH)'
	@echo '    LBA_LAYERVERSIONS_SET_NAME=$(LBA_LAYERVERSIONS_SET_NAME)'
	@echo

_lba_view_framework_targets ::
	@echo 'AWS::LamBdA::LayerVersion ($(_AWS_LAMBDA_LAYERVERSION_MK_VERSION)) targets:'
	@echo '    _lba_create_layerversion                  - Create a new layer-version'
	@echo '    _lba_delete_layerversion                  - Delete an existing layer-version'
	@echo '    _lba_permit_layerversion                  - Give permission to a layer-version'
	@echo '    _lba_show_layerversion                    - Show everything related to a layer-version'
	@echo '    _lba_show_layerversion_description        - Show description of a layer-version'
	@echo '    _lba_show_layerversion_policy             - Show policy of a layer-version'
	@echo '    _lba_view_layerversions                   - View existing layer-versions'
	@echo '    _lba_view_layerversions_set               - View a set of layer-versions' 
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_lba_create_layerversion:
	@$(INFO) '$(AWS_UI_LABEL)Creating version "$(LBA_LAYERVERSION_NUMBER)" of layer "$(LBA_LAYERVERSION_LAYER_NAME)" ...'; $(NORMAL)
	$(AWS) lambda publish-layer $(strip $(__LBA_CONTENT) $(__LBA_COMPATIBLE_RUNTIMES) $(__LBA_CONTENT) $(__LBA_DESCRIPTION__LAYERVERSION) $(__LBA_LAYER_NAME__LAYERVERSION) $(__LBA_LICENSE_INFO) $(__LBA_ZIP_FILE__LAYERVERSION) )

_lba_delete_layerversion:
	@$(INFO) '$(AWS_UI_LABEL)Deleting version "$(LBA_LAYERVERSION_NUMBER)" of layer "$(LBA_LAYERVERSION_LAYER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'When you delete a layer version, you can no longer configure functions to use it.'
	@$(WARN) 'However, any function that already uses the version continues to have access to it.'; $(NORMAL)
	$(AWS) lambda delete-layer-version $(__LBA_LAYER_NAME__LAYERVERSION) $(__LBA_VERSION_NUMBER)

_lba_permit_layerversion:
	@$(INFO) '$(AWS_UI_LABEL)Giving permissions to version "$(LBA_LAYERVERSION_NUMBER)" of layer "$(LBA_LAYERVERSION_LAYER_NAME)" ...'; $(NORMAL)
	$(AWS) lambda add-layer-version-permission $(__LBA_ACTION__LAYERVERSION) $(__LBA_LAYER_NAME__LAYERVERSION) $(__LBA_ORGANIZATION_ID) $(__LBA_STATEMENT_ID__LAYERVERSION) $(__LBA_VERSION_NUMBER)

_lba_show_layerversion: _lba_show_layerversion_policy _lba_show_layerversion_description

_lba_show_layerversion_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing version "$(LBA_LAYERVERSION_VERSION_NUMBER)" of layer "$(LBA_LAYERVERSION_LAYER_NAME)" ...'; $(NORMAL)
	$(AWS) lambda get-layer-version $(__LBA_LAYERVERSION_NAME) $(__LBA_VERSION_NUMBER)

_lba_show_layerversion_policy:
	@$(INFO) '$(AWS_UI_LABEL)Showing policy for version "$(LBA_LAYERVERSION_VERSION_NUMBER)" of layer "$(LBA_LAYERVERSION_LAYER_NAME)" ...'; $(NORMAL)
	$(AWS) lambda get-layer-version-policy $(__LBA_LAYER_NAME__LAYERVERSION) $(__LBA_VERSION_NUMBER)

_lba_unpermit_layerversion:
	@$(INFO) '$(AWS_UI_LABEL)Removing permissions from version "$(LBA_LAYERVERSION_NUMBER)" of layer "$(LBA_LAYERVERSION_LAYER_NAME)" ...'; $(NORMAL)
	$(AWS) lambda remove-layer-version-permission $(__LBA_LAYER_NAME__LAYERVERSION) $(__LBA_REVISION_ID) $(__LBA_STATEMENT_ID__LAYERVERSION) $(__LBA_VERSION_NUMBER)

_lba_view_layerversions:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all versions of layer "$(LBA_LAYERVERSION_LAYER_NAME)"  ...'; $(NORMAL)
	$(AWS) lambda list-layer-versions $(_X__LBA_COMPATIBLE_RUNTIME) $(__LBA_LAYER_NAME__LAYERVERSION) # --query 'EventSourceMappings[]$(LBA_UI_VIEW_LAYERS_FIELDS)'

_lba_view_layerversions_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing layer-versions-set "$(LBA_LAYERVERSIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Layer-versions are grouped based on layer, compatible-runtime, query filter, ...'; $(NORMAL)
	$(AWS) lambda list-layer-versions $(__LBA_COMPATIBLE_RUNTIME) $(__LBA_LAYER_NAME__LAYERVERSION) # --query 'EventSourceMappings[$(LBA_UI_VIEW_LAYERVERSIONS_SET_QUERY_FILTER)]$(LBA_UI_VIEW_LAYERVERSIONS_SET_FIELDS)'
