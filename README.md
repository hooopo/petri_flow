# Petri Flow

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

* [Petri-Nets and Workflows](https://app.gitbook.com/@hooopo/s/petri-flow/)
* [Workflow Conceptual Guide](https://app.gitbook.com/@hooopo/s/petri-flow/workflow-conceptual-guide)
* [Workflow Concepts Reference](https://app.gitbook.com/@hooopo/s/petri-flow/workflow-concepts-reference)
* [Petri Flow ERD](https://app.gitbook.com/@hooopo/s/petri-flow/erd)

## Screenshots

###  iterative routing

![](https://github.com/hooopo/wf/blob/master/screenshots/iterative_routing.png)

### parallel_routing

![](https://github.com/hooopo/wf/blob/master/screenshots/parallel_routing.png)

### guard

![](https://github.com/hooopo/wf/blob/master/screenshots/workflow_with_guard.png)

### case state graph

![](https://github.com/hooopo/wf/blob/master/screenshots/case_state_graph.png)

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
