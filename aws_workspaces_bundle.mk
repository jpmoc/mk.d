_AWS_WORKSPACES_BUNDLE_MK_VERSION= $(_AWS_WORKSPACES_MK_VERSION)

# WSS_BUNDLE_ID?= 
# WSS_BUNDLE_IDS?= 
# WSS_BUNDLE_NAME?= 
# WSS_BUNDLE_OWNER?= Amazon
# WSS_BUNDLES_SET_NAME?= my-bundles-set

# Derived parameters
WSS_BUNDLE_IDS?= $(WSS_BUNDLE_ID)
WSS_BUNDLE_OWNER?= $(AWS_ACCOUNT_ID)

# Option parameters
__WSS_BUNDLE_IDS= $(if $(WSS_BUNDLE_IDS), --bundle-ids $(WSS_BUNDLE_IDS))
__WSS_OWNER= $(if $(WSS_BUNDLE_OWNER), --owner $(WSS_BUNDLE_OWNER))

# UI parameters
WSS_UI_VIEW_BUNDLES_FIELDS?= .{BundleId:BundleId,Name:Name,owner:Owner,computeType:ComputeType.Name}
WSS_UI_VIEW_BUNDLES_SET_FIELDS?= $(WSS_UI_VIEW_BUNDLES_FIELDS)
WSS_UI_VIEW_BUNDLES_SET_SLICE?=

#--- Utilities

#--- MACROS
WSS_BUNDLE_NAME__GET?= $(shell echo $(WSS_BUNDLE_NAME))
_wss_get_bundle_id= $(call _wss_get_bundle_id_N, $(WSS_BUNDLE_NAME__GET))
_wss_get_bundle_id_N= $(call _wss_get_bundle_id_NO, $(1), $(WSS_BUNDLE_OWNER))
_wss_get_bundle_id_NO= $(shell $(AWS) workspaces describe-workspace-bundles --owner $(2) --query "Bundles[?Name=='$(strip $(1))'].BundleId" --output text)

WSS_GET_BUNDLE_IDS_SLICE?=
_wss_get_bundle_ids= $(call _wss_get_bundle_ids_S, $(WSS_GET_BUNDLE_IDS_SLICE))
_wss_get_bundle_ids_S= $(call _wss_get_bundle_ids_SO, $(1), $(WSS_BUNDLE_OWNER))
_wss_get_bundle_ids_SO= $(shell $(AWS) workspaces describe-workspace-bundles --owner $(2) --query "Bundles[$(strip $(1))].BundleId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_wss_view_framework_macros ::
	@echo 'AWS::WorkSpaceS::Bundle ($(_AWS_WORKSPACES_BUNDLE_MK_VERSION)) macros:'
	@echo '    _wss_get_bundle_id_{|N|NO}       - Get the ID of a bundle (Name,Owner)'
	@echo '    _wss_get_bundle_ids_{|S|SO}      - Get the IDs of bundles (Slice,Owner)'
	@echo

_wss_view_framework_parameters ::
	@echo 'AWS::WorkSpaceS::Bundle ($(_AWS_WORKSPACES_BUNDLE_MK_VERSION)) parameters:'
	@echo '    WSS_BUNDLE_ID?=$(WSS_BUNDLE_ID)'
	@echo '    WSS_BUNDLE_IDS?=$(WSS_BUNDLE_IDS)'
	@echo '    WSS_BUNDLE_NAME?=$(WSS_BUNDLE_NAME)'
	@echo '    WSS_BUNDLE_NAME__GET?=$(WSS_BUNDLE_NAME__GET)'
	@echo '    WSS_BUNDLE_OWNER?=$(WSS_BUNDLE_OWNER)'
	@echo

_wss_view_framework_targets ::
	@echo 'AWS::WorkSpaceS::Bundle ($(_AWS_WORKSPACES_BUNDLE_MK_VERSION)) targets:'
	@echo '    _wss_show_bundle                 - Show everything related to a bundle'
	@echo '    _wss_view_bundles                - View available bundles'
	@echo '    _wss_view_bundles_aws            - View available bundles provided by AWS'
	@echo '    _wss_view_bundles_owner          - View available bundles provided by AWS account ID'
	@echo '    _wss_view_bundles_set            - View a set of bundles'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_wss_show_bundle:
	@$(INFO) '$(AWS_UI_LABEL)Showing bundle "$(WSS_BUNDLE_NAME)" ...'; $(NORMAL)
	$(AWS) workspaces describe-workspace-bundles $(__WSS_BUNDLE_IDS) $(_X__WSS_OWNER)

_wss_view_bundles: _wss_view_bundles_aws _wss_view_bundles_owner
_wss_view_bundles_aws:
	@$(INFO) '$(AWS_UI_LABEL)Viewing AWS-bundles ...'; $(NORMAL)
	$(AWS) workspaces describe-workspace-bundles $(_X__WSS_BUNDLE_IDS) $(_X__WSS_OWNER) --owner AMAZON --query "Bundles[]$(WSS_UI_VIEW_BUNDLES_FIELDS)"

_wss_view_bundles_owner:
	@$(INFO) '$(AWS_UI_LABEL)Viewing owner-bundles ...'; $(NORMAL)
	$(AWS) workspaces describe-workspace-bundles $(_X__WSS_BUNDLE_IDS) $(__WSS_OWNER) --query "Bundles[]$(WSS_UI_VIEW_BUNDLES_FIELDS)"

_wss_view_bundles_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing bundles-set "$(WSS_BUNDLES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Bundles are grouped based on the provided IDs, owner, and/or slice'; $(NORMAL)
	$(AWS) workspaces describe-workspace-bundles $(__WSS_BUNDLE_IDS) $(__WSS_OWNER) --query "Bundles[$(WSS_UI_VIEW_BUNDLES_SET_SLICE)]$(WSS_UI_VIEW_BUNDLES_SET_FIELDS)"
