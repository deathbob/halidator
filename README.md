Small library for validating hal+json

Usage with bundler
```
gem 'halidator'
```

Usage stand-alone
```
gem install halidator
irb
require 'halidator'
```



A tiny example

```Ruby
require 'halidator'
require 'open-uri'

puts "Halidator will try and validate a string, if that's what you give it"
string = open("http://haltalk.herokuapp.com/users/mike/posts.json").read
puts "Valid = #{Halidator.new(string).valid?}"

puts "Halidator also will accept the result of JSON.parse"
json = JSON.parse(string)
puts "Valid = #{Halidator.new(json).valid?}"

```


Halidator is mainly intended to be used by instantiating a new instance with a string argument.
The parsed JSON argument is accepted because sometimes that's convenient to do internally.

There is also a executable included with the gem so you can do things like

```
 > curl -s http://haltalk.herokuapp.com/posts/latest.json | halidate
true
```

If there are errors in the string you pipe to halidate, it will print them on stderr
```
 > curl -s http://example.com/bad-hal.json | halidate
false
no self in {'_links' => {'pickles' => 'pie'}}
```

If that's inconvenient, just redirect stderr somewhere you won't see it.
```
 > curl -s http://example.com/bad-hal.json | halidate
false
```
