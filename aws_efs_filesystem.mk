_AWS_EFS_FILESYSTEM_MK_VERSION=$(_AWS_EFS_MK_VERSION)

# EFS_FILESYSTEM_CREATION_TOKEN?=
EFS_FILESYSTEM_ENCRYPTED?= false
# EFS_FILESYSTEM_ID?=
# EFS_FILESYSTEM_KMSKEY_ID?= /aws/elasticfilesystem #default ?
# EFS_FILESYSTEM_NAME?= my-filesystem-name
# EFS_FILESYSTEM_OWNER_ID?= 123456789012
EFS_FILESYSTEM_PERFORMANCE_MODE?= generalPurpose
# EFS_FILESYSTEM_TAGS?= Key=string,Value=string ...
# EFS_FILESYSTEM_TAGS_KEYS?= string ...
# EFS_FILESYSTEMS_SET_NAME?= my-file-systems-sets

# Derived parameters
EFS_FILESYSTEM_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)
EFS_FILESYSTEM_DNSNAME?= $(if $(EFS_FILESYSTEM_ID), $(EFS_FILESYSTEM_ID).efs.$(AWS_REGION).amazonaws.com)
EFS_FILESYSTEM_NAME?= $(EFS_FILESYSTEM_CREATION_TOKEN)
EFS_FILESYSTEM_TAGS+= $(if $(EFS_FILESYSTEM_NAME), Key=Name$(COMMA)Value=$(EFS_FILESYSTEM_NAME))

# Options parameters
__EFS_CREATION_TOKEN= $(if $(EFS_FILESYSTEM_CREATION_TOKEN), --creation-token  $(EFS_FILESYSTEM_CREATION_TOKEN))
__EFS_FILE_SYSTEM_ID= $(if $(EFS_FILESYSTEM_ID), --file-system-id $(EFS_FILESYSTEM_ID))
__EFS_ENCRYPTED= $(if $(filter true, $(EFS_FILESYSTEM_ENCRYPTED)), --encrypted, --no-encrypted)
__EFS_KMS_KEY_ID= $(if $(EFS_FILESYSTEM_KMSKEY_ID), --kms-key-id $(EFS_FILESYSTEM_KMSKEY_ID))
__EFS_PERFORMANCE_MODE= $(if $(EFS_FILESYSTEM_PERFORMANCE_MODE), --performance-mode $(EFS_FILESYSTEM_PERFORMANCE_MODE))
__EFS_TAG_KEYS= $(if $(EFS_FILESYSTEM_TAGS_KEYS), --tag-keys $(EFS_FILESYSTEM_TAGS_KEYS))
__EFS_TAGS_FILESYSTEM= $(if $(EFS_FILESYSTEM_TAGS), --tags $(EFS_FILESYSTEM_TAGS))

# UI parameters
EFS_UI_VIEW_FILESYSTEMS_FIELDS?= .{CreationToken:CreationToken,FileSystemId:FileSystemId,encrypted:Encrypted,lifeCycleState:LifeCycleState,performanceMode:PerformanceMode,numberOfMountTargets:NumberOfMountTargets,ownerID:OwnerId}

#--- Utilities

#--- MACROS
_efs_get_filesystem_dnsname= $(call _efs_get_filesystem_dnsname_I, $(EFS_FILESYSTEM_ID))
_efs_get_filesystem_dnsname_I= $(shell echo $(strip $(1)).efs.$(AWS_REGION).amazonaws.com)

