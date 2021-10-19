MGO_MK_VERSION=0.99.3

# MGO_AUTHENTICATION_MECHANISM?= MONGODB-CR
MGO_DATABASE_NAME?= test
# MGO_EVAL_COMMAND?= show dbs
# MGO_EVAL_FILEPATH?= ./commands.txt
MGO_LABEL?= [mongo] #
# MGO_MODE_DEBUG?= true
# MGO_MODE_QUIET?= false
MGO_SERVER_PORT?= 27017
# MGO_SERVER_NAME?= localhost
# MGO_SERVER_IP?= 127.0.0.1
# MGO_USER_NAME?= admin
# MGO_USER_PASSWORD?= my_password

# Derived variables
MGO_AUTHENTICATION_DATABASE?= $(MGO_DATABASE_NAME)
MGO_SERVER_NAME_OR_IP?= $(strip $(if $(MGO_SERVER_IP), $(MGO_SERVER_IP), $(MGO_SERVER_NAME)))

__MGO_<_EVAL= $(if $(MGO_EVAL_FILEPATH), < $(MGO_EVAL_FILEPATH))
__MGO_AUTHENTICATION_DATABASE= $(if $(MGO_AUTHENTICATION_DATABASE), --authenticationDatabase $(MGO_AUTHENTICATION_DATABASE))
__MGO_AUTHENTICATION_MECHANISM?= $(if $(MGO_AUTHENTICATION_MECHANISM), --authenticationMechanism $(MGO_AUTHENTICATION_MECHANISM))
__MGO_EVAL= $(if $(MGO_EVAL_COMMAND), --eval '$(MGO_EVAL_COMMAND)')
__MGO_HOST= $(if $(MGO_SERVER_NAME_OR_IP), --host $(MGO_SERVER_NAME_OR_IP))
__MGO_PASSWORD= $(if $(MGO_USER_PASSWORD), --password $(MGO_USER_PASSWORD))
__MGO_PORT= $(if $(MGO_SERVER_PORT), --port $(MGO_SERVER_PORT))
__MGO_QUIET= $(if $(filter true, $(MGO_MODE_QUIET)), --quiet)
__MGO_USERNAME= $(if $(MGO_USER_NAME), --username $(MGO_USER_NAME))
__MGO_VERBOSE= $(if $(filter true, $(MGO_MODE_DEBUG)), --verbose)

MONGO=$(__MONGO__ENVIRONMENT) $(MONGO_ENVIRONMENT) mongo $(__MONGO_OPTIONS) $(MONGO_OPTIONS)

#----------------------------------------------------------------------
# USAGE
#

_install_framework_dependencies :: _mgo_install_framework_dependencies
_mgo_install_framework_dependencies:
	@$(INFO) "Installing mongo client"
	@$(WARN) "Instructions at https://www.linode.com/docs/databases/mongodb/install-mongodb-on-ubuntu-16-04/"
	@$(WARN) "Mongo client version needs to match the major vesion of the mongo server one"; $(NORMAL)
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
	echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
	sudo apt-get update
	sudo apt-get install mongodb-org

_view_makefile_macros :: _mgo_view_makefile_macros
_mgo_view_makefile_macros:

_view_makefile_targets :: _mgo_view_makefile_targets
_mgo_view_makefile_targets:
	@echo "Mongo:: ($(MONGO_MK_VERSION)) targets:"
	@echo "    - _mgo_eval_command            - Execute a command in the mongo shell"
	@echo "    - _mgo_show_version            - Show version of mongo client"
	@echo "    - _mgo_start_shell             - Start a mongo shell"
	@echo

_view_makefile_variables :: _mgo_view_makefile_variables
_mgo_view_makefile_variables:
	@echo "Mongo:: ($(MONGO_MK_VERSION)) variables:"
	@echo "    MGO_AUTHENTICATION_DATABASE=$(MGO_AUTHENTICATION_DATABASE)"
	@echo "    MGO_AUTHENTICATION_MECHANISM=$(MGO_AUTHENTICATION_MECHANISM)"
	@echo "    MGO_DATABASE_NAME=$(MGO_DATABASE_NAME)"
	@echo "    MGO_EVAL_COMMAND=$(MGO_EVAL_COMMAND)"
	@echo "    MGO_EVAL_FILEPATH=$(MGO_EVAL_FILEPATH)"
	@echo "    MGO_MODE_DEBUG=$(MGO_MODE_DEBUG)"
	@echo "    MGO_MODE_QUIET=$(MGO_MODE_QUIET)"
	@echo "    MGO_SERVER_PORT=$(MGO_SERVER_PORT)"
	@echo "    MGO_SERVER_IP=$(MGO_SERVER_IP)"
	@echo "    MGO_SERVER_NAME=$(MGO_SERVER_NAME)"
	@echo "    MGO_USER_NAME=$(MGO_USER_NAME)"
	@echo "    MGO_USER_PASSWORD=$(MGO_USER_PASSWORD)"
	@echo

#----------------------------------------------------------------------
# PUBLIC KEYS
#

_mgo_eval_command:
	@$(INFO) "$(MGO_LABEL)Executing a command as user '$(MGO_USER_NAME)' on databse '$(MGO_SERVER_NAME_OR_IP):$(MGO_SERVER_PORT)/$(MGO_DATABASE_NAME)' ..."; $(NORMAL)
	@$(WARN) "Looking at input file: $(MGO_EVAL_FILEPATH)"; $(NORMAL)
	[ -f $(MGO_EVAL_FILEPATH) ] && cat $(MGO_EVAL_FILEPATH)
	$(MONGO) $(MGO_DATABASE_NAME) $(__MGO_AUTHENTICATION_DATABASE) $(__MGO_EVAL) $(__MGO_HOST) $(__MGO_PORT) $(__MGO_QUIET) $(__MGO_USERNAME) $(__MGO_PASSWORD) $(__MGO_VERBOSE) $(__MGO_<_EVAL)

_mgo_start_shell: 
	@$(INFO) "$(MGO_LABEL)Starting a mongo shell"; $(NORMAL)
	@$(WARN) "Connecting as/to: $(MGO_USER_NAME)@$(MGO_SERVER_NAME_OR_IP):$(MGO_SERVER_PORT)/$(MGO_DATABASE_NAME)"; $(NORMAL)
	$(MONGO) $(MGO_DATABASE_NAME) $(__MGO_AUTHENTICATION_DATABASE) $(__MGO_AUTHENTICATION_MECHANISM) $(__MGO_HOST) $(__MGO_PORT) $(__MGO_QUIET) $(__MGO_USERNAME) $(__MGO_PASSWORD) $(__MGO_VERBOSE)

_mgo_show_version:
	$(MONGO) --version
