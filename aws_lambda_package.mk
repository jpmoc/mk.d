_AWS_LAMBDA_PACKAGE_MK_VERSION= $(_AWS_LAMBDA_MK_VERSION)

# LBA_PACKAGE_FILENAME?= my-package.zip
# LBA_PACKAGE_FILEPATH?= ./zips/my-package.zip
# LBA_PACKAGE_FUNCTION_NAME?= my-function
# LBA_PACKAGE_NAME?= my-package
LBA_PACKAGE_SOURCE_DIRPATH?= ./code
# LBA_PACKAGE_ZIP_CONTENT?= .
LBA_PACKAGE_ZIP_EXECPATH?= .
LBA_PACKAGES_DIRPATH?= ./zips
# LBA_S3PACKAGE_BUCKET_NAME?= my-bucket
# LBA_S3PACKAGE_KEY?= folder/object.zip
# LBA_S3PACKAGE_URI?=

# Derived parameters
LBA_PACKAGE_FILENAME?= $(if $(LBA_PACKAGE_NAME),$(LBA_PACKAGE_NAME).zip)
LBA_PACKAGE_FILEPATH?= $(if $(LBA_PACKAGES_DIRPATH),$(LBA_PACKAGES_DIRPATH)/$(LBA_PACKAGE_FILENAME))
LBA_PACKAGE_FUNCTION_NAME?= $(LBA_FUNCTION_NAME)
LBA_PACKAGE_NAME?= $(LBA_PACKAGE_FUNCTION_NAME)
LBA_S3PACKAGE_KEY?= $(LBA_PACKAGE_FILEPATH)
LBA_S3PACKAGE_URI?= s3://$(LBA_S3PACKAGE_BUCKET_NAME)/$(LBA_S3PACKAGE_KEY)

# Option parameters

# UI parameters

#--- Utilities

# __ZIP_OPTIONS+= -j# Junk the path, i.e. flatten (dangerous with modules!)
__ZIP_OPTIONS+= -r# Recursive
__ZIP_OPTIONS+= -9# Use the optimal compression algorithm
ZIP_BIN?= zip
ZIP?= $(strip $(__ZIP_ENVIRONMENT) $(ZIP_ENVIRONMENT) $(ZIP_BIN) $(__ZIP_OPTIONS) $(ZIP_OPTIONS) )

#--- Macros


#----------------------------------------------------------------------
# USAGE
#

_lba_view_framework_macros ::
	@#echo 'AWS::LamBdA::Package ($(_AWS_LAMBDA_PACKAGE_MK_VERSION)) targets:'
	@#echo

_lba_view_framework_parameters ::
	@echo 'AWS::LamBdA::Package ($(_AWS_LAMBDA_PACKAGE_MK_VERSION)) parameters:'
	@echo '    LBA_PACKAGE_DIRPATH=$(LBA_PACKAGE_DIRPATH)'
	@echo '    LBA_PACKAGE_FILENAME=$(LBA_PACKAGE_FILENAME)'
	@echo '    LBA_PACKAGE_FILEPATH=$(LBA_PACKAGE_FILEPATH)'
	@echo '    LBA_PACKAGE_FUNCTION_NAME=$(LBA_PACKAGE_FUNCTION_NAME)'
	@echo '    LBA_PACKAGE_NAME=$(LBA_PACKAGE_NAME)'
	@echo '    LBA_PACKAGE_ZIP_CONTENT=$(LBA_PACKAGE_ZIP_CONTENT)'
	@echo '    LBA_PACKAGE_ZIP_EXECPATH=$(LBA_PACKAGE_ZIP_EXECPATH)'
	@echo '    LBA_S3PACKAGE_BUCKET_NAME=$(LBA_S3PACKAGE_BUCKET_NAME)'
	@echo '    LBA_S3PACKAGE_KEY=$(LBA_S3PACKAGE_KEY)'
	@echo '    LBA_S3PACKAGE_URI=$(LBA_S3PACKAGE_URI)'
	@echo '    LBA_PACKAGE_SOURCE_DIRPATH=$(LBA_PACKAGE_SOURCE_DIRPATH)'
	@echo '    LBA_PACKAGES_DIRPATH=$(LBA_PACKAGES_DIRPATH)'
	@echo '    ZIP=$(ZIP)'
	@echo

_lba_view_framework_targets ::
	@echo 'AWS::LamBdA::Package ($(_AWS_LAMBDA_PACKAGE_MK_VERSION)) targets:'
	@echo '    _lba_create_package              - Create a project deployment-package'
	@echo '    _lba_delete_package              - Delete the created deployment-package'
	@echo '    _lba_show_package                - Show everything related to a deployment-packages'
	@echo '    _lba_show_package_description    - Show everything related to a deployment-packages'
	@echo '    _lba_view_packages               - View deployment-packages'
	@echo '    _lba_sync_s3packages             - Sync deployment-packages with version on S3'
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_lba_create_package:
	@$(INFO) '$(CMN_UI_LABEL)Creating deployment-package "$(LBA_PACKAGE_NAME)" ...'; $(NORMAL)
	mkdir -p $(LBA_PACKAGES_DIRPATH)/
	cd $(LBA_PACKAGE_ZIP_EXECPATH); $(ZIP) $(LBA_PACKAGE_FILEPATH) $(LBA_PACKAGE_ZIP_CONTENT)

_lba_delete_package:
	@$(INFO) '$(CMN_UI_LABEL)Deleting deployment-package "$(LBA_PACKAGE_NAME)" ...'; $(NORMAL)
	-rm -rf $(LBA_PACKAGE_FILEPATH)

_lba_show_package: _lba_show_package_description

_lba_show_package_description:
	@$(INFO) '$(CMN_UI_LABEL)Showing description of deployment-package "$(LBA_PACKAGE_NAME)" ...'; $(NORMAL)
	ls -la $(LBA_PACKAGE_FILEPATH)

_lba_view_packages:
	@$(INFO) '$(CMN_UI_LABEL)Viewing deployment-packages ...'; $(NORMAL)
	-ls -la $(LBA_PACKAGES_DIRPATH)/

_lba_sync_s3package:
	@$(INFO) '$(AWS_UI_LABEL)Syncing deployment-packages "$(LBA_PACKAGE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Destination: $(LBA_S3PACKAGE_URI)'; $(NORMAL)
	@#$(AWS_S3) cp $(LBA_PACKAGE_FILEPATH) $(LBA_PACKAGE_S3OBJECT_URI)
	$(AWS) s3 cp $(LBA_PACKAGE_FILEPATH) $(LBA_S3PACKAGE_URI)
