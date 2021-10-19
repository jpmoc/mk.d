_AWS_CLOUDFRONT_DISTRIBUTION_MK_VERSION= $(_AWS_CLOUDFRONT_MK_VERSION)

# CFT_DISTRIBUTION_CONFIG?= 
# CFT_DISTRIBUTION_CONFIG_FILENAME?= distribution-config.json
# CFT_DISTRIBUTION_CONFIG_FILEPATH?= ./distribution-config.json
CFT_DISTRIBUTION_CURL_PROTO= http
# CFT_DISTRIBUTION_CURL_URL= http://d1bt4wb4hwjci7.cloudfront.net
# CFT_DISTRIBUTION_DEFAULTROOTOBJECT?= index.html
# CFT_DISTRIBUTION_DIRPATH?= ./in
# CFT_DISTRIBUTION_DOMAIN_NAME?= d1bt4wb4hwjci7.cloudfront.net
# CFT_DISTRIBUTION_ETAG?= 8UBQECEJX24ST
# CFT_DISTRIBUTION_ID?= S11A16G5KZMEQD
# CFT_DISTRIBUTION_ORIGIN_DOMAINNAME?= my-bucket.s3.amazonaws.com
# CFT_DISTRIBUTION_NAME?= my-distribution
# CFT_DISTRIBUTIONS_SET_NAME?= my-distributions-set

