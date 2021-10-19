_AWS_ES_DOMAIN_MK_VERSION= $(_AWS_ES_MK_VERSION)

# ES_DOMAIN_ACCESS_POLICIES?= '{ "Version":"2012-10-17", "Statement":[{"Effect":"Allow","Principal":{"AWS": ["arn:aws:iam::123456789012:role/Cognito_Auth_Role"]},"Action":"es:ESHttp*","Resource":"arn:aws:es:us-east-1:123456789012:domain/*" }]}'
# ES_DOMAIN_ADVANCED_OPTIONS?= rest.action.multi.allow_explicit_index=true ...
# ES_DOMAIN_ARN?= arn:aws:es:us-west-1:123456789012:domain/machine-data
# ES_DOMAIN_COGNITO_OPTIONS?= Enabled=boolean,UserPoolId=string,IdentityPoolId=string,RoleArn=string
# ES_DOMAIN_EBS_OPTIONS?= EBSEnabled=boolean,VolumeType=string,VolumeSize=integer,Iops=integer
# ES_DOMAIN_ELASTICSEARCH_CLUSTER_CONFIG?= InstanceType=string,InstanceCount=integer,DedicatedMasterEnabled=boolean,ZoneAwarenessEnabled=boolean,DedicatedMasterType=string,DedicatedMasterCount=integer
# ES_DOMAIN_ELASTICSEARCH_VERSION?= 6.3
# ES_DOMAIN_ENCRYPTION_AT_REST_OPTIONS?= Enabled=boolean,KmsKeyId=string
# ES_DOMAIN_ENDPOINT?= search-allspark-staging-xzh7meydfffap2p4dkza5pmmgi.us-west-2.es.amazonaws.com
ES_DOMAIN_ENDPOINT_PROTOCOL?= https
# ES_DOMAIN_ENDPOINT_URL?= https://search-allspark-staging-xzh7meydfffap2p4dkza5pmmgi.us-west-2.es.amazonaws.com
# ES_DOMAIN_INSTANCE_TYPE?= m4.large.elasticsearch
# ES_DOMAIN_LOG_PUBLISHING_OPTIONS?= SEARCH_SLOW_LOGS={CloudWatchLogsLogGroupArn=arn:aws:logs:us-east-1:123456789012:log-group:my-log-group,Enabled=true},INDEX_SLOW_LOGS={CloudWatchLogsLogGroupArn=arn:aws:logs:us-east-1:123456789012:log-group:my-other-log-group,Enabled=true}
# ES_DOMAIN_NAME?= my_domain
# ES_DOMAIN_SNAPSHOT_OPTIONS?= AutomatedSnapshotStartHour=integer
# ES_DOMAIN_TAGS_KEYS?= FirstName LastName
# ES_DOMAIN_TAGS_KEYVALUES?= Key=FirstName,Value=Emmanuel Key=LastName,Value=Mayssat
# ES_DOMAIN_VPC_OPTIONS?= SubnetIds=string,string,SecurityGroupIds=string,string
# ES_DOMAINS_NAMES?= my-domain ...
# ES_DOMAINS_SET_NAME?= my-domain-set

