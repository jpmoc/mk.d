_AWS_ELB_LOADBALANCER_MK_VERSION= $(_AWS_ELB_MK_VERSION)

# ELB_LOADBALANCER_ACCESSLOG_BUCKETNAME?= 123456789012-elbs
# ELB_LOADBALANCER_ACCESSLOG_FLAG?= false
# ELB_LOADBALANCER_AVAILABILITYZONES_IDS?= us-west-2a ...
# ELB_LOADBALANCER_DNSNAME?= a7ca6959a63414d089304ddd314b1548-1547877846.us-east-1.elb.amazonaws.com
# ELB_LOADBALANCER_DNSNAME_UID?= 1234567890
# ELB_LOADBALANCER_INSTANCES_IDS?= i-0ccbeb3919f02ca43 ...
# ELB_LOADBALANCER_LISTENERS_CONFIGS?= Protocol=string,LoadBalancerPort=integer,InstanceProtocol=string,InstancePort=integer,SSLCertificateId=string ...
# ELB_LOADBALANCER_NAME?= my-load-balancer
# ELB_LOADBALANCER_SCHEME?= internet-facing
# ELB_LOADBALANCER_SECURITYGROUPS_IDS?= sg-123456789012 ...
# ELB_LOADBALANCER_SUBNETS_IDS?= subnet-12345678901234567 ...
# ELB_LOADBALANCER_TAGS_KEYVALUES?=
# ELB_LOADBALANCER_VPC_ID?= vpc-12345678901234567
# ELB_LOADBALANCERS_NAMES?=
# ELB_LOADBALANCERS_SET_NAME?=

# Derived parameters
ELB_LOADBALANCER_DNSNAME?= $(if $(ELB_LOADBALANCER_DNSNAME_UID),$(ELB_LOADBALANCER_NAME)-$(ELB_LOADBALANCER_DNSNAME_UID).$(ELB_REGION_ID).elb.amazonaws.com)
ELB_LOADBALANCERS_NAMES?= $(ELB_LOADBALANCER_NAME)

# Option parameters
__ELB_AVAILABILITY_ZONES= $(if $(ELB_LOADBALANCER_AVAILABILITYZONES_IDS),--availability-zones $(ELB_LOADBALANCER_AVAILABILITYZONES_IDS))
__ELB_GROUP_IDS= $(if $(ELB_LOADBALANCER_SECURITYGROUPS_IDS),--group-ids $(ELB_LOADBALANCER_SECURITYGROUPS_IDS))
__ELB_LISTENERS= $(if $(ELB_LOADBALANCER_LISTENERS_CONFIGS),--listeners $(ELB_LOADBALANCER_LISTENERS_CONFIGS))
__ELB_LOAD_BALANCER_NAME= $(if $(ELB_LOADBALANCER_NAME),--load-balancer-name $(ELB_LOADBALANCER_NAME))
__ELB_LOAD_BALANCER_NAMES__LOADBALANCER= $(if $(ELB_LOADBALANCER_NAME),--load-balancer-names $(ELB_LOADBALANCER_NAME))
__ELB_LOAD_BALANCER_NAMES__LOADBALANCERS= $(if $(ELB_LOADBALANCERS_NAMES),--load-balancer-names $(ELB_LOADBALANCERS_NAMES))
__ELB_NAME__LOADBALANCER= $(if $(ELB_LOADBALANCER_NAME),--name $(ELB_LOADBALANCER_NAME))
__ELB_SCHEME= $(if $(ELB_LOADBALANCER_SCHEME),--scheme $(ELB_LOADBALANCER_SCHME))
__ELB_SECURITY_GROUPS= $(if $(ELB_LOADBALANCER_SECURITYGROUPS_IDS),--security-groups $(ELB_LOADBALANCER_SECURITYGROUPS_IDS))
__ELB_SUBNETS= $(if $(ELB_LOADBALANCER_SUBNETS_IDS),--subnets $(ELB_LOADBALANCER_SUBNETS_IDS))
__ELB_TAGS__LOADBALANCER= $(if $(ELB_LOADBALANCER_TAGS_KEYVALUES),--tags $(ELB_LOADBALANCER_TAGS_KEYVALUES))

