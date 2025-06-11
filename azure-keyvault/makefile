# Environment
ENV ?= development
ifneq ($(filter development staging production,$(ENV)),$(ENV))
    $(error ENV must be either 'development', 'staging', or 'production'. Current value: $(ENV))
endif

# Helm
HELM_RELEASE_NAME=azure-keyvault

# Azure
RESOURCE_GROUP_NAME ?= ${ENV}

# Functions
define get_subscription_id
$(shell az account list \
	--query "[?contains(name, '$(ENV)')].id" \
	--output tsv)
endef

################################################################################
# Commands                                                                     #
################################################################################
debug:
	helm template $(HELM_RELEASE_NAME) . \
		--values values.yaml \
		--values values.${ENV}.yaml \
		--set parameters.userAssignedIdentityID=debug-for-identity-id \
		--set parameters.tenantId=debug-for-tenant-id \
		--debug;

deploy:
	$(eval SECRETS_IDENTITY_ID := $(shell az aks show -g $(RESOURCE_GROUP_NAME) -n skand-$(ENV)-aks --subscription $(call get_subscription_id) --query 'addonProfiles.azureKeyvaultSecretsProvider.identity.clientId' -o tsv))
	$(eval TENANT_ID := $(shell az account show --query tenantId --output tsv))
	helm upgrade --install --wait $(HELM_RELEASE_NAME) . \
		--values values.yaml \
		--values values.${ENV}.yaml \
		--set parameters.userAssignedIdentityID=$(SECRETS_IDENTITY_ID) \
		--set parameters.tenantId=$(TENANT_ID);
