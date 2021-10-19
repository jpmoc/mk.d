_AWS_TRANSCRIBE_TRANSCRIPT_MK_VERSION = $(_AWS_TRANSCRIBE_MK_VERSION)

# TSE_TRANSCRIPT_BUCKET_NAME?= my-bucket
# TSE_TRANSCRIPT_BUCKET_URI?= s3://my-bucket
# TSE_TRANSCRIPT_DIRPATH?=
# TSE_TRANSCRIPT_FILENAME?=
# TSE_TRANSCRIPT_FILEPATH?=
# TSE_TRANSCRIPT_KEY?=
# TSE_TRANSCRIPT_NAME?= transcribejob01.json
# TSE_TRANSCRIPT_OBJECT_URI?= s3://123456789012-transcribe-examples/transcribejob01.json
# TSE_TRANSCRIPT_TRANSCRIPTOINJOB_NAME?=
# TSE_TRANSCRIPTS_DIRPATH?=
TSE_TRANSCRIPTS_REGEX?= *.json
# TSE_TRANSCRIPTS_SET_NAME?=

# Derived parameters
TSE_TRANSCRIPT_BUCKET_NAME?= $(TSE_TRANSCRIPTIONJOB_OUTPUTBUCKET_NAME)
TSE_TRANSCRIPT_BUCKET_URI?= $(addprefix s3://,$(TSE_TRANSCRIPT_BUCKET_NAME))
TSE_TRANSCRIPT_DIRPATH?= $(TSE_OUTPUTS_DIRPATH)
TSE_TRANSCRIPT_FILENAME?= $(addsuffix .json,$(TSE_TRANSCRIPT_TRANSCRIPTIONJOB_NAME))
TSE_TRANSCRIPT_FILEPATH?= $(TSE_TRANSCRIPT_DIRPATH)$(TSE_TRANSCRIPT_FILENAME)
TSE_TRANSCRIPT_KEY?= $(addprefix /,$(TSE_TRANSCRIPT_FILENAME))
TSE_TRANSCRIPT_NAME?= $(TSE_TRANSCRIPT_TRANSCRIPTIONJOB_NAME)
TSE_TRANSCRIPT_OBJECT_URI?= $(TSE_TRANSCRIPT_BUCKET_URI)$(TSE_TRANSCRIPT_KEY)
TSE_TRANSCRIPT_TRANSCRIPTIONJOB_NAME?= $(TSE_TRANSCRIPTIONJOB_NAME)

# Option parameters

# UI parameters

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_tse_view_framework_macros ::
	@echo 'AWS::TranScribE::Transcript ($(_AWS_TRANSCRIBE_TRANSCRIPT_MK_VERSION)) macros:'
	@echo

_tse_view_framework_parameters ::
	@echo 'AWS::TranScribE::Transcript ($(_AWS_TRANSCRIBE_TRANSCRIPT_MK_VERSION)) parameters:'
	@echo '    TSE_TRANSCRIPT_BUCKET_NAME=$(TSE_TRANSCRIPT_BUCKET_NAME)'
	@echo '    TSE_TRANSCRIPT_BUCKET_URI=$(TSE_TRANSCRIPT_BUCKET_URI)'
	@echo '    TSE_TRANSCRIPT_DIRPATH=$(TSE_TRANSCRIPT_DIRPATH)'
	@echo '    TSE_TRANSCRIPT_FILENAME=$(TSE_TRANSCRIPT_FILENAME)'
	@echo '    TSE_TRANSCRIPT_FILEPATH=$(TSE_TRANSCRIPT_FILEPATH)'
	@echo '    TSE_TRANSCRIPT_NAME=$(TSE_TRANSCRIPT_NAME)'
	@echo '    TSE_TRANSCRIPT_TRANSCRIPTIONJOB_NAME=$(TSE_TRANSCRIPT_TRANSCRIPTIONJOB_NAME)'
	@echo '    TSE_TRANSCRIPTS_DIRPATH=$(TSE_TRANSCRIPTS_DIRPATH)'
	@echo '    TSE_TRANSCRIPTS_REGEX=$(TSE_TRANSCRIPTS_REGEX)'
	@echo '    TSE_TRANSCRIPTS_SET_NAME=$(TSE_TRANSCRIPTS_SET_NAME)'
	@echo

_tse_view_framework_targets ::
	@echo 'AWS::TranScribE::Transcript ($(_AWS_TRANSCRIBE_TRANSCRIPT_MK_VERSION)) targets:'
	@echo '    _tse_create_transcript                       - Create a transcript'
	@echo '    _tse_delete_transcript                       - Delete a transcript'
	@echo '    _tse_pull_transcript                         - Pull a transcript'
	@echo '    _tse_show_transcript                         - Show everything related to a transcript'
	@echo '    _tse_show_transcript_description             - Show description of a transcript'
	@echo '    _tse_view_transcripts                        - View existing transcripts'
	@echo '    _tse_view_transcripts_set                    - View a set of transcripts'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_tse_create_transcript:
	@$(INFO) '$(TSE_UI_LABEL)Creating transcript "$(TSE_TRANSCRIPT_NAME)" ...'; $(NORMAL)

_tse_delete_transcript:
	@$(INFO) '$(TSE_UI_LABEL)Deleting transcript "$(TSE_TRANSCRIPT_NAME)" ...'; $(NORMAL)
	rm $(TSE_TRANSCRIPT_FILEPATH)

_tse_pull_transcript:
	@$(INFO) '$(TSE_UI_LABEL)Pulling transcript "$(TSE_TRANSCRIPT_NAME)" ...'; $(NORMAL)
	$(AWS) s3 cp $(TSE_TRANSCRIPT_OBJECT_URI) $(TSE_TRANSCRIPT_FILEPATH)

_tse_show_transcript :: _tse_show_transcript_content _tse_show_transcript_description

_tse_show_transcript_content:
	@$(INFO) '$(TSE_UI_LABEL)Showing content of transcript "$(TSE_TRANSCRIPT_NAME)" ...'; $(NORMAL)
	jq -r '.results.transcripts[].transcript' $(TSE_TRANSCRIPT_FILEPATH)

_tse_show_transcript_description:
	@$(INFO) '$(TSE_UI_LABEL)Showing description of transcript "$(TSE_TRANSCRIPT_NAME)" ...'; $(NORMAL)
	ls -l $(TSE_TRANSCRIPT_FILEPATH)

_tse_view_transcripts:
	@$(INFO) '$(TSE_UI_LABEL)Viewing ALL transcripts ...'; $(NORMAL)
	ls -l $(TSE_TRANSCRIPTS_DIRPATH)*

_tse_view_transcripts_set:
	@$(INFO) '$(TSE_UI_LABEL)Viewing transcripts-set "$(TSE_VOCABULARIES_SET_NAME)" ...'; $(NORMAL)
	ls -l $(TSE_TRANSCRIPTS_DIRPATH)$(TSE_TRANSCRIPTS_REGEX)

