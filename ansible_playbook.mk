ANSIBLE_PLAYBOOK_MK_VERSION= $(ANSIBLE_MK_VERSION)

# ABE_PLAYBOOK_DIRPATH?=
# ABE_PLAYBOOK_FILEPATH?=
# ABE_PLAYBOOK_PRIVATEKEY_FILEPATH?= $(HOME)/.ssh/id_rsa
# ABE_PLAYBOOK_REMOTEUSER_NAME?= ubuntu
# ABE_PLAYBOOK_RETRY_FILEPATH?= $(realpath ./playbook.retry)
ABE_PLAYBOOK_RUN_ASKVAULTPASS?= false
ABE_PLAYBOOK_RUN_BECOME?= false
ABE_PLAYBOOK_RUN_BECOMEMETHOD?= sudo
ABE_PLAYBOOK_RUN_BECOMEUSER?= root
# ABE_PLAYBOOK_RUN_EXTRAVARS?=
# ABE_PLAYBOOK_RUN_SKIPTAGS?=
# ABE_PLAYBOOK_RUN_STARTATTASK= druid_extensions
# ABE_PLAYBOOK_RUN_STEP?=
ABE_PLAYBOOK_RUN_TAGS?= all # untagged, tagged, always, and all (default) are reserved tags
# ABE_PLAYBOOKS_DIRPATH?=

# Derived parameters
ABE_PLAYBOOK_NAME?= $(notdir $(basename $(ABE_PLAYBOOK_FILEPATH)))
ABE_PLAYBOOK_PRIVATEKEY_FILEPATH?= $(ABE_PRIVATEKEY_FILEPATH)
ABE_PLAYBOOK_REMOTEUSER_NAME?= $(ABE_REMOTEUSER_NAME)

# Option parameters
__ABE_ASK_VAULT_PASS= $(if $(filter true,$(ABE_PLAYBOOK_RUN_ASKVAULTPASS)),--ask-vault-pass)
__ABE_BECOME__PLAYBOOK=
__ABE_BECOME_METHOD__PLAYBOOK= $(if $(ABE_PLAYBOOK_RUN_BECOMEMETHOD),--become-method $(ABE_PLAYBOOK_RUN_BECOMEMETHOD))
__ABE_BECOME_USER__PLAYBOOK= $(if $(ABE_PLAYBOOK_RUN_BECOMEUSER),--become-user $(ABE_PLAYBOOK_RUN_BECOMEUSER))
__ABE_EXTRA_VARS= $(if $(ABE_PLAYBOOK_EXTRA_VARS),--extra-vars $(ABE_PLAYBOOK_EXTRA_VARS))
__ABE_INVENTORY__PLAYBOOK= $(__ABE_INVENTORY__INVENTORY)
__ABE_PRIVATE_KEY__PLAYBOOK= $(if $(ABE_PLAYBOOK_PRIVATEKEY_FILEPATH),--private-key=$(ABE_PLAYBOOK_PRIVATEKEY_FILEPATH))
__ABE_SKIP_TAGS= $(if $(ABE_PLAYBOOK_RUN_SKIPTAGS),--skip-tags $(ABE_PLAYBOOK_RUN_SKIPTAGS))
__ABE_START_AT_TASK= $(if $(ABE_PLAYBOOK_RUN_STARTATTASK),--start-at-task='$(ABE_PLAYBOOK_RUN_STARTATTASK)')
__ABE_STEP= $(if $(filter true,$(ABE_PLAYBOOK_RUN_STEP)),--step)
__ABE_TAGS= $(if $(ABE_PLAYBOOK_RUN_TAGS),--tags $(ABE_PLAYBOOK_RUN_TAGS))
__ABE_USER__PLAYBOOK= $(if $(ABE_PLAYBOOK_REMOTEUSER_NAME),--user $(ABE_PLAYBOOK_REMOTEUSER_NAME))

# Utilities
ANSIBLE_PLAYBOOK_BIN?= ansible-playbook
ANSIBLE_PLAYBOOK= $(strip $(__ANSIBLE_PLAYBOOK_ENVIRONMENT) $(ANSIBLE_PLAYBOOK_ENVIRONMENT) $(ANSIBLE_PLAYBOOK_BIN) $(__ANSIBLE_PLAYBOOK_OPTIONS)  $(ANSIBLE_PLAYBOOK_OPTIONS))

