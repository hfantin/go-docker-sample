all: update docker 

update: 
	@go get -u
	@go mod tidy

docker: 
	@docker build -t go-docker-sample .
