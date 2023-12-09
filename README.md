# Go Module koan 1

Demonstration of a working project with multiple submodules, most of which refer to each using `replace` directives for maintainability/releasability, but with a command submodule (`./cmd/go-module-koan-1`) that targets a concrete version so that it can still be used with `go install ...@latest`.

Structure:

```sh
.                        # top-level is a Go module; uses `replace` directives
./cmd
    /go-module-koan-1    # installable command; is a Go module; does NOT use `replace`
./koandriver             # subpackage; is a Go module; uses `replace` directives
    /koanpgxv5           # sub-subpackage; is a Go module; uses `replace` directives
```

Each submodule is buildable:

```sh
$ go test .
?       github.com/brandur/go-module-koan-1     [no test files]

$ cd cmd/go-module-koan-1/
$ go test .
?       github.com/brandur/go-module-koan-1/cmd/go-module-koan-1        [no test files]

$ cd koandriver/
$ go test .
?       github.com/brandur/go-module-koan-1/koandriver  [no test files]

$ cd koandriver/koanpgxv5
$ go test .
?       github.com/brandur/go-module-koan-1/koandriver/koanpgxv5        [no test files]
```

The command is installable:

```sh
$ go install github.com/brandur/go-module-koan-1/cmd/go-module-koan-1@latest
go: downloading github.com/brandur/go-module-koan-1 v0.0.2
go: downloading github.com/brandur/go-module-koan-1/cmd/go-module-koan-1 v0.0.2
```

## Releasing

```sh
VERSION=v0.0.x
git tag $VERSION
git tag cmd/go-module-koan-1/$VERSION
git tag koandriver/$VERSION
git tag koandriver/koanpgxv5/$VERSION
```
