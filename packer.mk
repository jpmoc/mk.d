_PACKER_MK_VERSION=0.99.6

PKR_COLOR?= false
PKR_CONFIG_DIR?= .

# PKR_BUILDERS_ON?= amazon-ebs openstack
# PKR_BUILDERS_OFF?= amazon-ebs openstack
PKR_DEBUG_MODE?= $(CMN_DEBUG_MODE)
PKR_LABEL?=[packer] #
# PKR_MACHINE_READABLE?=false
# PKR_ON_ERROR?=cleanup
PKR_PARALLEL?=true
PKR_TEMPLATE_DIR?= $(PKR_CONFIG_DIR)
PKR_TEMPLATE_FILENAME?= template.json
# PKR_VALIDATION_SYNTAX?=false
# PKR_VARIABLES+= key=value
PKR_VARIABLES_DIR?= $(PKR_CONFIG_DIR)
PKR_VARIABLES_FILENAME?= variables.json

PKR_TEMPLATE_FILEPATH?= $(PKR_TEMPLATE_DIR)/$(PKR_TEMPLATE_FILENAME)
PKR_VARIABLES_FILEPATH?= $(PKR_VARIABLES_DIR)/$(PKR_VARIABLES_FILENAME)

__PKR_COLOR?= $(if $(filter true, $(PKR_COLOR)), -color=true, -color=false)
__PKR_DEBUG?= $(if $(filter true, $(PKR_DEBUG_MODE)), -debug)
__PKR_EXCEPT?= $(if $(PKR_BUILDERS_OFF), -except=$(subst $(SOACE),$(COMMA),$(PKR_BUILDERS_OFF)))
__PKR_FORCE?= $(if $(filter true, $(PKR_FORCE)), -force)
__PKR_MACHINE_READABLE?= $(if $(filter true, $(PKR_MACHINE_READABLE)), -machine-readable)
__PKR_ON_ERROR?= $(if $(PKR_ON_ERROR), -on-error=$(PKR_ON_ERROR), -on-error=cleanup)
__PKR_ONLY?= $(if $(PKR_BUILDERS_ON), -only=$(subst $(SPACE),$(COMMA),$(PKR_BUILDERS_ON)))
__PKR_PARALLEL?= $(if $(filter true, $(PKR_PARALLEL)), -parallel=true, -parallel=false)
__PKR_SYNTAX_ONLY?= $(if $(PKR_VALIDATION_SYNTAX), -syntax-only)
__PKR_VAR= $(foreach V, $(PKR_VARIABLES), --var "$(V)")
__PKR_VAR_FILE?= $(if $(PKR_VARIABLES_FILEPATH), -var-file=$(PKR_VARIABLES_FILEPATH))


__PACKER_OPTIONS +=

PACKER?= $(__PACKER_ENVIRONMENT) $(PACKER_ENVIRONMENT) packer $(__PACKER_OPTIONS) $(PACKER_OPTIONS)

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_install_framework_dependencies :: _pkr_install_framework_dependencies
_pkr_install_framework_dependencies:
	@$(INFO) "$(PKR_LABEL)Installing framework dependencies ..."; $(NORMAL)
	wget https://releases.hashicorp.com/packer/1.1.3/packer_1.1.3_linux_amd64.zip -O /tmp/packer.zip
	cd /tmp; unzip packer.zip
	cd /tmp; sudo mv packer /usr/local/bin

_view_makefile_macros:: _pkr_view_makefile_macros
_pkr_view_makefile_macros:
	@echo "Packer ($(_PACKER_MK_VERSION)) macros:"
	@echo

_view_makefile_targets :: _pkr_view_makefile_targets
_pkr_view_makefile_targets:
	@echo "Packer ($(_PACKER_MK_VERSION)) targets:"
	@echo "    _pkr_build_image              - Build image based on content of packer file"
	@echo "    _pkr_inspect_template         - Inspect resources in packer file"
	@echo "    _pkr_print_template           - Print packer template"
	@echo "    _pkr_print_variables          - Print packer variables"
	@echo "    _pkr_print_version            - Print packer version"
	@echo "    _pkr_validate_template        - Validate the provided template"
	@echo 

_view_makefile_variables :: _pkr_view_makefile_variables
_pkr_view_makefile_variables:
	@echo "Packer ($(_PACKER_MK_VERSION)) variables:"
	@echo "    PKR_BUILDERS_OFF=$(PKR_BUILDERS_OFF)"
	@echo "    PKR_BUILDERS_ON=$(PKR_BUILDERS_ON)"
	@echo "    PKR_COLOR=$(PKR_COLOR)"
	@echo "    PKR_DEBUG_MODE=$(PKR_DEBUG_MODE)"
	@echo "    PKR_EXCEPT=$(PKR_EXCEPT)"
	@echo "    PKR_MACHINE_READABLE=$(PKR_MACHINE_READABLE)"
	@echo "    PKR_ON_ERROR=$(PKR_ON_ERROR)"
	@echo "    PKR_PARALLEL=$(PKR_PARALLEL)"
	@echo "    PKR_TEMPLATE_DIR=$(PKR_TEMPLATE_DIR)"
	@echo "    PKR_TEMPLATE_FILEPATH=$(PKR_TEMPLATE_FILEPATH)"
	@echo "    PKR_VALIDATION_SYNTAX=$(PKR_VALIDATION_SYNTAX)"
	@echo "    PKR_VARIABLES=$(PKR_VARIABLES)"
	@echo "    PKR_VARIABLES_DIR=$(PKR_VARIABLES_DIR)"
	@echo "    PKR_VARIABLES_FILEPATH=$(PKR_VARIABLES_FILEPATH)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_pkr_build_image:
	@$(INFO) "$(PKR_LABEL)Building image ..."; $(NORMAL)
	$(PACKER) build $(__PKR_COLOR) $(__PKR_DEBUG) $(__PKR_EXCEPT) $(__PKR_FORCE) $(__PKR_MACHINE_READABLE) $(__PKR_ON_ERROR) $(__PKR_ONLY) $(__PKR_PARALLEL) $(__PKR_VAR) $(__PKR_VAR_FILE) $(PKR_TEMPLATE_FILEPATH)

_pkr_inspect_template:
	@$(INFO) "$(PKR_LABEL)Inspecting template '$(PKR_TEMPLATE_FILEPATH)'  ..."; $(NORMAL)
	$(PACKER) inspect $(__PKR_MACHINE_READABLE) $(PKR_TEMPLATE_FILEPATH)

_pkr_print_template:
	@$(INFO) "$(PKR_LABEL)Displaying template '$(PKR_TEMPLATE_FILEPATH)' ..."; $(NORMAL)
	cat $(PKR_TEMPLATE_FILEPATH)

_pkr_print_variables:
	@$(INFO) "$(PKR_LABEL)Displaying variable '$(PKR_VARIABLES_FILEPATH)' ..."; $(NORMAL)
	cat $(PKR_VARIABLES_FILEPATH)

_pkr_print_version:
	@$(INFO) "$(PKR_LABEL)Displaying version  ..."; $(NORMAL)
	$(PACKER) version

_pkr_validate_template:
	@$(INFO) "$(PKR_LABEL)Validating configuration  ..."; $(NORMAL)
	$(PACKER) validate $(__PKR_EXCEPT) $(__PKR_ONLY) $(__PKR_SYNTAX_ONLY) $(__PKR_VAR) $(__PKR_VAR_FILE) $(PKR_TEMPLATE_FILEPATH)
