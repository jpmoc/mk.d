_AWS_GLACIER_ARCHIVE_MK_VERSION=$(_AWS_GLACIER_MK_VERSION)

# GCR_ARCHIVE_CHECKSUM?=
# GCR_ARCHIVE_DESCRIPTION?= "This is my archive description"

# Derived variables

# Options variables
__GCR_ARCHIVE_DESCRIPTION= $(if $(GCR_ARCHIVE_DESCRIPTION), --archive-description $(GCR_ARCHIVE_DESCRIPTION))
__GCR_CHECKSUM= $(if $(GCR_ARCHIVE_CHECKSUM), --checksum $(GCR_ARCHIVE_CHECKSUM))

# UI variables


#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_gcr_view_makefile_macros ::
	@echo 'AWS::GlaCieR::Archive ($(_AWS_GLACIER_ARCHIVE_MK_VERSION)) macros:'
	@echo

_gcr_view_makefile_targets ::
	@echo 'AWS::GlaCieR::Archive ($(_AWS_GLACIER_ARCHIVE_MK_VERSION)) targets:'
	@echo '    _gcr_upload_archive             - Upload archive to vault'
	@echo 

_gcr_view_makefile_variables ::
	@echo 'AWS::GlaCieR::Archive ($(_AWS_GLACIER_ARCHIVE_MK_VERSION)) variables:'
	@echo '    GCR_ARCHIVE_CHECKSUM=$(GCR_ARCHIVE_CHECKSUM)'
	@echo '    GCR_ARCHIVE_DESCRIPTION=$(GCR_ARCHIVE_DESCRIPTION)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_gcr_upload_archive:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all existing vaults ...'; $(NORMAL)
	$(AWS) glacier upload-archive $(__GCR_ACCOUNT_ID) $(__GCR_ARCHIVE_DESCRIPTION) $(__GCR_CHECKSUM) $(__GCR_VAULT_NAME)
