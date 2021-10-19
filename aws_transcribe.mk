_AWS_TRANSCRIBE_MK_VERSION= 0.99.0

# TSE_INPUTS_DIRPATH?=
# TSE_OUTPUTS_DIRPATH?=

# Derived parameters

# Options parameters

# UI parameters
TSE_UI_LABEL?= $(AWS_UI_LABEL)

#--- Commands

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _tse_view_framework_macros
_tse_view_framework_macros ::
	@echo 'AWS::TransScribE ($(_AWS_TRANSCRIBE_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _tse_view_framework_parameters
_tse_view_framework_parameters ::
	@echo 'AWS::TransScribE ($(_AWS_TRANSCRIBE_MK_VERSION)) parameters:'
	@echo '    TSE_INPUTS_DIRPATH=$(TSE_INPUTS_DIRPATH)'
	@echo '    TSE_OUTPUTS_DIRPATH=$(TSE_OUTPUTS_DIRPATH)'
	@echo

_aws_view_framework_targets :: _tse_view_framework_targets
_tse_view_framework_targets ::
	@echo 'AWS::TransScribE ($(_AWS_TRANSCRIBE_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_transcribe_transcript.mk
-include $(MK_DIR)/aws_transcribe_transcriptionjob.mk
-include $(MK_DIR)/aws_transcribe_vocabulary.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_aws_install_framework_dependencies :: _tse_install_dependencies
_tse_install_dependencies:
	@$(INFO) '$(TSE_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	$(SUDO) apt-get install ffmpeg
	which ffmpeg
	ffmpeg -version
	which ffprobe
	ffprobe -version
	# https://askubuntu.com/questions/226773/how-to-read-mp3-tags-in-shell
	# sudo apt-get install ffmpeg lltag eyed3 mp3info id3v2 libimage-exiftool-perl libid3-tools id3tool

_aws_show_version :: _tse_show_version
_tse_show_version:
	@$(INFO) '$(TSE_UI_LABEL)Showing versions ...'; $(NORMAL)
	ffmpeg -version
	ffprobe -version
