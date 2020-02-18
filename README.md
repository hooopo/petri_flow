# Petri Flow ![Ruby Gem](https://github.com/hooopo/petri_flow/workflows/Ruby%20Gem/badge.svg?event=push) ![Testing](https://github.com/hooopo/petri_flow/workflows/Testing/badge.svg?event=push)

Workflow engine for Rails.

## Features
* Full petri net features support (seq, parallel, iterative, timed, automitic etc.)
* Both approval workflow and business workflow.
* Simple web admin for workflow definition and case management.
* Build-in simple dynamic form.
* Replaceable dynamic form.
* Graph screen for workflow definition.
* Graph screen for case and token migration.
* Powerful guard expression.
* MySQL and Postgres Support.
* Powerful assignment management.
* Flexible integration of organizational structure system(role, group, position or department etc.)

## Docs

* [Petri-Nets and Workflows](https://hooopo.gitbook.io/petri-flow/)
* [Workflow Conceptual Guide](https://hooopo.gitbook.io/petri-flow/workflow-conceptual-guide)
* [Workflow Concepts Reference](https://hooopo.gitbook.io/petri-flow/workflow-concepts-reference)
* [Petri Flow ERD](https://hooopo.gitbook.io/petri-flow/erd)
* [Developer Doc](https://hooopo.gitbook.io/petri-flow/developer-document)

## Screenshots

###  iterative routing

![](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-M-GhlU_QaD6nbLAbaJI%2F-M-X0nIxUUBwJsNhY4FN%2F-M-XAAQJbxDdaxoaYVda%2Fimage.png?alt=media&token=e74d1ae7-fa16-47ab-83b5-ad73a382fa07)

### parallel_routing

![](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-M-GhlU_QaD6nbLAbaJI%2F-M-X0nIxUUBwJsNhY4FN%2F-M-XAKm9VN1MJxPZT9Xe%2Fimage.png?alt=media&token=c8beba84-72ec-470f-9987-81cf40762e15)

### guard

![](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-M-GhlU_QaD6nbLAbaJI%2F-M-X0nIxUUBwJsNhY4FN%2F-M-XAT8Ui_xjqy9Niccp%2Fimage.png?alt=media&token=de4298fb-14b9-40bc-ab75-92ef0b98a533)

### case state graph

![](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-M-GhlU_QaD6nbLAbaJI%2F-M-X0nIxUUBwJsNhY4FN%2F-M-XAeeR42ZRVIVKuUae%2Fimage.png?alt=media&token=90c96af9-d01f-4d6e-ae2b-445ea343a5ac)

### 
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
bundle exec rails db:seed
```
## Usage

Add wf_config:

```ruby
# config/initializers/wf_config.rb
Wf.user_class = "::User"
Wf.org_classes = { group: "::Group" }
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

## Testing

* RAILS_ENV=test rake app:db:migrate && RAILS_ENV=test rake app:db:test:prepare && bundle exec rake test

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
