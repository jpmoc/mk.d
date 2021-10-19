_AWS_TRANSLATE_MK_VERSION= 0.99.6

# TLE_SOURCE_LANGUAGE_CODE?= fr
# TLE_TARGET_LANGUAGE_CODE?= es
# TLE_TEXT?= "C'est le texte at traduire!"

# Derived parameters

# Option parameters
__TLE_SOURCE_LANGUAGE_CODE?= $(if $(TLE_SOURCE_LANGUAGE_CODE), --source-language-code $(TLE_SOURCE_LANGUAGE_CODE))
__TLE_TARGET_LANGUAGE_CODE?= $(if $(TLE_TARGET_LANGUAGE_CODE), --target-language-code $(TLE_TARGET_LANGUAGE_CODE))
__TLE_TEXT?= $(if $(TLE_TEXT), --text $(TLE_TEXT))

# UI
TLE_UI_LABEL= $(AWS_UI_LABEL)

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _tle_view_framework_macros
_tle_view_framework_macros:
	@echo 'AWS::TransLatE ($(_AWS_TRANSLATE_MK_VERSION)) macros:'
	@echo

_aws_view_framework_variables :: _tle_view_framework_variables
_tle_view_framework_variables:
	@echo 'AWS::TransLatE ($(_AWS_TRANSLATE_MK_VERSION)) variables:'
	@echo '    TLE_SOURCE_LANGUAGE_CODE=$(TLE_SOURCE_LANGUAGE_CODE)'
	@echo '    TLE_TARGET_LANGUAGE_CODE=$(TLE_TARGET_LANGUAGE_CODE)'
	@echo '    TLE_TEXT=$(TLE_TEXT)'
	@echo

_aws_view_framework_targets :: _tle_view_framework_targets
_tle_view_framework_targets:
	@echo 'AWS::TransLatE ($(_AWS_TRANSLATE_MK_VERSION)) targets:'
	@echo '    _tle_create_cluster                 - Create a redshift cluster'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tle_translate_text:
	@$(INFO) '$(TLE_UI_LABEL)Translating input text ...'; $(NORMAL)
	$(AWS) translate translate-text $(__TLE_SOURCE_LANGUAGE_CODE) $(__TLE_TARGET_LANGUAGE_CODE) $(__TLE_TEXT)
