module github.com/brandur/go-module-koan-1

go 1.21.4

replace github.com/brandur/go-module-koan-1/koandriver => ./koandriver

replace github.com/brandur/go-module-koan-1/koandriver/koanpgxv5 => ./koandriver/koanpgxv5

require github.com/brandur/go-module-koan-1/koandriver/koanpgxv5 v0.0.2

require github.com/brandur/go-module-koan-1/koandriver v0.0.2 // indirect
