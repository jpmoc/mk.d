_AWS_ALEXAFORBUSINESS_MK_VERSION=0.99.6

# AFB_DEVICES_FILTERS?= Key=string,Value=string ...
# AFB_DEVICES_SORT_CRITERIA?= Key=string,Value=string ...
# AFB_PROFILE_ADDRESS?= 675 Sharon Park Dr, CA
# AFB_PROFILE_DISTANCE_UNIT?= METRIC
# AFB_PROFILE_MAX_VOLUME_LIMIT?= 80
# AFB_PROFILE_NAME?= my-profile
# AFB_PROFILE_PSTN_ENABLED?= true
# AFB_PROFILE_TIMEZONE?= UTC
# AFB_PROFILE_TEMPERATURE_UNIT?= CELSIUS
# AFB_PROFILE_WAKE_WORD?= ALEXA 
# AFB_PROFILES_FILTERS?= Key=string,Value=string ...
# AFB_PROFILES_SORT_CRITERIA?= Key=string,Value=string ...
# AFB_ROOM_ARN?=
# AFB_ROOM_DESCRIPTION?= This is my room
# AFB_ROOM_TAGS?= Key=string,Value=string ...
# AFB_ROOMS_FILTERS?= Key=string,Value=string ...
# AFB_ROOMS_SORT_CRITERIA?= Key=string,Value=string ...
# AFB_SKILLGROUP_ARN?=
# AFB_SKILLGROUP_DESCRIPTION?= This is my awesome skill-group
# AFB_SKILLGROUP_NAME?= my-skill-group
# AFB_SKILLGROUPS_FILTERS?= Key=string,Value=string ...
# AFB_SKILLGROUPS_SORT_CRITERIA?= Key=string,Value=string ...
# AFB_USER_FIRST_NAME?= Emmanuel
# AFB_USER_ID?=
# AFB_USER_LAST_NAME?= Mayssat
# AFB_USER_TAGS?= Key=string,Value=string ...
# AFB_USERS_FILTERS?= Key=string,Value=string ...
# AFB_USERS_SORT_CRITERIA?= Key=string,Value=string ...

# Derived variables
AFB_ROOM_PROFILE_ARN?= $(AFB_PROFILE_ARN)

