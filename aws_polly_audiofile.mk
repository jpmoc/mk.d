_AWS_POLLY_AUDIOFILE_MK_VERSION= $(_AWS_POLLY_MK_VERSION)

# PLY_AUDIOFILE_AUDIO_FORMAT?= mp3
# PLY_AUDIOFILE_LEXICON_NAMES?= w3c ...
# PLY_AUDIOFILE_FILEPATH?= ./my-speech.mp3
# PLY_AUDIOFILE_SAMPLE_RATE?= 22050
# PLY_AUDIOFILE_TEXTINPUT?=
# PLY_AUDIOFILE_TEXTINPUT_FILEPATH?= ./my-speech.ssml
# PLY_AUDIOFILE_TEXTINPUT_RAW?= '<speak>Hello <break time="300ms"/> World</speak>'     # <-- Beware needs to be quoted!
# PLY_AUDIOFILE_TEXT_TYPE?= ssml
# PLY_AUDIOFILE_VOICE_ID?=
# PLY_AUDIOFILES_DIRPATH?= ./mp3s
# PLY_AUDIOFILES_REGEX?= *.mp3
# PLY_AUDIOFILES_SET_NAME?= my-audiofiles-set

# Derived variables
PLY_AUDIOFILE_NAME?= $(notdir $(PLY_AUDIOFILE_FILEPATH))
PLY_AUDIOFILE_TEXTINPUT?= $(if $(PLY_AUDIOFILE_TEXTINPUT_FILEPATH),file://$(PLY_AUDIOFILE_TEXTINPUT_FILEPATH))$(PLY_AUDIOFILE_TEXTINPUT_RAW)
PLY_AUDIOFILE_TEXTINPUT_TYPE?= $(if $(PLY_AUDIOFILE_TEXTINPUT_FILEPATH),$(subst .,,$(suffix $(PLY_AUDIOFILE_TEXTINPUT_FILEPATH))),text)
PLY_AUDIOFILE_VOICE_ID?= $(PLY_VOICE_ID)
PLY_AUDIOFILES_SET_NAME?= $(PLY_AUDIOFILES_REGEX)

# Options variables
__PLY_LEXICON_NAMES= $(if $(PLY_LEXICON_NAMES),--lexicon-names $(PLY_LEXICON_NAMES))
__PLY_OUTPUT_FORMAT= $(if $(PLY_AUDIOFILE_AUDIO_FORMAT),--output-format $(PLY_AUDIOFILE_AUDIO_FORMAT))
__PLY_SAMPLE_RATE= $(if $(PLY_AUDIOFILE_SAMPLE_RATE),--sample-rate $(PLY_AUDIOFILE_SAMPLE_RATE)) 
__PLY_SPEECH_MARK_TYPES= 
__PLY_TEXT= $(if $(PLY_AUDIOFILE_TEXTINPUT),--text $(PLY_AUDIOFILE_TEXTINPUT))
__PLY_TEXT_TYPE= $(if $(PLY_AUDIOFILE_TEXT_TYPE),--text-type $(PLY_AUDIOFILE_TEXT_TYPE))
__PLY_VOICE_ID__AUDIOFILE= $(if $(PLY_AUDIOFILE_VOICE_ID),--voice-id $(PLY_AUDIOFILE_VOICE_ID))

# UI variables

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_ply_view_framework_macros ::  
	@echo 'AWS::PoLlY::AudioFile ($(_AWS_POLLY_AUDIOFILE_MK_VERSION)) macros:'
	@echo

_ply_view_framework_parameters ::
	@echo 'AWS::PoLly::AudioFile ($(_AWS_POLLY_AUDIOFILE_MK_VERSION)) parameters:'
	@echo '    PLY_AUDIOFILE_AUDIO_FORMAT=$(PLY_AUDIOFILE_AUDIO_FORMAT)'
	@echo '    PLY_AUDIOFILE_FILEPATH=$(PLY_AUDIOFILE_FILEPATH)'
	@echo '    PLY_AUDIOFILE_LEXICON_NAMES=$(PLY_AUDIOFILE_LEXICON_NAMES)'
	@echo '    PLY_AUDIOFILE_NAME=$(PLY_AUDIOFILE_NAME)'
	@echo '    PLY_AUDIOFILE_SAMPLE_RATE=$(PLY_AUDIOFILE_SAMPLE_RATE)'
	@echo '    PLY_AUDIOFILE_TEXTINPUT=$(PLY_AUDIOFILE_TEXTINPUT)'
	@echo '    PLY_AUDIOFILE_TEXTINPUT_FILEPATH=$(PLY_AUDIOFILE_TEXTINPUT_FILEPATH)'
	@echo '    PLY_AUDIOFILE_TEXTINPUT_RAW=$(PLY_AUDIOFILE_TEXTINPUT_RAW)'
	@echo '    PLY_AUDIOFILE_TEXTINPUT_TYPE=$(PLY_AUDIOFILE_TEXTINPUT_TYPE)'
	@echo '    PLY_AUDIOFILE_VOICE_ID=$(PLY_AUDIOFILE_VOICE_ID)'
	@echo '    PLY_AUDIOFILES_DIRPATH=$(PLY_AUDIOFILES_DIRPATH)'
	@echo '    PLY_AUDIOFILES_REGEX=$(PLY_AUDIOFILES_REGEX)'
	@echo '    PLY_AUDIOFILES_SET_NAME=$(PLY_AUDIOFILES_SET_NAME)'
	@echo

_ply_view_framework_targets ::
	@echo 'AWS::PoLly::AudioFile ($(_AWS_POLLY_AUDIOFILE_MK_VERSION)) targets:'
	@echo '    _ply_create_audiofile              - Create a new audio-file'
	@echo '    _ply_delete_audiofile              - Deletee an audio-file'
	@echo '    _ply_play_audiofile                - Play an audio-file'
	@echo '    _ply_show_audiofile                - Show everything related to an audio-file'
	@echo '    _ply_show_audiofile_description    - Show description of an audio-file'
	@echo '    _ply_update_audiofile              - Update an audio-file'
	@echo '    _ply_view_audiofiles               - View audio-files'
	@echo '    _ply_view_audiofiles_set           - View a set of audio-files'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ply_create_audiofile:
	@$(INFO) '$(PLY_UI_LABEL)Creating audio-file "$(PLY_AUDIOFILE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the audio-file already exists!'; $(NORMAL)
	$(if $(PLY_AUDIOFILE_TEXTINPUT_FILEPATH), cat $(PLY_AUDIOFILE_TEXTINPUT_FILEPATH))
	[ ! -f $(PLY_AUDIOFILE_FILEPATH) ] || exit 1
	$(AWS) polly synthesize-speech $(strip $(__PLY_LEXICON_NAMES) $(__PLY_OUTPUT_FORMAT) $(__PLY_SAMPLE_RATE) $(__PLY_SPEECH_MARK_TYPES) $(__PLY_TEXT) $(__PLY_TEXT_TYPE) $(__PLY_VOICE_ID__AUDIOFILE) $(PLY_AUDIOFILE_FILEPATH))

_ply_delete_audiofile:
	@$(INFO) '$(PLY_UI_LABEL)Deleting audio-file "$(PLY_AUDIOFILE_NAME)" ...'; $(NORMAL)
	[ -f $(PLY_AUDIOFILE_FILEPATH) ] && rm $(PLY_AUDIOFILE_FILEPATH)
	
_ply_show_audiofile: _ply_show_audiofile_description

_ply_show_audiofile_description:
	@$(INFO) '$(PLY_UI_LABEL)Showing description of audio-file "$(PLY_AUDIOFILE_NAME)" ...'; $(NORMAL)
	ls -al $(PLY_AUDIOFILE_FILEPATH)

_ply_play_audiofile:
	@$(INFO) '$(PLY_UI_LABEL)Playing audito-file "$(PLY_AUDIOFILE_FILEPATH)" ...'; $(NORMAL)
	$(MPLAYER) 

_ply_update_audiofile:
	@$(INFO) '$(PLY_UI_LABEL)Updating audio-file "$(PLY_AUDIOFILE_NAME)" ...'; $(NORMAL)
	$(if $(PLY_AUDIOFILE_TEXTINPUT_FILEPATH), cat $(PLY_AUDIOFILE_TEXTINPUT_FILEPATH))
	$(AWS) polly synthesize-speech $(strip $(__PLY_LEXICON_NAMES) $(__PLY_OUTPUT_FORMAT) $(__PLY_SAMPLE_RATE) $(__PLY_SPEECH_MARK_TYPES) $(__PLY_TEXT) $(__PLY_TEXT_TYPE) $(__PLY_VOICE_ID__AUDIOFILE) $(PLY_AUDIOFILE_FILEPATH))

_ply_view_audiofiles:
	@$(INFO) '$(PLY_UI_LABEL)Viewing audio-files ...'; $(NORMAL)
	ls -l $(PLY_AUDIOFILES_DIRPATH)

_ply_view_audiofiles_set:
	@$(INFO) '$(PLY_UI_LABEL)Viewing audio-files-set "$(PLY_AUDIOFILES_SET_NAME)" ...'; $(NORMAL)
	ls -l $(PLY_AUDIOFILES_DIRPATH)$(PLY_AUDIOFILES_REGEX)
