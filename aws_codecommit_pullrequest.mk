_AWS_CODECOMMIT_PULLREQUEST_MK_VERSION= $(_AWS_CODECOMMIT_MK_VERSION)

# CCT_PULLREQUEST_AUTHOR_ARN?=
# CCT_PULLREQUEST_DESCRIPTION?= "This is my pull-request description"
# CCT_PULLREQUEST_ID?=
# CCT_PULLREQUEST_STATUS?=
# CCT_PULLREQUEST_TARGETS?= repositoryName=string,sourceReference=string,destinationReference=string ...
# CCT_PULLREQUEST_TITLE?=

# Derived parameters

# Option parameters
__CCT_AUTHOR_ARN= $(if $(CCT_PULLREQUEST_AUTHOR_ARN), --author $(CCT_PULLREQUEST_AUTHOR_ARN))
__CCT_DESCRIPTION_PULLREQUEST= $(if $(CCT_PULLREQUEST_DESCRIPTION), --description $(CCT_PULLREQUEST_DESCRIPTION))
__CCT_PULL_REQUEST_ID= $(if $(CCT_PULLREQUEST_ID), --pull-request-id $(CCT_PULLREQUEST_ID))
__CCT_PULL_REQUEST_STATUS= $(if $(CCT_PULLREQUEST_STATUS), --pull-request-status $(CCT_PULLREQUEST_STATUS))
__CCT_TARGETS= $(if $(CCT_PULLREQUEST_TARGETS) --targets $(CCT_PULLREQUEST_TARGETS))
__CCT_TITLE= $(if $(CCT_PULLREQUEST_TITLE) --title $(CCT_PULLREQUEST_TITLE))

# UI parameters

#--- MACROS
_cct_get_pullrequest_id= $(call .... )
_cct_get_pullrequest_id_T= $(shell $(AWS) list-pull-quests ... )

#----------------------------------------------------------------------
# USAGE
#

_cct_view_framework_macros ::
	@#echo 'AWS::CodeCommiT::PullRequest ($(_AWS_CODECOMMIT_PULLREQUEST_MK_VERSION)) macros:'
	@#echo

_cct_view_framework_parameters ::
	@echo 'AWS::CodeCommiT::PullRequest ($(_AWS_CODECOMMIT_PULLREQUEST_MK_VERSION)) parameters:'
	@echo '    CCT_PULLREQUEST_AUTHOR_ARN=$(CCT_PULLREQUEST_AUTHOR_ARN)'
	@echo '    CCT_PULLREQUEST_DESCRIPTION=$(CCT_PULLREQUEST_DESCRIPTION)'
	@echo '    CCT_PULLREQUEST_STATUS=$(CCT_PULLREQUEST_STATUS)'
	@echo '    CCT_PULLREQUEST_TARGETS=$(CCT_PULLREQUEST_TARGETS)'
	@echo '    CCT_PULLREQUEST_TITLE=$(CCT_PULLREQUEST_TITLE)'
	@echo

_cct_view_framework_targets ::
	@echo 'AWS::CodeCommiT::PullRequest ($(_AWS_CODECOMMIT_PULLREQUEST_MK_VERSION)) targets:'
	@echo '    _cct_view_pullrequests                 - View existing pull-requests'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cct_create_pullrequest:
	@$(INFO) '$(AWS_UI_LABEL)Viewing pull-requests in repository "$(CCT_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(AWS) codecommit create-pull-requests $(__CCT_DESCRIPTION_PULLREQUEST) $(__CCT_TARGETS) $(__CCT_TITLE)

_cct_show_pullrequest:
	@$(INFO) '$(AWS_UI_LABEL)Showing details of pull-request "$(CCT_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(AWS) codecommit get-pull-request $(__CCT_PULL_REQUEST_ID)

_cct_view_pullrequests:
	@$(INFO) '$(AWS_UI_LABEL)Viewing pull-requests in repository "$(CCT_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(AWS) codecommit list-pull-requests $(__CCT_AUTHOR_ARN) $(__CCT_PULL_REQUEST_STATUS) $(__CCT_REPOSITORY_NAME)
