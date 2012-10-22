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
 > curl -s http://haltalk.herokuapp.com/users.json | halidate
false
no self in {"curie"=>{"name"=>"ht", "href"=>"http://haltalk.herokuapp.com/rels/{rel}", "templated"=>true}, "ht:user"=>[{"href"=>"/users/mike", "title"=>"Mike Kelly"}, {"href"=>"/users/graste", "title"=>"gra ste"}, {"href"=>"/users/mamund", "title"=>"Mike Amundsen"}, {"href"=>"/users/amir", "title"=>"Amir Mohtasebi"}, {"href"=>"/users/david", "title"=>"david h"}, {"href"=>"/users/lanzoma", "title"=>"Andres Freyria"}, {"href"=>"/users/solojavier", "title"=>"Javier Cervantes"}, {"href"=>"/users/jaime", "title"=>"Jaime Ryan"}, {"href"=>"/users/fred", "title"=>"Fred Wilson"}, {"href"=>"/users/joel", "title"=>"Joel Turnbull"}, {"href"=>"/users/ryan", "title"=>"Fred Wilson"}, {"href"=>"/users/mikehadlow", "title"=>"Mike Hadlow"}, {"href"=>"/users/locks", "title"=>"Ricardo Mendes"}, {"href"=>"/users/downchuck", "title"=>"Charles Pritchard."}, {"href"=>"/users/dgray", "title"=>"Derek Gray"}, {"href"=>"/users/toto", "title"=>nil}, {"href"=>"/users/qwer", "title"=>"Garrido Gadorna"}, {"href"=>"/users/redmatt", "title"=>nil}, {"href"=>"/users/qfwfq", "title"=>nil}, {"href"=>"/users/yamsahol", "title"=>nil}, {"href"=>"/users/grosbobo", "title"=>"Le Gros Bobo"}, {"href"=>"/users/jblow", "title"=>"Joe Blow"}, {"href"=>"/users/hbredel", "title"=>"Henning Bredel"}, {"href"=>"/users/leusername", "title"=>"Le Username"}, {"href"=>"/users/ahoi", "title"=>"Ahoi Mateh"}, {"href"=>"/users/stewart", "title"=>"Stewart Armbrecht"}, {"href"=>"/users/derp", "title"=>nil}, {"href"=>"/users/Shaun%20Marko", "title"=>nil}, {"href"=>"/users/Mitchy", "title"=>"Mitchy Mitch"}, {"href"=>"/users/eric", "title"=>"Eric"}, {"href"=>"/users/luke", "title"=>"Luke Stokes"}, {"href"=>"/users/samsm", "title"=>"Sam Schenkman-Moore"}, {"href"=>"/users/statonjr", "title"=>"Larry Staton Jr."}, {"href"=>"/users/joe", "title"=>"Fred Wilson"}, {"href"=>"/users/chrism", "title"=>"Chris Murphy"}, {"href"=>"/users/test", "title"=>"blah"}, {"href"=>"/users/febeling", "title"=>"Florian Ebeling"}, {"href"=>"/users/A_Edison", "title"=>"Albert Edison"}, {"href"=>"/users/jason", "title"=>"Jason Erickson"}, {"href"=>"/users/stade", "title"=>"Marcus Stade"}, {"href"=>"/users/foobar", "title"=>nil}, {"href"=>"/users/tony", "title"=>"Tony Leigh"}, {"href"=>"/users/coyote", "title"=>nil}]}
```

If that's inconvenient, just redirect stderr somewhere you won't see it.
```
 > curl -s http://haltalk.herokuapp.com/users.json | halidate 2>/dev/null
false
```
