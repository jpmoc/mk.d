_CHEF_KNIFE_MK_VERSION=0.99.1

# KFE_COOKBOOK_NAME?= learn_chef_apache2
KFE_COOKBOOK_UPLOAD_CONCURRENCY?= 10
# KFE_COOKBOOK_UPLOAD_DRYRUN?= false
# KFE_COOKBOOK_UPLOAD_FORCE?= false
# KFE_COOKBOOK_UPLOAD_PURGE?= false
KFE_COOKBOOK_UPLOAD_RECURSE?= true
# KFE_COOKBOOK_VERSION?= 0.3.0
# KFE_COOKBOOK_VERSION_FREEZE?= false

# Derived variables

# Options
__KFE_CONCURRENCY?= $(if $(KFE_COOKBOOK_UPLOAD_CONCURRENCY), --concurrency $(KFE_COOKBOOK_UPLOAD_CONCURRENCY))
__KFE_DRY_RUN_UPLOAD?=$(if $(filter true, $(KFE_COOKBOOK_UPLOAD_DRYRUN)), --dry-run)
__KFE_FORCE_UPLOAD?=$(if $(filter true, $(KFE_COOKBOOK_UPLOAD_FORCE)), --force, --no-force)
__KFE_FREEZE?=$(if $(filter true, $(KFE_COOKBOOK_VERSION_FREEZE)), --freeze, -no-freeze)
__KFE_PURGE?=$(if $(filter false, $(KFE_COOKBOOK_UPLOAD_PURGE)), --purge, --no-purge)
__KFE_RECURSE?=$(if $(filter false, $(KFE_COOKBOOK_UPLOAD_RECURSE)), --no-recurse, --recurse)

# Command

# Macros

#----------------------------------------------------------------------
# USAGE
#

_kfe_view_makefile_macros ::
	@#echo "Chef::KniFE::Cookbook ($(_CHEF_KNIFE_COOKBOOK_MK_VERSION)) targets:"
	@#echo

_kfe_view_makefile_targets ::
	@echo "Chef::KniFE::Cookbook ($(_CHEF_KNIFE_COOKBOOK_MK_VERSION)) targets:"
	@echo "    _kfe_download_cookbooks                 - Download all cookbooks from chef server"
	@echo "    _kfe_import_cookbook_github             - Import a cookbook from github"
	@echo "    _kfe_import_cookbook_opscode            - Import a cookbook from opscode"
	@echo "    _kfe_view_cookbooks                     - View available cookbooks on chef server"
	@echo "    _kfe_upload_cookbook                    - Upload a cookbook to chef server"
	@echo

_kfe_view_makefile_variables ::
	@echo "Chef::KniFE::Cookbook ($(_CHEF_KNIFE_COOKBOOK_MK_VERSION)) variables:"
	@echo "    KFE_COOKBOOK_NAME=$(KFE_COOKBOOK_NAME)"
	@echo "    KFE_COOKBOOK_UPLOAD_DRYRUN=$(KFE_COOKBOOK_UPLOAD_DRYRUN)"
	@echo "    KFE_COOKBOOK_UPLOAD_FORCE=$(KFE_COOKBOOK_UPLOAD_FORCE)"
	@echo "    KFE_COOKBOOK_UPLOAD_PURGE=$(KFE_COOKBOOK_UPLOAD_PURGE)"
	@echo "    KFE_COOKBOOK_UPLOAD_RECURSE=$(KFE_COOKBOOK_UPLOAD_RECURSE)"
	@echo "    KFE_COOKBOOK_VERSION=$(KFE_COOKBOOK_VERSION)"
	@echo "    KFE_COOKBOOK_VERSION_FREEZE=$(KFE_COOKBOOK_VERSION_FREEZE)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kfe_download_cookbooks:
	@$(INFO) "$(KFE_LABEL)Downloading cookbooks ..."; $(NORMAL)
	$(KNIFE) download /

_kfe_import_cookbook_github:
	@$(INFO) "$(KFE_LABEL)Downloading cookbook '$(KFE_COOKBOOK_NAME)' from github ..."; $(NORMAL)
	@$(WARN) "Required plugin: https://github.com/websterclay/knife-github-cookbooks"; $(NORMAL)
	$(KNIFE) cookbook github install $(__KFE_SUBCOMMAND_OPTIONS) $(KFE_COOKBOOK_NAME)

_kfe_import_cookbook_opscode:
	@$(INFO) "$(KFE_LABEL)Downloading cookbook '$(KFE_COOKBOOK_NAME)' from opscode ..."; $(NORMAL)
	$(KNIFE) cookbook site install $(__KFE_SUBCOMMAND_OPTIONS) $(KFE_COOKBOOK_NAME)

_kfe_upload_all_cookbooks:
	@$(INFO) "$(KFE_LABEL)Uploading all cookbook to chef server..."; $(NORMAL)
	$(KNIFE) cookbook upload $(__KFE_SUBCOMMAND_OPTIONS) \
		--all $(__KFE_CONCURRENCY) $(__KFE_INCLUDE_DEPENDENCIES) $(X_KFE_COOKBOOK_NAME)

_kfe_upload_cookbook:
	@$(INFO) "$(KFE_LABEL)Uploading cookbook '$(KFE_COOKBOOK_NAME)' to chef server..."; $(NORMAL)
	$(KNIFE) cookbook upload $(__KFE_SUBCOMMAND_OPTIONS) \
		$(_X__KFE_ALL) $(__KFE_CONCURRENCY) $(__KFE_DRY_RUN_UPLOAD) $(__KFE_FORCE_UPLOAD) $(__KFE_FREEZE) $(__KFE_INCLUDE_DEPENDENCIES) $(KFE_COOKBOOK_NAME)

_kfe_view_cookbooks:
	@$(INFO) "$(KFE_LABEL)Viewing cookbooks ..."; $(NORMAL)
	$(KNIFE) cookbook list $(__KFE_SUBCOMMAND_OPTIONS) $(__KFE_WITH_URI)
