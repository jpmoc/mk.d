_AWS_LIGHTSAIL_MK_VERSION=0.99.6

LSL_BUNDLE_ID?= micro_1_0
# LSL_DOMAIN_NAME?= domain.com
# LSL_DOMAIN_ENTRY?=
LSL_EVENT_SLICE=0:20:1
LSL_INSTANCE_AVAILABILITY_ZONE?= $(AWS_REGION)a
# LSL_IMAGE_BLUEPRINT_ID?= amazon_linux_2016_09_0
LSL_KEYPAIR_DIR?= $(SSH_KEYPAIR_DIR)
LSL_METRIC_NAME?= CPUUtilization
LSL_METRIC_PERIOD?= 60
LSL_METRIC_STATISTICS?= Average
LSL_METRIC_UNIT?= Percent
LSL_PROJECT_NAME?=MyProject
LSL_REMOTE_USER?=  $(SSH_REMOTE_USER)
# LSL_PORT_RANGE?= 3030 3030 tcp
# LSL_USER_DATA_FILEPATH?= ./userdata.sh
LSL_WATCH_INTERVAL?=5

# Derived variables
LSL_INSTANCE_NAME?= $(LSL_PROJECT_NAME)Instance
LSL_INSTANCE_NAMES?= $(LSL_INSTANCE_NAME)
LSL_KEYPAIR_NAME?= $(LSL_PROJECT_NAME)Key
LSL_PRIVATE_KEY_FILE?=$(LSL_KEYPAIR_NAME)
LSL_PRIVATE_KEY_FILEPATH?=$(LSL_KEYPAIR_DIR)/$(LSL_PRIVATE_KEY_FILE)
LSL_STATIC_IP_NAME?=  $(LSL_PROJECT_NAME)StaticIp
LSL_USER_DATA_DOCUMENT?= file://$(LSL_USER_DATA_FILEPATH)

# Derived options
__LSL_AVAILABILITY_ZONE?= $(if $(LSL_INSTANCE_AVAILABILITY_ZONE), --availability-zone $(LSL_INSTANCE_AVAILABILITY_ZONE))
__LSL_BUNDLE_ID?= $(if $(LSL_BUNDLE_ID), --bundle-id $(LSL_BUNDLE_ID))
__LSL_BLUEPRINT_ID?= $(if $(LSL_IMAGE_BLUEPRINT_ID), --blueprint-id $(LSL_IMAGE_BLUEPRINT_ID))
__LSL_DOMAIN_ENTRY?= $(if $(LSL_DOMAIN_ENTRY), --domain-entry $(LSL_DOMAIN_ENTRY))
__LSL_DOMAIN_NAME?= $(if $(LSL_DOMAIN_NAME), --domain-name $(LSL_DOMAIN_NAME))
__LSL_END_TIME?= $(if $(LSL_METRIC_END_TIME), --end-time $(LSL_METRIC_END_TIME))
__LSL_INCLUDE_INACTIVE?= --include-inactive
__LSL_INSTANCE_NAME?= $(if $(LSL_INSTANCE_NAME), --instance-name $(LSL_INSTANCE_NAME))
__LSL_INSTANCE_NAMES?= $(if $(LSL_INSTANCE_NAMES), --instance-names $(LSL_INSTANCE_NAMES))
__LSL_KEY_PAIR_NAME?= $(if $(LSL_KEYPAIR_NAME), --key-pair-name $(LSL_KEYPAIR_NAME))
__LSL_METRIC_NAME?= $(if $(LSL_METRIC_NAME), --metric-name $(LSL_METRIC_NAME))
__LSL_PERIOD?= $(if $(LSL_METRIC_PERIOD), --period $(LSL_METRIC_PERIOD))
__LSL_PORT_INFO?= $(if $(LSL_PORT_RANGE), --port-info fromPort='$(word 1, $(LSL_PORT_RANGE))'$(COMMA)toPort='$(word 2, $(LSL_PORT_RANGE))'$(COMMA)protocol='$(word 3, $(LSL_PORT_RANGE))')
__LSL_START_TIME?= $(if $(LSL_METRIC_START_TIME), --start-time $(LSL_METRIC_START_TIME))
__LSL_STATIC_IP_NAME?= $(if $(LSL_STATIC_IP_NAME), --static-ip-name $(LSL_STATIC_IP_NAME))
__LSL_STATISTICS?= $(if $(LSL_METRIC_STATISTICS), --statistics $(LSL_METRIC_STATISTICS))
__LSL_UNIT?= $(if $(LSL_METRIC_UNIT), --unit $(LSL_METRIC_UNIT))
__LSL_USER_DATA?= $(if $(LSL_USER_DATA_DOCUMENT), --user-data $(LSL_USER_DATA_DOCUMENT))

