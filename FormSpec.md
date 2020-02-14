## Why

The core of Petri Flow is the workflow engine. 
However, workflow, dynamic forms, and organization systems are inseparable. Therefore, petri flow provides simple built-in dynamic form functions, but in practice dynamic forms require more complex features. 
Such as selecting data from other data sources, data validation, application-oriented data fields, UI customization, etc. 
Petri Flow abstracts the interface needed to integrate with dynamic forms, in order to integrate more complex dynamic forms systems, such as [form core](https://github.com/rails-engine/form_core).

## Core Entity

* Form
* Field
* Entry
* FieldValue

## Relations

* form has_many fields
* form has_many entries

* field belongs_to form

* field_value belongs_to form
* field_value belongs_to field
* field_value belongs_to entry

* entry belongs_to form
* entry belongs_to user
* entry belongs_to workitem
* entry has_many field_values

## Casting

* Field#cast(value)
* FieldValue#value_after_cast

## Setting

```ruby
# config/initializers/wf_config.rb
Wf::Workflow.class_eval do
  def self.user_class
    "::Wf::User"
  end

  def self.form_class
    "::Form"
  end

  def self.entry_class
    "::Entry"
  end

  def self.field_class
    "::Field"
  end
end
```
