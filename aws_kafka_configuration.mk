_AWS_KAFKA_CONFIGURATION_MK_VERSION= $(_AWS_KAFKA_MK_VERSION)

# KKA_CONFIGURATION_ARN?= arn:aws:kafka:us-east-1:123456789012:configuration/CustomConfiguration/1432a325-8c7e-4a66-8498-8369339e0218-16
# KKA_CONFIGURATION_DESCRIPTION?= "My description"
# KKA_CONFIGURATION_KAFKA_VERSIONS?= 2.8.0 ...
# KKA_CONFIGURATION_NAME?= my-configuration-name
# KKA_CONFIGURATION_REVISION_ID?= 1
# KKA_CONFIGURATION_SERVERPROPERTIES_DIRPATH?= ./in/
# KKA_CONFIGURATION_SERVERPROPERTIES_FILENAME?= serverproperties.txt
# KKA_CONFIGURATION_SERVERPROPERTIES_FILEPATH?= ./in/serverproperties.txt
# KKA_CONFIGURATIONS_SET_NAME?= my-configurations-set

# Derived parameters
KKA_CONFIGURATION_SERVERPROPERTIES_DIRPATH?= $(KKA_INPUTS_DIRPATH)
KKA_CONFIGURATION_SERVERPROPERTIES_FILEPATH?= $(if $(KKA_CONFIGURATION_SERVERPROPERTIES_FILENAME),$(KKA_CONFIGURATION_SERVERPROPERTIES_DIRPATH)$(KKA_CONFIGURATION_SERVERPROPERTIES_FILENAME))