# Options variables
__AFB_ADDRESS= $(if $(AFB_PROFILE_ADDRESS), --address '$(AFB_PROFILE_ADDRESS)')
__AFB_DESCRIPTION_ROOM= $(if $(AFB_ROOM_DESCRIPTION), --description '$(AFB_ROOM_DESCRIPTION)')
__AFB_DESCRIPTION_SKILLGROUP= $(if $(AFB_SKILLGROUP_DESCRIPTION), --description '$(AFB_SKILLGROUP_DESCRIPTION)')
__AFB_DISTANCE_UNIT= $(if $(AFB_PROFILE_DISTANCE_UNIT), --distance-unit $(AFB_PROFILE_DISTANCE_UNIT))
__AFB_EMAIL= $(if $(AFB_USER_EMAIL), --email $(AFB_USER_EMAIL))
__AFB_FILTERS_DEVICES= $(if $(AFB_DEVICES_FILTERS), --filters $(AFB_DEVICES_FILTERS))
__AFB_FILTERS_PROFILES= $(if $(AFB_PROFILES_FILTERS), --filters $(AFB_PROFILES_FILTERS))
__AFB_FILTERS_ROOMS= $(if $(AFB_ROOMS_FILTERS), --filters $(AFB_ROOMS_FILTERS))
__AFB_FILTERS_SKILLGROUPS= $(if $(AFB_SKILLGROUPS_FILTERS), --filters $(AFB_SKILLGROUPS_FILTERS))
__AFB_FILTERS_USERS= $(if $(AFB_USERS_FILTERS), --filters $(AFB_USERS_FILTERS))
__AFB_FIRST_NAME= $(if $(AFB_USER_FIRST_NAME), --first-name $(AFB_USER_FIRST_NAME))
__AFB_LAST_NAME= $(if $(AFB_USER_LAST_NAME), --last-name $(AFB_USER_LAST_NAME))
__AFB_MAX_VOLUME_LIMIT= $(if $(AFB_PROFILE_MAX_VOLUME_LIMIT), --max-volume-limit $(AFB_PROFILE_MAX_VOLUME_LIMIT))
__AFB_PROFILE_ARN= $(if $(AFB_PROFILE_ARN), --profile-arn $(AFB_PROFILE_ARN))
__AFB_PROFILE_NAME= $(if $(AFB_PROFILE_NAME), --profile-name '$(AFB_PROFILE_NAME)')
__AFB_PROVIDER_CALENDAR_ID= $(if $(AFB_ROOM_PROVIDER_CALENDAR_ID), --provider-calendar-id $(AFB_ROOM_PROVIDER_CALENDAR_ID))
__AFB_ROOM_ARN= $(if $(AFB_ROOM_ARN), --room-arn $(AFB_ROOM_ARN))
__AFB_ROOM_NAME= $(if $(AFB_ROOM_NAME), --room-name '$(AFB_ROOM_NAME)')
__AFB_PSTN_ENABLED= $(if $(filter true, $(AFB_PROFILE_PSTN_ENABLED)), --pstn-enabled, --no-pstn-enabled)
__AFB_SKILL_GROUP_ARN= $(if $(AFB_SKILLGROUP_ARN), --skill-group-arn $(AFB_SKILLGROUP_ARN))
__AFB_SKILL_GROUP_NAME= $(if $(AFB_SKILLGROUP_NAME), --skill-group-name '$(AFB_SKILLGROUP_NAME)')
__AFB_SORT_CRITERIA_DEVICES= $(if $(AFB_DEVICES_SORT_CRITERIA), --sort-criteria $(AFB_DEVICES_SORT_CRITERIA))
__AFB_SORT_CRITERIA_PROFILES= $(if $(AFB_PROFILES_SORT_CRITERIA), --sort-criteria $(AFB_PROFILES_SORT_CRITERIA))
__AFB_SORT_CRITERIA_ROOMS= $(if $(AFB_ROOMS_SORT_CRITERIA), --sort-criteria $(AFB_ROOMS_SORT_CRITERIA))
__AFB_SORT_CRITERIA_SKILLGROUPS= $(if $(AFB_SKILLGROUPS_SORT_CRITERIA), --sort-criteria $(AFB_SKILLGROUPS_SORT_CRITERIA))
__AFB_SORT_CRITERIA_USERS= $(if $(AFB_USERS_SORT_CRITERIA), --sort-criteria $(AFB_USERS_SORT_CRITERIA))
__AFB_TAGS= $(if $(AFB_USER_TAGS), --tags $(AFB_USER_TAGS))
__AFB_TEMPERATURE_UNIT= $(if $(AFB_PROFILE_TEMPERATURE_UNIT), --temperature-unit $(AFB_PROFILE_TEMPERATURE_UNIT))
__AFB_TIMEZONE= $(if $(AFB_PROFILE_TIMEZONE), --timezone $(AFB_PROFILE_TIMEZONE))
__AFB_USER_ID= $(if $(AFB_USER_ID), --user-id $(AFB_USER_ID))
__AFB_WAKE_WORD= $(if $(AFB_PROFILE_WAKE_WORD), --wake-word $(AFB_PROFILE_WAKE_WORD))

# UI variables
AFB_VIEW_PROFILES_FIELDS?=
AFB_VIEW_ROOMS_FIELDS?= .{RoomName:RoomName,_ProfileName:ProfileName,_Description:Description}
AFB_VIEW_SKILLGROUPS_FIELDS?= .{SkillGroupName:SkillGroupName,_Description:Description}
AFB_VIEW_USERS_FIELDS?=

#--- Utilities

#--- MACROS
_afb_get_profile_arn=$(call _afb_get_profile_arn_N, $(AFB_PROFILE_NAME))
_afb_get_profile_arn_N=$(shell $(AWS) alexaforbusiness search-profiles --query "Profiles[?ProfileName=='$(strip $(1))'].ProfileArn" --output text)