# UI parameters
ELB_UI_VIEW_LOADBALANCERS_FIELDS?= .{LoadBalancerName:LoadBalancerName,dnsName:DNSName,scheme:Scheme,vpcId:VPCId}
ELB_UI_VIEW_LOADBALANCERS_SET_FIELDS?= $(ELB_UI_VIEW_LOADBALANCERS_FIELDS)
ELB_UI_VIEW_LOADBALANCERS_SET_QUERYFILTER?=

#--- Pipes
|_ELB_SHOW_LOADBALANCER_IPS?= | sort

#--- MACROS

_elb_get_loadbalancer_id= $(call _elb_get_loadbalancer_id_N, $(ELB_LOADBALANCER_NAME))
_elb_get_loadbalancer_id_N= $(call _elb_get_loadbalancer_id_NO, $(1), $(ELB_LOADBALANCER_ORGANIZATION_ID))
_elb_get_loadbalancer_id_NO= "$(shell $(AWS) elb list-loadbalancers --organization-id $(2) --query "Users[?Name=='$(strip $(1))'].Id" --output text)"

_elb_get_loadbalancer_instances_ids= $(call _elb_get_loadbalancer_instances_ids_N, $(ELB_LOADBALANCER_NAME))
_elb_get_loadbalancer_instances_ids_N= $(shell $(AWS) elb describe-load-balancers --load-balancer-names $(1) --query "LoadBalancerDescriptions[].Instances[]" --output text)

_elb_get_loadbalancer_securitygroups_ids= $(call _elb_get_loadbalancer_securitygroups_ids_N, $(ELB_LOADBALANCER_NAME))
_elb_get_loadbalancer_securitygroups_ids_N= $(shell $(AWS) elb describe-load-balancers --load-balancer-names $(1) --query "LoadBalancerDescriptions[].SecurityGroups[]" --output text)

_elb_get_loadbalancer_subnets_ids= $(call _elb_get_loadbalancer_subnets_ids_N, $(ELB_LOADBALANCER_NAME))
_elb_get_loadbalancer_subnets_ids_N= $(shell $(AWS) elb describe-load-balancers --load-balancer-names $(1) --query "LoadBalancerDescriptions[].Subnets[]" --output text)