#----------------------------------------------------------------------
# USAGE
#

_abe_view_framework_macros ::
	@#echo 'Ansible::Playbook ($(ANSIBLE_PLAYBOOK_MK_VERSION)) macros:'
	@#echo

_abe_view_framework_parameters ::
	@echo 'Ansible::Playbook ($(ANSIBLE_PLAYBOOK_MK_VERSION)) parameters:'
	@echo '    ABE_PLAYBOOK_DIRPATH=$(ABE_PLAYBOOK_DIRPATH)'
	@echo '    ABE_PLAYBOOK_FILEPATH=$(ABE_PLAYBOOK_FILEPATH)'
	@echo '    ABE_PLAYBOOK_NAME=$(ABE_PLAYBOOK_NAME)'
	@echo '    ABE_PLAYBOOK_PRIVATEKEY_FILEPATH=$(ABE_PLAYBOOK_PRIVATEKEY_FILEPATH)'
	@echo '    ABE_PLAYBOOK_REMOTEUSER_NAME=$(ABE_PLAYBOOK_REMOTEUSER_NAME)'
	@echo '    ABE_PLAYBOOK_RETRY_FILEPATH=$(ABE_PLAYBOOK_RETRY_FILEPATH)'
	@echo '    ABE_PLAYBOOK_RUN_ASKVAULTPASS=$(ABE_PLAYBOOK_RUN_ASKVAULTPASS)'
	@echo '    ABE_PLAYBOOK_RUN_BECOME=$(ABE_PLAYBOOK_RUN_BECOME)'
	@echo '    ABE_PLAYBOOK_RUN_BECOMEMETHOD=$(ABE_PLAYBOOK_RUN_BECOMEMETHOD)'
	@echo '    ABE_PLAYBOOK_RUN_BECOMEUSER=$(ABE_PLAYBOOK_RUN_BECOMEUSER)'
	@echo '    ABE_PLAYBOOK_RUN_EXTRAVARS=$(ABE_PLAYBOOK_RUN_EXTRAVARS)'
	@echo '    ABE_PLAYBOOK_RUN_SKIPTAGS=$(ABE_PLAYBOOK_RUN_SKIPTAGS)'
	@echo '    ABE_PLAYBOOK_RUN_STARTTASK=$(ABE_PLAYBOOK_RUN_STARTTASK)'
	@echo '    ABE_PLAYBOOK_RUN_STEP=$(ABE_PLAYBOOK_RUN_STEP)'
	@echo '    ABE_PLAYBOOK_RUN_TAGS=$(ABE_PLAYBOOK_RUN_TAGS)'
	@echo '    ABE_PLAYBOOKS_DIRPATH=$(ABE_PLAYBOOKS_DIRPATH)'
	@echo '    ANSIBLE_PLAYBOOK=$(ANSIBLE_PLAYBOOK)'
	@echo

_abe_view_framework_targets ::
	@echo 'Ansible::Playboook ($(ANSIBLE_PLAYBOOK_MK_VERSION)) targets:'
	@echo '    _abe_check_playbook                - Check everything on a playbook'
	@echo '    _abe_check_playbook_syntax         - Check the syntax of a playbook'
	@echo '    _abe_dryrun_playbook               - Dry run a playbook'
	@echo '    _abe_edit_playbook                 - Edit a playbook'
	@echo '    _abe_retry_playbook                - Retry the playbook on failed hosts'
	@echo '    _abe_run_playbook                  - Run a playbook'
	@echo '    _abe_show_playbook                 - Show everything related to a playbook'
	@echo '    _abe_show_playbook_content         - Show the content of a playbook'
	@echo '    _abe_show_playbook_description     - Show description of a playbook'
	@echo '    _abe_show_playbook_hosts           - Show target-hosts for a playbook'
	@echo '    _abe_show_playbook_tags            - Show tags used in a playbook'
	@echo '    _abe_show_playbook_tasks           - Show tasks in a playbook'
	@echo '    _abe_view_playbooks                - View playbooks'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_abe_check_playbook: _abe_check_playbook_syntax