_afb_get_room_arn=$(call _afb_get_room_arn_N, $(AFB_ROOM_NAME))
_afb_get_room_arn_N=$(shell $(AWS) alexaforbusiness search-rooms --query "Rooms[?RoomName=='$(strip $(1))'].RoomArn" --output text)

_afb_get_skillgroup_arn=$(call _afb_get_skillgroup_arn_N, $(AFB_SKILLGROUP_NAME))
_afb_get_skillgroup_arn_N=$(shell $(AWS) alexaforbusiness search-skill-groups --query "SkillGroups[?SkillGroupName=='$(strip $(1))'].SkillGroupArn" --output text)

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _afb_view_makefile_macros
_afb_view_makefile_macros:
	@echo "AWS::AlexaForBusiness ($(_AWS_ALEXAFORBUSINESS_MK_VERSION)) macros:"
	@echo "    _afb_get_profile_arn_{|N}       - Get the ARN of a profile (Name)"
	@echo "    _afb_get_room_arn_{|N}          - Get the ARN of a room (Name)"
	@echo "    _afb_get_skillgroup_arn_{|N}    - Get the ARN of a skill-group (Name)"
	@echo

_aws_view_makefile_targets :: _afb_view_makefile_targets
_afb_view_makefile_targets:
	@echo "AWS::AlexaForBusiness ($(_AWS_ALEXAFORBUSINESS_MK_VERSION)) targets:"
	@echo "    _afb_create_profile             - Create a new profile"
	@echo "    _afb_create_room                - Create a new room"
	@echo "    _afb_create_skillgroup          - Create a new skill-group"
	@echo "    _afb_create_user                - Create a new user"
	@echo "    _afb_delete_profile             - Delete a profile"
	@echo "    _afb_delete_room                - Delete a room"
	@echo "    _afb_delete_skillgroup          - Delete a skill-group"
	@echo "    _afb_delete_user                - Delete a user"
	@echo "    _afb_link_skillgroup_to_room    - Associate a skill-group with a room"
	@echo "    _afb_show_profile               - Show details of a profile"
	@echo "    _afb_show_room                  - Show details of a room"
	@echo "    _afb_show_skillgroup            - Show details of a skill-group"
	@echo "    _afb_show_skillgroup_skills     - Show skills in a skill-group"
	@echo "    _afb_view_devices               - View devices"
	@echo "    _afb_view_rooms                 - View rooms"
	@echo "    _afb_view_skillgroups           - View skill-groups"
	@echo "    _afb_view_users                 - View users"
	@echo 

