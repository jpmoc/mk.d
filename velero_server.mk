_VELERO_SERVER_MK_VERSION= $(_VELERO_MK_VERSION)

# VLO_SERVER_BACKUPLOCATION_CONFIG?= region=us-west-1
# VLO_SERVER_BUCKET_NAME?= emayssatat-velero
VLO_SERVER_CPU_LIMIT?= 1000m
VLO_SERVER_CPU_REQUEST?=500m 
VLO_SERVER_IMAGE?= gcr.io/heptio-images/velero:v1.1.0-beta.1
VLO_SERVER_INSTALL_WAIT?= false
VLO_SERVER_MEM_LIMIT?= 256Mi
VLO_SERVER_MEM_REQUEST?= 128Mi
# VLO_SERVER_NAMESPACE_NAME?= velero
# VLO_SERVER_PROVIDER?= aws
VLO_SERVER_RESTIC_ENABLE?= false
# VLO_SERVER_SECRET_FILEPATH?= ./credentials-velero
# VLO_SERVER_SNAPSHOTLOCATION_CONFIG?= region=us-west-1

# Derived parameters
VLO_SERVER_BUCKET_NAME?= $(S3I_BUCKET_NAME)
VLO_SERVER_NAMESPACE_NAME?= $(VLO_NAMESPACE_NAME)

# Option parameters
__VLO_BACKUP_LOCATION_CONFIG?= $(if $(VLO_SERVER_BACKUPLOCATION_CONFIG),--backup-location-config $(VLO_SERVER_BACKUPLOCATION_CONFIG))
__VLO_BUCKET?= $(if $(VLO_SERVER_BUCKET_NAME),--bucket $(VLO_SERVER_BUCKET_NAME))
__VLO_IMAGE?= $(if $(VLO_SERVER_IMAGE),--image $(VLO_SERVER_IMAGE)) 
__VLO_NAMESPACE__SERVER?= $(if $(VLO_SERVER_NAMESPACE_NAME),--namespace $(VLO_SERVER_NAMESPACE_NAME)) 
__VLO_PROVIDER?= $(if $(VLO_SERVER_PROVIDER),--provider $(VLO_SERVER_PROVIDER))
__VLO_SECRET_FILE?= $(if $(VLO_SERVER_SECRET_FILEPATH),--secret-file $(VLO_SERVER_SECRET_FILEPATH))
__VLO_SNAPSHOT_LOCATION_CONFIG?= $(if $(VLO_SERVER_SNAPSHOTLOCATION_CONFIG),--snapshot-location-config $(VLO_SERVER_SNAPSHOTLOCATION_CONFIG))
__VLO_USE_RESTIC?= $(if $(filter true, $(VLO_SERVER_RESTIC_ENABLE)),--use-restic)
__VLO_VELERO_POD_CPU_LIMIT?= $(if $(VLO_SERVER_CPU_LIMIT),--velero-pod-cpu-limit $(VLO_SERVER_CPU_LIMIT))
__VLO_VELERO_POD_CPU_REQUEST?= $(if $(VLO_SERVER_CPU_REQUEST),--velero-pod-cpu-request $(VLO_SERVER_CPU_REQUEST))
__VLO_VELERO_POD_MEM_LIMIT?= $(if $(VLO_SERVER_MEE_LIMIT),--velero-pod-mem-limit $(VLO_SERVER_MEM_LIMIT))
__VLO_VELERO_POD_MEM_REQUEST?= $(if $(VLO_SERVER_MEM_REQUEST),--velero-pod-mem-request $(VLO_SERVER_MEM_REQUEST))
__VLO_WAIT__SERVER?= $(if $(filter true, $(VLO_SERVER_INSTALL_WAIT)),--wait)

# UI parameters

#--- Utilities


#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_vlo_view_framework_macros ::
	@echo 'VeLerO::Server ($(_VELERO_SERVER_MK_VERSION)) macros:'
	@echo

