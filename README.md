# wabisaby-protos

Protocol buffer sources for WabiSaby (node and plugin APIs). This repo contains **proto sources only**; generated Go is not committed here.

## Go bindings

Go bindings are published in **[wabisaby-protos-go](https://github.com/WabiSaby/wabisaby-protos-go)**. Consumers should depend on that module:

```bash
go get github.com/wabisaby/wabisaby-protos-go@v0.0.1
```

## Publishing a new wabisaby-protos-go version

After changing `.proto` files and tagging a release in this repo:

1. Clone **wabisaby-protos-go** (or use your DevKit sibling).
2. From this repo run:  
   `make proto-for-go OUT_DIR=/path/to/wabisaby-protos-go`
3. In the wabisaby-protos-go repo: `go mod tidy`, commit, push, and tag (e.g. `v0.0.2`).
4. Consumers bump with: `go get github.com/wabisaby/wabisaby-protos-go@v0.0.2`

## Local development

- `make proto` — generates Go into `go/` for local use (output is gitignored).
- `make proto-for-go OUT_DIR=../wabisaby-protos-go` — generates into the -go repo with module path `github.com/wabisaby/wabisaby-protos-go` (for publishing or local DevKit).
