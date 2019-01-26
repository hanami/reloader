# Hanami::Reloader
Code reloading for Hanami

## v1.0.0.alpha1 - 2019-01-30
### Added
- [Luca Guidi] Added support for `hanami server --no-code-reloading` to skip code reloading.
- [Luca Guidi] Added `hanami server --guardfile` option to specify the path to `Guardfile`. It defaults to `Guardfile` at the root of the project.
- [Luca Guidi] Added support for `hanami generate reloader --puma` to generate Puma specific configuration.

### Changed
- [Luca Guidi] `hanami generate reloader` generates `Guardfile` (instead of `.hanami.server.guardfile`), with the Guard `:server` group.
- [Luca Guidi] `hanami server` will look for `Guardfile` at the root of the project instead of `.hanami.server.guardfile`.

## v0.2.1 - 2018-01-23
### Fixed
- [Luca Guidi] Avoid Guard prompt when shutting down the server

## v0.2.0 - 2017-11-24
### Changed
- [Marcello Rocha] Use `.hanami.server.guardfile` instead of `Guardfile` to avoid conflicts with other `guard` plugins.

## v0.1.0 - 2017-11-01
### Added
- [Luca Guidi] Added Hanami command `hanami generate reloader`
- [Luca Guidi] Code reloading based on `guard`