_vlo_view_framework_parameters ::
	@echo 'VeLerO::Server($(_VELERO_SERVER_MK_VERSION)) parameters:'
	@echo '    VLO_SERVER_BACKUPLOCATION_CONFIG=$(VLO_SERVER_BACKUPLOCATION_CONFIG)'
	@echo '    VLO_SERVER_BUCKET_NAME=$(VLO_SERVER_BUCKET_NAME)'
	@echo '    VLO_SERVER_CPU_LIMIT=$(VLO_SERVER_CPU_LIMIT)'
	@echo '    VLO_SERVER_CPU_REQUEST=$(VLO_SERVER_CPU_REQUEST)'
	@echo '    VLO_SERVER_IMAGE=$(VLO_SERVER_IMAGE)'
	@echo '    VLO_SERVER_INSTALL_WAIT=$(VLO_SERVER_INSTALL_WAIT)'
	@echo '    VLO_SERVER_MEM_LIMIT=$(VLO_SERVER_MEM_LIMIT)'
	@echo '    VLO_SERVER_MEM_REQUEST=$(VLO_SERVER_MEM_REQUEST)'
	@echo '    VLO_SERVER_NAMESPACE_NAME=$(VLO_SERVER_NAMESPACE_NAME)'
	@echo '    VLO_SERVER_PROVIDER=$(VLO_SERVER_PROVIDER)'
	@echo '    VLO_SERVER_RESTIC_ENABLE=$(VLO_SERVER_RESTIC_ENABLE)'
	@echo '    VLO_SERVER_SECRET_FILEPATH=$(VLO_SERVER_SECRET_FILEPATH)'
	@echo '    VLO_SERVER_SNAPSHOTLOCATION_CONFIG=$(VLO_SERVER_SNAPSHOTLOCATION_CONFIG)'
	@echo

_vlo_view_framework_targets ::
	@echo 'VeLerO::Server($(_VELERO_SERVER_MK_VERSION)) targets:'
	@echo '    _vlo_install_server          - Install server' 
	@echo '    _vlo_show_server             - Show everything related to a server' 
	@echo '    _vlo_show_server_manifest    - Show the manifest of a server' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
#

_vlo_install_server:
	@$(INFO) '$(VLO_UI_LABEL)Installing server ...'; $(NORMAL)
	$(VELERO) install $(strip $(__VLO_BACKUP_LOCATION_CONFIG) $(__VLO_BUCKET) $(__VLO_IMAGE) $(__VLO_NAMESPACE__SERVER) $(__VLO_PROVIDER) $(__VLO_SECRET_FILE) $(__VLO_SNAPSHOT_LOCATION_CONFIG) $(__VLO_USER_RESTIC) $(__VLO_VELERO_POD_CPU_LIMIT) $(__VLO_VELERO_POD_CPU_REQUEST) $(__VLO_VELERO_POD_MEM_LIMIT) $(__VLO_VELERO_POD_MEM_REQUEST) $(__VLO_WAIT__SERVER))

_vlo_show_server: _vlo_show_server_manifest

_vlo_show_server_manifest:
	@$(INFO) '$(VLO_UI_LABEL)Showing manifest of server ...'; $(NORMAL)
	$(VELERO) install $(strip $(__VLO_BACKUP_LOCATION_CONFIG) $(__VLO_BUCKET) $(__VLO_IMAGE) $(__VLO_NAMESPACE__SERVER) $(__VLO_PROVIDER) $(__VLO_SECRET_FILE) $(__VLO_SNAPSHOT_LOCATION_CONFIG) $(__VLO_USER_RESTIC) $(__VLO_VELERO_POD_CPU_LIMIT) $(__VLO_VELERO_POD_CPU_REQUEST) $(__VLO_VELERO_POD_MEM_LIMIT) $(__VLO_VELERO_POD_MEM_REQUEST) $(_X__VLO_WAIT__SERVER)) --dry-run --output yaml

_vlo_uninstall_server:
	@$(INFO) '$(VLO_UI_LABEL)Uninstalling server ...'; $(NORMAL)
	-$(KUBECTL) delete namespace $(VLO_SERVER_NAMESPACE_NAME)
	-$(KUBECTL) delete customresourcedefinitions --selector component=velero