_aws_view_makefile_variables :: _afb_view_makefile_variables
_afb_view_makefile_variables:
	@echo "AWS::AlexaForBusiness ($(_AWS_ALEXAFORBUSINESS_MK_VERSION)) variables:"
	@echo "    AFB_DEVICES_SORT_CRITERIA=$(AFB_DEVICES_SORT_CRITERIA)"
	@echo "    AFB_PROFILE_ADDRESS=$(AFB_PROFILE_ADDRESS)"
	@echo "    AFB_PROFILE_ARN=$(AFB_PROFILE_ARN)"
	@echo "    AFB_PROFILE_DISTANCE_UNIT=$(AFB_PROFILE_DISTANCE_UNIT)"
	@echo "    AFB_PROFILE_MAX_VOLUME_LIMIT=$(AFB_PROFILE_MAX_VOLUME_LIMIT)"
	@echo "    AFB_PROFILE_NAME=$(AFB_PROFILE_NAME)"
	@echo "    AFB_PROFILE_PSTN_ENABLED=$(AFB_PROFILE_PSTN_ENABLED)"
	@echo "    AFB_PROFILE_TEMPERATURE_UNIT=$(AFB_PROFILE_TEMPERATURE_UNIT)"
	@echo "    AFB_PROFILE_TIMEZONE=$(AFB_PROFILE_TIMEZONE)"
	@echo "    AFB_PROFILE_WAKE_WORD=$(AFB_PROFILE_WAKE_WORD)"
	@echo "    AFB_PROFILES_FILTERS=$(AFB_PROFILES_FILTERS)"
	@echo "    AFB_PROFILES_SORT_CRITERIA=$(AFB_PROFILES_SORT_CRITERIA)"
	@echo "    AFB_ROOM_ARN=$(AFB_ROOM_ARN)"
	@echo "    AFB_ROOM_DESCRIPTION=$(AFB_ROOM_DESCRIPTION)"
	@echo "    AFB_ROOM_NAME=$(AFB_ROOM_NAME)"
	@echo "    AFB_ROOM_PROFILE_ARN=$(AFB_ROOM_PROFILE_ARN)"
	@echo "    AFB_ROOM_PROVIDER_CALENDAR_ID=$(AFB_ROOM_PROVIDER_CALENDAR_ID)"
	@echo "    AFB_ROOM_TAGS=$(AFB_ROOM_TAGS)"
	@echo "    AFB_ROOMS_FILTERS=$(AFB_ROOMS_FILTERS)"
	@echo "    AFB_ROOMS_SORT_CRITERIA=$(AFB_ROOMS_SORT_CRITERIA)"
	@echo "    AFB_SKILLGROUP_ARN=$(AFB_SKILLGROUP_ARN)"
	@echo "    AFB_SKILLGROUP_DESCRIPTION=$(AFB_SKILLGROUP_DESCRIPTION)"
	@echo "    AFB_SKILLGROUP_NAME=$(AFB_SKILLGROUP_NAME)"
	@echo "    AFB_SKILLGROUPS_FILTERS=$(AFB_SKILLGROUPS_FILTERS)"
	@echo "    AFB_SKILLGROUPS_SORT_CRITERIA=$(AFB_SKILLGROUPS_SORT_CRITERIA)"
	@echo "    AFB_USER_EMAIL=$(AFB_USER_EMAIL)"
	@echo "    AFB_USER_FIRST_NAME=$(AFB_USER_FIRST_NAME)"
	@echo "    AFB_USER_ID=$(AFB_USER_ID)"
	@echo "    AFB_USER_LAST_NAME=$(AFB_USER_LAST_NAME)"
	@echo "    AFB_USER_TAGS=$(AFB_USER_TAGS)"
	@echo "    AFB_USERS_FILTERS=$(AFB_USERS_FILTERS)"
	@echo "    AFB_USERS_SORT_CRITERIA=$(AFB_USERS_SORT_CRITERIA)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_afb_create_profile:
	@$(INFO) "$(AWS_LABEL)Creating profile '$(AFB_PROFILE_NAME)' ..."; $(NORMAL)
	$(AWS) alexaforbusiness create-profile $(__AFB_ADDRESS) $(__AFB_DISTANCE_UNIT) $(__AFB_MAX_VOLUME) $(__AFB_PROFILE_NAME) $(__AFB_PSTN_ENABLED) $(__AFB_TEMPERATURE_UNIT) $(__AFB_TIMEZONE) $(__AFB_WAKE_WORD)

_afb_create_room:
	@$(INFO) "$(AWS_LABEL)Creating room '$(AFB_ROOM_NAME)' ..."; $(NORMAL)
	@$(WARN) "For a successful creation, the room should be attached to a room profile"; $(NORMAL)
	$(AWS) alexaforbusiness create-room $(__AFB_DESCRIPTION_ROOM) $(__AFB_PROFILE_ARN) $(__AFB_PROVIDER_CALENDAR_ID) $(__AFB_ROOM_NAME) $(__AFB_TAGS_ROOM)

_afb_create_skillgroup:
	@$(INFO) "$(AWS_LABEL)Creating skill-group '$(AFB_SKILLGROUP_NAME)' ..."; $(NORMAL)
	$(AWS) alexaforbusiness create-skill-group $(__AFB_DESCRIPTION_SKILLGROUP) $(__AFB_SKILL_GROUP_NAME)

_afb_create_user:
	@$(INFO) "$(AWS_LABEL)Creating a user ..."; $(NORMAL)
	$(AWS) alexaforbusiness create-user $(__AFB_EMAIL) $(__AFB_FIRST_NAME) $(__AFB_LAST_NAME) $(__AFB_TAGS) $(__AFB_USER_ID)

