_AWS_GLUE_CONNECTION_MK_VERSION=$(_AWS_GLUE_MK_VERSION)

# GLE_CONNECTION_INPUT?= Name=string,Description=string,ConnectionType=string,MatchCriteria=string,string,ConnectionProperties={KeyName1=string,KeyName2=string},PhysicalConnectionRequirements={SubnetId=string,SecurityGroupIdList=[string,string],AvailabilityZone=string}
# GLE_CONNECTION_INPUT_FILEPATH?= ./connection-input.json
# GLE_CONNECTION_NAME?= my-connection
# GLE_CONNECTIONSET_NAME?= my-connection-set

# Derived variables
GLE_CONNECTION_INPUT?= $(if $(GLE_CONNECTION_INPUT_FILEPATH), file://$(GLE_CONNECTION_INPUT_FILEPATH))

# Options variables
__GLE_CONNECTION_INPUT= $(if $(GLE_CONNECTION_INPUT), --connection-input $(GLE_CONNECTION_INPUT))
__GLE_CONNECTION_NAME= $(if $(GLE_CONNECTION_NAME), --connection-name $(GLE_CONNECTION_NAME))
__GLE_FILTER_CONNECTION=
__GLE_NAME_CONNECTION= $(if $(GLE_CONNECTION_NAME), --connection-name $(GLE_CONNECTION_NAME))

# UI variables

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_gle_view_makefile_macros ::
	@echo 'AWS::GLuE::Connection ($(_AWS_GLUE_CONNECTION_MK_VERSION)) macros:'
	@echo

_gle_view_makefile_targets ::
	@echo 'AWS::GLuE::Connection ($(_AWS_GLUE_CONNECTION_MK_VERSION)) targets:'
	@echo '    _gle_creata_connection                 - Create a connection'
	@echo '    _gle_delete_connection                 - Delete a connection'
	@echo '    _gle_show_connection                   - Show details of a connection'
	@echo '    _gle_view_connectionset                - View a connection-set'
	@echo '    _gle_view_connections                  - View connections'
	@echo 

_gle_view_makefile_variables ::
	@echo 'AWS::GLuE::Connection ($(_AWS_GLUE_CONNECTION_MK_VERSION)) variables:'
	@echo '    GLE_CONNECTION_INPUT=$(GLE_CONNECTION_INPUT)'
	@echo '    GLE_CONNECTION_INPUT_FILEPATH=$(GLE_CONNECTION_INPUT_FILEPATH)'
	@echo '    GLE_CONNECTION_NAME=$(GLE_CONNECTION_NAME)'
	@echo '    GLE_CONNECTIONSET_NAME=$(GLE_CONNECTIONSET_NAME)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_gle_create_connection:
	@$(INFO) '$(AWS_LABEL)Creating new connection "$(GLE_CONNECTION_NAME)" ...'; $(NORMAL)
	$(AWS) glue create-connection $(__GLE_CATALOG_ID) $(__GLE_CONNECTION_INPUT)

_gle_delete_connection:
	@$(INFO) '$(AWS_LABEL)Deleting connection "$(GLE_CONNECTION_NAME)" ...'; $(NORMAL)
	$(AWS) glue delete-connection $(__GLE_CATALOG_ID) $(__GLE_CONNECTION_NAME)

_gle_show_connection:
	@$(INFO) '$(AWS_LABEL)Showing connection "$(GLE_CONNECTION_NAME)" ...'; $(NORMAL)
	$(AWS) glue get-connection $(__GLE_CATALOG_ID) $(__GLE_NAME_CONNECTION)

_gle_view_connectionset:
	@$(INFO) '$(AWS_LABEL)Viewing connection-set "$(GLE_CONNECTIONSET_NAME)" ...'; $(NORMAL)
	$(AWS) glue get-connections $(__GLE_CATALOG_ID) $(__GLE_FILTER_CONNECTION)

_gle_view_connections:
	@$(INFO) '$(AWS_LABEL)Viewing connections ...'; $(NORMAL)
	$(AWS) glue get-connections $(__GLE_CATALOG_ID) $(_X__GLE_FILTER_CONNECTION)
