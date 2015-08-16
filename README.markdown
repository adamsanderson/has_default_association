HasDefaultAssociations
======================

Easily declare default associations for ActiveRecord models.

Usage
-----

Include HasDefaultAssociations and then declare any associations that should 
get defaults.

~~~ ruby
class Book < ActiveRecord::Base
  include HasDefaultAssociation
  
  # Build a default author on demand
  belongs_to :author, class_name: "Person"
  has_default_association(:author)
  
  # Build a custom summary.
  has_one :summary
  has_default_association(:summary) do |book|
    Summary.new(text: "'#{book.name}' is just swell!")
  end
end
~~~

If no block is passed, HasDefaultAssociation will build a default empty model.

Alternatively a block can be used to build the default associated model.

By default, models are only created on demand.  If you always want the 
associated model created you can pass in the `:eager` option:

~~~ ruby
  # Always create a default summary
  has_one :summary
  has_default_association(:summary, eager: true) do |book|
    Summary.new(text: "'#{book.name}' is just swell!")
  end
~~~

For convenience, more than one default association can be named at once:

~~~ ruby
  has_one :summary
  has_one :preface
  has_default_association :summary, :preface
~~~

And there you go.  Enjoy by default!

LICENSE:
--------

(The MIT License)

Copyright (c) Adam Sanderson

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


-----

Adam Sanderson, http://www.monkeyandcrow.com