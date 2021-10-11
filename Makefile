.DEFAULT_GOAL := help

configure-env: ## Configure vpc and subnet variables for specified environment
	fetch_constructor_details -e $(env)

ubuntu-18: configure-env ## Make an Ubuntu 18.04 AMI EU-WEST-1
	packer build \
		-var-file=ubuntu-18.04-vars.json \
		-var "TYPE=base" \
		-var "ENVIRONMENT=$(env)" \
		-var "AMI_SOURCE_ID=ami-08d658f84a6d84a80" \
		-var-file=environment/$(env).json \
		base.json | tee /tmp/packer.build.output
	${MAKE} share-ami

ubuntu-18-lon: configure-env ## Make an Ubuntu 18.04 AMI EU-WEST-2
	packer build \
		-var-file=ubuntu-18.04-vars.json \
		-var "TYPE=base" \
		-var "ENVIRONMENT=$(env)" \
		-var "AMI_SOURCE_ID=ami-0b0a60c0a2bd40612" \
		-var-file=environment/$(env).json \
		base.json | tee /tmp/packer.build.output
	${MAKE} share-ami

centos-7: configure-env ## Make a CentOS 7 AMI
	packer build \
		-var-file=centos-7-vars.json \
		-var "TYPE=base" \
		-var "ENVIRONMENT=$(env)" \
		-var "AMI_SOURCE_ID=ami-3548444c" \
		-var-file=environment/$(env).json \
		base.json | tee /tmp/packer.build.output
	${MAKE} share-ami

centos-7-lon: configure-env ## Make a CentOS 7 AMI
	packer build \
		-var-file=centos-7-vars.json \
		-var "TYPE=base" \
		-var "ENVIRONMENT=$(env)" \
		-var "AMI_SOURCE_ID=ami-00846a67" \
		-var-file=environment/$(env).json \
		base.json | tee /tmp/packer.build.output
	${MAKE} share-ami

share-ami: ## Share the last AMI created, subsequent builds will update the ami to send.
	share-ami `egrep "eu-west-[0-9]: ami-" /tmp/packer.build.output | awk '{ print $$2 }'`

help: ## See all the Makefile targets
	@grep -E '^[a-zA-Z0-9._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