_abe_check_playbook_syntax:
	@$(INFO) '$(ABE_UI_LABEL)Checking syntax of playbook "$(ABE_PLAYBOOK_NAME)" ...'; $(NORMAL)
	$(ANSIBLE_PLAYBOOK) --syntax-check $(ABE_PLAYBOOK_FILEPATH)

_abe_dryrun_playbook:
	@$(INFO) '$(ABE_UI_LABEL)Dry-running playbook "$(ABE_PLAYBOOK_NAME)" ...'; $(NORMAL)
	$(ANSIBLE_PLAYBOOK) --check $(ABE_PLAYBOOK_FILEPATH)

_abe_edit_playbook:
	@$(INFO) '$(ABE_UI_LABEL)Editing playbook "$(ABE_PLAYBOOK_NAME)" ...'; $(NORMAL)
	$(EDITOR) $(ABE_PLAYBOOK_FILEPATH)

_abe_retry_playbook:
	@$(INFO) '$(ABE_UI_LABEL)Retrying the playbook on failed hosts...'; $(NORMAL)
	$(ANSIBLE_PLAYBOOK) --limit @$(ABE_PLAYBOOK_RETRY_FILEPATH) $(ABE_PLAYBOOK_FILEPATH)

_abe_run_playbook:
	@$(INFO) '$(ABE_UI_LABEL)Running playbook "$(ABE_PLAYBOOK_NAME)" ...'; $(NORMAL)
	$(ANSIBLE_PLAYBOOK) $(strip $(__ABE_BECOME__PLAYBOOK) $(__ABE_BECOME_METHOD__PLAYBOOK) $(__ABE_BECOME_USER__PLAYBOOK) $(__ABE_INVENTORY__PLAYBOOK) $(__ABE_PRIVATE_KEY__PLAYBOOK) $(__ABE_SKIP_TGS) $(__ABE_START_AT_TASK) $(__ABE_STEP) $(__ABE_TAGS) $(__ABE_USER__PLAYBOOK)) $(ABE_PLAYBOOK_FILEPATH)

_abe_show_playbook: _abe_show_playbook_content _abe_show_playbook_hosts _abe_show_playbook_tags _abe_show_playbook_tasks _abe_show_playbook_description

_abe_show_playbook_content:
	@$(INFO) '$(ABE_UI_LABEL)Showing content of playbook "$(ABE_PLAYBOOK_NAME)" ...'; $(NORMAL)
	cat $(ABE_PLAYBOOK_FILEPATH)

_abe_show_playbook_description:
	@$(INFO) '$(ABE_UI_LABEL)Showing description of playbook "$(ABE_PLAYBOOK_NAME)" ...'; $(NORMAL)
	ls -al $(ABE_PLAYBOOK_FILEPATH)

_abe_show_playbook_hosts:
	@$(INFO) '$(ABE_UI_LABEL)Showing target-hosts for playbook "$(ABE_PLAYBOOK_NAME)" ...'; $(NORMAL)
	$(ANSIBLE_PLAYBOOK) --list-hosts $(ABE_PLAYBOOK_FILEPATH)

_abe_show_playbook_tags:
	@$(INFO) '$(ABE_UI_LABEL)Showing tags in playbook "$(ABE_PLAYBOOK_NAME)"  ...'; $(NORMAL)
	$(ANSIBLE_PLAYBOOK) --list-tags $(ABE_PLAYBOOK_FILEPATH)

_abe_show_playbook_tasks:
	@$(INFO) '$(ABE_UI_LABEL)Showing tasks in playbook "$(ABE_PLAYBOOK_NAME)" ...'; $(NORMAL)
	$(ANSIBLE_PLAYBOOK) --list-task $(ABE_PLAYBOOK_FILEPATH)

_abe_view_playbooks:
	@$(INFO) '$(ABE_UI_LABEL)Viewing playbooks ...'; $(NORMAL)
	ls -al $(ABE_PLAYBOOKS_DIRPATH)
