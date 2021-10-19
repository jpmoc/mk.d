_AWS_POLLY_MK_VERSION= 0.99.0

# PLY_VOICES_LANGUAGE_CODE?= en-US

# Derived variables

# Options variables

# UI variables
PLY_UI_LABEL?= $(AWS_UI_LABEL)

#--- Utilities
MPLAYER_BIN?= mplayer
MPLAYER= $(strip $(__MPLAYER_ENVIRONMENT) $(MPLAYER_ENVIRONMENT) $(MPLAYER_BIN) $(__MPLAYER_OPTIONS) $(MPLAYER_OPTION))

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _ply_view_framework_macros
_ply_view_framework_macros ::  
	@echo 'AWS::PoLlY:: ($(_AWS_POLLY_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _ply_view_framework_parameters
_ply_view_framework_parameters ::
	@echo 'AWS::PoLly:: ($(_AWS_POLLY_MK_VERSION)) variables:'
	@echo '    MPLAYER=$(MPLAYER)'
	@echo

_aws_view_framework_targets :: _ply_view_framework_targets
_ply_view_framework_targets ::
	@echo 'AWS::PoLly:: ($(_AWS_POLLY_MK_VERSION)) targets:'
	@echo '    _ply_check_speakers                 - Check sound settings'
	@echo '    _ply_install_dependencies           - Install the dependencies'
	@echo '    _ply_show_version                   - Show version of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_polly_audiofile.mk
-include $(MK_DIR)/aws_polly_lexicon.mk
-include $(MK_DIR)/aws_polly_voice.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ply_check_speakers:
	@$(INFO) '$(PLY_UI_LABEL)Checking speaker settings ...'; $(NORMAL)
	speaker-test

_aws_install_dependencies :: _ply_install_dependencies
_ply_install_dependencies:
	$(SUDO) apt-get install mplayer
	which mplayer
	$(SUDO) apt-get install alsa-util
	which alsa-util

_view_versions:: _ply_show_version
_ply_show_version:
	@$(INFO) '$(PLY_UI_LABEL)Showing versions of dependencies ...'; $(NORMAL)
	which alsa-util
	which mplayer