LSL_VIEW_BLUEPRINTS_FIELDS?=.{"Id":blueprintId,"Name":name,"Platform":platform,"Version":version}
LSL_VIEW_BUNDLES_FIELDS?=.{bundleId:bundleId,transferPerMonthInGb:transferPerMonthInGb,diskSizeInGb:diskSizeInGb,ramSizeinGb:ramSizeInGb,power:power,cpuCount:cpuCount,price:price}
LSL_VIEW_INSTANCES_FIELDS?=.[name,blueprintId,bundleId,createdAt,blueprintName,resourceType]
LSL_VIEW_KEYPAIRS_FIELDS?=.{name:name,fingerprint:fingerprint}
LSL_VIEW_OPERATIONS_FIELDS?=.[createdAt,statusChangedAt,operationType,resourceName,status]
LSL_VIEW_STATIC_IPS_FIELDS?=.{name:name,isAttached:isAttached,ipAddress:ipAddress}

#--- MACROS
_lsl_get_public_ip_N=$(shell $(AWS)  lightsail get-instance  --instance-name $(1) --query "instance.publicIpAddress" --output text)

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _lsl_view_makefile_macros
_lsl_view_makefile_macros:
	@echo "AWS::LightSaiL ($(_AWS_CLOUD9_MK_VERSION)) macros:"
	@echo "    _lsl_get_public_ip_N                - Get public ip address of instance (Name)"
	@echo

_aws_view_makefile_targets :: _lsl_view_makefile_targets
_lsl_view_makefile_targets:
	@echo "AWS::LightSaiL ($(_AWS_CLOUD9_MK_VERSION)) targets:"
	@echo "    _lsl_attach_static_ip              - Attach static IP to a lightsail instance"
	@echo "    _lsl_close_ports                   - CLose already opened ports"
	@echo "    _lsl_create_domain                 - Create a lighsail domain"
	@echo "    _lsl_create_domain_entry           - Create a lighsail domain entry"
	@echo "    _lsl_create_instances              - Create lightsail instances"
	@echo "    _lsl_create_static_ip              - Create static IP for lightsail instances"
	@echo "    _lsl_create_keypair                - Create a keypair for lightsail instance"
	@echo "    _lsl_delete_domain                 - Delete a lighsail domain"
	@echo "    _lsl_delete_domain_entry           - Delete a lighsail domain entry"
	@echo "    _lsl_delete_instance               - Delete a lightsail instances"
	@echo "    _lsl_delete_keypair                - Delete a lightsail keypair"
	@echo "    _lsl_delete_static_ip              - Delete a lightsail static IP"
	@echo "    _lsl_detach_static_ip              - Detach ia static IP from a lightsail instance"
	@echo "    _lsl_get_instance_access_deatils   - Get ssh key to access an instances"
	@echo "    _lsl_open_ports                    - Open a port range"
	@echo "    _lsl_print_keypair                 - Print private key for lighsail keypair"
	@echo "    _lsl_reboot_instance               - Reboot a given lighsail instance"
	@echo "    _lsl_show_bundle                   - Show details of a bundle"
	@echo "    _lsl_show_domain                   - Show an existing domain"
	@echo "    _lsl_show_instance                 - Show a lightsail instances"
	@echo "    _lsl_show_instance_ports           - Get port states of an instances"
	@echo "    _lsl_show_instance_state           - Get the state of a lightail instances"
	@echo "    _lsl_show_static_ips               - Show a lightsail static IP"
	@echo "    _lsl_view_blueprints               - View available blueprints"
	@echo "    _lsl_view_bundles                  - View available bundles"
	@echo "    _lsl_view_domains                  - Get ia list of available domains"
	@echo "    _lsl_view_instances                - View running lightsail instances"
	@echo "    _lsl_view_load_balancers           - View running load balancers"
	@echo "    _lsl_view_metrics                  - View all metrics"
	@echo "    _lsl_view_events                   - View all events"
	@echo "    _lsl_view_regions                  - View lightsail regions"
	@echo "    _lsl_view_resources                - View lightsail resources"
	@echo "    _lsl_view_static_ips               - View lightsail static IPs"
	@echo "    _lsl_watch_events                  - Watch events"
	@echo 

_aws_view_makefile_variables :: _lsl_view_makefile_variables
_lsl_view_makefile_variables:
	@echo "AWS::LightSaiL ($(_AWS_CLOUD9_MK_VERSION)) variables:"
	@echo "    LSL_BUNDLE_ID=$(LSL_BUNDLE_ID)"
	@echo "    LSL_IMAGE_BLUEPRINT=$(LSL_IMAGE_BLUEPRINT)"
	@echo "    LSL_INSTANCE_AVAILABILITY_ZONE=$(LSL_INSTANCE_AVAILABILITY_ZONE)"
	@echo "    LSL_INSTANCE_NAMES=$(LSL_INSTANCE_NAMES)"
	@echo "    LSL_KEYPAIR_NAME=$(LSL_KEYPAIR_NAME)"
	@echo "    LSL_METRIC_END_TIME=$(LSL_METRIC_END_TIME)"
	@echo "    LSL_METRIC_NAME=$(LSL_METRIC_NAME)"
	@echo "    LSL_METRIC_PERIOD=$(LSL_METRIC_PERIOD)"
	@echo "    LSL_METRIC_START_TIME=$(LSL_METRIC_START_TIME)"
	@echo "    LSL_METRIC_STATISTICS=$(LSL_METRIC_STATISTICS)"
	@echo "    LSL_METRIC_UNIT=$(LSL_METRIC_UNIT)"
	@echo "    LSL_PORT_RANGE=$(LSL_PORT_RANGE)"
	@echo "    LSL_PRIVATE_KEY_FILE=$(LSL_PRIVATE_KEY_FILE)"
	@echo "    LSL_PRIVATE_KEY_FILEPATH=$(LSL_PRIVATE_KEY_FILEPATH)"
	@echo "    LSL_PROJECT_NAME=$(LSL_PROJECT_NAME)"
	@echo "    LSL_REMOTE_USER=$(LSL_REMOTE_USER)"
	@echo "    LSL_STATIC_IP_NAME=$(LSL_STATIC_IP_NAME)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_lsl_attach_static_ip:
	@$(INFO) "$(AWS_LABEL)Attaching static ip '$(LSL_STATIC_IP_NAME)' to instance '$(LSL_INSTANCE_NAME)' ..."; $(NORMAL)
	$(AWS) lightsail attach-static-ip $(__LSL_INSTANCE_NAME) $(__LSL_STATIC_IP_NAME)

_lsl_close_ports:
	@$(INFO) "$(AWS_LABEL)Closing port range for instance '$(LSL_INSTANCE_NAME)' ..."; $(NORMAL)
	$(AWS) lightsail close-instance-public-ports $(__LSL_INSTANCE_NAME) $(__LSL_PORT_INFO)

_lsl_create_domain:
	@$(INFO) "$(AWS_LABEL)Creating domain '$(LSL_DOMAIN_NAME)' ..."; $(NORMAL)
	$(AWS) lightsail create-domain $(__LSL_DOMAIN_NAME)

_lsl_create_domain_entry:
	@$(INFO) "$(AWS_LABEL)Creating entry on domain '$(LSL_DOMAIN_NAME)' ..."; $(NORMAL)
	$(AWS) lightsail create-domain-entry i$(__LSL_DOMAIN_ENTRY) $(__LSL_DOMAIN_NAME)

_lsl_create_instances:
	@$(INFO) "$(AWS_LABEL)Creating instances '$(LSL_INSTANCE_NAMES)' ..."; $(NORMAL)
	$(AWS) lightsail create-instances $(__LSL_AVAILABILITY_ZONE) $(__LSL_BLUEPRINT_ID) $(__LSL_BUNDLE_ID) $(__LSL_INSTANCE_NAMES) $(__LSL_KEY_PAIR_NAME) $(__LSL_USER_DATA)

_lsl_create_keypair:
	@$(INFO) "$(AWS_LABEL)Creating keypair '$(LSL_KEYPAIR_NAME)' ..."; $(NORMAL)
	$(AWS) lightsail create-key-pair $(__LSL_KEY_PAIR_NAME) --query 'privateKeyBase64' --output text > $(LSL_PRIVATE_KEY_FILEPATH)
	chmod 700 $(LSL_PRIVATE_KEY_FILEPATH)

_lsl_create_static_ip:
	@$(INFO) "$(AWS_LABEL)Creating a static IP '$(LSL_STATIC_IP_NAME)' ..."; $(NORMAL)
	$(AWS) lightsail allocate-static-ip $(__LSL_STATIC_IP_NAME)

_lsl_delete_domain:
	@$(INFO) "$(AWS_LABEL)Deleting domain '$(LSL_DOMAIN_NAME)' ..."; $(NORMAL)
	$(AWS) lightsail delete-domain $(__LSL_DOMAIN_NAME)

_lsl_delete_domain_entry:
	@$(INFO) "$(AWS_LABEL)Deleting entry on domain '$(LSL_DOMAIN_NAME)' ..."; $(NORMAL)
	$(AWS) lightsail delete-domain-entry i$(__LSL_DOMAIN_ENTRY) $(__LSL_DOMAIN_NAME)

_lsl_delete_instance:
	@$(INFO) "$(AWS_LABEL)Deleting lightsail instance '$(LSL_INSTANCE_NAME)' ..."; $(NORMAL)
	@$(WARN) "Deletion is instantaneous!"; $(NORMAL)
	$(AWS) lightsail delete-instance $(__LSL_INSTANCE_NAME)

_lsl_delete_keypair:
	@$(INFO) "$(AWS_LABEL)Deleting lightsail keypair '$(LSL_KEYPAIR_NAME)' ..."; $(NORMAL)
	$(AWS) lightsail delete-key-pair $(__LSL_KEY_PAIR_NAME)

_lsl_delete_static_ip:
	@$(INFO) "$(AWS_LABEL)Deleting lightsail static IP '$(LSL_STATIC_IP_NAME)' ..."; $(NORMAL)
	@$(WARN) "Deletion is instantaneous!"; $(NORMAL)
	$(AWS) lightsail release-static-ip $(__LSL_STATIC_IP_NAME)

_lsl_detach_static_ip:
	@$(INFO) "$(AWS_LABEL)Detaching static ip '$(LSL_STATIC_IP_NAME)' to instance '$(LSL_INSTANCE_NAME)' ..."; $(NORMAL)
	$(AWS) lightsail detach-static-ip $(__LSL_STATIC_IP_NAME)

_lsl_get_instance_access_details:
	@$(INFO) "$(AWS_LABEL)Getting access details for instance '$(LSL_INSTANCE_NAME)' ..."; $(NORMAL)
	$(AWS) lightsail get-instance-access-details $(__LSL_INSTANCE_NAME) $(__LSL_PROTOCOL)

_lsl_open_ports:
	@$(INFO) "$(AWS_LABEL)Opening TCP range ' lightsail instance '$(LSL_INSTANCE_NAME)' ..."; $(NORMAL)
	$(AWS) lightsail open-instance-public-ports $(__LSL_INSTANCE_NAME) $(__LSL_PORT_INFO)

_lsl_print_keypair:
	@$(INFO) "$(AWS_LABEL)Printing private key for keypair '$(LSL_KEYPAIR_NAME)' ..."; $(NORMAL)
	@$(WARN) "Private key: $(LSL_PRIVATE_KEY_FILEPATH)"; $(NORMAL)
	cat $(LSL_PRIVATE_KEY_FILEPATH)

_lsl_reboot_instance:
	@$(INFO) "$(AWS_LABEL)Rebooting lightsail instance '$(LSL_INSTANCE_NAME)' ..."; $(NORMAL)
	$(AWS) lightsail reboot-instance $(__LSL_INSTANCE_NAME)

_lsl_show_bundle:
	@$(INFO) "$(AWS_LABEL)Show lightsail bundle '$(LSL_BUNDLE_ID)' ..."; $(NORMAL)
	$(AWS)  lightsail get-bundles --include-inactive --query 'bundles[?bundleId==`$(LSL_BUNDLE_ID)`]'

_lsl_show_domain:
	@$(INFO) "$(AWS_LABEL)Show domain '$(LSL_DOMAIN_NAME)' ..."; $(NORMAL)
	$(AWS)  lightsail get-domain $(__LSL_DOMAIN_NAME) 

_lsl_show_instance:
	@$(INFO) "$(AWS_LABEL)Show lightsail instance '$(LSL_INSTANCE_NAME)' ..."; $(NORMAL)
	$(AWS) lightsail get-instance $(__LSL_INSTANCE_NAME)

