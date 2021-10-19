_AWS_ELBV2_LOADBALANCER_MK_VERSION= $(_AWS_ELBV2_MK_VERSION)

# ELB2_LOADBALANCER_ALIASNAME?= entrypoint.east.domain.com
# ELB2_LOADBALANCER_ALIASNAME_DOMAIN?= domain.com
# ELB2_LOADBALANCER_ALIASNAME_HOSTNAME?= entrypoint
# ELB2_LOADBALANCER_ALIASNAME_SUBDOMAIN?= east.domain.com
# ELB2_LOADBALANCER_ARN?=
ELB2_LOADBALANCER_CURL?= $(AWS_CURL)
ELB2_LOADBALANCER_DIG?= $(AWS_DIG)
# ELB2_LOADBALANCER_DNSNAME?=
ELB2_LOADBALANCER_DNSNAME_DOMAIN?= elb.amazonaws.com
# ELB2_LOADBALANCER_DNSNAME_HOSTNAME?= loadbalancer-XXXXX
# ELB2_LOADBALANCER_DNSNAME_SUBDOMAIN?= us-east-1.elb.amazonaws.com
# ELB2_LOADBALANCER_DNSNAME_UID?=
# ELB2_LOADBALANCER_IPADDRESS_POOL?= outpost
# ELB2_LOADBALANCER_IPADDRESSES?= 1.1.1.1 ...
ELB2_LOADBALANCER_IPADDRESS_TYPE?= ipv4
# ELB2_LOADBALANCER_NAME?=
# ELB2_LOADBALANCER_REGION_ID?= us-east-1
ELB2_LOADBALANCER_SCHEME?= internet-facing
# ELB2_LOADBALANCER_SECURITYGROUPS_IDS?=
# ELB2_LOADBALANCER_SECURITYGROUPS_IDS_OR_NAME?=
# ELB2_LOADBALANCER_SECURITYGROUPS_NAMES?=
# ELB2_LOADBALANCER_SUBNETS_IDS?= subnet-12345678901234567 ...
# ELB2_LOADBALANCER_SUBNETMAPPINGS_CONFIGS?= SubnetId=string,AllocationId=string,PrivateIPv4Address=string,IPv6Address=string ...
# ELB2_LOADBALANCER_TAGS_KEYVALUES?= Key=string,Value=string ...
# ELB2_LOADBALANCER_TYPE?= network
# ELB2_LOADBALANCER_URL?= https://entrypoint.east.domain.com:443/my/path
# ELB2_LOADBALANCER_URL_DNSNAME?= entrypoint.east.domain.com
# ELB2_LOADBALANCER_URL_PATH?= /my/path
# ELB2_LOADBALANCER_URL_PORT?= :443
# ELB2_LOADBALANCER_URL_PROTOCOL?= https://
# ELB2_LOADBALANCER_VPC_ID?= vpc-12345678901234567
# ELB2_LOADBALANCERS_ARNS?=
# ELB2_LOADBALANCERS_NAMES?=
# ELB2_LOADBALANCERS_SET_NAME?=

