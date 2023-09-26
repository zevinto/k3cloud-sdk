# K3cloud-sdk
Ruby Gem for K3cloud API.

## Installation

Install the gem and add to the Rails application's Gemfile by executing:

    $ bundle add k3cloud-sdk

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install k3cloud-sdk

## Usage

You'll need to configure it in `config/initializers/k3cloud.rb`:

```ruby
  K3cloud.configure do |config|
    config.acct_id = ENV['K3CLOUD_ACCT_ID']
    config.user_name = ENV['K3CLOUD_USERNAME']
    config.app_id = ENV['K3CLOUD_APP_ID']
    config.app_secret = ENV['K3CLOUD_APP_SECRET']
    config.server_url = ENV['K3CLOUD_SERVER_URL']
  end
```

Then you can call the k3cloud API using the following code:
```ruby
  data = {
    FormId: "",
    FieldKeys: "",
    FilterString: ""
  }
  K3cloud.execute_bill_query(data)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zevinto/k3cloud-sdk. 
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/zevinto/k3cloud-sdk/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the K3cloud-sdk project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/zevinto/k3cloud-sdk/blob/master/CODE_OF_CONDUCT.md).
