_OPENSTACK_USER_MK_VERSION= 0.99.3

# OSU_USERNAME?=

# Derived parameters
OSU_USERNAME?= $(OS_USERNAME)

# Option parameters

# UI parameters
#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _osu_view_framework_macros
_osu_view_framework_macros ::
	@echo "OpenStack::User ($(_OPENSTACK_USER_MK_VERSION)) macros:"
	@echo


_view_framework_targets :: _osu_view_framework_targets
_osu_view_framework_targets ::
	@echo "OpensStack::User ($(_OPENSTACK_USER_MK_VERSION)) targets:"
	@echo "    _osu_show_user              - Show details on given user"
	@echo "    _osu_view_users             - List available users"
	@echo

_view_framework_parameters :: _osu_view_framework_parameters
_osu_view_framework_parameters ::
	@echo "OpenStack::User ($(_OPENSTACK_USER_MK_VERSION)) parameters:"
	@echo "    OSU_USERNAME=$(OSU_USERNAME)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#


_osu_show_user:
	@$(INFO) "$(OS_UI_LABEL)Show user '$(OSU_USERNAME)' ..."; $(NORMAL)
	$(OPENSTACK) user show $(OSU_USERNAME)

_osu_view_users:
	@$(INFO) "$(OS_UI_LABEL)View users ..."; $(NORMAL)
	$(OPENSTACK) user list --long
