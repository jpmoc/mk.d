_AWS_CODEBUILD_ENVIRONMENT_MK_VERSION= $(_AWS_CODEBUILD_MK_VERSION)

# CBD_ENVIRONMENT_IMAGE_VERSION?= aws/codebuild/java:openjdk-8-1.0.0
# CBD_ENVIRONMENT_OS_PLATFORM?= UBUNTU
# CBD_ENVIRONMENT_RUNTIME_LANGUAGE?= JAVA
# CBD_ENVIRONMENT_RUNTIME_VERSION?= aws/codebuild/java:openjdk-8

# Derived parameters

# Options parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_cbd_view_framework_macros ::
	@echo 'AWS::CodeBuilD::Environment ($(_AWS_CODEBUILD_ENVIRONMENT_MK_VERSION)) macros:'
	@echo

_cbd_view_framework_parameters ::
	@echo 'AWS::CodeBuilD::Environment ($(_AWS_CODEBUILD_ENVIRONMENT_MK_VERSION)) parameters:'
	@echo '    CBD_ENVIRONMENT_IMAGE_VERSION=$(CBD_ENVIRONMENT_IMAGE_VERSION)'
	@echo '    CBD_ENVIRONMENT_OS_PLATFORM=$(CBD_ENVIRONMENT_OS_PLATFORM)'
	@echo '    CBD_ENVIRONMENT_RUNTIME_LANGUAGE=$(CBD_ENVIRONMENT_RUNTIME_LANGUAGE)'
	@echo '    CBD_ENVIRONMENT_RUNTIME_VERSION=$(CBD_ENVIRONMENT_RUNTIME_VERSION)'
	@echo

_cbd_view_framework_targets ::
	@echo 'AWS::CodeBuilD::Environment ($(_AWS_CODEBUILD_ENVIRONMENT_MK_VERSION)) targets:'
	@echo '    _cbd_view_environments           - View build-environments managed by AWS'
	@echo '    _cbd_view_environments           - View build-environments managed by AWS'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

__cbd_view_environments_info:
	@$(INFO) '$(AWS_UI_LABEL)Viewing environments provided by AWS ...'; $(NORMAL)
	@$(WARN) 'If required you can provide your own environment!'; $(NORMAL)
	@echo '    CBD_ENVIRONMENT_OS_PLATFORM=$(CBD_ENVIRONMENT_OS_PLATFORM)'
	@echo '    CBD_ENVIRONMENT_RUNTIME_LANGUAGE=$(CBD_ENVIRONMENT_RUNTIME_LANGUAGE)'
	@echo '    CBD_ENVIRONMENT_RUNTIME_VERSION=$(CBD_ENVIRONMENT_RUNTIME_VERSION)'
	@echo '    CBD_ENVIRONMENT_IMAGE_VERSION=$(CBD_ENVIRONMENT_IMAGE_VERSION)'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cbd_create_environment:
_cbd_delete_environment:
_cbd_show_environment:

_cbd_view_environments: __cbd_view_environments_info _cbd_view_environments_platforms _cbd_view_environments_runtimes _cbd_view_environments_images

_cbd_view_environments_platforms:
	@$(INFO) '$(AWS_UI_LABEL)Viewing available Operating System for build-environment ...'; $(NORMAL)
	$(AWS) codebuild list-curated-environment-images --query "platforms[].{platform:platform}"

_cbd_view_environments_runtimes:
	@$(INFO) '$(AWS_UI_LABEL)Viewing available runtimes for OS platform "$(CBD_ENVIRONMENT_OS_PLATFORM)" to be used as build-environment ...'; $(NORMAL)
	$(AWS) codebuild list-curated-environment-images --query "platforms[?platform=='$(CBD_ENVIRONMENT_OS_PLATFORM)'].languages[].{language:language}"

_cbd_view_environments_images:
	@$(INFO) '$(AWS_UI_LABEL)Viewing available images for runtime "$(CBD_ENVIRONMENT_RUNTIME_LANGUAGE)" in OS "$(CBD_ENVIRONMENT_OS_PLATFORM)" ...'; $(NORMAL)
	$(AWS) codebuild list-curated-environment-images --query "platforms[?platform=='$(CBD_ENVIRONMENT_OS_PLATFORM)'].languages[] | @[?language=='$(CBD_ENVIRONMENT_RUNTIME_LANGUAGE)']"