# Option parameters
__KKA_ARN__CONFIGURATION= $(if $(KKA_CONFIGURATION_ARN),--arn $(KKA_CONFIGURATION_ARN))
__KKA_CONFIGURATION_NAME= $(if $(KKA_CONFIGURATION_NAME),--configuration-name $(KKA_CONFIGURATION_NAME))
__KKA_DESCRIPTION__CONFIGURATION= $(if $(KKA_CONFIGURATION_DESCRIPTION),--description $(KKA_CONFIGURATION_DESCRIPTION))
__KKA_KAFKA_VERSIONS= $(if $(KKA_CONFIGURATION_KAFKA_VERSIONS),--kafka-versions $(KKA_CONFIGURATION_KAFKA_VERSIONS))
__KKA_NAME__CONFIGURATION= $(if $(KKA_CONFIGURATION_NAME),--name $(KKA_CONFIGURATION_NAME))
__KKA_SERVER_PROPERTIES= $(if $(KKA_CONFIGURATION_SERVERPROPERTIES_FILEPATH),--server-properties fileb://$(KKA_CONFIGURATION_SERVERPROPERTIES_FILEPATH))

# UI parameters
KKA_UI_VIEW_CONFIGURATIONS_FIELDS?= .{Name: Name,state: State,description: Description}
KKA_UI_VIEW_CONFIGURATIONS_SET_FIELDS?= $(KKA_UI_VIEW_CONFIGURATIONS_FIELDS)
KKA_UI_VIEW_CONFIGURATIONS_SET_SLICE?=

#--- MACROS
_kka_get_configuration_arn= $(call _kka_get_configuration_arn_N, $(KKA_CONFIGURATION_NAME))
_kka_get_configuration_arn_N= $(shell $(AWS) kafka list-configurations --query "Configurations[?Name=='$(strip $(1))'].Arn" --output text)

#----------------------------------------------------------------------
# USAGE
#

_kka_view_framework_macros ::
	@echo 'AWS::KafKA::Configuration ($(_AWS_KAFKA_CONFIGURATION_MK_VERSION)) macros:'
	@echo '    _kka_get_configuration_arn_{|N}                   - Get ARN of a configuration (Name)'
	@echo

_kka_view_framework_parameters ::
	@echo 'AWS::KafKA::Configuration ($(_AWS_KAFKA_CONFIGURATION_MK_VERSION)) parameters:'
	@echo '    KKA_CONFIGURATION_ARN=$(KKA_CONFIGURATION_ARN)'
	@echo '    KKA_CONFIGURATION_KAFKA_VERSIONS=$(KKA_CONFIGURATION_KAFKA_VERSIONS)'
	@echo '    KKA_CONFIGURATION_NAME=$(KKA_CONFIGURATION_NAME)'
	@echo '    KKA_CONFIGURATION_REVISON_ID=$(KKA_CONFIGURATION_REVISION_ID)'
	@echo '    KKA_CONFIGURATION_SERVERPROPERTIES_DIRPATH=$(KKA_CONFIGURATION_SERVERPROPERTIES_DIRPATH)'
	@echo '    KKA_CONFIGURATION_SERVERPROPERTIES_FILENAME=$(KKA_CONFIGURATION_SERVERPROPERTIES_FILENAME)'
	@echo '    KKA_CONFIGURATION_SERVERPROPERTIES_FILEPATH=$(KKA_CONFIGURATION_SERVERPROPERTIES_FILEPATH)'
	@echo '    KKA_CONFIGURATIONS_SET_NAME=$(KKA_CONFIGURATIONS_SET_NAME)'
	@echo

_kka_view_framework_targets ::
	@echo 'AWS::KafKA::Configuration ($(_AWS_KAFKA_CONFIGURATION_MK_VERSION)) targets:'
	@echo '    _kka_create_configuration                 - Create a configuration'
	@echo '    _kka_delete_configuration                 - Delete an existing configuration'
	@echo '    _kka_show_configuration                   - Show everything related to a configuration'
	@echo '    _kka_show_configuration_description       - Show the description of a configuration'
	@echo '    _kka_show_configuration_revisions         - Show the revisions of a configuration'
	@echo '    _kka_show_configuration_serverproperties  - Show the server-properties of a configuration'
	@echo '    _kka_view_configurations                  - View existing configurations'
	@echo '    _kka_view_configurations_set              - View a set of configurations'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGET
#
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kka_create_configuration:
	@$(INFO) '$(KKA_UI_LABEL)Creating configuration "$(KKA_CONFIGURATION_NAME)" ...'; $(NORMAL)
	$(AWS) kafka create-configuration $(__KKA_DESCRIPTION__CONFIGURATION) $(__KKA_KAFKA_VERSIONS) $(__KKA_NAME__CONFIGURATION) $(__KKA_SERVER_PROPERTIES)

_kka_delete_configuration:
	@$(INFO) '$(KKA_UI_LABEL)Deleting configuration "$(KKA_CONFIGURATION_NAME)" ...'; $(NORMAL)
	$(AWS) kafka delete-configuration $(__KKA_ARN__CONFIGURATION)

_kka_show_configuration :: _kka_show_configuration_revisions _kka_show_configuration_serverproperties _kka_show_configuration_description

_kka_show_configuration_description:
	@$(INFO) '$(KKA_UI_LABEL)Showing description of configuration "$(KKA_CONFIGURATION_NAME)" ...'; $(NORMAL)
	$(AWS) kafka describe-configuration $(__KKA_ARN__CONFIGURATION)

_kka_show_configuration_revisions:
	@$(INFO) '$(KKA_UI_LABEL)Showing revisions of configuration "$(KKA_CONFIGURATION_NAME)" ...'; $(NORMAL)
	$(AWS) kafka list-configuration-revisions $(__KKA_ARN__CONFIGURATION)

_kka_show_configuration_serverproperties:
	@$(INFO) '$(KKA_UI_LABEL)Showing server-properties of configuration "$(KKA_CONFIGURATION_NAME)" ...'; $(NORMAL)
	$(if $(KKA_CONFIGURATION_SERVERPROPERTIES_FILEPATH), \
		cat $(KKA_CONFIGURATION_SERVERPROPERTIES_FILEPATH), \
		@echo "KKA_CONFIGURATION_SERVERPROPERTIES_FILEPATH not set"\
	)

_kka_view_configurations:
	@$(INFO) '$(KKA_UI_LABEL)Viewing configurations ...'; $(NORMAL)
	$(AWS) kafka list-configurations --query "Configurations[]$(KKA_UI_VIEW_CONFIGURATIONS_FIELDS)"

_kka_view_configurations_set:
	@$(INFO) '$(KKA_UI_LABEL)Viewing configurations-set "$(KKA_CONFIGURATIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Configurations are grouped based on the slice'; $(NORMAL)
	$(AWS) kafka list-configurations --query "Configurations[$(KKA_UI_VIEW_CONFIGURATIONS_SET_SLICE)]$(KKA_UI_VIEW_CONFIGURATIONS_SET_FIELDS)"
