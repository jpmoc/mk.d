_KN_CHANNEL_MK_VERSION= $(_KN_MK_VERSION)

# KN_CHANNEL_CURL_BIN?= time curl
# KN_CHANNEL_NAME?= helloworld-go
# KN_CHANNEL_NAMESPACE_NAME?= eventing-example
# KN_CHANNELS_NAMESPACE_NAME?= eventing-example
# KN_CHANNELS_SET_NAME?= my-channels-set

# Derived parameters
KN_CHANNEL_NAMESPACE_NAME?= $(KN_NAMESPACE_NAME)
KN_CHANNELS_NAMESPACE_NAME?= $(KN_CHANNEL_NAMESPACE_NAME)
KN_CHANNELS_SET_NAME?= knative-channels@@@$(KN_CHANNELS_NAMESPACE_NAME)

# Options
# __KN_ALL_NAMESPACES__CHANNELS=
__KN_NAMESPACE__CHANNEL= $(if $(KN_CHANNEL_NAMESPACE_NAME),--namespace $(KN_CHANNEL_NAMESPACE_NAME))
__KN_NAMESPACE__CHANNELS= $(if $(KN_CHANNELS_NAMESPACE_NAME),--namespace $(KN_CHANNELS_NAMESPACE_NAME))

# Customizations

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kn_list_macros ::
	@#echo 'KN::Channel ($(_KN_CHANNEL_MK_VERSION)) macros:'
	@#echo

_kn_list_parameters ::
	@echo 'KN::Channel ($(_KN_CHANNEL_MK_VERSION)) parameters:'
	@echo '    KN_CHANNEL_NAME=$(KN_CHANNEL_NAME)'
	@echo '    KN_CHANNEL_NAMESPACE_NAME=$(KN_CHANNEL_NAMESPACE_NAME)'
	@echo '    KN_CHANNELS_NAMESPACE_NAME=$(KN_CHANNELS_NAMESPACE_NAME)'
	@echo '    KN_CHANNELS_SET_NAME=$(KN_CHANNELS_SET_NAME)'
	@echo

_kn_list_targets ::
	@echo 'KN::Channel ($(_KN_CHANNEL_MK_VERSION)) targets:'
	@echo '    _kn_create_channel                  - Create a new channel'
	@echo '    _kn_delete_channel                  - Delete an existing channel'
	@echo '    _kn_show_channel                    - Show everything related to a channel'
	@echo '    _kn_show_channel_description        - Show the description of a channel'
	@echo '    _kn_list_channels                   - List all channels'
	@echo '    _kn_list_channels_set               - List a set of channels'
	@#echo '    _kn_watch_channels                  - Watch channels'
	@#echo '    _kn_watch_channels_set              - Watch a set of channels'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kn_create_channel:
	@$(INFO) '$(KN_UI_LABEL)Creating channel "$(KN_CHANNEL_NAME)" ...'; $(NORMAL)
	$(KN) channel create ... $(__KN_NAMESPACE__CHANNEL_CHANNEL_NAME)

_kn_delete_channel:
	@$(INFO) '$(KN_UI_LABEL)Deleting channel "$(KN_CHANNEL_NAME)" ...'; $(NORMAL)

_kn_list_channels:
	@$(INFO) '$(KN_UI_LABEL)Listing channels ...'; $(NORMAL)
	$(KN) channel list --all-namespaces=true $(_X__KN_NAMESPACE__CHANNELS) $(__KN_TARGET__CHANNELS)

_kn_list_channels_set:
	@$(INFO) '$(KN_UI_LABEL)Listing channels-set "$(KN_CHANNELS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'channels are grouped based on the provided namespace, and ...'; $(NORMAL)
	$(KN) channel list --all-namespaces=false $(__KN_NAMESPACE__CHANNELS) $(__KN_TARGET__CHANNELS)

_kn_show_channel: _kn_show_channel_description

_kn_show_channel_description:
	@$(INFO) '$(KN_UI_LABEL)Showing description channel "$(KN_CHANNEL_NAME)" ...'; $(NORMAL)
	$(KN) channel describe $(__KN_NAMESPACE__CHANNEL) $(KN_CHANNEL_NAME)

_kn_update_channel:
	@$(INFO) '$(KN_UI_LABEL)Updating channel "$(KN_CHANNEL_NAME)" ...'; $(NORMAL)

_kn_watch_channels:
	@$(INFO) '$(KN_UI_LABEL)Watching channels ...'; $(NORMAL)

_kn_watch_channels_set:
	@$(INFO) '$(KN_UI_LABEL)Watching channels ...'; $(NORMAL)
