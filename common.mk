_COMMON_MK_VERSION= 0.99.1

# __DATE_ENVIRONMENT?= TZ='America/Los_Angeles'
DATE_BIN?= date
DATE?= $(strip $(__DATE_ENVIRONMENT) $(DATE_ENVIRONMENT) $(DATE_BIN) $(__DATE_OPTIONS) $(DATE_OPTIONS) )

CMN_DATE:=$(shell $(DATE))
CMN_DATE_HHMMSS:=$(shell $(DATE) +%H%M%S)
CMN_DATE_YYYYMMDD:=$(shell $(DATE) +%Y%m%d)
CMN_DATE_YYYYMMDD_HHMMSS:=$(CMN_DATE_YYYYMMDD)_$(CMN_DATE_HHMMSS)
# CMN_INPUTS_DIRPATH?= ./in/
CMN_MODE_DEBUG?= false
CMN_MODE_INTERACTIVE?= false
CMN_MODE_NOWAIT?= false
CMN_MODE_SILENT?= $(if $(filter s, $(MAKEFLAGS)),true,false)
CMN_MODE_YES?= false
# CMN_OUTPUTS_DIRPATH?= ./out/
CMN_TMP_DIR:= /tmp/$(CMN_DATE_YYYYMMDD)
CMN_VERBOSITY_LEVEL?= 0
CMN_UI_LABEL?= [common] #
COMMA= ,#
# MAKE_ENVIRONMENT?=FOO=1
# MAKE_OPTIONS?= -e -n -p --silent FOO=1

CURL?= curl
DIG?= dig
ECHO?= /bin/echo
EDITOR?= vim
MD5SUM?= openssl md5
WEBBROWSER?= chrome

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

_view_framework_macros :: _cmn_view_framework_macros
_cmn_view_framework_macros ::
	@echo 'CoMmoN ($(_COMMON_MK_VERSION)) macros:'
	@echo '    _cmn_comma2space_S         - Convert a csv-string into a string-array (String)'
	@echo '    _cmn_space2comma_S         - Convert a string-array into a CSV string (String)'
	@echo

_view_framework_parameters :: _cmn_view_framework_parameters
_cmn_view_framework_parameters ::
	@echo 'CoMmoN ($(_COMMON_MK_VERSION)) parameters:'
	@echo '    CMN_DATE=$(CMN_DATE)'
	@echo '    CMN_DATE_HHMMSS=$(CMN_DATE_HHMMSS)'
	@echo '    CMN_DATE_YYYYMMDD=$(CMN_DATE_YYYYMMDD)'
	@echo '    CMN_DATE_YYYYMMDD_HHMMSS=$(CMN_DATE_YYYYMMDD_HHMMSS)'
	@echo '    CMN_INPUTS_DIRPATH=$(CMN_INPUTS_DIRPATH)'
	@echo '    CMN_MODE_DEBUG=$(CMN_MODE_DEBUG)'
	@echo '    CMN_MODE_INTERACTIVE=$(CMN_MODE_INTERACTIVE)'
	@echo '    CMN_MODE_NOWAIT=$(CMN_MODE_NOWAIT)'
	@echo '    CMN_MODE_SILENT=$(CMN_MODE_SILENT)'
	@echo '    CMN_MODE_YES=$(CMN_MODE_YES)'
	@echo '    CMN_OUTPUTS_DIRPATH=$(CMN_OUTPUTS_DIRPATH)'
	@echo '    CMN_TMP_DIR=$(CMN_TMP_DIR)'
	@echo '    CMN_VERBOSITY_LEVEL=$(CMN_VERBOSITY_LEVEL)'
	@echo '    CMN_UI_LABEL=$(CMN_UI_LABEL)'
	@echo '    DATE=$(DATE)'
	@echo '    EDITOR=$(EDITOR)'
	@echo '    HOST=$(HOST)'
	@echo '    HOSTNAME=$(HOSTNAME)'
	@echo '    MAKE=$(MAKE)'
	@echo '    MD5SUM=$(MD5SUM)'
	@echo '    MK_DIR=$(MK_DIR)'
	@echo '    SHELL=$(SHELL)'
	@echo '    TERM=$(TERM)'
	@echo '    USER=$(USER)'
	@echo '    WEBBROWSER=$(WEBBROWSER)'
	@echo

_view_framework_targets :: _cmn_view_framework_targets
_cmn_view_framework_targets ::
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

_install_framework_dependencies :: _cmn_install_dependencies
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
