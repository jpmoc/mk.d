_KN_SUBSCRIPTION_MK_VERSION= $(_KN_MK_VERSION)

# KN_SUBSCRIPTION_NAME?= helloworld-go
# KN_SUBSCRIPTION_NAMESPACE_NAME?= eventing-example
# KN_SUBSCRIPTIONS_NAMESPACE_NAME?= eventing-example
# KN_SUBSCRIPTIONS_SET_NAME?= my-subscriptions-set

# Derived parameters
KN_SUBSCRIPTION_NAMESPACE_NAME?= $(KN_NAMESPACE_NAME)
KN_SUBSCRIPTIONS_NAMESPACE_NAME?= $(KN_SUBSCRIPTION_NAMESPACE_NAME)
KN_SUBSCRIPTIONS_SET_NAME?= knative-subscriptions@@@$(KN_SUBSCRIPTIONS_NAMESPACE_NAME)

# Option parameters
# __KN_ALL_NAMESPACES__SUBSCRIPTIONS=
__KN_NAMESPACE__SUBSCRIPTION= $(if $(KN_SUBSCRIPTION_NAMESPACE_NAME),--namespace $(KN_SUBSCRIPTION_NAMESPACE_NAME))
__KN_NAMESPACE__SUBSCRIPTIONS= $(if $(KN_SUBSCRIPTIONS_NAMESPACE_NAME),--namespace $(KN_SUBSCRIPTIONS_NAMESPACE_NAME))

# Pipe parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kn_view_framework_macros ::
	@echo 'KN::Subscription ($(_KN_SUBSCRIPTION_MK_VERSION)) macros:'
	@echo

_kn_view_framework_parameters ::
	@echo 'KN::Subscription ($(_KN_SUBSCRIPTION_MK_VERSION)) parameters:'
	@echo '    KN_SUBSCRIPTION_NAME=$(KN_SUBSCRIPTION_NAME)'
	@echo '    KN_SUBSCRIPTION_NAMESPACE_NAME=$(KN_SUBSCRIPTION_NAMESPACE_NAME)'
	@echo '    KN_SUBSCRIPTIONS_NAMESPACE_NAME=$(KN_SUBSCRIPTIONS_NAMESPACE_NAME)'
	@echo '    KN_SUBSCRIPTIONS_SET_NAME=$(KN_SUBSCRIPTIONS_SET_NAME)'
	@echo

_kn_view_framework_targets ::
	@echo 'KN::Subscription ($(_KN_SUBSCRIPTION_MK_VERSION)) targets:'
	@echo '    _kn_create_subscription                  - Create a new subscription'
	@echo '    _kn_delete_subscription                  - Delete an existing subscription'
	@echo '    _kn_show_subscription                    - Show everything related to a subscription'
	@echo '    _kn_show_subscription_description        - Show the description of a subscription'
	@echo '    _kn_view_subscriptions                   - View all subscriptions'
	@echo '    _kn_view_subscriptions_set               - View a set of subscriptions'
	@#echo '    _kn_watch_subscriptions                  - Watch subscriptions'
	@#echo '    _kn_watch_subscriptions_set              - Watch a set of subscriptions'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kn_create_subscription:
	@$(INFO) '$(KN_UI_LABEL)Creating subscription "$(KN_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	$(KN) subscription create ... $(__KN_NAMESPACE__SUBSCRIPTION)

_kn_delete_subscription:
	@$(INFO) '$(KN_UI_LABEL)Deleting subscription "$(KN_SUBSCRIPTION_NAME)" ...'; $(NORMAL)

_kn_show_subscription: _kn_show_subscription_description

_kn_show_subscription_description:
	@$(INFO) '$(KN_UI_LABEL)Showing description subscription "$(KN_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	$(KN) subscription describe $(__KN_NAMESPACE__SUBSCRIPTION) $(KN_SUBSCRIPTION_NAME)

_kn_update_subscription:
	@$(INFO) '$(KN_UI_LABEL)Updating subscription "$(KN_SUBSCRIPTION_NAME)" ...'; $(NORMAL)

_kn_view_subscriptions:
	@$(INFO) '$(KN_UI_LABEL)Viewing subscriptions ...'; $(NORMAL)
	$(KN) subscription list --all-namespaces=true $(_X__KN_NAMESPACE__SUBSCRIPTIONS)

_kn_view_subscriptions_set:
	@$(INFO) '$(KN_UI_LABEL)Viewing subscriptions-set "$(KN_SUBSCRIPTIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'subscriptions are grouped based on the provided namespace, and ...'; $(NORMAL)
	$(KN) subscription list --all-namespaces=false $(__KN_NAMESPACE__SUBSCRIPTIONS)

_kn_watch_subscriptions:
	@$(INFO) '$(KN_UI_LABEL)Watching subscriptions ...'; $(NORMAL)

_kn_watch_subscriptions_set:
	@$(INFO) '$(KN_UI_LABEL)Watching subscriptions ...'; $(NORMAL)
