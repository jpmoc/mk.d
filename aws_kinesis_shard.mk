_AWS_KINESIS_SHARD_MK_VERSION= $(_AWS_KINESIS_MK_VERSION)

# KSS__SHARD_CHILDREN_IDS?= shardId-000000000001 shardId-000000000002
# KSS_SHARD_ID?= shardId-000000000000
# KSS_SHARD_ITERATOR?=  AAAAAAAAAAFVPpqffLt0Cbn4Urq2UMQKbAmqZ+UFt5aHb+e2h1QXouqF9QMeMw3UGo0h2d9l6LTyFYEZAJBKcE8WM/qW8gRr45kMtrQ7vU5IC5JL9PeE1BOr67oF50nugvgc4dK3xSLM9viZsLK8nboVucm3wDhK+xB57F01wQYVmOpavIHXonzw3qwmliIyLqj0Y+WtmTUD8TUqyxZ4ukH1om50mUfH
# KSS_SHARD_ITERATOR_TYPE?= LATEST
# KSS_SHARD_STREAM_NAME?= my-stream 
# KSS_SHARD_TOSPLIT_ID?= shardId-000000000000
# KSS_SHARD_TOSPLIT_NEWHASHKEY?= my-new-hash-key 
# KSS_SHARD_TOMERGE_ID?= shardId-000000000000
# KSS_SHARD_TOMERGEADJACENT_ID?= shardId-000000000000

# Derived parameters
KSS_SHARD_STREAM_NAME?= $(KSS_STREAM_NAME)
KSS_SHARD_TOSPLIT_ID?= $(KSS_SHARD_ID)

# Option parameters
__KSS_ADJACENT_SHARD_TO_MERGE=
__KSS_EXCLUSIVE_START_SHARD_ID=
__KSS_MAX_RESULTS__SHARD=
__KSS_NEW_STARTING_HASH_KEY= $(if $(KSS_SHARD_TOSPLIT_NEWHASHKEY),--new-starting-hash-key $(KSS_SHARD_TOSPLIT_NEWHASHKEY))
__KSS_SHARD_ID= $(if $(KSS_SHARD_ID),--shard-id $(KSS_SHARD_ID))
__KSS_SHARD_ITERATOR_TYPE= $(if $(KSS_SHARD_ITERATOR_TYPE),--shard-iterator-type $(KSS_SHARD_ITERATOR_TYPE))
__KSS_SHARD_TO_MERGE= $(if $(KSS_SHARD_TOMERGE_ID),--shard-to-merge $(KSS_SHARD_TOMERGE_ID))
__KSS_SHARD_TO_SPLIT= $(if $(KSS_SHARD_TOSPLIT_ID),--shard-to-split $(KSS_SHARD_TOSPLIT_ID))
__KSS_STREAM_CREATION_TIMESTAMP=
__KSS_STREAM_NAME__SHARD= $(if $(KSS_SHARD_STREAM_NAME),--stream-name $(KSS_SHARD_STREAM_NAME))

# UI parameters
KSS_UI_VIEW_SHARDS_FIELDS?=
KSS_UI_VIEW_SHARDS_SET_FIELDS?= $(KSS_UI_VIEW_SHARDS_FIELDS)
KSS_UI_VIEW_SHARDS_SET_QUERYFILTER?=

#--- Utilities

#--- MACROS
_kss_get_shard_iterator= $(call _kss_get_shard_iterator_T, $(KSS_SHARD_ITERATOR_TYPE))
_kss_get_shard_iterator_T= $(call _kss_get_shard_iterator_TI, $(1), $(KSS_SHARD_ID))
_kss_get_shard_iterator_TI= $(call _kss_get_shard_iterator_TIS, $(1), $(2), $(KSS_SHARD_STREAM_NAME))
_kss_get_shard_iterator_TIS= $(shell $(AWS) kinesis get-shard-iterator --shard-id $(2) --shard-iterator-type $(1) --stream-name $(3) --query "ShardIterator" --output text)

