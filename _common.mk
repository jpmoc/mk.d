_COMMON_MK_VERSION= 0.99.1

CMN_UI_LABEL?= [common] #

COMMA= ,#
# MAKE_ENVIRONMENT?=FOO=1
# MAKE_OPTIONS?= -e -n -p --silent FOO=1
DEBUG_FLAG?= false
# INPUTS_DIRPATH?= ./in/
MK_DIRPATH?= ./mk.d/
# OUTPUTS_DIRPATH?= ./out/
SILENT_FLAG?= $(if $(filter s, $(MAKEFLAGS)),true,false)
INTERACTIVE_FLAG?= false
NOWAIT_FLAG?= false
TMP_DIRPATH?= /tmp/$(CMN_DATE_YYYYMMDD)
VERBOSITY_LEVEL?= 0
YES_FLAG?= false

# Utilities
CURL?= curl
# __DATE_ENVIRONMENT?= TZ='America/Los_Angeles'
DATE_BIN?= date
DATE?= $(strip $(__DATE_ENVIRONMENT) $(DATE_ENVIRONMENT) $(DATE_BIN) $(__DATE_OPTIONS) $(DATE_OPTIONS) )
DIG?= dig
ECHO?= /bin/echo
READER?= cat
WRITER?= vim
MD5SUM?= openssl md5
UNTAR?= tar -x
UNZIP?= unzip
WEBBROWSER?= chrome
TAR?= tar
ZIP?= zip

HOST?= $(shell hostname -s)
HOSTNAME?= $(shell hostname)

# Directory in which make was executed
# MAKE_DIR?= $(PWD)
SHELL:=/bin/sh
SOURCE:= .
SUDO:= sudo
SPACE=
SPACE+=

# Use := instead of = because the latter causes make to use late-binding
# and MAKEFILE_LIST may have changed due to later includes.
# TOP:= $(dir $(lastword $(MAKEFILE_LIST)))

# To find out the correctponding char sequence, use 'tput setaf 2 | xxd'
WHITE= $(if $(TERM), tput setaf 0;)
RED= $(if $(TERM),tput setaf 1;)
GREEN= $(if $(TERM),tput setaf 2;)
YELLOW= $(if $(TERM),tput setaf 3;)
BLUE= $(if $(TERM),tput setaf 4;)
PURPLE= $(if $(TERM),tput setaf 5;)
CYAN= $(if $(TERM),tput setaf 6;)
WHITE= $(if $(TERM),tput setaf 7;)
BLACK= $(if $(TERM),tput setaf 16;)

HIGHLIGHT?= $(CYAN)

ifeq (,$(findstring s,$(MAKEFLAGS)))
ERROR?= $(RED) $(ECHO) -n '[ERROR] '; $(ECHO)
INFO?= $(GREEN) $(ECHO) -n ''; $(ECHO)
WARN?= $(YELLOW) $(ECHO) -n '<!> '; $(ECHO)
NORMAL?= $(WHITE) $(ECHO) -n
else
# If silent mode
ERROR= $(ECHO) > /dev/null
INFO= $(ECHO) > /dev/null
NORMAL= $(ECHO) > /dev/null
WARN= $(ECHO) > /dev/null
endif

# MAKE is normally automatically set to the 'make' that was called!
MAKE_BIN?= make
MAKE?= $(strip $(__MAKE_ENVIRONMENT) $(MAKE_ENVIRONMENT) $(MAKE_BIN) $(__MAKE_OPTIONS) $(MAKE_OPTIONS) )

#--- Macros
_cmn_comma2space_S= $(subst $(COMMA),$(SPACE),$(1))

_cmn_space2comma_S= $(subst $(SPACE),$(COMMA),$(1))

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _cmn_list_macros
_cmn_list_macros ::
	@echo 'CoMmoN ($(_COMMON_MK_VERSION)) macros:'
	@echo '    _cmn_comma2space_S         - Convert a csv-string into a string-array (String)'
	@echo '    _cmn_space2comma_S         - Convert a string-array into a CSV string (String)'
	@echo

_list_parameters :: _cmn_list_parameters
_cmn_list_parameters ::
	@echo 'CoMmoN ($(_COMMON_MK_VERSION)) parameters:'
	@echo '    CMN_UI_LABEL=$(CMN_UI_LABEL)'
	@echo '    DATE=$(DATE)'
	@echo '    DEBUG_FLAG=$(DEBUG_FLAG)'
	@echo '    HOST=$(HOST)'
	@echo '    HOSTNAME=$(HOSTNAME)'
	@echo '    INTERACTIVE_FLAG=$(INTERACTIVE_FLAG)'
	@echo '    INPUTS_DIRPATH=$(INPUTS_DIRPATH)'
	@echo '    MAKE=$(MAKE)'
	@echo '    MD5SUM=$(MD5SUM)'
	@echo '    MK_DIRPATH=$(MK_DIRPATH)'
	@echo '    NOWAIT_FLAG=$(NOWAIT_FLAG)'
	@echo '    OUTPUTS_DIRPATH=$(OUTPUTS_DIRPATH)'
	@echo '    SHELL=$(SHELL)'
	@echo '    SILENT_FLAG=$(SILENT_FLAG)'
	@echo '    TAR=$(TAR)'
	@echo '    TERM=$(TERM)'
	@echo '    TMP_DIRPATH=$(TMP_DIRPATH)'
	@echo '    UNTAR=$(UNTAR)'
	@echo '    UNZIP=$(UNZIP)'
	@echo '    USER=$(USER)'
	@echo '    VERBOSITY_LEVEL=$(VERBOSITY_LEVEL)'
	@echo '    WEBBROWSER=$(WEBBROWSER)'
	@echo '    WRITER=$(WRITER)'
	@echo '    YES_FLAG=$(YES_FLAG)'
	@echo '    ZIP=$(ZIP)'
	@echo

_list_targets :: _cmn_list_targets
_cmn_list_targets ::
	@echo 'CoMmoN ($(_COMMON_MK_VERSION)) targets:'
	@echo '    _cmn_install_dependencies     - Install software dependencies' 
	@echo '    _cmn_print-%                  - Print info on a parameter' 
	@echo '    _cmn_show_quickhelp           - Show quick-help' 
	@echo '    _cmn_sleep-%                  - Sleep % seconds' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

-include gmsl

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_install_dependencies :: _cmn_install_dependencies
_cmn_install_dependencies ::
	@$(INFO) '$(CMN_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	sudo apt-get update
	sudo apt-get install --upgrade gmsl
	@# sudo apt-get install --upgrade realpath

# Usage: make _cmn_print-CMN_MODE_INTERACTIVE
# CMN_MODE_INTERACTIVE is a recursive variable set to >true<
_cmn_print-% : ; $(info $* is a $(flavor $*) variable set to >$($*)<) @true

_cmn_show_quickhelp:
	@$(INFO) '$(CMN_UI_LABEL)Showing quick-help ...'; $(NORMAL)
	grep --only-matching --extended-regexp '^[-_a-zA-Z0-9]+:' Makefile | grep --only-matching --extended-regexp '^[-_a-zA-Z0-9]+'

_cmn_sleep-% : ; $(shell sleep $*)  @true
