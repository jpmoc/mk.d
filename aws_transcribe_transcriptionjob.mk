_AWS_TRANSCRIBE_TRANSCRIPTIONJOB_MK_VERSION = $(_AWS_TRANSCRIBE_MK_VERSION)

# TSE_TRANSCRIPTIONJOB_LANGUAGE_CODE?= en-US
# TSE_TRANSCRIPTIONJOB_MEDIA_FORMAT?= mp3
# TSE_TRANSCRIPTIONJOB_MEDIA?=
# TSE_TRANSCRIPTIONJOB_MEDIA_SAMPLERATE?= 44100
# TSE_TRANSCRIPTIONJOB_MEDIA_URI?= MediaFileUri=string
# TSE_TRANSCRIPTIONJOB_NAME?= my-transcription-job
# TSE_TRANSCRIPTIONJOB_NAME_CONTAINS?=
# TSE_TRANSCRIPTIONJOB_OUTPUTBUCKET_NAME?=
# TSE_TRANSCRIPTIONJOB_OUTPUTENCRYPTIONKEY_ID?=
# TSE_TRANSCRIPTIONJOB_SETTINGS?= VocabularyName=string,ShowSpeakerLabels=boolean,MaxSpeakerLabels=integer
# TSE_TRANSCRIPTIONJOB_STATUS?=
# TSE_TRANSCRIPTIONJOBS_SET_NAME?= my-transcription-jobs-set

# Derived parameters
TSE_TRANSCRIPTIONJOB_MEDIA?= $(if $(TSE_TRANSCRIPTIONJOB_MEDIA_URI),MediaFileUri=$(TSE_TRANSCRIPTIONJOB_MEDIA_URI))
TSE_TRANSCRIPTIONJOB_NAMES?= $(TSE_TRANSCRIPTIONJOB_NAME)

# Option parameters
__TSE_JOB_NAME_CONTAINS= $(if $(TSE_TRANSCRIPTIONJOB_NAME_CONTAINS),--job-name-contains $(TSE_TRANSCRIPTIONJOB_NAME_CONTAINS))
__TSE_LANGUAGE_CODE__TRANSCRIPTIONJOB= $(if $(TSE_TRANSCRIPTIONJOB_LANGUAGE_CODE),--language-code $(TSE_TRANSCRIPTIONJOB_LANGUAGE_CODE))
__TSE_MEDIA= $(if $(TSE_TRANSCRIPTIONJOB_MEDIA),--media $(TSE_TRANSCRIPTIONJOB_MEDIA))
__TSE_MEDIA_FORMAT= $(if $(TSE_TRANSCRIPTIONJOB_MEDIA_FORMAT),--media-format $(TSE_TRANSCRIPTIONJOB_MEDIA_FORMAT))
__TSE_MEDIA_SAMPLE_RATE_HERTZ= $(if $(TSE_TRANSCRIPTIONJOB_MEDIA_SAMPLERATE),--media-sample-rate-hertz $(TSE_TRANSCRIPTIONJOB_MEDIA_SAMPLERATE))
__TSE_OUTPUT_BUCKET_NAME= $(if $(TSE_TRANSCRIPTIONJOB_OUTPUTBUCKET_NAME),--output-bucket-name $(TSE_TRANSCRIPTIONJOB_OUTPUTBUCKET_NAME))
__TSE_OUTPUT_ENCRYPTION_KMS_KEY_ID= $(if $(TSE_TRANSCRIPTIONJOB_OUTPUTENCRYPTIONKEY_ID),--output-encryption-key-id $(TSE_TRANSCRIPTIONJOB_OUTPUTENCRYPTIONKEY_ID))
__TSE_SETTINGS= $(if $(TSE_TRANSCRIPTIONJOB_SETTINGS),--settings $(TSE_TRANSCRIPTIONJOB_SETTINGS))
__TSE_STATUS= $(if $(TSE_TRANSCRIPTIONJOB_STATUS),--status $(TSE_TRANSCRIPTIONJOB_STATUS))
__TSE_TRANSCRIPTION_JOB_NAME= $(if $(TSE_TRANSCRIPTIONJOB_NAME),--transcription-job-name $(TSE_TRANSCRIPTIONJOB_NAME))

# UI parameters
TSE_UI_VIEW_TRANSCRIPTIONJOBS_FIELDS?=
TSE_UI_VIEW_TRANSCRIPTIONJOBS_SET_FIELDS?= $(TSE_UI_VIEW_TRANSCRIPTIONJOBS_FIELDS)
TSE_UI_VIEW_TRANSCRIPTIONJOBS_SET_QUERYFILTER?=

#--- MACRO

_tse_get_transcriptionjob_transcript_uri= $(call _tse_get_transcriptionjob_transcript_uri_N, $(TSE_TRANSCRIPTIONJOB_NAME))
_tse_get_transcriptionjob_transcript_uri_N= $(shell $(AWS) transcribe get-transcription-job --transcription-job-name $(1) --query "TranscriptionJob.Transcript.TranscriptFileUri" --output text)

#----------------------------------------------------------------------
# USAGE
#