_kss_get_shard_children_ids= $(call _kss_get_shard_children_ids_I, $(KSS_SHARD_ID))
_kss_get_shard_children_ids_I= $(call _kss_get_shard_children_ids_IS, $(1), $(KSS_SHARD_STREAM_NAME))
_kss_get_shard_children_ids_IS= $(shell $(AWS) kinesis list-shards --stream-name $(2) --query "Shards[?ParentShardId=='$(strip $(1))'].ShardId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_kss_view_framework_macros ::
	@echo 'AWS::KineSiS::Shard ($(_AWS_KINESIS_SHARD_MK_VERSION)) macros:'
	@echo '    _kss_get_shard_children_ids_{|I|IS}          - Get the IDs of the 2 children of a shard (shardId,Stream)'
	@echo '    _kss_get_shard_iterator_{|T|TI|TIS}          - Get the iterator/cursor of a shard (Type,shardId,Stream)'
	@echo

_kss_view_framework_parameters ::
	@echo 'AWS::KineSiS::Shard ($(_AWS_KINESIS_SHARD_MK_VERSION)) parameters:'
	@echo '    KSS_SHARD_CHILDREN_IDS=$(KSS_SHARD_CHILDREN_IDS)'
	@echo '    KSS_SHARD_ID=$(KSS_SHARD_ID)'
	@echo '    KSS_SHARD_ITERATOR=$(KSS_SHARD_ITERATOR)'
	@echo '    KSS_SHARD_ITERATOR_TYPE=$(KSS_SHARD_ITERATOR_TYPE)'
	@echo '    KSS_SHARD_STREAM_NAME=$(KSS_SHARD_STREAM_NAME)'
	@echo '    KSS_SHARD_TOSPLIT_ID=$(KSS_SHARD_TOSPLIT_ID)'
	@echo '    KSS_SHARD_TOSPLIT_NEWHASHKEY=$(KSS_SHARD_TOSPLIT_NEWHASHKEY)'
	@echo '    KSS_SHARD_TOMERGE_ID=$(KSS_SHARD_TOMERGE_ID)'
	@echo '    KSS_SHARD_TOMERGEADJACENT_ID=$(KSS_SHARD_TOMERGEADJACENT_ID)'
	@echo

_kss_view_framework_targets ::
	@echo 'AWS::KineSiS::Shard ($(_AWS_KINESIS_SHARD_MK_VERSION)) targets:'A
	@echo '    _kss_get_shard_iterator                    - Get an iteartor on a shard'
	@echo '    _kss_merge_shard                           - Merge 2 to shard in 1'
	@echo '    _kss_split_shard                           - Split a shard in 2'
	@echo '    _kss_view_shards                           - View stream-shards'
	@echo '    _kss_view_shards_set                       - View a set of stream-shards'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kss_get_shard_iterator:
	@$(INFO) '$(AWS_UI_LABEL)Getting iterator for shard "$(KSS_SHARD_ID)" of stream "$(KSS_SHARD_STREAM_NAME)" ...'; $(NORMAL)
	$(AWS) kinesis get-shard-iterator $(__KSS_SHARD_ID) $(__KSS_SHARD_ITERATOR_TYPE) $(__KSS_STREAM_NAME__SHARD)

_kss_merge_shard:
	@$(INFO) '$(AWS_UI_LABEL)Merging shard "$(KSS_SHARD_TOMERGE_ID)" with "$(KSS_SHARD_TOMERGEADJACENT_ID)" ...'; $(NORMAL)
	@$(WARN) 'Only 2 shards with the same parent shard can be merged!'; $(NORMAL)
	$(AWS) kinesis merge-shards $(__KSS_ADJACENT_SHARD_TO_MERGE) $(__KSS_SHARD_TO_MERGE) $(__KSS_STREAM_NAME__SHARD)

_kss_split_shard:
	@$(INFO) '$(AWS_UI_LABEL)Splitting shard "$(KSS_SHARD_TOSPLIT_ID)" in 2 ...'; $(NORMAL)
	@$(WARN) 'If successful, this operation creates 2 shards whose parent-shard is the shard to be split'; $(NORMAL)
	@$(WARN) 'For the 1st new shard, the hash-keys go from the parent-shard starting-hash-key to the new-starting-hash-key'; $(NORMAL)
	@$(WARN) 'For the 2nd new shard, the hash-keys go from the new-starting-hash-key to the parent-shard ending-hash-key'; $(NORMAL)
	$(AWS) kinesis split-shard $(__KSS_NEW_STARTING_HASH_KEY) $(__KSS_SHARD_TO_SPLIT) $(__KSS_STREAM_NAME__SHARD)

_kss_view_shards:
	@$(INFO) '$(AWS_UI_LABEL)Viewing shards of stream "$(KSS_SHARD_STREAM_NAME)" ...'; $(NORMAL)
	$(AWS) kinesis list-shards $(__KSS_EXCLUSIVE_START_SHARD_ID) $(__KSS_MAX_RESULTS__SHARD) $(__KSS_STREAM_CREATION_TIMESTAMP) $(__KSS_STREAM_NAME__SHARD)

_kss_view_shards_set:
