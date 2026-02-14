.PHONY: proto clean proto-plugin proto-node test proto-for-go

proto: proto-plugin proto-node

# Generate Go code for wabisaby-protos-go repo (new module path). Set OUT_DIR to the -go repo root.
# Usage: make proto-for-go OUT_DIR=/path/to/wabisaby-protos-go
proto-for-go:
	@test -n "$(OUT_DIR)" || (echo "OUT_DIR is required (e.g. make proto-for-go OUT_DIR=../wabisaby-protos-go)"; exit 1)
	@mkdir -p $(OUT_DIR)/go/plugin $(OUT_DIR)/go/node
	protoc \
		--proto_path=api/proto/plugin \
		--go_out=$(OUT_DIR)/go/plugin \
		--go_opt=paths=source_relative \
		--go_opt='Mapi/proto/plugin/execution.proto=github.com/wabisaby/wabisaby-protos-go/go/plugin;pluginpb' \
		--go_opt='Mapi/proto/plugin/common.proto=github.com/wabisaby/wabisaby-protos-go/go/plugin;pluginpb' \
		--go_opt='Mapi/proto/plugin/capabilities.proto=github.com/wabisaby/wabisaby-protos-go/go/plugin;pluginpb' \
		--go-grpc_out=$(OUT_DIR)/go/plugin \
		--go-grpc_opt=paths=source_relative \
		--go-grpc_opt='Mapi/proto/plugin/execution.proto=github.com/wabisaby/wabisaby-protos-go/go/plugin;pluginpb' \
		--go-grpc_opt='Mapi/proto/plugin/common.proto=github.com/wabisaby/wabisaby-protos-go/go/plugin;pluginpb' \
		--go-grpc_opt='Mapi/proto/plugin/capabilities.proto=github.com/wabisaby/wabisaby-protos-go/go/plugin;pluginpb' \
		api/proto/plugin/common.proto api/proto/plugin/execution.proto api/proto/plugin/capabilities.proto
	protoc \
		--proto_path=api/proto/node \
		--go_out=$(OUT_DIR)/go/node \
		--go_opt=paths=source_relative \
		--go_opt='Mapi/proto/node/node.proto=github.com/wabisaby/wabisaby-protos-go/go/node;nodepb' \
		--go-grpc_out=$(OUT_DIR)/go/node \
		--go-grpc_opt=paths=source_relative \
		--go-grpc_opt='Mapi/proto/node/node.proto=github.com/wabisaby/wabisaby-protos-go/go/node;nodepb' \
		api/proto/node/node.proto
	@echo "Generated into $(OUT_DIR)/go"

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
