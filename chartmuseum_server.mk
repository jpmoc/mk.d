_CHARTMUSEUM_SERVER_MK_VERSION= $(_CHARTMUSEUM_MK_VERSION)

CMM_SERVER_PORT= 8080
# CMN_SERVER_STORAGE_AWSBUCKET?= my-s3-bucket
# CMN_SERVER_STORAGE_AWSPREFIX?=
# CMM_SERVER_STORAGE_AWSREGION?= us-east-1
# CMM_SERVER_STORAGE_BACKEND= amazon
# CMM_SERVER_STORAGE_LOCALROOTDIR?=

# Derived parameters
CMN_SERVER_STORAGE_AWSBUCKET?= $(S3_BUCKET_NAME)
CMN_SERVER_STORAGE_AWSREGION?= $(AWS_REGION)

# Option parameters
__CMM_PORT= $(if $(CMM_SERVER_PORT), --port $(CMM_SERVER_PORT))
__CMM_STORAGE= $(if $(CMM_SERVER_STORAGE_BACKEND), --storage $(CMM_SERVER_STORAGE_BACKEND))
__CMM_STORAGE_AMAZON_BUCKET= $(if $(CMM_SERVER_STORAGE_AWSBUCKET), --storage-amazon-bucket $(CMM_SERVER_STORAGE_AWSBUCKET))
__CMM_STORAGE_AMAZON_PREFIX= $(if $(CMM_SERVER_STORAGE_AWSPREFIX), --storage-amazon-prefix $(CMM_SERVER_STORAGE_AWSPREFIX))
__CMM_STORAGE_LOCAL_ROOTDIR= $(if $(CMM_SERVER_STORAGE_LOCALROOTDIR), --storage-local-rootdir $(CMM_SERVER_STORAGE_LOCALROOTDIR))

# UI parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_cmm_view_framework_macros ::
	@echo 'ChartMuseuM::Server ($(_CHARTMUSEUM_SERVER_MK_VERSION)) macros:'
	@echo

_cmm_view_framework_parameters ::
	@echo 'ChartMuseuM::Server ($(_CHARTMUSEUM_SERVER_MK_VERSION)) variables:'
	@echo '    CMM_SERVER_PORT=$(CMM_SERVER_PORT)'
	@echo '    CMM_SERVER_STORAGE_AWSBUCKET=$(CMM_SERVER_STORAGE_AWSBUCKET)'
	@echo '    CMM_SERVER_STORAGE_AWSPREFIX=$(CMM_SERVER_STORAGE_AWSPREFIX)'
	@echo '    CMM_SERVER_STORAGE_AWSREGION=$(CMM_SERVER_STORAGE_AWSREGION)'
	@echo '    CMM_SERVER_STORAGE_BACKEND=$(CMM_SERVER_STORAGE_BACKEND)'
	@echo '    CMM_SERVER_STORAGE_LOCALROOTDIR=$(CMM_SERVER_STORAGE_LOCALROOTDIR)'
	@echo

_cmm_view_framework_targets ::
	@echo 'ChartMuseuM::Server ($(_CHARTMUSEUM_SERVER_MK_VERSION)) targets:'
	@echo '    _cmm_start_server               - Start server'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cmm_start_server:
	@$(INFO) '$(CMM_UI_LABEL)Starting chartmuseum server ...'; $(NORMAL)
	$(CHARTMUSEUM) $(strip $(__CMM_PORT) $(__CMM_STORAGE) $(__CMM_STORAGE_AMAZON_BUCKET) $(__CMM_STORAGE_AMAZON_PREFIX) $(__CMM_STORAGE_AMAZONREGION) $(__CMM_STORAGE_LOCAL_ROOTDIR) )
