# Hanami::Reloader

**Experimental** code reloading for Hanami.

## Usage

### 1. Setup Hanami project

```shell
gem install hanami
hanami new bookshelf && cd bookshelf
```

### 2. Prepare Gemfile

Edit `Gemfile`

  1. Remove `shotgun`
  2. Add the following lines

```ruby
group :plugins do
  gem "hanami-reloader", "~> 0.1"
end
```

### 3. Setup hanami-reloader

```shell
bundle
bundle exec hanami generate reloader
```

Now you can start the server via `bundle exec hanami server`.

## Upgrade Nodes

If you're upgrading from `v0.1.0` to `v0.2.0`, use `.hanami.server.guardfile` instead of `Guardfile`.

## Puma usage

If you're using `puma`, I **strongly** suggest to use `guard-puma` **alongside** with `hanami-reloader`.

Add `guard-puma` to your `Gemfile`:

```ruby
group :development do
  gem "guard-puma"
end
```

Then change the group name in `.hanami.server.guardfile` from `"rack"` to `"puma"`:

```diff
-guard "rack", port: ENV["HANAMI_PORT"] || 2300 do
+guard "puma", port: ENV["HANAMI_PORT"] || 2300 do
```

Now start the server as usual: `bundle exec hanami server`

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jodosha/hanami-reloader.

## Copyright

Copyright © 2017-2018 Luca Guidi – Released under MIT License
