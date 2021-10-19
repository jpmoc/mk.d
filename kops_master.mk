_KOPS_MASTER_MK_VERSION= $(_KOPS_MK_VERSION)

# KOPS_MASTER_CLUSTER_NAME?= my-cluster
# KOPS_MASTER_HOSTNAME?=
# KOPS_MASTER_IP?=
# KOPS_MASTER_IP_OR_HOSTNAME?=
KOPS_MASTER_PRIVATE_KEY?= $(HOME)/.ssh/id_rsa
KOPS_MASTER_USERNAME?= admin
# KOPS_MASTERS_IPS?=

# Derived parameters
KOPS_MASTER_CLUSTER_NAME?= $(KOPS_CLUSTER_NAME)
KOPS_MASTER_IP_OR_HOSTNAME?= $(if $(KOPS_MASTER_IP),$(KOPS_MASTER_IP),$(KOPS_MASTER_HOSTNAME))

# Option parameters

# UI parameters
KOPS_UI_VIEW_MASTERS_FIELDS?= .{Name:Tags[?Key=='Name']|[0].Value,InstanceId:InstanceId,instanceType:InstanceType,availabilityZone:Placement.AvailabilityZone,publicIp:PublicIpAddress,PrivateDnsName:PrivateDnsName} | sort_by(@,&PrivateDnsName)
#--- Utilities

#--- Macros

_kops_get_masters_ips= $(call _kops_get_masters_ips_C, $(KOPS_MASTER_CLUSTER_NAME))
_kops_get_masters_ips_C= $(strip $(shell $(AWS) ec2 describe-instances  --filter Name=iam-instance-profile.arn,Values=arn:aws:iam::$(AWS_ACCOUNT_ID):instance-profile/masters.$(strip $(1)) --query "Reservations[].Instances[].PublicIpAddress" --output text))

#----------------------------------------------------------------------
# USAGE
#

_kops_view_framework_macros ::
	@echo 'KOPS::Master ($(_KOPS_MASTER_MK_VERSION)) macros:'
	@echo '    _kops_get_masters_ips_{|C}      - Get the IPs of the master nodes (Cluster)'
	@echo

_kops_view_framework_parameters ::
	@echo 'KOPS::Master ($(_KOPS_MASTER_MK_VERSION)) parameters:'
	@echo '    KOPS_MASTER_CLUSTER_NAME=$(KOPS_MASTER_CLUSTER_NAME)'
	@echo '    KOPS_MASTER_HOSTNAME=$(KOPS_MASTER_HOSTNAME)'
	@echo '    KOPS_MASTER_IP=$(KOPS_MASTER_IP)'
	@echo '    KOPS_MASTER_IP_OR_HOSTNAME=$(KOPS_MASTER_IP_OR_HOSTNAME)'
	@echo '    KOPS_MASTER_PRIVATE_KEY=$(KOPS_MASTER_PRIVATE_KEY)'
	@echo '    KOPS_MASTER_USERNAME=$(KOPS_MASTER_USERNAME)'
	@echo '    KOPS_MASTERS_IPS=$(KOPS_MASTERS_IPS)'
	@echo

_kops_view_framework_targets ::
	@echo 'KOPS::Master ($(_KOPS_MASTER_MK_VERSION)) targets:'
	@echo '    _kops_ssh_master                  - Ssh into a master-node of a cluster'
	@echo '    _kops_view_masters                - View master-nodes of a cluster'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kops_ssh_master:
	@$(INFO) '$(KOPS_UI_LABEL)Sshing into master-node of cluster "$(KOPS_MASTER_CLUSTER_NAME)" ...'; $(NORMAL)
	ssh -A -i $(KOPS_MASTER_PRIVATE_KEY) $(KOPS_MASTER_USERNAME)@$(KOPS_MASTER_IP_OR_HOSTNAME)

_kops_view_masters: 
	@$(INFO) '$(KOPS_UI_LABEL)Viewing master-nodes of cluster "$(KOPS_MASTER_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation uses the AWS CLI'; $(NORMAL)
	$(AWS)  ec2 describe-instances --filter Name=iam-instance-profile.arn,Values=arn:aws:iam::$(AWS_ACCOUNT_ID):instance-profile/masters.$(KOPS_MASTER_CLUSTER_NAME) --query "Reservations[].Instances[]$(KOPS_UI_VIEW_MASTERS_FIELDS)"
