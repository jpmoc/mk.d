_AWS_KINESISVIDEO_STREAM_MK_VERSION= $(_AWS_KINESISVIDEO_MK_VERSION)

# KVO_STREAM_ARN?=
# KVO_STREAM_DEVICE_NAME?=
# KVO_STREAM_KMSKEY_ID?=
# KVO_STREAM_MEDIA_TYPE?=
# KVO_STREAM_NAME?=
# KVO_STREAM_RETENTION?=
# KVO_STREAMS_NAMES?=
# KVO_STREAMS_SET_NAME?=

# Derived parameters
KVO_STREAMS_NAMES?= $(KVO_STREAM_NAME)

# Option parameters
__KVO_CURRENT_VERSION=
__KVO_DATA_RETENTION_IN_HOURS= $(if $(KVO_STREAM_RETENTION), --data-retention-in-hours $(KVO_STREAM_RETENTION))
__KVO_DEVICE_NAME= $(if $(KVO_STREAM_DEVICE_NAME), --device-name $(KVO_STREAM_DEVICE_NAME))
__KVO_KMS_KEY_ID= $(if $(KVO_STREAM_KMSKEY_ID), --kms-key-id $(KVO_STREAM_KMSKEY_ID))
__KVO_MEDIA_TYPE= $(if $(KVO_STREAM_MEDIA_TYPE), --media-type $(KVO_STREAM_MEDIA_TYPE))
__KVO_STREAM_ARN= $(if $(KVO_STREAM_ARN), --stream-arn $(KVO_STREAM_ARN))
__KVO_STREAM_NAME= $(if $(KVO_STREAM_NAME), --stream-name $(KVO_STREAM_NAME))
__KVO_STREAMNAME_CONDITION=

# UI parameters
KVO_UI_VIEW_STREAMS_FIELDS?=
KVO_UI_VIEW_STREAMS_SET_FIELDS?= $(KVO_UI_VIEW_STREAMS_FIELDS)
KVO_UI_VIEW_STREAMS_SET_SLICE?=

#--- Utilities

#--- MACROS

_kvo_get_stream_id= $(call _kvo_get_stream_id_N, $(KVO_STREAM_NAME))
_kvo_get_stream_id_N= "$(shell $(AWS) kinesisvideo list-streams --organization-id $(2) --query "Users[?Name=='$(strip $(1))'].Id" --output text)"

#----------------------------------------------------------------------
# USAGE
#

_kvo_view_framework_macros ::
	@echo 'AWS::KinesisVideO::Stream ($(_AWS_KINESISVIDEO_STREAM_MK_VERSION)) macros:'
	@echo '    _kvo_get_stream_id_{|N|NO}                     - Get the ID of a stream (Name,OrganizationId)'
	@echo

_kvo_view_framework_parameters ::
	@echo 'AWS::KinesisVideO::Stream ($(_AWS_KINESISVIDEO_STREAM_MK_VERSION)) parameters:'
	@echo '    KVO_STREAM_ARN=$(KVO_STREAM_ARN)'
	@echo '    KVO_STREAM_DEVICE_NAME=$(KVO_STREAM_DEVICE_NAME)'
	@echo '    KVO_STREAM_KMSKEY_ID=$(KVO_STREAM_KMSKEY_ID)'
	@echo '    KVO_STREAM_MEDIA_TYPE=$(KVO_STREAM_MEDIA_TYPE)'
	@echo '    KVO_STREAM_NAME=$(KVO_STREAM_NAME)'
	@echo '    KVO_STREAM_RETENTION=$(KVO_STREAM_RETENTION)'
	@echo '    KVO_STREAMS_NAMES=$(KVO_STREAM_NAMES)'
	@echo '    KVO_STREAMS_SET_NAME=$(KVO_STREAMS_SET_NAME)'
	@echo

_kvo_view_framework_targets ::
	@echo 'AWS::KinesisVideO::Stream ($(_AWS_KINESISVIDEO_STREAM_MK_VERSION)) targets:'A
	@echo '    _kvo_create_stream                           - Create a new stream'
	@echo '    _kvo_delete_stream                           - Delete an existing stream'
	@echo '    _kvo_show_stream                             - Show everything related to a stream'
	@echo '    _kvo_show_stream_description                 - Show description of a stream'
	@echo '    _kvo_view_streams                            - View streams'
	@echo '    _kvo_view_streams_set                        - View a set of streams'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kvo_create_stream:
	@$(INFO) '$(AWS_UI_LABEL)Creating stream "$(KVO_STREAM_NAME)" ...'; $(NORMAL)
	$(AWS) kinesisvideo create-stream $(__KVO_DATA_RETENTION_IN_HOURS) $(__KVO_DEVICE_NAME) $(__KVO_KMS_KEY_ID) $(__KVO_MEDIA_TYPE) $(__KVO_STREAM_NAME)

_kvo_delete_stream:
	@$(INFO) '$(AWS_UI_LABEL)Deleting stream "$(KVO_STREAM_NAME)" ...'; $(NORMAL)
	$(AWS) kinesisvideo delete-stream $(__KVO_CURRENT_VERSION) $(__KVO_STREAM_ARN)

_kvo_show_stream: _kvo_show_stream_description

_kvo_show_stream_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of stream "$(KVO_STREAM_NAME)" ...'; $(NORMAL)
	$(AWS) kinesisvideo describe-stream $(__KVO_STREAM_ARN) $(__KVO_STREAM_NAME) # --query "Stream"

_kvo_view_streams:
	@$(INFO) '$(AWS_UI_LABEL)Viewing streams ...'; $(NORMAL)
	$(AWS) kinesisvideo list-streams $(_X__KVO_STREAM_NAME_CONDITION) # --query "Streams[]$(KVO_UI_VIEW_STREAMS_FIELDS)"

_kvo_view_streams_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing streams-set "$(KVO_STREAMS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Applications are grouped based on the ... and slice'; $(NORMAL)
	$(AWS) kinesisvideo list-streams $(__KVO_STREAM_NAME_CONDITION) # --query "Streams[$(KVO_UI_VIEW_STREAMS_SET_SLICE)]$(KVO_UI_VIEW_STREAMS_SET_FIELDS)"