_tse_view_framework_macros ::
	@echo 'AWS::TranScribE::TranscriptionJob ($(_AWS_TRANSCRIBE_TRANSCRIPTIONJOB_MK_VERSION)) macros:'
	@echo '    _tse_get_transcriptionjob_transcript_uri_{|N}    - Get the URI for transcript of transcribe-job (Name)'
	@echo

_tse_view_framework_parameters ::
	@echo 'AWS::TranScribE::TranscriptionJob ($(_AWS_TRANSCRIBE_TRANSCRIPTIONJOB_MK_VERSION)) parameters:'
	@echo '    TSE_TRANSCRIPTIONJOB_LANGUAGE_CODE=$(TSE_TRANSCRIPTIONJOB_LANGUAGE_CODE)'
	@echo '    TSE_TRANSCRIPTIONJOB_MEDIA=$(TSE_TRANSCRIPTIONJOB_MEDIA)'
	@echo '    TSE_TRANSCRIPTIONJOB_MEDIA_FORMAT=$(TSE_TRANSCRIPTIONJOB_MEDIA_FORMAT)'
	@echo '    TSE_TRANSCRIPTIONJOB_MEDIA_SAMPLERATE=$(TSE_TRANSCRIPTIONJOB_MEDIA_SAMPLERATE)'
	@echo '    TSE_TRANSCRIPTIONJOB_MEDIA_URI=$(TSE_TRANSCRIPTIONJOB_MEDIA_URI)'
	@echo '    TSE_TRANSCRIPTIONJOB_NAME=$(TSE_TRANSCRIPTIONJOB_NAME)'
	@echo '    TSE_TRANSCRIPTIONJOB_NAME_CONTAINS=$(TSE_TRANSCRIPTIONJOB_NAME_CONTAINS)'
	@echo '    TSE_TRANSCRIPTIONJOB_OUTPUTBUCKET_NAME=$(TSE_TRANSCRIPTIONJOB_OUTPUTBUCKET_NAME)'
	@echo '    TSE_TRANSCRIPTIONJOB_OUTPUTENCRYPTIONKMSKEY_ID=$(TSE_TRANSCRIPTIONJOB_OUTPUTENCRYPTIONKEY_ID)'
	@echo '    TSE_TRANSCRIPTIONJOB_STATUS=$(TSE_TRANSCRIPTIONJOB_STATUS)'
	@echo '    TSE_TRANSCRIPTIONJOB_TRANSCRIPT_URI=$(TSE_TRANSCRIPTIONJOB_TRANSCRIPT_URI)'
	@echo

_tse_view_framework_targets ::
	@echo 'AWS::TranScribE::TranscriptionJob ($(_AWS_TRANSCRIBE_TRANSCRIPTIONJOB_MK_VERSION)) targets:'
	@echo '    _tse_create_transcriptionjob                       - Create a transcription-job'
	@echo '    _tse_show_transcriptionjob                         - Show everything related to a transcription-job'
	@echo '    _tse_view_transcriptionjobs                        - View existing transcription-jobs'
	@echo '    _tse_view_transcriptionjobs_set                    - View a set of transcription-jobs'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_tse_create_transcriptionjob:
	@$(INFO) '$(TSE_UI_LABEL)Creating transcription-job "$(TSE_TRANSCRIPTIONJOB_NAME)" ...'; $(NORMAL)
	$(AWS) transcribe start-transcription-job $(__TSE_LANGUAGE_CODE__TRANSCRIPTIONJOB) $(__TSE_MEDIA) $(__TSE_MEDIA_FORMAT) $(__TSE_MEDIA_SAMPLE_RATE_HERTZ) $(__TSE_OUTPUT_BUCKET_NAME) $(__TSE_OUTPUT_ENCRYPTION_KMS_KEY_ID) $(__TSE_SETTINGS) $(__TSE_TRANSCRIPTION_JOB_NAME)

_tse_show_transcriptionjob: _tse_show_transcriptionjob_description

_tse_show_transcriptionjob_description:
	@$(INFO) '$(TSE_UI_LABEL)Showing description of transcription-job "$(TSE_TRANSCRIPTIONJOB_NAME)" ...'; $(NORMAL)
	$(AWS) transcribe get-transcription-job $(__TSE_TRANSCRIPTION_JOB_NAME)

_tse_view_transcriptionjobs:
	@$(INFO) '$(TSE_UI_LABEL)Viewing ALL transcription-jobs ...'; $(NORMAL)
	$(AWS) transcribe list-transcription-jobs $(_X__TSE_JOB_NAME_CONTAINS) $(_X__TSE_STATUS) --query "TranscriptionJobSummaries[]$(TSE_UI_VIEW_TRANSCRIPTIONJOBS_FIELDS)"

_tse_view_transcriptionjobs_set:
	@$(INFO) '$(TSE_UI_LABEL)Viewing transcription-jobs-set "$(TSE_TRANSCRIPTIONJOBS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Transcription-jobs are grouped based on regex, status, query-filter'; $(NORMAL)
	$(AWS) transcribe list-transcription-jobs $(__TSE_JOB_NAME_CONTAINS) $(__TSE_STATUS) --query "TranscriptionJobSummaries[$(TSE_VIEW_TRANSCRIPTIONJOBS_SET_QUERYFILTER)]$(TSE_UI_VIEW_TRANSCRIPTIONJOBS_FIELDS)"

