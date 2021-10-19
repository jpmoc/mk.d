_AWS_KAFKA_CLUSTER_MK_VERSION= $(_AWS_KAFKA_MK_VERSION)

# KKA_CLUSTER_ARN?= arn:aws:kafka:us-east-1:123456789012:cluster/k-cluster/ef6fab0b-326d-4567-b839-37fbb922932a-16
# KKA_CLUSTER_BROKERNODEGROUPINFO_CONFIG?= BrokerAZDistribution=s,ClientSubnets=s,s,InstanceType=s,SecurityGroups=s,s,StorageInfo={EbsStorageInfo={VolumeSize=i}}
# KKA_CLUSTER_BROKERNODEGROUPINFO_DIRPATH?= ./in/
# KKA_CLUSTER_BROKERNODEGROUPINFO_FILENAME?= brokernodegroupconfig.json
# KKA_CLUSTER_BROKERNODEGROUPINFO_FILEPATH?= ./in/brokernodegroupconfig.json
# KKA_CLUSTER_BROKERNODES_COUNT?= 3
# KKA_CLUSTER_BROKERNODES?=
# KKA_CLUSTER_CONFIGURATION_ARN?= arn:aws:kafka:us-east-1:123456789012:configuration/CustomConfiguration/1432a325-8c7e-4a66-8498-8369339e0218-16 
# KKA_CLUSTER_CONFIGURATION_REVISIONID?= 1
# KKA_CLUSTER_ENCRYPTIONINFO_CONFIG?= EncryptionAtRest={DataVolumeKMSKeyId=s},EncryptionInTransit={ClientBroker=s,InCluster=b}
# KKA_CLUSTER_ENHANCEDMONITORING_TYPE?= DEFAULT
# KKA_CLUSTER_LOGGINGINFO_CONFIG?= BrokerLogs={CloudWatchLogs={Enabled=b,LogGroup=s},Firehose={DeliveryStream=s,Enabled=b},S3={Bucket=s,Enabled=b,Prefix=s}}
# KKA_CLUSTER_NAME?= my-cluster-name
# KKA_CLUSTER_TAGS_KEYVALUES?= Key=string,Value=string ...
# KKA_CLUSTER_VERSION?= K2EUQ1WTGCTBG2
# KKA_CLUSTERS_SET_NAME?= my-clusters-set

# Derived parameters
KKA_CLUSTER_BROKERNODEGROUPINFO_DIRPATH?= $(KKA_INPUTS_DIRPATH)
KKA_CLUSTER_BROKERNODEGROUPINFO_FILEPATH?= $(if $(KKA_CLUSTER_BROKERNODEGROUPINFO_FILENAME),$(KKA_CLUSTER_BROKERNODEGROUPINFO_DIRPATH)$(KKA_CLUSTER_BROKERNODEGROUPINFO_FILENAME))
KKA_CLUSTER_CONFIGURATION_ARN?= $(if $(KKA_CLUSTER_CONFIGURATION_REVISIONID),$(KKA_CONFIGURATION_ARN))
# KKA_CLUSTER_CONFIGURATION_REVISIONID?= $(KKA_CONFIGURATION_REVISION_ID)

