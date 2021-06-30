envs := $(shell cat envs.yaml | yq .envs | jq 'keys[]' -r)
apps := $(shell cat apps.yaml | yq .apps | jq 'keys[]' -r)
app_values := $(foreach E,$(envs),$(addsuffix .yaml,$(addprefix build/$E/,$(apps))))

default: $(app_values)
	@echo "Done!"

$(app_values): lifecycle=$(shell echo $@ | awk -F'/' '{print $$2}')
$(app_values): env=$(shell echo $@ | awk -F'/' '{print $$3}')
$(app_values): app=$(shell echo $@ | awk -F'[/.]' '{print $$4}')
$(app_values): FORCE
	@mkdir -p $(@D)
	./bin/manifest --lifecycle ${lifecycle} --env ${env} --app_name ${app} --output_file $@

FORCE:
