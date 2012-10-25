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

The default validator is a pure ruby implementation that is slightly more strict than the spec http://tools.ietf.org/html/draft-kelly-json-hal-03.
(Specifically, the default validator requires you to have a self link.  This is not technically part of the spec, because everybody wants HAL to be usable as a response to non-GET requests)

You can use a json-schema validator https://github.com/DaveJS/dave.schema.json/blob/master/hal.json by passing an optional argument.
Many thanks to Isaac from the hal-discuss google group for providing this very comprehensive alternate validator for HAL.

```Ruby
puts "Valid = #{Halidator.new(string, :json_schema).valid?}"
puts "Valid = #{Halidator.new(json, :json_schema).valid?}"

```


---

There is also a executable included so after you install the gem you can do things like

```
 > curl -s http://haltalk.herokuapp.com/posts/latest.json | halidate
true
```

Get help with
```
 >  halidate -h
Usage: halidate [options]
    -j, --json-schema                Validate using the HAL JSON schema
    -h, --help                       Output this help and exit
    -d, --debug                      Output debugging info
```

If there are errors in the string you pipe to halidate, it will print them on stderr
```
 > curl -s http://example.com/bad-hal.json | halidate
false
no self in {'_links' => {'pickles' => 'pie'}}
```

If that's inconvenient, just redirect stderr somewhere you won't see it.
```
 > curl -s http://example.com/bad-hal.json | halidate 2>/dev/null
false
```


---

Thanks to:

 * Steve Klabnik for bringing hypermedia APIs to my attention
 * Everybody at http://groups.google.com/group/hal-discuss

---

Pull requests welcome, especially if you're adding XML support!