# Option parameters
__KKA_BROKER_NODE_GROUP_INFO+= $(if $(KKA_CLUSTER_BROKERNODEGROUPINFO_CONFIG),--broker-node-group-info $(KKA_CLUSTER_BROKERNODEGROUPINFO_CONFIG))
__KKA_BROKER_NODE_GROUP_INFO+= $(if $(KKA_CLUSTER_BROKERNODEGROUPINFO_FILEPATH),--broker-node-group-info file://$(KKA_CLUSTER_BROKERNODEGROUPINFO_FILEPATH))
__KKA_CLIENT_AUTHENTICATION=
__KKA_CLUSTER_ARN= $(if $(KKA_CLUSTER_ARN),--cluster-arn $(KKA_CLUSTER_ARN))
__KKA_CLUSTER_NAME= $(if $(KKA_CLUSTER_NAME),--cluster-name $(KKA_CLUSTER_NAME))
__KKA_CLUSTER_NAME_FILTER=
__KKA_CONFIGURATION_INFO= $(if $(KKA_CLUSTER_CONFIGURATION_REVISIONID),--configuration-info Arn=$(KKA_CLUSTER_CONFIGURATION_ARN)$(COMMA)Revision=$(KKA_CLUSTER_CONFIGURATION_REVISIONID))
__KKA_CURRENT_VERSION= $(if $(KKA_CLUSTER_VERSION),--current-version $(KKA_CLUSTER_VERSION))
__KKA_ENCRYPTION_INFO=
__KKA_ENHANCED_MONITORING=
__KKA_KAFKA_VERSION= $(if $(KKA_CLUSTER_KAFKA_VERSION),--kafka-version $(KKA_CLUSTER_KAFKA_VERSION))
__KKA_LOGGING_INFO=
__KKA_NUMBER_OF_BROKER_NODES= $(if $(KKA_CLUSTER_BROKERNODES_COUNT),--number-of-broker-nodes $(KKA_CLUSTER_BROKERNODES_COUNT))
__KKA_OPEN_MONITORING=
__KKA_RESOURCE_ARN__CLUSTER= $(if $(KKA_CLUSTER_ARN),--resource-arn $(KKA_CLUSTER_ARN))
__KKA_TAGS__CLUSTER= $(if $(KKA_CLUSTER_TAGS_KEYVALUES),--tags $(KKA_CLUSTER_TAGS_KEYVALUES))
__KKA_TARGET_BROKER_EBS_VOLUME_INFO=
__KKA_TARGET_NUMBER_OF_BROKER_NODES=
__KKA_TARGET_INSTANCE_TYPE=
__KKA_TARGET_KAFKA_VERSION=

# UI parameters
KKA_UI_VIEW_CLUSTERS_FIELDS?= .{ClusterName:ClusterName,enhancedMonitoring:EnhancedMonitoring,numberOfBrokerNodes:NumberOfBrokerNodes,state:State}
KKA_UI_VIEW_CLUSTERS_SET_FIELDS?= $(KKA_UI_VIEW_CLUSTERS_FIELDS)
KKA_UI_VIEW_CLUSTERS_SET_SLICE?=

#--- MACROS
_kka_get_cluster_arn= $(call _kka_get_cluster_arn_N, $(KKA_CLUSTER_NAME))
_kka_get_cluster_arn_N= $(shell $(AWS) kafka list-clusters --query "ClusterInfoList[?ClusterName=='$(strip $(1))'].ClusterArn" --output text)

#----------------------------------------------------------------------
# USAGE
#

_kka_view_framework_macros ::
	@echo 'AWS::KafKA::Cluster ($(_AWS_KAFKA_CLUSTER_MK_VERSION)) macros:'
	@echo '    _kka_get_cluster_arn_{|N}                   - Get ARN of a cluster (Name)'
	@echo

_kka_view_framework_parameters ::
	@echo 'AWS::KafKA::Cluster ($(_AWS_KAFKA_CLUSTER_MK_VERSION)) parameters:'
	@echo '    KKA_CLUSTER_ARN=$(KKA_CLUSTER_ARN)'
	@echo '    KKA_CLUSTER_BROKERNODEGROUPINFO_CONFIG=$(KKA_CLUSTER_BROKERNODEGROUPINFO_CONFIG)'
	@echo '    KKA_CLUSTER_BROKERNODEGROUPINFO_DIRPATH=$(KKA_CLUSTER_BROKERNODEGROUPINFO_DIRPATH)'
	@echo '    KKA_CLUSTER_BROKERNODEGROUPINFO_FILENAME=$(KKA_CLUSTER_BROKERNODEGROUPINFO_FILENAME)'
	@echo '    KKA_CLUSTER_BROKERNODEGROUPINFO_FILEPATH=$(KKA_CLUSTER_BROKERNODEGROUPINFO_FILEPATH)'
	@echo '    KKA_CLUSTER_BROKERNODES_COUNT=$(KKA_CLUSTER_BROKERNODES_COUNT)'
	@echo '    KKA_CLUSTER_BROKERNODES=$(KKA_CLUSTER_BROKERNODES)'
	@echo '    KKA_CLUSTER_CONFIGURATION_ARN=$(KKA_CLUSTER_CONFIGURATION_ARN)'
	@echo '    KKA_CLUSTER_CONFIGURATION_REVISIONID=$(KKA_CLUSTER_CONFIGURATION_REVISIONID)'
	@echo '    KKA_CLUSTER_ENCRYPTIONINFO_CONFIG=$(KKA_CLUSTER_ENCRYPTIONINFO_CONFIG)'
	@echo '    KKA_CLUSTER_ENHANCEDMONITORING_TYPE=$(KKA_CLUSTER_ENHANCEDMONITORING_TYPE)'
	@echo '    KKA_CLUSTER_KAFKA_VERSION=$(KKA_CLUSTER_KAFKA_VERSION)'
	@echo '    KKA_CLUSTER_LOGGINGINFO_CONFIG=$(KKA_CLUSTER_LOGGINGINFO_CONFIG)'
	@echo '    KKA_CLUSTER_NAME=$(KKA_CLUSTER_NAME)'
	@echo '    KKA_CLUSTER_TAGS_KEYVALUES=$(KKA_CLUSTER_TAGS_KEYVALUES)'
	@echo '    KKA_CLUSTER_VERSION=$(KKA_CLUSTER_VERSION)'
	@echo '    KKA_CLUSTERS_SET_NAME=$(KKA_CLUSTERS_SET_NAME)'
	@echo

_kka_view_framework_targets ::
	@echo 'AWS::KafKA::Cluster ($(_AWS_KAFKA_CLUSTER_MK_VERSION)) targets:'
	@echo '    _kka_create_cluster                   - Create a cluster'
	@echo '    _kka_delete_cluster                   - Delete an existing cluster'
	@echo '    _kka_show_cluster                     - Show everything related to a cluster'
	@echo '    _kka_show_cluster_brokers             - Show brokers of a cluster'
	@echo '    _kka_show_cluster_configuration       - Show configuration of a cluster'
	@echo '    _kka_show_cluster_description         - Show description of a cluster'
	@echo '    _kka_show_cluster_nodes               - Show nodes of a cluster'
	@echo '    _kka_show_cluster_operations          - Show operations of a cluster'
	@echo '    _kka_show_cluster_tags                - Show tags of a cluster'
	@echo '    _kka_tag_cluster                      - Tag a cluster'
	@echo '    _kka_untag_cluster                    - Untag a cluster'
	@echo '    _kka_update_cluster_brokernodecount   - Update the count of broker-nodes in a cluster'
	@echo '    _kka_update_cluster_brokernodestorage - Update the storage space for each broker-node in a cluster'
	@echo '    _kka_update_cluster_brokernodetype    - Update the type of broker-nodes used in a cluster'
	@echo '    _kka_update_cluster_kafkaversion      - Update the kafka-version of a cluster'
	@echo '    _kka_view_clusters                    - View existing clusters'
	@echo '    _kka_view_clusters_set                - View a set of clusters'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGET
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kka_create_cluster:
	@$(INFO) '$(KKA_UI_LABEL)Creating a cluster "$(KKA_CLUSTER_NAME)" ...'; $(NORMAL)
	$(if $(KKA_CLUSTER_BROKERNODEGROUPINFO_FILEPATH),cat $(KKA_CLUSTER_BROKERNODEGROUPINFO_FILEPATH))
	$(AWS) kafka create-cluster $(strip $(__KKA_BROKER_NODE_GROUP_INFO) $(__KKA_CLIENT_AUTHENTICATION) $(__KKA_CLUSTER_NAME) $(__KKA_CONFIGURATION_INFO) $(__KKA_ENCRYPTION_INFO) $(__KKA_ENHANCE_MONITORING) $(__KKA_OPEN_MONITORING) $(__KKA_KAFKA_VERSION) $(__KKA_LOGGING_INFO) $(__KKA_NUMBER_OF_BROKER_NODES) $(__KKA_TAGS__CLUSTER) )

_kka_delete_cluster:
	@$(INFO) '$(KKA_UI_LABEL)Deleting cluster "$(KKA_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the cluster is not in ACTIVE state'; $(NORMAL)
	$(AWS) kafka delete-cluster $(__KKA_CLUSTER_ARN)

_kka_show_cluster: _kka_show_cluster_brokers _kka_show_cluster_configuration _kka_show_cluster_nodes _kka_show_cluster_operations _kka_show_cluster_tags _kka_show_cluster_description

_kka_show_ckuster_brokers:
	@$(INFO) '$(KKA_UI_LABEL)Showing brokers of cluster "$(KKA_CLUSTER_NAME)" ...'; $(NORMAL)
	# bin/kafka-console-consumer.sh --bootstrap-server $MYBROKERS --topic test 
	$(AWS) kafka get-bootstrap-brokers $(__KKA_CLUSTER_ARN)

_kka_show_cluster_configuration:
	@$(INFO) '$(KKA_UI_LABEL)Showing configuration of cluster "$(KKA_CLUSTER_NAME)" ...'; $(NORMAL)
	$(if $(KKA_CLUSTER_CONFIGURATION_REVISIONID),, @echo "KKA_CLUSTER_CONFIGURATION_REVISIONID not set")
	# $(if $(KKA_CLUSTER_CONFIGURATION_NAME),, @echo "KKA_CLUSTER_CONFIGURATION_NAME not set")

_kka_show_cluster_description:
	@$(INFO) '$(KKA_UI_LABEL)Showing description of cluster "$(KKA_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) kafka describe-cluster $(__KKA_CLUSTER_ARN) --query "ClusterInfo"

_kka_show_cluster_nodes:
	@$(INFO) '$(KKA_UI_LABEL)Showing the nodes of cluster "$(KKA_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the cluster is not in ACTIVE state'; $(NORMAL)
	-$(AWS) kafka list-nodes $(__KKA_CLUSTER_ARN) --query "NodeInfoList[]"

_kka_show_cluster_operations:
	@$(INFO) '$(KKA_UI_LABEL)Showing operations on cluster "$(KKA_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the cluster is not in ACTIVE state'; $(NORMAL)
	-$(AWS) kafka list-cluster-operations $(__KKA_CLUSTER_ARN) # --query "NodeInfoList[]"

_kka_show_cluster_tags:
	@$(INFO) '$(KKA_UI_LABEL)Showing tags of cluster "$(KKA_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) kafka list-tags-for-resource $(__KKA_RESOURCE_ARN__CLUSTER) --query "Tags[]"

_kka_tag_cluster:
	@$(INFO) '$(KKA_UI_LABEL)Tagging cluster "$(KKA_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) kafka tag-resource $(__KKA_RESOURCE_ARN__CLUSTER) $(__KKA_TAGS__CLUSTER)

_kka_untag_cluster:
	@$(INFO) '$(KKA_UI_LABEL)Untagging cluster "$(KKA_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) kafka untag-resource $(__KKA_RESOURCE_ARN__CLUSTER) $(__KKA_TAGS__CLUSTER)

_kka_update_cluster_brokernodecount:
	@$(INFO) '$(KKA_UI_LABEL)Updating the broker-node-count of cluster "$(KKA_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) kafka update-cluster-broker-count $(__KKA_CLUSTER_ARN) $(__KKA_CURRENT_VERSION) $(__KKA_TARGET_NUMBER_OF_BROKER_NODES)

_kka_update_cluster_brokernodestorage:
	@$(INFO) '$(KKA_UI_LABEL)Updating the broker-node-storage of cluster "$(KKA_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) kafka update-broker-storage $(__KKA_CLUSTER_ARN) $(__KKA_CURRENT_VERSION) $(__KKA_TARGET_BROKER_EBS_VOLUME_INFO)

_kka_update_cluster_brokernodetype:
	@$(INFO) '$(KKA_UI_LABEL)Updating the broker-node-type used in cluster "$(KKA_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) kafka update-broker-type $(__KKA_CLUSTER_ARN) $(__KKA_CURRENT_VERSION) $(__KKA_TARGET_KAFKA_VERSION)

_kka_update_cluster_kafkaversion:
	@$(INFO) '$(KKA_UI_LABEL)Updating kafka-version of cluster "$(KKA_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) kafka update-cluster-kafka-version $(__KKA_CLUSTER_ARN) $(__KKA_CONFIGURATION_INFO) $(__KKA_CURRENT_VERSION) $(__KKA_TARGET_KAFKA_VERSION)

_kka_view_clusters:
	@$(INFO) '$(KKA_UI_LABEL)Viewing clusters ...'; $(NORMAL)
	$(AWS) kafka list-clusters $(_X__KKA_CLUSTER_NAME_FILTER) --query "ClusterInfoList[]$(KKA_UI_VIEW_CLUSTERS_FIELDS)"

_kka_view_clusters_set:
	@$(INFO) '$(KKA_UI_LABEL)Viewing clusters-set "$(KKA_CLUSTERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Clusters are grouped based on name-filter and slice'; $(NORMAL)
	$(AWS) kafka list-clusters $(__KKA_CLUSTER_NAME_FILTER) --query "ClusterInfoList[$(KKA_UI_VIEW_CLUSTERS_SET_SLICE)]$(KKA_UI_VIEW_CLUSTERS_SET_FIELDS)"