# Derived parameters
ELB2_LOADBALANCER_ALIASNAME?= $(if $(ELB2_LOADBALANCER_ALIASNAME_HOSTNAME),$(ELB2_LOADBALANCER_ALIASNAME_HOSTNAME).$(ELB2_LOADBALANCER_ALIASNAME_SUBDOMAIN))
ELB2_LOADBALANCER_ALIASNAME_SUBDOMAIN?= $(ELB2_LOADBALANCER_ALIASNAME_DOMAIN)
ELB2_LOADBALANCER_DNSNAME?= $(if $(ELB2_LOADBALANCER_DNSNAME_HOSTNAME),$(ELB2_LOADBALANCER_DNSNAME_HOSTNAME).$(ELB2_LOADBALANCER_DNSNAME_SUBDOMAIN))
ELB2_LOADBALANCER_DNSNAME_HOSTNAME?= $(if $(ELB2_LOADBALANCER_DNSNAME_UID),$(ELB2_LOADBALANCER_NAME)-$(ELB2_LOADBALANCER_DNSNAME_UID))
ELB2_LOADBALANCER_DNSNAME_SUBDOMAIN?= $(ELB2_LOADBALANCER_REGION_ID).$(ELB2_LOADBALANCER_DNSNAME_DOMAIN)
ELB2_LOADBALANCER_REGION_ID?= $(ELB2_REGION_ID)
ELB2_LOADBALANCER_SECURITYGROUPS_IDS_OR_NAMES?= $(if $(ELB2_LOADBALANCER_SECURITYGROUPS_IDS),$(ELB2_LOADBALANCER_SECURITYGROUPS_IDS),$(ELB2_LOADBALANCER_SECURITYGROUPS_NAMES))
ELB2_LOADBALANCER_URL?= $(ELB2_LOADBALANCER_URL_PROTOCOL)$(ELB2_LOADBALANCER_URL_DNSNAME)$(ELB2_LOADBALANCER_URL_PORT)$(ELB2_LOADBALANCER_URL_PATH)
ELB2_LOADBALANCER_URL_DNSNAME?= $(ELB2_LOADBALANCER_DNSNAME)
ELB2_LOADBALANCERS_ARNS?= $(ELB2_LOADBALANCER_ARN)
ELB2_LOADBALANCERS_NAMES?= $(ELB2_LOADBALANCER_NAME)

# Option parameters
__ELB2_CUSTOMER_OWNED_IPV4_POOL= $(if $(ELB2_LOADBALANCER_IPADDRESS_POOL),--ip-address-type $(ELB2_LOADBALANCER_IPADDRESS_POOL))
__ELB2_IP_ADDRESS_TYPE= $(if $(ELB2_LOADBALANCER_IPADDRESS_TYPE),--ip-address-type $(ELB2_LOADBALANCER_IPADDRESS_TYPE))
__ELB2_LOAD_BALANCER_ARN= $(if $(ELB2_LOADBALANCER_ARN),--load-balancer-arn $(ELB2_LOADBALANCER_ARN))
__ELB2_LOAD_BALANCER_ARNS__LOADBALANCER= $(if $(ELB2_LOADBALANCER_ARN),--load-balancer-arns $(ELB2_LOADBALANCER_ARN))
__ELB2_LOAD_BALANCER_ARNS__LOADBALANCERS= $(if $(ELB2_LOADBALANCERS_ARNS),--load-balancer-arns $(ELB2_LOADBALANCERS_ARNS))
__ELB2_NAME__LOADBALANCER= $(if $(ELB2_LOADBALANCER_NAME),--name $(ELB2_LOADBALANCER_NAME))
__ELB2_NAMES__LOADBALANCER= $(if $(ELB2_LOADBALANCER_NAME),--names $(ELB2_LOADBALANCER_NAME))
__ELB2_NAMES__LOADBALANCERS= $(if $(ELB2_LOADBALANCERS_NAMES),--names $(ELB2_LOADBALANCERS_NAMES))
__ELB2_SCHEME= $(if $(ELB2_LOADBALANCER_SCHEME),--scheme $(ELB2_LOADBALANCER_SCHEME))
__ELB2_SECURITY_GROUPS= $(if $(ELB2_LOADBALANCER_SECURITYGROUPS_IDS_OR_NAMES),--security-groups $(ELB2_LOADBALANCER_SECURITYGROUPS_IDS_OR_NAMES))
__ELB2_SUBNETS= $(if $(ELB2_LOADBALANCER_SUBNETS_IDS),--subnets $(ELB2_LOADBALANCER_SUBNETS_IDS))
__ELB2_TAGS__LOADBALANCER= $(if $(ELB2_LOADBALANCER_TAGS_KEYVALUES),--tags $(ELB2_LOADBALANCER_TAGS_KEYVALUES))
__ELB2_TYPE= $(if $(ELB2_LOADBALANCER_TYPE),--type $(ELB2_LOADBALANCER_TYPE))

