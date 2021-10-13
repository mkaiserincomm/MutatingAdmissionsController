build:
	npm install
	npm run build-server
	npm run test

docker:
	docker build --no-cache -t mutatingcontroller . 
	# push to here: mgkaiser/mutatingcontroller:0.1.0

docker-test:
	docker run -d -p 3000:3000 mutatingcontroller
	@echo '> Hitting health endpoint'
	bash ./scripts/health.sh
	@echo '> Cleaning up'
	docker ps | grep mutatingcontroller | awk '{print $$1}' | xargs docker kill

helm-package:
	helm package ${PWD}/chart/registry-rewriter -d ${PWD}

.PHONY: build