_lsl_show_instance_ports:
	@$(INFO) "$(AWS_LABEL)Getting port states for instance '$(LSL_INSTANCE_NAME)' ..."; $(NORMAL)
	$(AWS) lightsail get-instance-port-states $(__LSL_INSTANCE_NAME)

_lsl_show_instance_state:
	@$(INFO) "$(AWS_LABEL)Getting state of instance '$(LSL_INSTANCE_NAME)' ..."; $(NORMAL)
	$(AWS) lightsail get-instance-state $(__LSL_INSTANCE_NAME)

_lsl_show_metric:
	@$(INFO) "$(AWS_LABEL)Show metric '$(LSL_METRIC_NAME)' for instance '$(LSL_INSTANCE_NAME)' ..."; $(NORMAL)
	$(AWS)  lightsail get-instance-metric-data $(__LSL_END_TIME) $(__LSL_INSTANCE_NAME) $(__LSL_METRIC_NAME) $(__LSL_PERIOD) $(__LSL_START_TIME) $(__LSL_STATISTICS) $(__LSL_UNIT)

_lsl_show_static_ip:
	@$(INFO) "$(AWS_LABEL)Showing static IP '$(LSL_STATIC_IP_NAME)' ..."; $(NORMAL)
	$(AWS) lightsail get-static-ip $(__LSL_STATIC_IP_NAME)

_lsl_view_blueprints:
	@$(INFO) "$(AWS_LABEL)Viewing available blueprints ..."; $(NORMAL)
	$(AWS) lightsail get-blueprints --query "blueprints[]${LSL_VIEW_BLUEPRINTS_FIELDS}"

_lsl_view_bundles:
	@$(INFO) "$(AWS_LABEL)Viewing available bundles ..."; $(NORMAL)
	$(AWS) lightsail get-bundles $(__LSL_INCLUDE_INACTIVE) --query 'bundles[]$(LSL_VIEW_BUNDLES_FIELDS)'

_lsl_view_domains:
	@$(INFO) "$(AWS_LABEL)Getting available domains ..."; $(NORMAL)
	@$(WARN) "This  API call is only valid in us-east-1"; $(NORMAL)
	$(AWS) lightsail get-domains --region us-east-1

_lsl_view_instances:
	@$(INFO) "$(AWS_LABEL)Viewing lightsail instances ..."; $(NORMAL)
	$(AWS) lightsail get-instances --query "instances[]$(LSL_VIEW_INSTANCES_FIELDS)"

_lsl_view_load_balancers:
	@$(INFO) "$(AWS_LABEL)Viewing load balancers ..."; $(NORMAL)
	$(AWS) lightsail get-load-balancers

_lsl_view_metrics:
	@$(INFO) "$(AWS_LABEL)Viewing metrics for instance '$(LSL_INSTANCE_NAME)' ..."; $(NORMAL)
	$(AWS)  lightsail get-instance-metric-data $(__LSL_END_TIME) $(__LSL_INSTANCE_NAME) --metric-name NetworkOut $(__LSL_PERIOD) $(__LSL_START_TIME) --statistics Sum --unit Bytes --period 2700000 --start-time 1488326400 --end-time 1490100240

_lsl_view_events:
	@$(INFO) "$(AWS_LABEL)Viewing lightsail events ..."; $(NORMAL)
	$(AWS) lightsail get-operations --query "operations[$(LSL_EVENT_SLICE)]$(LSL_VIEW_OPERATIONS_FIELDS)"

_lsl_view_keypairs:
	@$(INFO) "$(AWS_LABEL)Viewing lightsail keypairs ..."; $(NORMAL)
	$(AWS) lightsail get-key-pairs --query "keyPairs[]$(LSL_VIEW_KEYPAIRS_FIELDS)"

_lsl_view_regions:
	@$(INFO) "$(AWS_LABEL)Viewing lightsail regions ..."; $(NORMAL)
	$(AWS) lightsail get-regions

_lsl_view_resources:
	@$(INFO) "$(AWS_LABEL)Viewing lightsail resources ..."; $(NORMAL)
	$(AWS) lightsail get-active-names

_lsl_view_static_ips:
	@$(INFO) "$(AWS_LABEL)Viewing lightsail static IPs ..."; $(NORMAL)
	$(AWS) lightsail get-static-ips --query 'staticIps[]$(LSL_VIEW_STATIC_IPS_FIELDS)'

_lsl_watch_events:
	watch -n $(LSL_WATCH_INTERVAL) --color "$(MAKE) -e --quiet _lsl_view_events"

