Gem::Specification.new do |s|
  s.name        = 'halidator'
  s.version     = '0.5.1'
  s.date        = Date.today
  s.summary     = "A small library to validate hal+json"
  s.description = "A small library to validate hal+json"
  s.authors     = ["Bob Larrick"]
  s.email       = 'larrick@gmail.com'
  s.files       = [
                   "./lib/halidator.rb",
                   "./lib/halidate/hal.json",
                   "./lib/halidate/pure_ruby.rb",
                   "./lib/halidate/json_schema.rb"
                  ]
  s.executables = ['halidate']
  s.homepage    = "https://github.com/deathbob/halidator"
  s.add_runtime_dependency "json", [">= 1.6.0"]
  s.add_runtime_dependency "json-schema", [">= 1.0.0"]
end
