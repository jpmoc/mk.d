_AWS_APPSTREAM_IMAGEBUILDER_MK_VERSION= $(_AWS_APPSTREAM_MK_VERSION)

# ASM_IMAGEBUILDER_NAME?= 
# ASM_IMAGEBUILDER_NAMES?= 
# ASM_IMAGEBUILDERS_SET_NAME?= 

# Derived parameters
ASM_IMAGEBUILDER_NAMES?= $(ASM_IMAGEBUILDER_NAME)

# Option parameters
__ASM_NAMES__IMAGEBUILDER= $(if $(ASM_IMAGEBUILDER_NAMES), --names $(ASM_IMAGEBUILDER_NAMES))

# UI parameters
ASM_UI_VIEW_IMAGEBUILDERS__FIELDS?=
ASM_UI_VIEW_IMAGEBUILDERS_SET_FIELDS?= $(ASM_UI_VIEW_IMAGEBUILDERS_FIELDS)
ASM_UI_VIEW_IMAGEBUILDERS_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_asm_view_framework_macros ::
	@echo 'AWS::AppStreaM::ImageBuilder ($(_AWS_APPSTREAM_IMAGEBUILDER_MK_VERSION)) macros:'
	@echo

_asm_view_framework_parameters ::
	@echo 'AWS::AppStreaM::ImageBuilder ($(_AWS_APPSTREAM_IMAGEBUILDER_MK_VERSION)) parameters:'
	@echo '    ASM_IMAGEBUILDER_NAME=$(ASM_IMAGEBUILDER_NAME)'
	@echo '    ASM_IMAGEBUILDER_NAMES=$(ASM_IMAGEBUILDER_NAMES)'
	@echo '    ASM_IMAGEBUILDERS_SET_NAME=$(ASM_IMAGEBUILDERS_SET_NAME)'
	@echo

_asm_view_framework_targets ::
	@echo 'AWS::AppStreaM::ImageBuilder ($(_AWS_APPSTREAM_IMAGEBUILDER_MK_VERSION)) targets:'A
	@echo '    _asm_create_imagebuilder               - Create a new image-builder'
	@echo '    _asm_delete_imagebuilder               - Delete an existing image-builder'
	@echo '    _asm_show_imagebuilder                 - Show everything related to a image-builder'
	@echo '    _asm_view_imagebuilders                - View image-builders'
	@echo '    _asm_view_imagebuilders_set            - View a set of image-builders'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_asm_create_imagebuilder:

_asm_delete_imagebuilder:

_asm_show_imagebuilder:

_asm_view_imagebuilders:
	@$(INFO) '$(AWS_UI_LABEL)Viewing image-builders ...'; $(NORMAL)
	$(AWS) appstream describe-image-builders $(_X__ASM_NAMES__IMAGEBUILDER)

_asm_view_imagebuilders_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing image-builders-set "$(ASM_IMAGEBUILDERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Fleets are grouped based on the provided imagebuilder-names and/or slice'; $(NORMAL)
	$(AWS) appstream describe-image-builders $(__ASM_NAMES__IMAGEBUILDER)
