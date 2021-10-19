_KOPS_BASTION_MK_VERSION= $(_KOPS_MK_VERSION)

# KOPS_BASTION_CLUSTER_NAME?= my-cluster
# KOPS_BASTION_ELB?=
KOPS_BASTION_PRIVATE_KEY?= $(HOME)/.ssh/id_rsa
KOPS_BASTION_USERNAME?= admin

# Derived parameters
KOPS_BASTION_CLUSTER_NAME?= $(KOPS_CLUSTER_NAME)
KOPS_BASTION_ELB?= bastion.$(KOPS_CLUSTER_NAME)

# Option parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_kops_view_framework_macros ::
	@echo 'KOPS::Bastion ($(_KOPS_BASTION_MK_VERSION)) macros:'
	@echo

_kops_view_framework_parameters ::
	@echo 'KOPS::Bastion ($(_KOPS_BASTION_MK_VERSION)) parameters:'
	@echo '    KOPS_BASTION_CLUSTER_NAME=$(KOPS_BASTION_CLUSTER_NAME)'
	@echo '    KOPS_BASTION_ELB=$(KOPS_BASTION_ELB)'
	@echo '    KOPS_BASTION_PRIVATE_KEY=$(KOPS_BASTION_PRIVATE_KEY)'
	@echo '    KOPS_BASTION_USERNAME=$(KOPS_BASTION_USERNAME)'
	@echo

_kops_view_framework_targets ::
	@echo 'KOPS::Bastion ($(_KOPS_BASTION_MK_VERSION)) targets:'
	@echo '    _kops_ssh_bastion                  - Ssh to the bastion of a cluster'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kops_ssh_bastion:
	@$(INFO) '$(KOPS_LABEL)Sshing into bastion to access cluster "$(KOPS_BASTION_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Once in the bastion: ssh $(KOPS_BASTION_MASTER_USERNAME)@<master_ip>'; $(NORMAL)
	ssh -A -i $(KOPS_BASTION_PRIVATE_KEY) $(KOPS_BASTION_USERNAME)@$(KOPS_BASTION_ELB)
