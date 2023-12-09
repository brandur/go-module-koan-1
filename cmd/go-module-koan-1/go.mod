module github.com/brandur/go-module-koan-1/cmd/go-module-koan-1

go 1.21.4

replace github.com/brandur/go-module-koan-1 => ../..

replace github.com/brandur/go-module-koan-1/koandriver => ../../koandriver

replace github.com/brandur/go-module-koan-1/koandriver/koanpgxv5 => ../../koandriver/koanpgxv5

require github.com/brandur/go-module-koan-1 v0.0.0-20231209211256-351d9c0498c3

require (
	github.com/brandur/go-module-koan-1/koandriver v0.0.0-00010101000000-000000000000 // indirect
	github.com/brandur/go-module-koan-1/koandriver/koanpgxv5 v0.0.0-00010101000000-000000000000 // indirect
)
