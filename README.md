# Capistrano::Server::Plug

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-server-plug'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-server-plug

## Usage

inside `config/deploy.rb`

```ruby
require 'capistrano/server/plug'
```

inside `config/deploy/<my-stage>.rb`

```ruby
set :server_type, :passenger
```



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
