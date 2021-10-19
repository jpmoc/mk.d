_KOPS_WORKER_MK_VERSION= $(_KOPS_MK_VERSION)

# KOPS_WORKER_CLUSTER_NAME?= my-cluster
# KOPS_WORKER_HOSTNAME?=
KOPS_WORKER_INDEX?= 1
# KOPS_WORKER_IP?=
# KOPS_WORKER_IP_OR_HOSTNAME?=
KOPS_WORKER_PRIVATE_KEY?= $(HOME)/.ssh/id_rsa
KOPS_WORKER_USERNAME?= admin
# KOPS_WORKERS_IPS?=

# Derived parameters
KOPS_WORKER_CLUSTER_NAME?= $(KOPS_CLUSTER_NAME)
KOPS_WORKER_IP_OR_HOSTNAME?= $(if $(KOPS_WORKER_IP),$(KOPS_WORKER_IP),$(KOPS_WORKER_HOSTNAME))

# Option parameters

# UI parameters
KOPS_UI_VIEW_WORKERS_FIELDS?= .{InstanceId:InstanceId,instanceType:InstanceType,availabilityZone:Placement.AvailabilityZone,publicIp:PublicIpAddress,PrivateDnsName:PrivateDnsName} | sort_by(@,&PrivateDnsName)
#--- Utilities

#--- Macros

_kops_get_workers_ips= $(call _kops_get_workers_ips_C, $(KOPS_WORKER_CLUSTER_NAME))
_kops_get_workers_ips_C= $(strip $(shell $(AWS) ec2 describe-instances --filter Name=tag:Name,Values=nodes.$(strip $(1)) --query "Reservations[].Instances[].PublicIpAddress" --output text))

#----------------------------------------------------------------------
# USAGE
#

_kops_view_framework_macros ::
	@echo 'KOPS::Worker ($(_KOPS_WORKER_MK_VERSION)) macros:'
	@echo '    _kops_get_workers_ips_{|C}      - Get the IPs of the worker nodes (Cluster)'
	@echo

_kops_view_framework_parameters ::
	@echo 'KOPS::Worker ($(_KOPS_WORKER_MK_VERSION)) parameters:'
	@echo '    KOPS_WORKER_CLUSTER_NAME=$(KOPS_WORKER_CLUSTER_NAME)'
	@echo '    KOPS_WORKER_HOSTNAME=$(KOPS_WORKER_HOSTNAME)'
	@echo '    KOPS_WORKER_INDEX=$(KOPS_WORKER_INDEX)'
	@echo '    KOPS_WORKER_IP=$(KOPS_WORKER_IP)'
	@echo '    KOPS_WORKER_IP_OR_HOSTNAME=$(KOPS_WORKER_IP_OR_HOSTNAME)'
	@echo '    KOPS_WORKER_PRIVATE_KEY=$(KOPS_WORKER_PRIVATE_KEY)'
	@echo '    KOPS_WORKER_USERNAME=$(KOPS_WORKER_USERNAME)'
	@echo '    KOPS_WORKERS_IPS=$(KOPS_WORKERS_IPS)'
	@echo

_kops_view_framework_targets ::
	@echo 'KOPS::Worker ($(_KOPS_WORKER_MK_VERSION)) targets:'
	@echo '    _kops_ssh_worker                  - Ssh into a worker-node of a cluster'
	@echo '    _kops_view_workers                - View worker-nodes of a cluster'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kops_ssh_worker:
	@$(INFO) '$(KOPS_UI_LABEL)Sshing into worker-node of cluster "$(KOPS_WORKER_CLUSTER_NAME)" ...'; $(NORMAL)
	ssh -A -i $(KOPS_WORKER_PRIVATE_KEY) $(KOPS_WORKER_USERNAME)@$(KOPS_WORKER_IP_OR_HOSTNAME)

_kops_view_workers: 
	@$(INFO) '$(KOPS_UI_LABEL)Viewing worker-nodes of cluster "$(KOPS_WORKER_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The name of those instances is nodes.$(KOPS_WORKER_CLUSTER_NAME)'; $(NORMAL)
	$(AWS)  ec2 describe-instances  --filter Name=tag:Name,Values=nodes.$(KOPS_WORKER_CLUSTER_NAME) --query "Reservations[].Instances[]$(KOPS_UI_VIEW_WORKERS_FIELDS)"