_elb_get_loadbalancer_vpc_id= $(call _elb_get_loadbalancer_vpc_id_N, $(ELB_LOADBALANCER_NAME))
_elb_get_loadbalancer_vpc_id_N= $(shell $(AWS) elb describe-load-balancers --load-balancer-names $(1) --query "LoadBalancerDescriptions[].VPCId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_elb_view_framework_macros ::
	@echo 'AWS::ElasticLoadBalancer::LoadBalancer ($(_AWS_ELB_LOADBALANCER_MK_VERSION)) macros:'
	@echo '    _elb_get_loadbalancer_id_{|N|NO}                     - Get the ID of a loadbalancer (Name,OrganizationId)'
	@echo '    _elb_get_loadbalancer_instances_ids_{|N}             - Get the instance IDs of a loadbalancer (Name)'
	@echo '    _elb_get_loadbalancer_securitygroups_ids_{|N}        - Get the security-group IDs of a loadbalancer (Name)'
	@echo '    _elb_get_loadbalancer_subnets_ids_{|N}               - Get the subnet IDs of a loadbalancer (Name)'
	@echo '    _elb_get_loadbalancer_vpc_id_{|N}                    - Get the vpc ID of a loadbalancer (Name)'
	@echo

_elb_view_framework_parameters ::
	@echo 'AWS::ElasticLoadBalancer::LoadBalancer ($(_AWS_ELB_LOADBALANCER_MK_VERSION)) parameters:'
	@echo '    ELB_LOADBALANCER_ACCESSLOG_BUCKETNAME=$(ELB_LOADBALANCER_ACCESSLOG_BUCKETNAME)'
	@echo '    ELB_LOADBALANCER_ACCESSLOG_FLAG=$(ELB_LOADBALANCER_ACCESSLOG_FLAG)'
	@echo '    ELB_LOADBALANCER_AVAILABILITYZONES_IDS=$(ELB_LOADBALANCER_AVAILABILITYZONES_IDS)'
	@echo '    ELB_LOADBALANCER_DNSNAME=$(ELB_LOADBALANCER_DNSNAME)'
	@echo '    ELB_LOADBALANCER_DNSNAME_UID=$(ELB_LOADBALANCER_DNSNAME_UID)'
	@echo '    ELB_LOADBALANCER_INSTANCES_IDS=$(ELELBOADBALANCER_INSTANCES_IDS)'
	@echo '    ELB_LOADBALANCER_LISTENERS_CONFIGS=$(ELELBOADBALANCER_LISTENERS_CONFIGS)'
	@echo '    ELB_LOADBALANCER_NAME=$(ELB_LOADBALANCER_NAME)'
	@echo '    ELB_LOADBALANCER_SCHEME=$(ELB_LOADBALANCER_SCHEME)'
	@echo '    ELB_LOADBALANCER_SECURITYGROUPS_IDS=$(ELB_LOADBALANCER_SECURITYGROUPS_IDS)'
	@echo '    ELB_LOADBALANCER_SUBNETS_IDS=$(ELB_LOADBALANCER_SUBNETS_IDS)'
	@echo '    ELB_LOADBALANCER_TAGS_KEYVALUES=$(ELB_LOADBALANCER_TAGS_KEYVALUES)'
	@echo '    ELB_LOADBALANCER_VPC_ID=$(ELB_LOADBALANCER_VPC_ID)'
	@echo '    ELB_LOADBALANCERS_NAMES=$(ELB_LOADBALANCER_NAMES)'
	@echo '    ELB_LOADBALANCERS_SET_NAME=$(ELB_LOADBALANCERS_SET_NAME)'
	@echo

_elb_view_framework_targets ::
	@echo 'AWS::ElasticLoadBalancer::LoadBalancer ($(_AWS_ELB_LOADBALANCER_MK_VERSION)) targets:'
	@echo '    _elb_create_loadbalancer                           - Create a load-balancer'
	@echo '    _elb_delete_loadbalancer                           - Delete an existing load-balancer'
	@echo '    _elb_show_loadbalancer                             - Show everything related to a load-balancer'
	@echo '    _elb_show_loadbalancer_attributes                  - Show attributes of a load-balancer'
	@echo '    _elb_show_loadbalancer_description                 - Show description of a load-balancer'
	@echo '    _elb_show_loadbalancer_instances                   - Show instances of a load-balancer'
	@echo '    _elb_show_loadbalancer_policies                    - Show policies of a load-balancer'
	@echo '    _elb_show_loadbalancer_securitygroups              - Show security-groups of a load-balancer'
	@echo '    _elb_view_loadbalancers                            - View all load-balancers'
	@echo '    _elb_view_loadbalancers_set                        - View a set of load-balancers'
	@echo '    _elb_watch_loadbalancers                           - Watch all load-balancers'
	@echo '    _elb_watch_loadbalancers_set                       - Watch a set of load-balancers'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_elb_create_loadbalancer:
	@$(INFO) '$(ELB_UI_LABEL)Creating load-balancer "$(ELB_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(AWS) elb create-load-balancer $(__ELB_AVAILABILITY_ZONES) $(__ELB_LISTENERS) $(__ELB_NAME__LOADBALANCER) $(__ELB_SCHEME) $(__ELB_SECURITY_GROUPS) $(__ELB_SUBNETS) $(__ELB_TAGS__LOADBALANCER)

_elb_delete_loadbalancer:
	@$(INFO) '$(ELB_UI_LABEL)Deleting load-balancer "$(ELB_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(AWS) elb delete-load-balancer $(__ELB_LOADBALANCER_NAME)

_elb_show_loadbalancer: _elb_show_loadbalancer_attributes _elb_show_loadbalancer_instances _elb_show_loadbalancer_ips _elb_show_loadbalancer_policies _elb_show_loadbalancer_securitygroups _elb_show_loadbalancer_sourcesecuritygroup _elb_show_loadbalancer_description

_elb_show_loadbalancer_attributes:
	@$(INFO) '$(ELB_UI_LABEL)Showing attributes of load-balancer "$(ELB_LOADBALANCER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As far as I can tell, the LB is completely transparent when using HTTPS'; $(NORMAL)
	@$(WARN) 'It appears that the backend also lose the origin IP or the request'; $(NORMAL)
	$(AWS) elb describe-load-balancer-attributes $(__ELB_LOAD_BALANCER_NAME) --query "LoadBalancerAttributes"

_elb_show_loadbalancer_description:
	@$(INFO) '$(ELB_UI_LABEL)Showing description of load-balancer "$(ELB_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(AWS) elb describe-load-balancers $(__ELB_LOAD_BALANCER_NAMES__LOADBALANCER) --query "LoadBalancerDescriptions[]"

_elb_show_loadbalancer_instances:
	@$(INFO) '$(ELB_UI_LABEL)Showing backend-instances of load-balancer "$(ELB_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(if $(ELB_LOADBALANCER_INSTANCES_IDS), \
		@echo 'ELB_LOADBALANCER_INSTANCES_IDS=$(ELB_LOADBALANCER_INSTANCES_IDS)', \
		@echo 'ELB_LOADBALANCER_INSTANCES_IDS not set' \
	)

_elb_show_loadbalancer_ips:
	@$(INFO) '$(ELB_UI_LABEL)Showing IPs of load-balancer "$(ELB_LOADBALANCER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Beware the IPs of the loadbalancer can change over its lifetime'; $(NORMAL)
	$(if $(ELB_LOADBALANCER_DNSNAME), \
		dig +short $(ELB_LOADBALANCER_DNSNAME) $(|_ELB_SHOW_LOADBALANCER_IPS), \
		@echo 'ELB_LOADBALANCER_DNSNAME not set ...' \
	)

_elb_show_loadbalancer_policies:
	@$(INFO) '$(ELB_UI_LABEL)Showing policies of load-balancer "$(ELB_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(AWS) elb describe-load-balancer-policies $(__ELB_LOAD_BALANCER_NAME) --query "PoliciesDescriptions[]"

_elb_show_loadbalancer_securitygroups:
	@$(INFO) '$(ELB_UI_LABEL)Showing security-groups of load-balancer "$(ELB_LOADBALANCER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Security-groups allow inbound connections to listener-ports from source IPs'; $(NORMAL)
	@$(WARN) 'IpPermissions --> Ingress-rules          IpPermissionsEgress --> Egress-rules'; $(NORMAL)
	$(if $(ELB_LOADBALANCER_SECURITYGROUPS_IDS), \
		$(AWS) ec2 describe-security-groups $(__ELB_GROUP_IDS) --query "SecurityGroups[]", \
		@echo 'ELB_LOADBALANCER_SECURITYGROUPS_IDS not set' \
	)

_elb_show_loadbalancer_sourcesecuritygroup:
	@$(INFO) '$(ELB_UI_LABEL)Showing SOURCE-security-group of load-balancer "$(ELB_LOADBALANCER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This security group is used as a source in the security-groups of the nodegroups/backends'; $(NORMAL)
	@echo 'ELB_LOADBALANCER_SOURCESECURITYGROUP_ID not set'

_elb_tag_loadbalancer:
	@$(INFO) '$(ELB_UI_LABEL)Tagging load-balancer "$(ELB_LOADBALANCER_NAME)" ...'; $(NORMAL)

_elb_untag_loadbalancer:
	@$(INFO) '$(ELB_UI_LABEL)Un-tagging load-balancer "$(ELB_LOADBALANCER_NAME)" ...'; $(NORMAL)

_elb_view_loadbalancers:
	@$(INFO) '$(ELB_UI_LABEL)Viewing ALL load-balancers ...'; $(NORMAL)
	$(AWS) elb describe-load-balancers $(_X__ELB_LOAD_BALANCER_NAMES__LOADBALANCERS) --query "LoadBalancerDescriptions[]$(ELB_UI_VIEW_LOADBALANCERS_FIELDS)"

_elb_view_loadbalancers_set:
	@$(INFO) '$(ELB_UI_LABEL)Viewing load-balancers-set "$(ELB_LOADBALANCERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Users are grouped based on the provided names and slice'; $(NORMAL)
	$(AWS) elb list-load-balancers $(__ELB_LOAD_BALANCER_NAMES__LOADBALANCERS)  --query "LoadBalancers[$(ELB_UI_VIEW_LOADBALANCERS_SET_QUERYFILTER)]$(ELB_UI_VIEW_LOADBALANCERS_SET_FIELDS)"

_elb_watch_loadbalancers:
	@$(INFO) '$(ELB_UI_LABEL)Watching ALL load-balancers ...'; $(NORMAL)

_elb_watch_loadbalancers_set:
	@$(INFO) '$(ELB_UI_LABEL)Watching load-balancers-set "$(ELB_LOADBALANCERS_SET_NAME)" ...'; $(NORMAL)
