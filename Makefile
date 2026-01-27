.PHONY: proto clean proto-plugin proto-node test

proto: proto-plugin proto-node

test: proto ## Generate protobuf code (no tests to run, but ensures code is generated)
	@echo "Protobuf code generated successfully"

proto-plugin:
	@mkdir -p go/plugin
	protoc \
		--proto_path=api/proto/plugin \
		--go_out=go/plugin \
		--go_opt=paths=source_relative \
		--go-grpc_out=go/plugin \
		--go-grpc_opt=paths=source_relative \
		api/proto/plugin/*.proto

proto-node:
	@mkdir -p go/node
	protoc \
		--proto_path=api/proto/node \
		--go_out=go/node \
		--go_opt=paths=source_relative \
		--go-grpc_out=go/node \
		--go-grpc_opt=paths=source_relative \
		api/proto/node/*.proto

clean:
	rm -f go/plugin/*.pb.go go/node/*.pb.go
