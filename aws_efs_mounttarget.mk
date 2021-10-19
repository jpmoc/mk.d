_AWS_EFS_MOUNTTARGET_MK_VERSION=$(_AWS_EFS_MK_VERSION)

# EFS_MOUNTTARGET_ID?= fsmt-d43cfcad
# EFS_MOUNTTARGET_IP_ADDRESS?=
# EFS_MOUNTTARGET_SECURITYGROUP_IDS?= sg-4b8f7f22
# EFS_MOUNTTARGET_SUBNET_ID?=

# Derived parameters

# Options parameters
__EFS_IP_ADDRESS=
__EFS_MOUNT_TARGET_ID= $(if $(EFS_MOUNTTARGET_ID), --mount-target-id $(EFS_MOUNTTARGET_ID))
__EFS_SECURITY_GROUPS= $(if $(EFS_MOUNTTARGET_SECURITYGROUP_IDS), --security-groups $(EFS_MOUNTTARGET_SECURITYGROUP_IDS))
__EFS_SUBNET_ID= $(if $(EFS_MOUNTTARGET_SUBNET_ID), --subnet-id $(EFS_MOUNTTARGET_SUBNET_ID))

# UI parameters
EFS_UI_SHOW_MOUNTATARGET_OVERVIEW_FIELDS?=
EFS_UI_VIEW_MOUNTTARGETS_SET_FIELDS?=

#--- Utilities

#--- MACROS
_efs_get_mounttarget_id= $(call _efs_get_mounttarget_id_F, $(EFS_FILESYSTEM_ID))
_efs_get_mounttarget_id_F= $(shell $(AWS) efs describe-mount-targets --file-system-id $(1)  --query "MountTargets[].MountTargetId" --output text)

_efs_get_mounttarget_securitygroup_ids= $(call _efs_get_mounttarget_securitygroup_ids_I, $(EFS_MOUNTTARGET_ID))
_efs_get_mounttarget_securitygroup_ids_I= $(shell $(AWS) efs describe-mount-target-security-groups  --mount-target-id $(1) --query "SecurityGroups[]" --output text)

#----------------------------------------------------------------------
# USAGE
#

_efs_view_framework_macros ::
	@echo 'AWS::EFS::MountTarget ($(_AWS_EFS_MOUNTTARGET_MK_VERSION)) macros:'
	@echo '    _efs_get_mounttarget_id_{|F}                   - Get the ID of a mount target'
	@echo '    _efs_get_mounttarget_securitygroup_ids_{|I}    - Get the IDs of the security-groups attached to a mount target'
	@echo

_efs_view_framework_parameters ::
	@echo 'AWS::EFS::MountTarget ($(_AWS_EFS_MOUNTTARGET_MK_VERSION)) parameters:'
	@echo '    EFS_MOUNTTARGET_ID=$(EFS_MOUNTTARGET_ID)'
	@echo '    EFS_MOUNTTARGET_IP_ADDRESS=$(EFS_MOUNTTARGET_IP_ADDRESS)'
	@echo '    EFS_MOUNTTARGET_SECURITYGROUP_IDS=$(EFS_MOUNTTARGET_SECURITYGROUP_IDS)'
	@echo '    EFS_MOUNTTARGET_SUBNET_ID=$(EFS_MOUNTTARGET_SUBNET_ID)'
	@echo

_efs_view_framework_targets ::
	@echo 'AWS::EFS::MountTarget ($(_AWS_EFS_MOUNTTARGET_MK_VERSION)) targets:'
	@echo '    _efs_create_mounttargets                       - Create mount-targets'
	@echo '    _efs_delete_mounttargets                       - Delete mount-targets'
	@echo '    _efs_show_mounttarget                          - Show everything related to a mount-target'
	@echo '    _efs_show_mounttarget_description              - Show description of a mount-target'
	@echo '    _efs_show_mounttarget_securitygroup            - Show security-group of a mount-target'
	@echo '    _efs_view_mounttargets                         - View mount-targets'
	@echo '    _efs_view_mounttargets_set                     - View a set of mount-targets'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_efs_create_mounttarget:
	@$(INFO) '$(AWS_UI_LABEL)Creating a mount-target ...'; $(NORMAL)
	@$(WARN) 'If no security-groups are provided, the VPC default security-group will apply'; $(NORMAL)
	$(AWS) efs create-mount-target $(__EFS_FILE_SYSTEM_ID) $(__EFS_IP_ADDRESS) $(__EFS_SECURITY_GROUPS) $(__EFS_SUBNET_ID)

_efs_delete_mounttarget:
	@$(INFO) '$(AWS_UI_LABEL)Deleting a mount-target ...'; $(NORMAL)
	$(AWS) efs delete-mount-target $(__EFS_MOUNT_TARGET_ID)

_efs_show_mounttarget: _efs_show_mounttarget_securitygroups _efs_show_mounttarget_description

_efs_show_mounttarget_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing overview of mount-target "$(EFS_MOUNTTARGET_ID)" ...'; $(NORMAL)
	$(AWS) efs describe-mount-targets $(_X__EFS_FILE_SYSTEM_ID) $(__EFS_MOUNT_TARGET_ID) --query "MountTargets[]$(EFS_UI_SHOW_MOUNTTARGET_OVERVIEW_FIELDS)"

_efs_show_mounttarget_securitygroups:
	@$(INFO) '$(AWS_UI_LABEL)Showing security-groups of mount-target "$(EFS_MOUNTTARGET_ID)" ...'; $(NORMAL)
	@$(WARN) 'If no security-group were provided at the mount-target creation time, the VPC default security-group applies'; $(NORMAL)
	$(AWS) efs describe-mount-target-security-groups $(__EFS_MOUNT_TARGET_ID) --query "SecurityGroups[]"

_efs_view_mounttargets: _efs_view_mounttargets_set
	@$(INFO) '$(AWS_UI_LABEL)Viewing existing mount-targets ...'; $(NORMAL)
	@$(ERROR) 'Mount targets can only be viewed in sets'; $(NORMAL)

_efs_view_mounttargets_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing mount-target set for file-system ...'; $(NORMAL)
	@$(WARN) 'Mount-targets are grouped in sets based on their corresponding filesystems'; $(NORMAL)
	$(AWS) efs describe-mount-targets $(__EFS_FILE_SYSTEM_ID) $(_X__EFS_MOUNT_TARGET_ID) --query "MountTargets[]$(EFS_UI_VIEW_MOUNTTARGETS_SET_FIELDS)"
