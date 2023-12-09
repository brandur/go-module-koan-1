# Go Module koan 1

Demonstration of a working project with multiple submodules, most of which refer to each using `replace` directives for maintainability/releasability, but with a command submodule (`./cmd/go-module-koan-1`) that targets a concrete version so that it can still be used with `go install ...@latest`.

It works, but it's bad UX for projects that import it. See below.

## Structure

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

## Problems

It's workable, but it's annoying to add to another project. `go get` finds the right version of the top-level dependency, but then finds the fake `replace`-ed version of subdependencies and errors:

```sh
$ go mod tidy
go: finding module for package github.com/brandur/go-module-koan-1
go: found github.com/brandur/go-module-koan-1 in github.com/brandur/go-module-koan-1 v0.0.2
go: downloading github.com/brandur/go-module-koan-1/koandriver/koanpgxv5 v0.0.0-00010101000000-000000000000

go: github.com/brandur/go-module-koan-1-importer imports
        github.com/brandur/go-module-koan-1 imports
        github.com/brandur/go-module-koan-1/koandriver/koanpgxv5: github.com/brandur/go-module-koan-1/koandriver/koanpgxv5@v0.0.0-00010101000000-000000000000: invalid version: unknown revision 000000000000
```

This is fixable by making sure to `go get` dependencies separately, starting with the lowest level one and working your way upwards, but it's annoying as hell:

``` sh
$ go get github.com/brandur/go-module-koan-1/koandriver
go: added github.com/brandur/go-module-koan-1/koandriver v0.0.2

$ go get github.com/brandur/go-module-koan-1/koandriver/koanpgxv5
go: added github.com/brandur/go-module-koan-1/koandriver/koanpgxv5 v0.0.2

$ go get github.com/brandur/go-module-koan-1
go: added github.com/brandur/go-module-koan-1 v0.0.2

$ go mod tidy

$ go test .
?       github.com/brandur/go-module-koan-1-importer    [no test files]
```

## Conclusion

Unfortunately, there is no good way to cleanly manage a multi-module project in Go without pain roughly on order with inhabiting the ninth circle of hell.

## Releasing

```sh
VERSION=v0.0.x
git tag $VERSION
git tag cmd/go-module-koan-1/$VERSION
git tag koandriver/$VERSION
git tag koandriver/koanpgxv5/$VERSION
```
