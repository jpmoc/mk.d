_OPENSSL_MK_VERSION= 0.99.0

# OSL_INPUTS_DIRPATH?= ./in/
# OSL_OUTPUTS_DIRPATH?= ./out/

# Derived parameters
OSL_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
OSL_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)

# Option parameters

# UI
OSL_UI_LABEL?= [openssl] #

#--- Utilities

OPENSSL= $(strip $(__SSL_ENVIRONMENT) $(SSL_ENVIRONMENT) openssl $(__SSL_OPTIONS) $(SSL_OPTIONS) )

#--- MACROS

#----------------------------------------------------------------------
# INTERFACE
#

_list_macros :: _osl_list_macros
_osl_list_macros ::
	@#echo 'OpenSSL:: ($(_OPENSSL_MK_VERSION)) parameters:'
	@#echo

_list_parameters :: _osl_list_parameters
_osl_list_parameters ::
	@echo 'OpenSSL:: ($(_OPENSSL_MK_VERSION)) parameters:'
	@echo '    OSL_INPUTS_DIRPATH=$(OSL_INPUTS_DIRPATH)'
	@echo '    OSL_OUTPUTS_DIRPATH=$(OSL_OUTPUTS_DIRPATH)'
	@echo '    OPENSSL=$(OPENSSL)'
	@echo

_list_targets :: _osl_list_targets
_osl_list_targets ::
	@#echo 'OpenSSL:: ($(_OPENSSL_MK_VERSION)) targets:'
	@#echo

#----------------------------------------------------------------------
# PRIVATE TARGETS 
#

MK_DIR?= .
-include $(MK_DIR)/openssl_certificatesigningrequest.mk
-include $(MK_DIR)/openssl_certificatesigningrequestconfig.mk
-include $(MK_DIR)/openssl_certificate.mk
-include $(MK_DIR)/openssl_filepair.mk
-include $(MK_DIR)/openssl_privatekey.mk
-include $(MK_DIR)/openssl_publickey.mk
-include $(MK_DIR)/openssl_remotecertificate.mk
-include $(MK_DIR)/openssl_rootcertificate.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS 
#

_osl_list_cipheralgorithms:
	@$(INFO) '$(OSL_UI_LABEL)Listing cipher-algorithms ...'; $(NORMAL)
	@$(WARN) 'The cipher-algorithm is used for the encryption of the private-key, if any'; $(NORMAL)
	$(OPENSSL) list -cipher-algorithms
