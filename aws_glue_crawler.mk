_AWS_GLUE_CRAWLER_MK_VERSION=$(_AWS_GLUE_MK_VERSION)

# GLE_CRAWLER_CONFIGURATION?= '{ "Version": 1.0, "CrawlerOutput": { "Partitions": { "AddOrUpdateBehavior": "InheritFromTable" } } }'
# GLE_CRAWLER_DESCRIPTION?= This is my crawler
# GLE_CRAWLER_DATABASE_NAME?= my-new-database
# GLE_CRAWLER_NAME?= my-crawler
# GLE_CRAWLER_ROLE?= service-role/AWSGlueServiceRole-Mongo
# GLE_CRAWLER_SCHEDULE?= cron(15 12 * * ? *)
# GLE_CRAWLER_SCHEMA_CHANGE_POLICY?= UpdateBehavior=string,DeleteBehavior=string
# GLE_CRAWLER_TABLE_PREFIX?= 
# GLE_CRAWLER_TARGETS?= 
# GLE_CRAWLER_TARGETS_FILEPATH?= 

# Derived variables
GLE_CRAWLER_DATABASE_NAME?= $(GLE_DATABASE_NAME)
GLE_CRAWLER_TARGETS?= $(if $(GLE_CRAWLER_TARGETS_FILEPATH), file://$(GLE_CRAWLER_TARGETS_FILEPATH))

# Options variables
# __GLE_CLASSIFIERS=
__GLE_CRAWLER_NAME= $(if $(GLE_CRAWLER_NAME), --crawler-name $(GLE_CRAWLER_NAME))
__GLE_DATABASE_NAME_CRAWLER= $(if $(GLE_CRAWLER_DATABASE_NAME), --database-name $(GLE_CRAWLER_DATABASE_NAME))
__GLE_DESCRIPTION_CRAWLER= $(if $(GLE_CRAWLER_DESCRIPTION), --description $(GLE_CRAWLER_DESCRIPTION))
__GLE_NAME_CRAWLER= $(if $(GLE_CRAWLER_NAME), --name $(GLE_CRAWLER_NAME))
__GLE_ROLE= $(if $(GLE_CRAWLER_ROLE), --role $(GLE_CRAWLER_ROLE))
__GLE_SCHEDULE= $(if $(GLE_CRAWLER_SCHEDULE), --schedule $(GLE_CRAWLER_SCHEDULE))
__GLE_SCHEMA_CHANGE_POLICY=
__GLE_TABLE_PREFIX= $(if $(GLE_CRAWLER_TABLE_PREFIX), --table-prefix $(GLE_CRAWLER_TABLE_PREFIX))
__GLE_TARGETS= $(if $(GLE_CRAWLER_TARGETS), --targets $(GLE_CRAWLER_TARGET))

# UI variables
GLE_UI_SHOW_CRAWLER_FIELDS?=
GLE_UI_VIEW_CRAWLERS_FIELDS?= .{Name:Name,_State:State,_DatabaseName:DatabaseName,_LastCrawlStatus:LastCrawl.Status,_LastCrawlErrorMessage:LastCrawl.ErrorMessage}

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_gle_view_makefile_macros ::
	@#echo "AWS::GLuE::Crawler ($(_AWS_GLUE_CRAWLER_MK_VERSION)) macros:"
	@#echo

_gle_view_makefile_targets ::
	@echo "AWS::GLuE::Crawler ($(_AWS_GLUE_CRAWLER_MK_VERSION)) targets:"
	@echo "    _gle_create_crawler                 - Create a crawler"
	@echo "    _gle_delete_crawler                 - Delete a crawler"
	@echo "    _gle_schedule_crawler               - Schedule a crawler to start"
	@echo "    _gle_show_crawler                   - Show details on a crawler"
	@echo "    _gle_start_crawler                  - Start a crawler"
	@echo "    _gle_stop_crawler                   - Stop a running crawler"
	@echo "    _gle_unschedule_crawler             - Unschedule a scheduled crawler"
	@echo "    _gle_view_crawlers                  - View crawlers"
	@echo 

_gle_view_makefile_variables ::
	@echo "AWS::GLuE::Crawler ($(_AWS_GLUE_CRAWLER_MK_VERSION)) variables:"
	@echo "    GLE_CRAWLER_DATABASE_NAME=$(GLE_CRAWLER_DATABASE_NAME)"
	@echo "    GLE_CRAWLER_DESCRIPTION=$(GLE_CRAWLER_DESCRIPTION)"
	@echo "    GLE_CRAWLER_NAME=$(GLE_CRAWLER_NAME)"
	@echo "    GLE_CRAWLER_SCHEDULE=$(GLE_CRAWLER_SCHEDULE)"
	@echo "    GLE_CRAWLER_SCHEMA_CHANGE_POLICY=$(GLE_CRAWLER_SCHEMA_CHANGE_POLICY)"
	@echo "    GLE_CRAWLER_TABLE_PREFIX=$(GLE_CRAWLER_TABLE_PREFIX)"
	@echo "    GLE_CRAWLER_TARGETS=$(GLE_CRAWLER_TARGETS)"
	@echo "    GLE_CRAWLER_TARGETS_FILEPATH=$(GLE_CRAWLER_TARGETS_FILEPATH)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_gle_create_crawler:
	@$(INFO) "$(AWS_LABEL)Creating crawler '$(GLE_CRAWLER_NAME)' ..."; $(NORMAL)
	$(AWS) glue create-crawler $(__GLE_CLASSIFIERS) $(__GLE_CONFIGURATION) $(__GLE_DATABASE_NAME_CRAWLER) $(__GLE_DESCRIPTION_CRAWLER) $(__GLE_NAME_CRAWLER) $(__GLE_ROLE) $(__GLE_SCHEDULE) $(__GLE_SCHEMA_CHANGE_POLICY) $(__GLE_TABLE_PREFIX) $(__GLE_TARGETS)

_gle_delete_crawler:
	@$(INFO) "$(AWS_LABEL)Deleting crawler '$(GLE_CRAWLER_NAME)' ..."; $(NORMAL)
	$(AWS) glue delete-crawler $(__GLE_NAME_CRAWLER)

_gle_schedule_crawler:
	@$(INFO) "$(AWS_LABEL)Scheduling crawler '$(GLE_CRAWLER_NAME)' to start ..."; $(NORMAL)
	@$(WARN) "This operation does NOT start the crowler immediately"; $(NORMAL)
	$(AWS) glue start-crawler-schedule $(__GLE_NAME_CRAWLER)

_gle_show_crawler:
	@$(INFO) "$(AWS_LABEL)Showing crawler '$(GLE_CRAWLER_NAME)' ..."; $(NORMAL)
	$(AWS) glue get-crawler $(__GLE_NAME_CRAWLER)

_gle_start_crawler:
	@$(INFO) "$(AWS_LABEL)Starting crawler '$(GLE_CRAWLER_NAME)' ..."; $(NORMAL)
	$(AWS) glue start-crawler $(__GLE_NAME_CRAWLER)

_gle_stop_crawler:
	@$(INFO) "$(AWS_LABEL)Stop crawler '$(GLE_CRAWLER_NAME)' ..."; $(NORMAL)
	$(AWS) glue stop-crawler $(__GLE_NAME_CRAWLER)

_gle_unschedule_crawler:
	@$(INFO) "$(AWS_LABEL)Unscheduling crawler '$(GLE_CRAWLER_NAME)' ..."; $(NORMAL)
	@$(WARN) "This operation does NOT stop the crawler if already running!"; $(NORMAL)
	$(AWS) glue stop-crawler-schedule $(__GLE_CRAWLER_NAME)

_gle_view_crawlers:
	@$(INFO) "$(AWS_LABEL)Viewing crawlers ..."; $(NORMAL)
	$(AWS) glue get-crawlers --query "Crawlers[]$(GLE_UI_VIEW_CRAWLERS_FIELDS)"