_afb_delete_profile:
	@$(INFO) "$(AWS_LABEL)Deleting profile '$(AFB_PROFILE_NAME)' ..."; $(NORMAL)
	@$(WARN) "For a successful deletion, this profile should NOT be attached to any room"; $(NORMAL)
	$(AWS) alexaforbusiness delete-profile $(__AFB_PROFILE_ARN)

_afb_delete_room:
	@$(INFO) "$(AWS_LABEL)Deleting room '$(AFB_ROOM_NAME)' ..."; $(NORMAL)
	$(AWS) alexaforbusiness delete-room $(__AFB_ROOM_ARN)

_afb_delete_skillgroup:
	@$(INFO) "$(AWS_LABEL)Deleting skill-group '$(AFB_SKILLGROUP_NAME)' ..."; $(NORMAL)
	$(AWS) alexaforbusiness delete-skill-group $(__AFB_SKILL_GROUP_ARN)

_afb_link_skillgroup_to_room:
	@$(INFO) "$(AWS_LABEL)Associating skill-group '$(AFB_SKILLGROUP_NAME)' to room '$(AFB_ROOM_NAME)' ..."; $(NORMAL)
	$(AWS) alexaforbusiness associate-skill-group-with-room $(__AFB_ROOM_ARN) $(__AFB_SKILL_GROUP_ARN)

_afb_show_profile:
	@$(INFO) "$(AWS_LABEL)Showing profile '$(AFB_PROFILE_NAME)' ..."; $(NORMAL)
	$(AWS) alexaforbusiness get-profile $(__AFB_PROFILE_ARN)

_afb_show_room:
	@$(INFO) "$(AWS_LABEL)Showing room '$(AFB_ROOM_NAME)' ..."; $(NORMAL)
	$(AWS) alexaforbusiness get-room $(__AFB_ROOM_ARN)

_afb_show_skillgroup:
	@$(INFO) "$(AWS_LABEL)Showing skill-group '$(AFB_SKILLGROUP_NAME)' ..."; $(NORMAL)
	$(AWS) alexaforbusiness get-skill-group $(__AFB_SKILL_GROUP_ARN)

_afb_show_skillgroup_skills:
	@$(INFO) "$(AWS_LABEL)Showing skills in skill-group '$(AFB_SKILLGROUP_NAME)' ..."; $(NORMAL)
	$(AWS) alexaforbusiness list-skills $(__AFB_SKILL_GROUP_ARN)

_afb_view_devices:
	@$(INFO) "$(AWS_LABEL)Viewing managed devices ..."; $(NORMAL)
	$(AWS) alexaforbusiness search-devices $(__AFB_FILTERS_DEVICES) $(__AFB_SORT_CRITERIA_DEVICES)

_afb_view_profiles:
	@$(INFO) "$(AWS_LABEL)Viewing room profiles ..."; $(NORMAL)
	$(AWS) alexaforbusiness search-profiles $(__AFB_FILTERS_PROFILES) $(__AFB_SORT_CRITERIA_PROFILES)

_afb_view_rooms:
	@$(INFO) "$(AWS_LABEL)Viewing roooms ..."; $(NORMAL)
	$(AWS) alexaforbusiness search-rooms $(__AFB_FILTERS_ROOMS) $(__AFB_SORT_CRITERIA_ROOMS) --query "Rooms[]$(AFB_VIEW_ROOMS_FIELDS)"

_afb_view_skillgroups:
	@$(INFO) "$(AWS_LABEL)Viewing skill-groups ..."; $(NORMAL)
	$(AWS) alexaforbusiness search-skill-groups $(__AFB_FILTERS_SKILLGROUPS) $(__AFB_SORT_CRITERIA_SKILLGROUPS) --query "SkillGroups[]$(AFB_VIEW_SKILLGROUPS_FIELDS)"

_afb_view_users:
	@$(INFO) "$(AWS_LABEL)Viewing users ..."; $(NORMAL)
	$(AWS) alexaforbusiness search-users $(__AFB_FILTERS_USERS) $(__AFB_SORT_CRITERIA_USERS)
