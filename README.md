# Cloudtracer
[![Build Status](https://travis-ci.org/ibawt/cloudtracer.svg?branch=master)](https://travis-ci.org/ibawt/cloudtracer)

A Rails plugin for Google's CloudTrace API.

## Usage
```ruby
Cloudtrace.configure do |config|
  config.project_id = 'my-cool-project'
end
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'cloudtracer'
```
## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