# Derived variables
ES_DOMAIN_ELASTICSEARCH_VERSION?= $(ES_ELASTICSEARCH_VERSION)
ES_DOMAIN_ENDPOINT_URL?= $(if $(ES_DOMAIN_ENDPOINT),$(ES_DOMAIN_ENDPOINT_PROTOCOL)://$(ES_DOMAIN_ENDPOINT))
ES_DOMAINS_NAMES?= $(ES_DOMAIN_NAME)

# Options
__ES_ADVANCED_OPTIONS= $(if $(ES_DOMAIN_ADVANCED_OPTIONS), --advanced-options $(subst $(SPACE),$(COMMA),$(ES_DOMAIN_ADVANCED_OPTIONS)))
__ES_ACCESS_POLICIES= $(if $(ES_DOMAIN_ACCESS_POLICIES), --access-policies $(ES_DOMAIN_ACCESS_POLICIES))
__ES_ARN__DOMAIN= $(if $(ES_DOMAIN_ARN), --arn $(ES_DOMAIN_ARN))
__ES_COGNITO_OPTIONS= $(if $(ES_DOMAIN_COGNITO_OPTIONS), --cognito-options $(ES_DOMAIN_COGNITO_OPTIONS))
__ES_DOMAIN_NAME= $(if $(ES_DOMAIN_NAME), --domain-name $(ES_DOMAIN_NAME))
__ES_DOMAIN_NAMES= $(if $(ES_DOMAINS_NAMES), --domain-names $(ES_DOMAINS_NAMES))
__ES_EBS_OPTIONS= $(if $(ES_DOMAIN_EBS_OPTIONS), --ebs-options $(ES_DOMAIN_EBS_OPTIONS))
__ES_ELASTICSEARCH_CLUSTER_CONFIG= $(if $(ES_DOMAIN_ELASTICSEARCH_CLUSTER_CONFIG), --elasticsearch-cluster-config $(subst $(SPACE),$(COMMA),$(ES_DOMAIN_ELASTICSEARCH_CLUSTER_CONFIG)))
__ES_ELASTICSEARCH_VERSION__DOMAIN= $(if $(ES_DOMAIN_ELASTICSEARCH_VERSION), --elasticsearch-version $(ES_DOMAIN_ELASTICSEARCH_VERSION))
__ES_ENCRYPTION_AT_REST_OPTIONS= $(if $(ES_DOMAIN_ENCRYPTION_AT_REST_OPTIONS), --encryption-at-rest-options $(ES_DOMAIN_ENCRYPTION_AT_REST_OPTIONS))
__ES_INSTANCE_TYPE__DOMAIN= $(if $(ES_DOMAIN_INSTANCE_TYPE), --instance-type $(ES_DOMAIN_INSTANCE_TYPE))
__ES_LOG_PUBLISHING_OPTIONS= $(if $(ES_DOMAIN_LOG_PUBLISHING_OPTIONS), --log-publishing-options $(ES_DOMAIN_LOG_PUBLISHING_OPTIONS))
__ES_NODE_TO_NODE_ENCRYPTION_OPTIONS=
__ES_SNAPSHOT_OPTIONS= $(if $(ES_DOMAIN_SNAPSHOT_OPTIONS), --snapshot-options $(ES_DOMAIN_SNAPSHOT_OPTIONS))
__ES_TAG_KEYS__DOMAIN= $(if $(ES_DOMAIN_TAGS_KEYS), --tag-keys $(ES_DOMAIN_TAGS_KEYS))
__ES_TAG_LIST= $(if $(ES_DOMAIN_TAGS_KEYVALUES), --tag-list $(ES_DOMAIN_TAGS_KEYVALUES))
__ES_VPC_OPTIONS= $(if $(ES_DOMAIN_VPC_OPTIONS), --vpc-options $(ES_DOMAIN_VPC_OPTIONS))

# UI variables
ES_VIEW_DOMAINS_SET_FIELDS?= .{DomainName:DomainName,ElasticsearchVersion:ElasticsearchVersion,Endpoint:Endpoint}

#--- Utilities

#--- Macros

_es_get_domain_arn= $(call _es_get_domain_arn_N, $(ES_DOMAIN_NAME))
_es_get_domain_arn_N= $(shell $(AWS) es describe-elasticsearch-domain --domain-name $(1) --query "DomainStatus.ARN" --output text)

_es_get_domain_endpoint= $(call _es_get_domain_endpoint_N, $(ES_DOMAIN_NAME))
_es_get_domain_endpoint_N= $(shell $(AWS) es describe-elasticsearch-domain --domain-name $(1) --query "DomainStatus.Endpoint" --output text)

_es_get_domains_names= $(shell $(AWS) es list-domain-names --query "DomainNames[].DomainName" --output text)

#----------------------------------------------------------------------
# USAGE
#

_es_view_framework_macros ::
	@echo 'AWS::ElasticSearch::Domain ($(_AWS_ES_DOMAIN_MK_VERSION)) macros:' 
	@echo '    _es_get_domain_arn_{|N}                  - Get the arn of an ES domain (Name)'
	@echo '    _es_get_domain_endpoint_{|N}             - Get the endpoint of an ES domain (Name)'
	@echo '    _es_get_domains_names                    - Get all domain names in current region'
	@echo

_es_view_framework_parameters ::
	@echo 'AWS::ElasticSearch::Domain ($(_AWS_ES_DOMAIN_MK_VERSION)) parameters:'
	@echo '    ES_DOMAIN_ACCESS_POLICIES=$(ES_DOMAIN_ACCESS_POLICIES)'
	@echo '    ES_DOMAIN_ADVANCED_OPTIONS=$(ES_DOMAIN_ADVANCED_OPTIONS)'
	@echo '    ES_DOMAIN_ARN=$(ES_DOMAIN_ARN)'
	@echo '    ES_DOMAIN_COGNITO_OPTIONS=$(ES_DOMAIN_COGNITO_OPTIONS)'
	@echo '    ES_DOMAIN_EBS_OPTIONS=$(ES_DOMAIN_EBS_OPTIONS)'
	@echo '    ES_DOMAIN_ELASTICSEARCH_CLUSTER_CONFIG=$(ES_DOMAIN_ELASTICSEARCH_CLUSTER_CONFIG)'
	@echo '    ES_DOMAIN_ELASTICSEARCH_VERSION=$(ES_DOMAIN_ELASTICSEARCH_VERSION)'
	@echo '    ES_DOMAIN_ENCRYPTION_AT_REST_OPTIONS=$(ES_DOMAIN_ENCRYPTION_AT_REST_OPTIONS)'
	@echo '    ES_DOMAIN_ENDPOINT=$(ES_DOMAIN_ENDPOINT)'
	@echo '    ES_DOMAIN_ENDPOINT_PROTOCOL=$(ES_DOMAIN_ENDPOINT_PROTOCOL)'
	@echo '    ES_DOMAIN_ENDPOINT_URL=$(ES_DOMAIN_ENDPOINT_URL)'
	@echo '    ES_DOMAIN_INSTANCE_TYPE=$(ES_DOMAIN_INSTANCE_TYPE)'
	@echo '    ES_DOMAIN_LOG_PUBLISHING_OPTIONS=$(ES_DOMAIN_LOG_PUBLISHING_OPTIONS)'
	@echo '    ES_DOMAIN_NAME=$(ES_DOMAIN_NAME)'
	@echo '    ES_DOMAIN_SNAPSHOT_OPTIONS=$(ES_DOMAIN_SNAPSHOT_OPTIONS)'
	@echo '    ES_DOMAIN_TAGS_KEYS=$(ES_DOMAIN_TAGS_KEYS)'
	@echo '    ES_DOMAIN_TAGS_KEYVALUES=$(ES_DOMAIN_TAGS_KEYVALUES)'
	@echo '    ES_DOMAIN_VPC_OPTIONS=$(ES_DOMAIN_VPC_OPTIONS)'
	@echo '    ES_DOMAINS_NAMES=$(ES_DOMAINS_NAMES)'
	@echo '    ES_DOMAINS_SET_NAME=$(ES_DOMAINS_SET_NAME)'
	@echo

_es_view_framework_targets ::
	@echo 'AWS::ElasticSearch::Domain ($(_AWS_ES_DOMAIN_MK_VERSION)) targets:' 
	@echo '    _es_create_domain                   - Create a new ES domain'
	@echo '    _es_delete_domain                   - Delete an existing ES domain'
	@echo '    _es_start_local_proxy               - Start a local signature 4 proxy to an ES cluster'
	@echo '    _es_show_domain                     - Show details of a given ES domain'
	@echo '    _es_show_domain_description         - Show description of a given ES domain'
	@echo '    _es_show_domain_config              - Show config of a given ES domain'
	@echo '    _es_show_domain_instancetypes       - Show instance-types for a domain'
	@echo '    _es_show_domain_instancelimits      - Show instance-limits of a domain'
	@echo '    _es_show_tags                       - Show tags attached to a given domain'
	@echo '    _es_tag_domain                      - Tag an ES domain'
	@echo '    _es_untag_domain                    - Untag an ES domain'
	@echo '    _es_update_domain_config            - Update the configuration of a given ES domain'
	@echo '    _es_view_domains                    - View all ES domains'
	@echo '    _es_view_domains_set                - View a set of domains'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_es_create_domain:
	@$(INFO) '$(AWS_UI_LABEL)Creating ES domain "$(ES_DOMAIN_NAME)" ...'; $(NORMAL)
	$(AWS) es create-elasticsearch-domain $(strip $(__ES_ACCESS_POLICIES) $(__ES_ADVANCED_OPTIONS) $(__ES_COGNITO_OPTIONS) $(__ES_DOMAIN_NAME) $(__ES_EBS_OPTIONS) $(__ES_ELASTICSEARCH_CLUSTER_CONFIG) $(__ES_ELASTICSEARCH_VERSION__DOMAIN) $(__ES_ENCRYPTION_AT_REST_OPTIONS) $(__ES_LOG_PUBLISHING_OPTIONS) $(__ES_NODE_TO_NODE_ENCRYPTION_OPTIONS) $(__ES_SNAPSHOT_OPTIONS) $(__ES_VPC_OPTIONS) )

_es_delete_domain:
	@$(INFO) '$(AWS_UI_LABEL)Deleting ES domain "$(ES_DOMAIN_NAME)" ...'; $(NORMAL)
	$(AWS) es delete-elasticsearch-domain $(__ES_DOMAIN_NAME)

_es_show_domain: _es_show_domain_config _es_show_domain_instancetypes _es_show_domain_instancelimits _es_show_domain_tags _es_show_domain_description

_es_show_domain_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing details of ES domain "$(ES_DOMAIN_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The domain endpoint will be available once processing reports "false"'; $(NORMAL)
	$(AWS) es describe-elasticsearch-domain $(__ES_DOMAIN_NAME)

_es_show_domain_config:
	@$(INFO) '$(AWS_UI_LABEL)Showing config of ES domain "$(ES_DOMAIN_NAME)" ...'; $(NORMAL)
	$(AWS) es describe-elasticsearch-domain-config $(__ES_DOMAIN_NAME)

_es_show_domain_instancetypes:
	@$(INFO) "$(AWS_UI_LABEL)View available instance-types for ES version '$(ES_ELASTICSEARCH_VERSION)' ..."; $(NORMAL)
	$(AWS) es list-elasticsearch-instance-types $(__ES_DOMAIN_NAME) $(__ES_ELASTICSEARCH_VERSION__DOMAIN)

_es_show_domain_instancelimits:
	@$(INFO) '$(AWS_UI_LABEL)Show the current-instance-type limits for ES version "$(ES_ELASTICSEARCH_VERSION)" ...'; $(NORMAL)
	$(AWS) es describe-elasticsearch-instance-type-limits $(__ES_DOMAIN_NAME) $(__ES_ELASTICSEARCH_VERSION__DOMAIN) $(__ES_INSTANCE_TYPE__DOMAIN)

_es_show_domain_tags:
	@$(INFO) '$(AWS_UI_LABEL)Showing tags of domain "$(ES_DOMAIN_NAME)" ...'; $(NORMAL)
	$(AWS) es list-tags $(__ES_ARN__DOMAIN)

_es_tag_domain:
	@$(INFO) '$(AWS_UI_LABEL)Tagging ES domain "$(ES_DOMAIN_NAME)" ...'; $(NORMAL)
	$(AWS) es add-tags $(__ES_ARN__DOMAIN) $(__ES_TAG_LIST)

_es_untag_domain:
	@$(INFO) '$(AWS_UI_LABEL)Untagging ES domain "$(ES_DOMAIN_NAME)" ...'; $(NORMAL)
	$(AWS) es remove-tags $(__ES_ARN__DOMAIN) $(__ES_TAG_KEYS__DOMAIN)

_es_update_domain_config:
	@$(INFO) '$(AWS_UI_LABEL)Updating configuration of ES domain "$(ES_DOMAIN_NAME)" ...'; $(NORMAL)
	$(AWS) es update-elasticsearch-domain-config $(__ES_ACCESS_POLICIES) $(__ES_ADVANCED_OPTIONS) $(__ES_DOMAIN_NAME) $(ES_EBS_OPTIONS) $(__ES_ELASTICSEARCH_CLUSTER_CONFIG) $(LOG_PUBLISHING_OPTIONS) $(__ES_SNAPSHOT_OPTIONS) $(__ES_VPC_OPTIONS)

_es_view_domains:
	@$(INFO) '$(AWS_UI_LABEL)View all elasticsearch domains ...'; $(NORMAL)
	$(AWS) es list-domain-names

_es_view_domains_set:
	@$(INFO) '$(AWS_UI_LABEL)View domains-set "$(ES_DOMAINS_SET_NAME)" ...'; $(NORMAL)
	$(AWS) es describe-elasticsearch-domains $(__ES_DOMAIN_NAMES) --query "DomainStatusList[]$(ES_VIEW_DOMAINS_SET_FIELDS)"
