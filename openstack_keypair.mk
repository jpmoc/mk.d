_OPENSTACK_KEYPAIR_MK_VERSION= 0.99.3

# OSK_KEYPAIR_DIR?=
# OSK_KEYPAIR_NAME?=
# OSK_PRIVATE_KEY?=
# OSK_PUBLIC_KEY?=

# Derived parameters
OSK_KEYPAIR_DIR?= $(SSH_KEYPAIR_DIR)
OSK_KEYPAIR_NAME?= $(SSH_KEYPAIR_NAME)
OSK_PRIVATE_KEY?= $(SSH_PRIVATE_KEY)
OSK_PUBLIC_KEY?= $(SSH_PUBLIC_KEY)

# Option parameters
__OSK_PUBLIC_KEY?= $(if $(OSK_PUBLIC_KEY), --public-key $(OSK_PUBLIC_KEY))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _osk_view_framework_macros
_osk_view_framework_macros ::
	@echo "OpenStack::Keypair ($(_OPENSTACK_KEYPAIR_MK_VERSION)) macros:"
	@echo

_view_framework_parameters :: _osk_view_framework_parameters
_osk_view_framework_parameters ::
	@echo "OpenStack::Keypair ($(_OPENSTACK_KEYPAIR_MK_VERSION)) parameters:"
	@echo "    OSK_KEYPAIR_DIR=$(OSK_KEYPAIR_DIR)"
	@echo "    OSK_KEYPAIR_NAME=$(OSK_KEYPAIR_NAME)"
	@echo "    OSK_PRIVATE_KEY=$(OSK_PRIVATE_KEY)"
	@echo "    OSK_PUBLIC_KEY=$(OSK_PUBLIC_KEY)"
	@echo

_view_framework_targets :: _osk_view_framework_targets
_osk_view_framework_targets ::
	@echo "OpensStack::Keypair ($(_OPENSTACK_KEYPAIR_MK_VERSION)) targets:"
	@echo "    _osk_create_keypair            - Create a new keypair"
	@echo "    _osk_delete_keypair            - Delete an existing keypair"
	@echo "    _osk_import_keypair            - Import an already-created keypair"
	@echo "    _osk_show_keypair              - Show details of an existing keypair"
	@echo "    _osk_view_keypairs             - List all available keypairs"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_osk_create_keypair:
	@$(INFO) "$(OS_UI_LABEL)Creating keypairs '$(OSK_KEYPAIR_NAME)'..."; $(NORMAL)
	mkdir -v -p $(OSK_KEYPAIR_DIR)
	$(OPENSTACK) keypair create $(OSK_KEYPAIR_NAME) > $(OSK_PRIVATE_KEY)
	cat $(OSK_PRIVATE_KEY)

_osk_delete_keypair:
	@$(INFO) "$(OS_UI_LABEL)Deleting keypairs '$(OSK_KEYPAIR_NAME)'..."; $(NORMAL)
	$(OPENSTACK) keypair delete $(OSK_KEYPAIR_NAME)

_osk_import_keypair:
	@$(INFO) "$(OS_UI_LABEL)Importing keypairs '$(OSK_KEYPAIR_NAME)'..."; $(NORMAL)
	@$(WARN) "The keypair needs to already have been created!"; $(NORMAL)
	ls -al $(OSK_PRIVATE_KEY)
	ls -al $(OSK_PUBLIC_KEY)
	-$(OPENSTACK) keypair create $(__OSK_PUBLIC_KEY) $(OSK_KEYPAIR_NAME)

_osk_show_keypair:
	@$(INFO) "$(OS_UI_LABEL)Showing keypairs '$(OSK_KEYPAIR_NAME)'..."; $(NORMAL)
	$(OPENSTACK) keypair show $(OSK_KEYPAIR_NAME)

_osk_view_keypairs:
	@$(INFO) "$(OS_UI_LABEL)View keypairs ..."; $(NORMAL)
	$(OPENSTACK) keypair list
