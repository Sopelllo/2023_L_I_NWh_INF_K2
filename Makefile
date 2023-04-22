deps:
	pip install -r requirements.txt;\
	pip install -r test_requirements.txt
lint:
	flake8 hello_world test 
run:
	python main.py
.PHONY: test
test:
	PYTHONPATH=. py.test --verbose -s
docker_build:
	docker build -t hello_world-printer-k6 .
docker_run: docker_build
	docker run \
	--name hello_world-printer-k6 \
	-p 5000:5000 \
	-d hello_world-printer-k6

USERNAME=Sopelllo
TAG=$(USERNAME)/hello_world-printer-k6 

docker_push: docker_build
	@docker login --username $(USERNAME) --password $${DOCKER_PASSWORD};\
	docker tag hello_world-printer-k6 $(TAG);\
	docker push $(TAG);\
	docker logout;