# UI parameters
ELB2_SHOW_LOADBALANCER_LISTENERS_FIELDS?= # .{ListenerArn:ListenerArn,port:Port,protocol:Protocol}
ELB2_UI_VIEW_LOADBALANCERS_FIELDS?= .{LoadBalancerName:LoadBalancerName,Type:Type,Scheme:Scheme,LoadBalancerArn:LoadBalancerArn}
ELB2_UI_VIEW_LOADBALANCERS_SET_FIELDS?= $(ELB2_UI_VIEW_LOADBALANCERS_FIELDS)
ELB2_UI_VIEW_LOADBALANCERS_SET_QUERYFILTER?=

# Pipes
_ELB2_DIG_LOADBALANCER_|?= # watch -n 5
_ELB2_DIG_LOADBALANCER_ALIASNAME_|?= $(_ELB2_DIG_LOADBALANCER_|)
_ELB2_DIG_LOADBALANCER_DNSNAME_|?= $(_ELB2_DIG_LOADBALANCER_|)

#--- Utilities

#--- MACROS

_elb2_get_loadbalancer_arn= $(call _elb2_get_loadbalancer_arn_N, $(ELB2_LOADBALANCER_NAME))
_elb2_get_loadbalancer_arn_N= $(shell $(AWS) elbv2 describe-load-balancers --names $(1) --query "LoadBalancers[].LoadBalancerArn" --output text) 
# _elb2_get_loadbalancer_arn_N= $(shell $(AWS) elbv2 describe-load-balancers --names $(1) --query "LoadBalancers[].LoadBalancerArn" --output text 2>/dev/null) 

_elb2_get_loadbalancer_dnsname= $(call _elb2_get_loadbalancer_dnsname_N, $(ELB2_LOADBALANCER_NAME))
_elb2_get_loadbalancer_dnsname_N= $(shell $(AWS) elbv2 describe-load-balancers --names $(1) --query "LoadBalancers[].DNSName" --output text)

_elb2_get_loadbalancer_ipaddresses= $(call _elb2_get_loadbalancer_ipaddresses_D, $(ELB2_LOADBALANCER_DNSNAME))
_elb2_get_loadbalancer_ipaddresses_D= $(shell dig +short $(1))

_elb2_get_loadbalancer_vpc_id= $(call _elb2_get_loadbalancer_vpc_id_N, $(ELB2_LOADBALANCER_NAME))
_elb2_get_loadbalancer_vpc_id_N= $(shell $(AWS) elbv2 describe-load-balancers --names $(1) --query "LoadBalancers[].VpcId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_elb2_view_framework_macros ::
	@echo 'AWS::ElasticLoadBalancerV2::LoadBalancer ($(_AWS_ELBV2_LOADBALANCER_MK_VERSION)) macros:'
	@echo '    _elb2_get_loadbalancer_arn_{|N}                     - Get the ARN of a load-balancer (Name)'
	@echo '    _elb2_get_loadbalancer_dnsname_{|N}                 - Get the DNS name of a load-balancer (Name)'
	@echo '    _elb2_get_loadbalancer_ipaddresses_{|D}             - Get the IP addresses of a load-balancer (Dnsname)'
	@echo '    _elb2_get_loadbalancer_vpc_id_{|N}                  - Get the VPC IP of a load-balancer (Name)'
	@echo

_elb2_view_framework_parameters ::
	@echo 'AWS::ElasticLoadBalancerV2::LoadBalancer ($(_AWS_ELBV2_LOADBALANCER_MK_VERSION)) parameters:'
	@echo '    ELB2_LOADBALANCER_ALIASNAME=$(ELB2_LOADBALANCER_ALIASNAME)'
	@echo '    ELB2_LOADBALANCER_ALIASNAME_DOMAIN=$(ELB2_LOADBALANCER_ALIASNAME_DOMAIN)'
	@echo '    ELB2_LOADBALANCER_ALIASNAME_HOSTNAME=$(ELB2_LOADBALANCER_ALIASNAME_HOSTNAME)'
	@echo '    ELB2_LOADBALANCER_ALIASNAME_SUBDOMAIN=$(ELB2_LOADBALANCER_ALIASNAME_SUBDOMAIN)'
	@echo '    ELB2_LOADBALANCER_ARN=$(ELB2_LOADBALANCER_ARN)'
	@echo '    ELB2_LOADBALANCER_DNSNAME=$(ELB2_LOADBALANCER_DNSNAME)'
	@echo '    ELB2_LOADBALANCER_DNSNAME_DOMAIN=$(ELB2_LOADBALANCER_DNSNAME_DOMAIN)'
	@echo '    ELB2_LOADBALANCER_DNSNAME_HOSTNAME=$(ELB2_LOADBALANCER_DNSNAME_HOSTNAME)'
	@echo '    ELB2_LOADBALANCER_DNSNAME_SUBDOMAIN=$(ELB2_LOADBALANCER_DNSNAME_SUBDOMAIN)'
	@echo '    ELB2_LOADBALANCER_DNSNAME_UID=$(ELB2_LOADBALANCER_DNSNAME_UID)'
	@echo '    ELB2_LOADBALANCER_IPADDRESS_POOL=$(ELB2_LOADBALANCER_IPADDRESS_POOL)'
	@echo '    ELB2_LOADBALANCER_IPADDRESS_TYPE=$(ELB2_LOADBALANCER_IPADDRESS_TYPE)'
	@echo '    ELB2_LOADBALANCER_NAME=$(ELB2_LOADBALANCER_NAME)'
	@echo '    ELB2_LOADBALANCER_SCHEME=$(ELB2_LOADBALANCER_SCHEME)'
	@echo '    ELB2_LOADBALANCER_SECURITYGROUPS_IDS=$(ELB2_LOADBALANCER_SECURITYGROUPS_IDS)'
	@echo '    ELB2_LOADBALANCER_SECURITYGROUPS_NAMES=$(ELB2_LOADBALANCER_SECURITYGROUPS_NAMES)'
	@echo '    ELB2_LOADBALANCER_SUBNETMAPPINGS_CONFIGS=$(ELB2_LOADBALANCER_SUBNETMAPPINGS_CONFIGS)'
	@echo '    ELB2_LOADBALANCER_SUBNETS_IDS=$(ELB2_LOADBALANCER_SUBNETS_IDS)'
	@echo '    ELB2_LOADBALANCER_TAGS_KEYVALUES=$(ELB2_LOADBALANCER_TAGS_KEYVALUES)'
	@echo '    ELB2_LOADBALANCER_TYPE=$(ELB2_LOADBALANCER_TYPE)'
	@echo '    ELB2_LOADBALANCER_URL=$(ELB2_LOADBALANCER_URL)'
	@echo '    ELB2_LOADBALANCER_URL_DNSNAME=$(ELB2_LOADBALANCER_URL_DNSNAME)'
	@echo '    ELB2_LOADBALANCER_URL_PATH=$(ELB2_LOADBALANCER_URL_PATH)'
	@echo '    ELB2_LOADBALANCER_URL_PORT=$(ELB2_LOADBALANCER_URL_PORT)'
	@echo '    ELB2_LOADBALANCER_URL_PROTOCOL=$(ELB2_LOADBALANCER_URL_PROTOCOL)'
	@echo '    ELB2_LOADBALANCER_VPC_ID=$(ELB2_LOADBALANCER_VPC_ID)'
	@echo '    ELB2_LOADBALANCERS_ARNS=$(ELB2_LOADBALANCERS_ARNS)'
	@echo '    ELB2_LOADBALANCERS_NAMES=$(ELB2_LOADBALANCERS_NAMES)'
	@echo '    ELB2_LOADBALANCERS_SET_NAME=$(ELB2_LOADBALANCERS_SET_NAME)'
	@echo

_elb2_view_framework_targets ::
	@echo 'AWS::ElasticLoadBalancerV2::LoadBalancer ($(_AWS_ELBV2_LOADBALANCER_MK_VERSION)) targets:'
	@echo '    _elb2_create_loadbalancer                           - Create a load-balancer'
	@echo '    _elb2_curl_loadbalancer                             - Curl a load-balancer'
	@echo '    _elb2_delete_loadbalancer                           - Delete an existing load-balancer'
	@echo '    _elb2_dig_loadbalancer                              - Dig alias and dns names of a load-balancer'
	@echo '    _elb2_dig_loadbalancer_dnsname                      - Dig the dns-name of a load-balancer'
	@echo '    _elb2_dig_loadbalancer_aliasname                    - Dig the alias-name of a lod-balancer'
	@echo '    _elb2_show_loadbalancer                             - Show everything related to a load-balancer'
	@echo '    _elb2_show_loadbalancer_attributes                  - Show attributes of a load-balancer'
	@echo '    _elb2_show_loadbalancer_description                 - Show description of a load-balancer'
	@echo '    _elb2_show_loadbalancer_listeners                   - Show listeners of a load-balancer'
	@echo '    _elb2_show_loadbalancer_targetgroups                - Show target-group of a load-balancer'
	@echo '    _elb2_view_loadbalancers                            - View all load-balancers'
	@echo '    _elb2_view_loadbalancers_set                        - View a set of load-balancers'
	@echo '    _elb2_watch_loadbalancers                           - Watch all load-balancers'
	@echo '    _elb2_watch_loadbalancers_set                       - Watch a set of load-balancers'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_elb2_create_loadbalancer:
	@$(INFO) '$(ELB2_UI_LABEL)Creating load-balancer "$(ELB2_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(AWS) elbv2 create-load-balancer $(strip $(__ELB2_CUSTOMER_OWNED_IPV4_POOL) $(__ELB2_IP_ADDRESS_TYPE) $(__ELB2_NAME__LOADBALANCER) $(__ELB2_SCHEME) $(__ELB2_SECURITY_GROUPS) $(__ELB2_SUBNETS) $(__ELB2_TAGS__LOADBALANCER) $(__ELB2_TYPE) ) --query 'LoadBalancers'

_elb2_curl_loadbalancer:
	@$(INFO) '$(ELB2_UI_LABEL)Curl-ing load-balancer "$(ELB2_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(if $(ELB2_LOADBALANCER_URL), \
		$(ELB2_LOADBALANCER_CURL) $(ELB2_LOADBALANCER_URL), \
		@echo 'ELB2_LOADBALANCER_URL not set!' \
	)

_elb2_delete_loadbalancer:
	@$(INFO) '$(ELB2_UI_LABEL)Deleting load-balancer "$(ELB2_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(AWS) elbv2 delete-load-balancer $(__ELB2_LOAD_BALANCER_ARN)

_elb2_dig_loadbalancer : _elb2_dig_loadbalancer_aliasname _elb2_dig_loadbalancer_dnsname

_elb2_dig_loadbalancer_aliasname:
	@$(INFO) '$(ELB2_UI_LABEL)Dig-ing alias-name of load-balancer "$(ELB2_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(if $(ELB2_LOADBALANCER_ALIASNAME), \
		$(_ELB2_DIG_LOADBALANCER_ALIASNAME_|)$(ELB2_LOADBALANCER_DIG) $(ELB2_LOADBALANCER_ALIASNAME), \
		@echo 'ELB2_LOADBALANCER_ALIASNAME not set!' \
	)

_elb2_dig_loadbalancer_dnsname:
	@$(INFO) '$(ELB2_UI_LABEL)Dig-ing DNS-name of load-balancer "$(ELB2_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(if $(ELB2_LOADBALANCER_DNSNAME), \
		$(_ELB2_DIG_LOADBALANCER_DNSNAME_|)$(ELB2_LOADBALANCER_DIG) $(ELB2_LOADBALANCER_DNSNAME), \
		@echo 'ELB2_LOADBALANCER_DNSNAME not set!' \
	)

_elb2_show_loadbalancer: _elb2_show_loadbalancer_attributes _elb2_show_loadbalancer_listeners _elb2_show_loadbalancer_targetgroups _elb2_show_loadbalancer_description

_elb2_show_loadbalancer_attributes:
	@$(INFO) '$(ELB2_UI_LABEL)Showing attributes of load-balancer "$(ELB2_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(AWS) elbv2 describe-load-balancer-attributes $(__ELB2_LOAD_BALANCER_ARN) --query "Attributes[]"

_elb2_show_loadbalancer_description:
	@$(INFO) '$(ELB2_UI_LABEL)Showing description of load-balancer "$(ELB2_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(AWS) elbv2 describe-load-balancers $(__ELB2_LOAD_BALANCER_ARNS__LOADBALANCER) $(_X__ELB2_NAMES__LOADBALANCER) --query "LoadBalancers[]"

_elb2_show_loadbalancer_listeners:
	@$(INFO) '$(ELB2_UI_LABEL)Showing listeners of load-balancer "$(ELB2_LOADBALANCER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Beware: Make sure to configure at least one listener for the load balancer'; $(NORMAL)
	$(AWS) elbv2 describe-listeners $(__ELB2_LOAD_BALANCER_ARN) $(_X__ELB2_LISTENER_ARNS__LOADBALANCER) --query "Listeners[]$(ELB2_SHOW_LOADBALANCER_LISTENERS_FIELDS)"

_elb2_show_loadbalancer_targetgroups:
	@$(INFO) '$(ELB2_UI_LABEL)Showing target-group of load-balancer "$(ELB2_LOADBALANCER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Target-groups are attached to the load-balancer through listeners'; $(NORMAL)
	$(AWS) elbv2 describe-target-groups $(__ELB2_LOAD_BALANCER_ARN) $(_X__ELB2_NAMES__LOADBALANCER) $(_X__ELB2_TARGET_GROUP_ARNS__LOADBALANCER) --query "TargetGroups[]"

_elb2_view_loadbalancers:
	@$(INFO) '$(ELB2_UI_LABEL)Viewing ALL load-balancers ...'; $(NORMAL)
	$(AWS) elbv2 describe-load-balancers $(_X__ELB2_LOAD_BALANCER_ARNS) $(_X__ELB2_NAMES__LOADBALANCERS) --query "LoadBalancers[]$(ELB2_UI_VIEW_LOADBALANCERS_FIELDS)"

_elb2_view_loadbalancers_set:
	@$(INFO) '$(ELB2_UI_LABEL)Viewing load-balancers-set "$(ELB2_LOADBALANCERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Load-balancers are grouped based on the provided ARNs, names, and slice'; $(NORMAL)
	$(AWS) elbv2 describe-load-balancers $(__ELB2_LOAD_BALANCER_ARNS) $(__ELB2_NAMES__LOADBALANCERS) --query "LoadBalancers[$(ELB2_UI_VIEW_LOADBALANCERS_SET_QUERYFILTER)]$(ELB2_UI_VIEW_LOADBALANCERS_SET_FIELDS)"

_elb2_watch_loadbalancers:
	@$(INFO) '$(ELB2_UI_LABEL)Watching ALL load-balancers ...'; $(NORMAL)

_elb2_watch_loadbalancers_set:
	@$(INFO) '$(ELB2_UI_LABEL)Watching load-balancers-set "$(ELB2_LOADBALANCERS_SET_NAME)" ...'; $(NORMAL)