# Derived parameters
CFT_DISTRIBUTION_CONFIG?= $(if $(CFT_DISTRIBUTION_CONFIG_FILEPATH),file://$(CFT_DISTRIBUTION_CONFIG_FILEPATH))
CFT_DISTRIBUTION_CONFIG_FILEPATH?= $(CFT_DISTRIBUTION_DIRPATH)$(CFT_DISTRIBUTION_CONFIG_FILENAME)
CFT_DISTRIBUTION_CURL_URL?= $(if $(CFT_DISTRIBUTION_DOMAIN_NAME),$(CFT_DISTRIBUTION_CURL_PROTO)://$(CFT_DISTRIBUTION_DOMAIN_NAME))
CFT_DISTRIBUTION_DIRPATH?= $(CFT_DIRPATH)

# Option parameters
__CFT_DEFAULT_ROOT_OBJECT= $(if $(CFT_DISTRIBUTION_DEFAULTROOTOBJECT), --default-root-object $(CFT_DISTRIBUTION_DEFAULTROOTOBJECT))
__CFT_DISTRIBUTION_CONFIG= $(if $(CFT_DISTRIBUTION_CONFIG), --distribution-config $(CFT_DISTRIBUTION_CONFIG))
__CFT_ID__DISTRIBUTION= $(if $(CFT_DISTRIBUTION_ID), --id $(CFT_DISTRIBUTION_ID))
__CFT_IF_MATCH= $(if $(CFT_DISTRIBUTION_ETAG), --if-match $(CFT_DISTRIBUTION_ETAG))
__CFT_ORIGIN_DOMAIN_NAME=


# Pipe parameters
_CFT_CURL_DISTRIBUTION_|?= [ -z "$(CFT_DISTRIBUTION_CURL_URL)" ] ||
|_CFT_CURL_DISTRIBUTION?= | head -10

# UI parameters
CFT_UI_VIEW_DISTRIBUTIONS_FIELDS?= .{Id:Id,domainName:DomainName,enabled:Enabled,httpVersion:HttpVersion,priceClass:PriceClass,status:Status,isIPv6Enabled:IsIPV6Enabled}
CFT_UI_VIEW_DISTRIBUTIONS_SET_FIELDS?= $(CFT_UI_VIEW_DISTRIBUTIONS_FIELDS)
CFT_UI_VIEW_DISTRIBUTIONS_SET_QUERYFILTER?=

#--- Utilities

#--- MACROS
_cft_get_distribution_domain_name= $(call _cft_get_distribution_domain_name_I, $(CFT_DISTRIBUTION_ID))
_cft_get_distribution_domain_name_I= $(shell $(AWS) cloudfront get-distribution --id $(1) --query "Distribution.DomainName" --output text)

_cft_get_distribution_etag= $(call _cft_get_distribution_etag_I, $(CFT_DISTRIBUTION_ID))
_cft_get_distribution_etag_I= $(shell $(AWS) cloudfront get-distribution  --id $(1) --query "ETag" --output text)

_cft_get_distribution_id= $(call _cft_get_distribution_id_N, $(CFT_DISTRIBUTION_DOMAIN_NAME))
_cft_get_distribution_id_N= $(shell $(AWS) cloudfront list-distributions --query "DistributionList.Items[?DomainName=='$(strip $(1))'].Id" --output text)

#----------------------------------------------------------------------
# USAGE
#

_cft_view_framework_macros ::
	@echo 'AWS::CloudFronT::Distribution ($(_AWS_CLOUDFRONT_DISTRIBUTION_MK_VERSION)) macros:'
	@echo '    _cft_get_distribution_domain_name_{|I}    - Get the domain-name of a distribution (Id)'
	@echo '    _cft_get_distribution_etag_{|I}           - Get the ETAG of a distribution (Id)'
	@echo '    _cft_get_distribution_id_{|N}             - Get the ID of a distribution (domainName)'
	@echo

_cft_view_framework_parameters ::
	@echo 'AWS::CloudFronT::Distribution ($(_AWS_CLOUDFRONT_DISTRIBUTION_MK_VERSION)) parameters:'
	@echo '    CFT_DISTRIBUTION_CONFIG=$(CFT_DISTRIBUTION_CONFIG)'
	@echo '    CFT_DISTRIBUTION_CONFIG_FILENAME=$(CFT_DISTRIBUTION_CONFIG_FILENAME)'
	@echo '    CFT_DISTRIBUTION_CONFIG_FILEPATH=$(CFT_DISTRIBUTION_CONFIG_FILEPATH)'
	@echo '    CFT_DISTRIBUTION_CURL_PROTO=$(CFT_DISTRIBUTION_CURL_PROTO)'
	@echo '    CFT_DISTRIBUTION_CURL_URL=$(CFT_DISTRIBUTION_CURL_URL)'
	@echo '    CFT_DISTRIBUTION_DEFAULTROOTOBJECT=$(CFT_DISTRIBUTION_DEFAULTROOTOBJECT)'
	@echo '    CFT_DISTRIBUTION_DIRPATH=$(CFT_DISTRIBUTION_DIRPATH)'
	@echo '    CFT_DISTRIBUTION_DOMAIN_NAME=$(CFT_DISTRIBUTION_DOMAIN_NAME)'
	@echo '    CFT_DISTRIBUTION_ID=$(CFT_DISTRIBUTION_ID)'
	@echo '    CFT_DISTRIBUTION_ORIGIN_DOMAINNAME=$(CFT_DISTRIBUTION_ORIGIN_DOMAINNAME)'
	@echo '    CFT_DISTRIBUTION_NAME=$(CFT_DISTRIBUTION_NAME)'
	@echo '    CFT_DISTRIBUTIONS_SET_NAME=$(CFT_DISTRIBUTIONS_SET_NAME)'
	@echo

_cft_view_framework_targets ::
	@echo 'AWS::CloudFronT::Distribution ($(_AWS_CLOUDFRONT_DISTRIBUTION_MK_VERSION)) targets:'A
	@echo '    _cft_curl_distribution                 - Curl a distribution'
	@echo '    _cft_create_distribution               - Create a new distribution'
	@echo '    _cft_delete_distribution               - Delete an existing distribution'
	@echo '    _cft_show_distribution                 - Show everything related to a distribution'
	@echo '    _cft_show_distribution_description     - Show description of a distribution'
	@echo '    _cft_update_distribution               - Update a distribution'
	@echo '    _cft_view_distributions                - View distributions'
	@echo '    _cft_view_distributions_set            - View a set of distributions'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cft_curl_distribution:
	@$(INFO) '$(CFT_UI_LABEL)Curling distribution "$(CFT_DISTRIBUTION_NAME)" ...'; $(NORMAL)
	$(_CFT_CURL_DISTRIBUTION_|) curl --location --silent $(CFT_DISTRIBUTION_CURL_URL) $(|_CFT_CURL_DISTRIBUTION)

_cft_create_distribution:
	@$(INFO) '$(CFT_UI_LABEL)Creating distribution "$(CFT_DISTRIBUTION_NAME)" ...'; $(NORMAL)
	$(if $(CFT_DISTRIBUTION_CONFIG_FILEPATH), cat $(CFT_DISTRIBUTION_CONFIG_FILEPATH))
	$(AWS) cloudfront create-distribution $(strip $(__CFT_DEFAULT_ROOT_OBJECT) $(__CFT_DISTRIBUTION_CONFIG) $(__CFT_ORIGIN_DOMAIN_NAME))

_cft_delete_distribution:
	@$(INFO) '$(CFT_UI_LABEL)Deleting distribution "$(CFT_DISTRIBUTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation will fail if the distribution has not yet been disabled!'; $(NORMAL)
	$(AWS) cloudfront get-distribution $(__CFT_ID__DISTRIBUTION) --query "Distribution.{Status:Status,Enabled:DistributionConfig.Enabled}"
	$(AWS) cloudfront delete-distribution $(__CFT_ID__DISTRIBUTION) $(__CFT_IF_MATCH)

_cft_disable_distribution: TMP_FILE?= /tmp/distribution-config-disabled.json
_cft_disable_distribution:
	@$(INFO) '$(CFT_UI_LABEL)Disabling distribution "$(CFT_DISTRIBUTION_NAME)" ...'; $(NORMAL)
	$(AWS) cloudfront get-distribution-config  $(__CFT_ID__DISTRIBUTION) --query "merge(DistributionConfig,{"Enabled":\`false\`})" --output json > $(TMP_FILE)
	$(AWS) cloudfront update-distribution --distribution-config file://$(TMP_FILE) $(__CFT_ID__DISTRIBUTION) $(__CFT_IF_MATCH) 

_cft_enable_distribution:
	@$(INFO) '$(CFT_UI_LABEL)Enabling distribution "$(CFT_DISTRIBUTION_NAME)" ...'; $(NORMAL)

_cft_show_distribution: _cft_show_distribution_config _cft_show_distribution_origins _cft_show_distribution_description

_cft_show_distribution_config:
	@$(INFO) '$(CFT_UI_LABEL)Showing config of distribution "$(CFT_DISTRIBUTION_NAME)" ...'; $(NORMAL)
	$(AWS) cloudfront get-distribution-config $(__CFT_ID__DISTRIBUTION) --query "DistributionConfig" --output json

_cft_show_distribution_description:
	@$(INFO) '$(CFT_UI_LABEL)Showing description of distribution "$(CFT_DISTRIBUTION_NAME)" ...'; $(NORMAL)
	$(AWS) cloudfront get-distribution $(__CFT_ID__DISTRIBUTION)

_cft_show_distribution_origins:
	@$(INFO) '$(CFT_UI_LABEL)Showing origins of distribution "$(CFT_DISTRIBUTION_NAME)" ...'; $(NORMAL)
	$(AWS) cloudfront get-distribution-config  $(__CFT_ID__DISTRIBUTION) --query "DistributionConfig.Origins.Items"

_cft_update_distribution:
	@$(INFO) '$(CFT_UI_LABEL)Updating distribution "$(CFT_DISTRIBUTION_NAME)" ...'; $(NORMAL)
	$(AWS) cloudfront update-distribution $(__CFT_DEFAULT_ROOT_OBJECT) $(__CFT_DISTRIBUTION_CONFIG) $(__CFT_ID__DISTRIBUTION) $(__CFT_IF_MATCH)

_cft_view_distributions:
	@$(INFO) '$(CFT_UI_LABEL)Viewing distributions ...'; $(NORMAL)
	$(AWS) cloudfront list-distributions --query "DistributionList.Items[]$(CFT_UI_VIEW_DISTRIBUTIONS_FIELDS)"

_cft_view_distributions_set:
	@$(INFO) '$(CFT_UI_LABEL)Viewing distributions-set "$(CFT_DISTRIBUTIONS_SET_NAME)" ...'; $(NORMAL)
	$(AWS) cloudfront list-distributions --query "DistributionList.Items[$(CFT_UI_VIEW_DISTRIBUTIONS_SET_QUERYFILTER)]$(CFT_UI_VIEW_DISTRIBUTIONS_SET_FIELDS)"
