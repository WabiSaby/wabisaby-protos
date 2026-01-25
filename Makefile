.PHONY: proto clean proto-plugin proto-node

proto: proto-plugin proto-node

proto-plugin:
	protoc \
		--proto_path=api/proto/plugin \
		--go_out=go/plugin \
		--go_opt=paths=source_relative \
		--go-grpc_out=go/plugin \
		--go-grpc_opt=paths=source_relative \
		api/proto/plugin/*.proto

proto-node:
	protoc \
		--proto_path=api/proto/node \
		--go_out=go/node \
		--go_opt=paths=source_relative \
		--go-grpc_out=go/node \
		--go-grpc_opt=paths=source_relative \
		api/proto/node/*.proto

clean:
	rm -f go/plugin/*.pb.go go/node/*.pb.go
