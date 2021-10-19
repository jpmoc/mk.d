_CHEF_KNIFE_MK_VERSION=0.99.1

# KFE_CONFIG_DIR?= $(HOME)/chef-repo/.chef
KFE_CONFIG_FILENAME?= knife.rb
# KFE_EDITOR?= vi
# KFE_KEY_FILENAME= knife.pem
KFE_LABEL?= $(CHF_LABEL)
# KFE_MODE_DEBUG?= false
# KFE_MODE_INTERACTIVE?= false
# KFE_ORGANIZATION_NAME?=
# KFE_OUTPUT_FORMAT?= json
# KFE_SERVER_NAME?= chef-server.example.com
# KFE_WITH_URI?= true

# Derived variables
KFE_CONFIG_FILEPATH?= $(if $(KFE_CONFIG_DIR), $(KFE_CONFIG_DIR)/$(KFE_CONFIG_FILENAME))
KFE_KEY_DIR?= $(KFE_CONFIG_DIR)
KFE_KEY_FILEPATH?= $(if $(KFE_KEY_FILENAME), $(KFE_KEY_DIR)/$(KFE_KEY_FILENAME))
KFE_MODE_DEBUG?= $(CMN_MODE_DEBUG)
KFE_MODE_INTERACTIVE?= $(CMN_MODE_INTERACTIVE)
KFE_SERVER_URL?= $(if $(KFE_SERVER_NAME), https://$(KFE_SERVER_NAME)/organizations/$(KFE_ORGANIZATION_NAME))

# Options
__KFE_CONFIG?=$(if $(KFE_CONFIG_FILEPATH), --config $(KFE_CONFIG_FILEPATH))
__KFE_EDITOR?=$(if $(KFE_EDITOR), --editor $(KFE_EDITOR))
__KFE_FORMAT?=$(if $(KFE_OUTPUT_FORMAT), --format $(KFE_OUTPUT_FORMAT))
__KFE_KEY?=$(if $(KFE_KEY_FILEPATH), --key $(KFE_KEY_FILEPATH))
__KFE_SERVER_URL?=$(if $(KFE_SERVER_URL), --server-url $(KFE_SERVER_URL))
__KFE_VERBOSE?=$(if $(filter true, $(KFE_MODE_DEBUG)), --verbose)
__KFE_WITH_URI?=$(if $(filter true, $(KFE_WITH_URI)), --with-uri)

__KFE_SUBCOMMAND_OPTIONS+= $(__KFE_CONFIG)
__KFE_SUBCOMMAND_OPTIONS+= $(__KFE_EDITOR)
__KFE_SUBCOMMAND_OPTIONS+= $(__KFE_FORMAT)
__KFE_SUBCOMMAND_OPTIONS+= $(__KFE_KEY)
__KFE_SUBCOMMAND_OPTIONS+= $(__KFE_SERVER_URL)
__KFE_SUBCOMMAND_OPTIONS+= $(__KFE_VERBOSE)

# Command
KNIFE= $(__KNIFE_ENVIRONMENT)  $(KNIFE_ENVIRONMENT) knife $(__KNIFE_OPTIONS) $(KNIFE_OPTIONS)

# Macros

#----------------------------------------------------------------------
# USAGE
#

_chf_view_makefile_macros :: _kfe_view_makefile_macros
_kfe_view_makefile_macros ::
	@#echo "Chef::KniFE ($(_CHEF_KNIFE_MK_VERSION)) targets:"
	@#echo

_chf_view_makefile_targets :: _kfe_view_makefile_targets
_kfe_view_makefile_targets ::
	@echo "Chef::KniFE ($(_CHEF_KNIFE_MK_VERSION)) targets:"
	@echo "    _kfe_check_ssl                          - Check SSL certificate against chef server"
	@echo "    _kfe_fetch_ssl                          - Fetch SSL certificate from chef server"
	@echo

_chf_view_makefile_variables :: _kfe_view_makefile_variables
_kfe_view_makefile_variables ::
	@echo "Chef::KniFE ($(_CHEF_KNIFE_MK_VERSION)) variables:"
	@echo "    KFE_CONFIG_DIR=$(KFE_CONFIG_DIR)"
	@echo "    KFE_CONFIG_FILENAME=$(KFE_CONFIG_FILENAME)"
	@echo "    KFE_CONFIG_FILEPATH=$(KFE_CONFIG_FILEPATH)"
	@echo "    KFE_EDITOR=$(KFE_EDITOR)"
	@echo "    KFE_KEY_DIR=$(KFE_KEY_DIR)"
	@echo "    KFE_KEY_FILENAME=$(KFE_KEY_FILENAME)"
	@echo "    KFE_KEY_FILEPATH=$(KFE_KEY_FILEPATH)"
	@echo "    KFE_MODE_DEBUG=$(KFE_MODE_DEBUG)"
	@echo "    KFE_MODE_INTERACTIVE=$(KFE_MODE_INTERACTIVE)"
	@echo "    KFE_ORGANIZATION_NAME=$(KFE_ORGANIZATION_NAME)"
	@echo "    KFE_OUTPUT_FORMAT=$(KFE_OUTPUT_FORMAT)"
	@echo "    KFE_SERVER_NAME=$(KFE_SERVER_NAME)"
	@echo "    KFE_SERVER_URL=$(KFE_SERVER_URL)"
	@echo "    KFE_WITH_URI=$(KFE_WITH_URI)"
	@echo "    KNIFE=$(KNIFE)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/chef_knife_client.mk
-include $(MK_DIR)/chef_knife_cookbook.mk
-include $(MK_DIR)/chef_knife_databag.mk
-include $(MK_DIR)/chef_knife_environment.mk
-include $(MK_DIR)/chef_knife_node.mk
-include $(MK_DIR)/chef_knife_role.mk
-include $(MK_DIR)/chef_knife_user.mk


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kfe_check_ssl:
	@$(INFO) "$(KFE_LABEL)Checking ssl from '$(KFE_SERVER_NAME)' ..."; $(NORMAL)
	$(KNIFE) ssl check $(__KFE_SUBCOMMAND_OPTIONS)

_kfe_fetch_ssl:
	@$(INFO) "$(KFE_LABEL)Fetching ssl from '$(KFE_SERVER_NAME)' ..."; $(NORMAL)
	$(KNIFE) ssl fetch $(__KFE_SUBCOMMAND_OPTIONS)
