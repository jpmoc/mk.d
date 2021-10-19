_KN_ROUTE_MK_VERSION= $(_KN_MK_VERSION)

# KN_ROUTE_NAME?= helloworld-go
# KN_ROUTE_NAMESPACE_NAME?= default
# KN_ROUTE_SERVICE_NAME?= helloworld-go
# KN_ROUTES_NAMESPACE_NAME?= default

# Derived parameters
KN_ROUTE_SERVICE_NAME?= $(KN_SERVICE_NAME)
KN_ROUTE_NAME?= $(KN_ROUTE_SERVICE_NAME)
KN_ROUTE_NAMESPACE_NAME?= $(KN_NAMESPACE_NAME)
KN_ROUTES_NAMESPACE_NAME?= $(KN_ROUTE_NAMESPACE_NAME)
# KN_ROUTES_SET_NAME?= knative-routes@@@$(KN_ROUTES_NAMESPACE_NAME)

# Option parameters
__KN_NAMESPACE__ROUTE= $(if $(KN_ROUTE_NAMESPACE_NAME),--namespace $(KN_ROUTE_NAMESPACE_NAME))
__KN_NAMESPACE__ROUTES= $(if $(KN_ROUTES_NAMESPACE_NAME),--namespace $(KN_ROUTES_NAMESPACE_NAME))

# Pipe parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kn_view_framework_macros ::
	@echo 'KN::Route ($(_KN_ROUTE_MK_VERSION)) macros:'
	@echo

_kn_view_framework_parameters ::
	@echo 'KN::Route ($(_KN_ROUTE_MK_VERSION)) parameters:'
	@echo '    KN_ROUTE_NAME=$(KN_ROUTE_NAME)'
	@echo '    KN_ROUTE_NAMESPACE_NAME=$(KN_ROUTE_NAMESPACE_NAME)'
	@echo '    KN_ROUTE_SERVICE_NAME=$(KN_ROUTE_SERVICE_NAME)'
	@echo '    KN_ROUTES_NAMESPACE_NAME=$(KN_ROUTES_NAMESPACE_NAME)'
	@#echo '    KN_ROUTES_SELECTOR=$(KN_ROUTES_SELECTOR)'
	@#echo '    KN_ROUTES_SET_NAME=$(KN_ROUTES_SET_NAME)'
	@echo

_kn_view_framework_targets ::
	@echo 'KN::Route ($(_KN_ROUTE_MK_VERSION)) targets:'
	@echo '    _kn_show_route                    - Show everything related to a route'
	@echo '    _kn_show_route_description        - Show the description of a route'
	@echo '    _kn_view_routes                   - View all routes'
	@#echo '    _kn_view_routes_set               - View a set of routes'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kn_show_route: _kn_show_route_description

_kn_show_route_description:
	@$(INFO) '$(KN_UI_LABEL)Showing description route "$(KN_ROUTE_NAME)" ...'; $(NORMAL)
	$(KN) route describe $(__KN_NAMESPACE__ROUTE) $(KN_ROUTE_NAME)

_kn_view_routes:
	@$(INFO) '$(KN_UI_LABEL)Viewing routes ...'; $(NORMAL)
	$(KN) route list --all-namespaces=true $(_X__KN_NAMESPACE__ROUTES) $(__KN_TARGET__ROUTES)

_kn_view_routes_set:
	@$(INFO) '$(KN_UI_LABEL)Viewing routes-set "$(KN_ROUTES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'routes are grouped based on the provided namespace, and ...'; $(NORMAL)
	$(KN) route list --all-namespaces=false $(__KN_NAMESPACE__ROUTES) $(__KN_TARGET__ROUTES)
