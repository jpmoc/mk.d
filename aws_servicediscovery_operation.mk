_AWS_SERVICEDISCOVERY_OPERATION_MK_VERSION= $(_AWS_SERVICEDISCOVERY_MK_VERSION)

# SDY_OPERATION_ID?= 5pbuqasqkeoeaajymbrtr7jlesnvexgz-jrb504xl
# SDY_OPERATION_NAME?= my-operation
# SDY_OPERATIONS_FILTERS?= Name=string,Values=string,string,Condition=string ...
# SDY_OPERATIONS_SET_NAME?= my-operations-set

# Derived parameters
SDY_OPERATION_NAME?= $(SDY_OPERATION_ID)

# Option parameters
__SDY_OPERATION_ID__OPERATION= $(if $(SDY_OPERATION_ID),--operation-id $(SDY_OPERATION_ID))
__SDY_FILTERS__OPERATIONS= $(if $(SDY_OPERATIONS_FILTERS),--filters $(SDY_OPERATIONS_FILTERS))

# UI parameters
SDY_UI_SHOW_OPERATION_FIELDS?=
SDY_UI_VIEW_OPERATIONS_FIELDS?= 
SDY_UI_VIEW_OPERATIONS_SET_FIELDS?= $(SDY_UI_VIEW_OPERATIONS_FIELDS)
SDY_UI_VIEW_OPERATIONS_SET_QUERYFILTER?=

#--- MACROS

#--- Utilities

#----------------------------------------------------------------------
# USAGE
#

_sdy_view_framework_macros ::
	@echo 'AWS::ServiceDiscoverY::Operation ($(_AWS_SERVICEDISCOVERY_OPERATION_MK_VERSION)) macros:'
	@echo

_sdy_view_framework_parameters ::
	@echo 'AWS::ServiceDiscoverY::Operation ($(_AWS_SERVICEDISCOVERY_OPERATION_MK_VERSION)) parameters:'
	@echo '    SDY_OPERATION_ID=$(SDY_OPERATION_ID)'
	@echo '    SDY_OPERATION_NAME=$(SDY_OPERATION_NAME)'
	@echo '    SDY_OPERATIONS_FILTERS=$(SDY_OPERATIONS_FILTERS)'
	@echo '    SDY_OPERATIONS_SET_NAME=$(SDY_OPERATION_SET_NAME)'
	@echo

_sdy_view_framework_targets ::
	@echo 'AWS::ServiceDiscoverY::Operation ($(_AWS_SERVICEDISCOVERY_OPERATION_MK_VERSION)) targets:'
	@echo '    _sdy_show_operation                    - Show everything related to an operation'
	@echo '    _sdy_show_operation_description        - Show description of an operation'
	@echo '    _sdy_view_operations                   - View operations'
	@echo '    _sdy_view_operations_set               - View a set of operations'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sdy_show_operation: _sdy_show_operation_description

_sdy_show_operation_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of operation "$(SDY_OPERATION_NAME)"...'; $(NORMAL)
	$(AWS) servicediscovery get-operation $(__SDY_OPERATION_ID__OPERATION) --query "@.Operation$(SDY_UI_SHOW_OPERATION_FIELDS)"

_sdy_view_operations:
	@$(INFO) '$(AWS_UI_LABEL)Viewing operations ...'; $(NORMAL)
	$(AWS) servicediscovery list-operations $(_X__SDY_FILTERS__OPERATIONS) $(_X__MAX_ITEMS__OPERATIONS) --query "Operations[]$(SDY_UI_VIEW_OPERATIONS_FIELDS)"

_sdy_view_operartions_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing opeations-set "$(SDY_OPERATIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Operations are grouped based on the provided filters, and/or slice'; $(NORMAL)
	$(AWS) servicediscovery list-operations $(__SDY_FILTERS__OPERATIONS) $(_X__MAX_ITEMS__OPERAITONS) --query "Operations[$(SDY_UI_VIEW_NAMESPACES_SET_FIELDS)]$(SDY_UI_VIEW_NAMESPACES_SET_FIELDS)"
