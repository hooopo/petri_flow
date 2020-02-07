# Wf
Short description and motivation.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'petri_flow', require: 'wf'
```

And then execute:

```bash
$ bundle
```

Install graphviz

```
brew install graphviz
```

Migration:

```
bundle exec rake wf:install:migrations
bundle exec rails db:create
bundle exec rails db:migrate
```
## Usage

Add wf_config:

```ruby
# config/initializers/wf_config.rb
Wf::Workflow.class_eval do
  def self.user_class
    ::User
  end
  
  # you can add more org class, for example, Role, Department, Position etc.
  def self.org_classes
    { group: ::Group }
  end
end
```

Set parties:

```ruby
class User < ApplicationRecord
  belongs_to :group, optional: true
  has_one :party, as: :partable, class_name: 'Wf::Party'

  # NOTICE: group or user or role all has_many users
  has_many :users, foreign_key: :id

  after_create do
    create_party(party_name: name)
  end
end
```

```ruby
class Group < ApplicationRecord
  has_many :users
  has_one :party, as: :partable, class_name: 'Wf::Party'
  after_create do
    create_party(party_name: name)
  end
end
```

then

```
bundle exec rails 
```

visit:

```
http://localhost:3000/wf
```

Demo App: https://github.com/hooopo/petri_flow_demo

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
