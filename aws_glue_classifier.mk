_AWS_GLUE_CLASSIFIER_MK_VERSION=$(_AWS_GLUE_MK_VERSION)

# GLE_CLASSIFIER_CLASSIFICATION?= 'Amazon CloudWatch Logs'
# GLE_CLASSIFIER_CUSTOM_PATTERNS?= 
# GLE_CLASSIFIER_GROK_PATTERN?= 
# GLE_CLASSIFIER_JSON_PATH?= 
# GLE_CLASSIFIER_NAME?= my-grok-classifier
# GLE_CLASSIFIER_ROW_TAG?=
# GLE_CLASSIFIER_TYPE?= grok
# GLE_CLASSIFIERS?=

# Derived variables
GLE_CLASSIFIER_NAMES?= $(GLE_CLASSIFIER_NAME)
GLE_GROK_CLASSIFIER?= $(if $(filter grok, (GLE_CLASSIFIER_TYPE)), Classification=$(GLE_CLASSIFIER_CLASSIFICATION)$(COMMA)Name=$(GLE_CLASSIFIER_NAME)$(COMMA)GrokPatterns=$(GLE_CLASSIFIER_CUSTOM_PATTERNS))

# Options variables
__GLE_CLASSIFIERS= $(if $(GLE_CLASSIFIER_NAMES), --classifiers $(GLE_CLASSIFIER_NAMES))
__GLE_GROK_CLASSIFIER= $(if $(GLE_GROK_CLASSIFIER), --grok-classifier $(GLE_GROK_CLASSIFIER))
__GLE_JSON_CLASSIFIER= $(if $(GLE_JSON_CLASSIFIER), --json-classifier $(GLE_JSON_CLASSIFIER))
__GLE_NAME_CLASSIFIER= $(if $(GLE_CLASSIFIER_NAME), --name $(GLE_CLASSIFIER_NAME))
__GLE_XMK_CLASSIFIER= $(if $(GLE_XML_CLASSIFIER), --xml-classifier $(GLE_XML_CLASSIFIER))

# UI variables
GLE_UI_VIEW_CLASSIFIERS_FIELDS?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_gle_view_makefile_macros ::
	@#echo "AWS::GLuE::Classifier ($(_AWS_GLUE_MK_VERSION)) macros:"
	@#echo

_gle_view_makefile_targets ::
	@echo "AWS::GLuE::Classifier ($(_AWS_GLUE_CLASSIFIER_MK_VERSION)) targets:"
	@echo "    _gle_create_classifier                 - Create a classifier"
	@echo "    _gle_delete_classifier                 - Delete a classifier"
	@echo "    _gle_show_classifier                   - Show details of a classifier"
	@echo "    _gle_update_classifier                 - Update a classifier"
	@echo "    _gle_view_classifiers                  - View classifiers"
	@echo 

_gle_view_makefile_variables ::
	@echo "AWS::GLuE::Classifier ($(_AWS_GLUE_CLASSIFIER_MK_VERSION)) variables:"
	@echo "    GLE_CLASSIFIER_CLASSIFICATION=$(GLE_CLASSIFIER_CLASSIFICATION)"
	@echo "    GLE_CLASSIFIER_CUSTOM_PATTERNS=$(GLE_CLASSIFIER_CUSTOM_PATTERNS)"
	@echo "    GLE_CLASSIFIER_GROK_PATTERNS=$(GLE_CLASSIFIER_GROK_PATTERNS)"
	@echo "    GLE_CLASSIFIER_JSON_PATH=$(GLE_CLASSIFIER_JSON_PATH)"
	@echo "    GLE_CLASSIFIER_NAME=$(GLE_CLASSIFIER_NAME)"
	@echo "    GLE_CLASSIFIER_NAMES=$(GLE_CLASSIFIER_NAMES)"
	@echo "    GLE_CLASSIFIER_ROW_TAG=$(GLE_CLASSIFIER_ROW_TAG)"
	@echo "    GLE_CLASSIFIER_TYPE=$(GLE_CLASSIFIER_TYPE)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_gle_create_classifier:
	@$(INFO) "$(AWS_LABEL)Creating classifier '$(GLE_CLASSIFIER_NAME)' ..."; $(NORMAL)
	$(AWS) glue create-classifier $(__GLE_GROK_CLASSIFIER) $(__GLE_JSON_CLASSIFIER) $(__GLE_XML_CLASSIFIER)

_gle_delete_classifier:
	@$(INFO) "$(AWS_LABEL)Deleting classifier '$(GLE_CLASSIFIER_NAME)' ..."; $(NORMAL)
	$(AWS) glue delete-classifier $(__GLE_NAME_CLASSIFIER)

_gle_show_classifier:
	@$(INFO) "$(AWS_LABEL)Showing classifier '$(GLE_CLASSIFIER_NAME)' ..."; $(NORMAL)
	$(AWS) glue get-classifier $(__GLE_NAME_CLASSIFIER)

_gle_update_classifier:

_gle_view_classifiers:
	@$(INFO) "$(AWS_LABEL)Viewing classifiers ..."; $(NORMAL)
	$(AWS) glue get-classifiers