_efs_get_filesystem_id= $(call _efs_get_filesystem_id_T, $(EFS_FILESYSTEM_CREATION_TOKEN))
_efs_get_filesystem_id_T= $(call _efs_get_filesystem_id_TO, $(1), $(EFS_FILESYSTEM_OWNER_ID))
_efs_get_filesystem_id_TO= $(shell $(AWS) efs describe-file-systems   --query "FileSystems[?CreationToken=='$(strip $(1))'].FileSystemId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_efs_view_framework_macros ::
	@echo 'AWS::EFS::FileSystem ($(_AWS_EFS_FILESYSTEM_MK_VERSION)) macros:'
	@echo '    _efs_get_filesystem_dns_name_{|I}     - Get the DNS-name of NFSv4 filesystem/server (Id)'
	@echo '    _efs_get_filesystem_id_{|T|TO}        - Get the ID of a filesystem (Token,Owner)'
	@echo

_efs_view_framework_parameters ::
	@echo 'AWS::EFS::FileSystem ($(_AWS_EFS_FILESYSTEM_MK_VERSION)) parameters:'
	@echo '    EFS_FILESYSTEM_CREATION_TOKEN=$(EFS_FILESYSTEM_CREATION_TOKEN)'
	@echo '    EFS_FILESYSTEM_DNSNAME=$(EFS_FILESYSTEM_DNSNAME)'
	@echo '    EFS_FILESYSTEM_ENCRYPTED=$(EFS_FILESYSTEM_ENCRYPTED)'
	@echo '    EFS_FILESYSTEM_ID=$(EFS_FILESYSTEM_ID)'
	@echo '    EFS_FILESYSTEM_KMSKEY_ID=$(EFS_FILESYSTEM_KMSKEY_ID)'
	@echo '    EFS_FILESYSTEM_NAME=$(EFS_FILESYSTEM_NAME)'
	@echo '    EFS_FILESYSTEM_OWNER_ID=$(EFS_FILESYSTEM_OWNER_ID)'
	@echo '    EFS_FILESYSTEM_PERFORMANCE_MODE=$(EFS_FILESYSTEM_PERFORMANCE_MODE)'
	@echo '    EFS_FILESYSTEM_TAGS=$(EFS_FILESYSTEM_TAGS)'
	@echo '    EFS_FILESYSTEM_TAGS_KEYS=$(EFS_FILESYSTEM_TAGS_KEYS)'
	@echo '    EFS_FILESYSTEMS_SET_NAME=$(EFS_FILESYSTEMS_SET_NAME)'
	@echo

_efs_view_framework_targets ::
	@echo 'AWS::EFS::FileSystem ($(_AWS_EFS_FILESYSTEM_MK_VERSION)) targets:'
	@echo '    _efs_create_filesystems               - Create a file-system'
	@echo '    _efs_delete_filesystems               - Delete a file-system'
	@echo '    _efs_show_filesystems                 - Show details of a file-system'
	@echo '    _efs_show_filesystems_description     - Show overview of a file-system'
	@echo '    _efs_show_filesystems_dnsname         - Show DNS-name to access a file-system'
	@echo '    _efs_show_filesystems_mounttargets    - Show mount-targets of a file-system'
	@echo '    _efs_show_filesystems_tags            - Show tags of a file-system'
	@echo '    _efs_view_filesystems                 - View file-systems'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_efs_create_filesystem:
	@$(INFO) '$(AWS_UI_LABEL)Creating file-system "$(EFS_FILESYSTEM_NAME)" ...'; $(NORMAL)
	$(AWS) efs create-file-system $(__EFS_CREATION_TOKEN) $(__EFS_ENCRYPTED) $(__EFS_KMS_KEY_ID) $(__EFS_PERFORMANCE_MODE)

_efs_delete_filesystem:
	@$(INFO) '$(AWS_UI_LABEL)Delete file-system "$(EFS_FILESYSTEM_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation will fail if the file-system has any mount-point'; $(NORMAL)
	@$(WARN) 'If one or more mount-points were just deleted, it may take a 20 sec for the deletion to complete!'; $(NORMAL)
	$(AWS) efs delete-file-system $(__EFS_FILE_SYSTEM_ID)

_efs_show_filesystem: _efs_show_filesystem_dnsname _efs_show_filesystem_mounttargets _efs_show_filesystem_tags _efs_show_filesystem_description

_efs_show_filesystem_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of file-system "$(EFS_FILESYSTEM_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT show the filesystem tags'; $(NORMAL)
	$(AWS) efs describe-file-systems $(_X__EFS_CREATION_TOKEN) $(__EFS_FILE_SYSTEM_ID)

_efs_show_filesystem_dnsname:
	@$(INFO) '$(AWS_UI_LABEL)Showing DNS-name to access file-system "$(EFS_FILESYSTEM_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The file-system DNS-name will resolve to the subnet-specific mount-target ip address'; $(NORMAL)
	@echo 'To mount the filesystem in an instance, as root execute:'
	@echo '  apt-get install nfs.common'
	@echo '  mkdir /efs'
	@echo '  mount -t nfs $(EFS_FILESYSTEM_DNSNAME):/ /efs'
	@echo '  df -t nfs4 -h'
	@echo 'or'
	@echo '  cat >>/etc/fsab <<EOT'
	@echo '  $(EFS_FILESYSTEM_DNSNAME):/ /efs nfs defaults   0 0'
	@echo '  EOT'

_efs_show_filesystem_mounttargets: _efs_view_mounttargets_set

_efs_show_filesystem_tags:
	@$(INFO) '$(AWS_UI_LABEL)Showing tags of file-system "$(EFS_FILESYSTEM_NAME)" ...'; $(NORMAL)
	$(AWS) efs describe-tags $(__EFS_FILE_SYSTEM_ID)

_efs_tag_filesystem:
	@$(INFO) '$(AWS_UI_LABEL)Tagging file-system "$(EFS_FILESYSTEM_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If a key already exists, it will be updated'; $(NORMAL)
	$(AWS) efs create-tags $(__EFS_FILE_SYSTEM_ID) $(__EFS_TAGS_FILESYSTEM)

_efs_untag_filesystem:
	@$(INFO) '$(AWS_UI_LABEL)Untagging file-system "$(EFS_FILESYSTEM_NAME)" ...'; $(NORMAL)
	$(AWS) efs delete-tags $(__EFS_FILE_SYSTEM_ID) $(__EFS_TAG_KEYS)

_efs_view_filesystems:
	@$(INFO) '$(AWS_UI_LABEL)Viewing existing file-systems ...'; $(NORMAL)
	$(AWS) efs describe-file-systems $(_X__EFS_CREATION_TOKEN) $(_X__EFS_FILE_SYSTEM_ID) --query "FileSystems[]$(EFS_UI_VIEW_FILESYSTEMS_FIELDS)"

_efs_view_filesystems_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing file-systems-set "$(EFS_FILESYSTEMS_SET_NAME)"  ...'; $(NORMAL)
	@$(ERROR) 'Not yet implemented!'; $(NORMAL)
