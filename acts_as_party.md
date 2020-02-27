## Usage


for normal org model, for example group or role etc.

```ruby
module Wf
  class Group < ApplicationRecord
    has_many :users 
    include Wf::ActsAsParty
    acts_as_party(user: false, party_name: :name)
  end
end
```

for user model:

```ruby
module Wf
  class User < ApplicationRecord
    belongs_to :group, optional: true
    include Wf::ActsAsParty
    acts_as_party(user: true, party_name: :name)
  end
end
```