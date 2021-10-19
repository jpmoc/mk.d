_CONSUL_KVPAIR_MK_VERSION= $(_CONSUL_MK_VERSION)

# CSL_KVPAIR_KEY?= backend
# CSL_KVPAIR_NAME?=
CSL_KVPAIR_RECURSE_FLAG?= false
# CSL_KVPAIR_VALUE?= 123456

# Derived variables
CSL_KVPAIR_NAME?= $(CSL_KVPAIR_KEY)

# Options variables
__CSL_RECURSE= $(if $(filter true,$(CSL_KVPAIR_RECURSE_FLAG)),--recurse)

# Pipe

# UI parameters

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_csl_view_framework_macros ::
	@echo 'ConSuL::KeyValue ($(_CONSUL_KVPAIR_MK_VERSION)) macros:'
	@echo

_csl_view_framework_parameters ::
	@echo 'ConSuL::KeyValue ($(_CONSUL_KVPAIR_MK_VERSION)) parameters:'
	@echo '    CSL_KVPAIR_KEY=$(CSL_KVPAIR_KEY)'
	@echo '    CSL_KVPAIR_NAME=$(CSL_KVPAIR_NAME)'
	@echo '    CSL_KVPAIR_RECURSE_FLAG=$(CSL_KVPAIR_RECURSE_FLAG)'
	@echo '    CSL_KVPAIR_VALUE=$(CSL_DIG_KVPAIR_VALUE)'
	@echo '    CSL_KVPAIR_SET_NAME=$(CSL_KVPAIR_SET_NAME)'
	@echo

_csl_view_framework_targets ::
	@echo 'ConSuL::KeyValue ($(_CONSUL_KVPAIR_MK_VERSION)) targets:'
	@echo '    _csl_create_kvpair                - Create a key-value pair'
	@echo '    _csl_delete_kvpair                - Delete a key-value pair'
	@echo '    _csl_show_kvpair                  - Show everything related to a key-valu pair'
	@echo '    _csl_show_kvpair_description      - Show description of a key-valu pair'
	@echo '    _csl_view_kvpairs                 - View key-value pairs'
	@echo '    _csl_view_kvpairs_set             - View a set of key-value pairs'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csl_create_kvpair:
	@$(INFO) '$(CSL_UI_LABEL)Creating/updating a key-value pair "$(CSL_KVPAIR_NAME)" ...'; $(NORMAL)
	$(CONSUL) kv put $(__CSL_HTTP_ADDR) $(CSL_KVPAIR_KEY) $(CSL_KVPAIR_VALUE)

_csl_delete_kvpair:
	@$(INFO) '$(CSL_UI_LABEL)Deleting a key-value pair "$(CSL_KVPAIR_NAME)" ...'; $(NORMAL)
	$(CONSUL) kv deelte $(__CSL_HTTP_ADDR) $(CSL_KVPAIR_KEY)

_csl_show_kvpair: _csl_show_kvpair_description

_csl_show_kvpair_description:
	@$(INFO) '$(CSL_UI_LABEL)Showing description of key-value pair "$(CSL_KVPAIR_NAME)" ...'; $(NORMAL)
	$(CONSUL) kv get $(__CSL_HTTP_ADDR) $(__CSL_RECURSE) $(CSL_KVPAIR_KEY)

_csl_update_kvpair: _csl_create_kvpair

_csl_view_kvpairs:

_csl_view_kvpairs_set:
