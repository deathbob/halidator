class JsonStrings
  @json_dir =  File.dirname(__FILE__) + "/../json/"

  class << self
    def dtime_root
      @dtime_root ||= File.open(File.join(@json_dir, 'dtime_root.json')).read
    end

    def haltalk_users
      @haltalk_users ||= File.open(File.join(@json_dir, 'haltalk_users.json')).read
    end

    def haltalk_posts_latest
      @haltalk_posts_latest ||= File.open(File.join(@json_dir, 'haltalk_posts_latest.json')).read
    end

    def haltalk_users_mike_posts
      @haltalk_users_mike_posts ||= File.open(File.join(@json_dir, 'haltalk_users_mike_posts.json')).read
    end


    def invalid_haltalk_users
      # url = "http://haltalk.herokuapp.com/users.json"
      <<-json
{"_links":{"curie":{"name":"ht","href":"http://haltalk.herokuapp.com/rels/{rel}","templated":true},"ht:user":[{"href":"/users/mike","title":"Mike Kelly"},{"href":"/users/graste","title":"gra ste"},{"href":"/users/mamund","title":"Mike Amundsen"},{"href":"/users/amir","title":"Amir Mohtasebi"},{"href":"/users/david","title":"david h"},{"href":"/users/lanzoma","title":"Andres Freyria"},{"href":"/users/solojavier","title":"Javier Cervantes"},{"href":"/users/jaime","title":"Jaime Ryan"},{"href":"/users/fred","title":"Fred Wilson"},{"href":"/users/joel","title":"Joel Turnbull"},{"href":"/users/ryan","title":"Fred Wilson"},{"href":"/users/mikehadlow","title":"Mike Hadlow"},{"href":"/users/locks","title":"Ricardo Mendes"},{"href":"/users/downchuck","title":"Charles Pritchard."},{"href":"/users/dgray","title":"Derek Gray"},{"href":"/users/toto","title":null},{"href":"/users/qwer","title":"Garrido Gadorna"},{"href":"/users/redmatt","title":null},{"href":"/users/qfwfq","title":null},{"href":"/users/yamsahol","title":null},{"href":"/users/grosbobo","title":"Le Gros Bobo"},{"href":"/users/jblow","title":"Joe Blow"},{"href":"/users/hbredel","title":"Henning Bredel"},{"href":"/users/leusername","title":"Le Username"},{"href":"/users/ahoi","title":"Ahoi Mateh"},{"href":"/users/stewart","title":"Stewart Armbrecht"},{"href":"/users/derp","title":null},{"href":"/users/Shaun%20Marko","title":null},{"href":"/users/Mitchy","title":"Mitchy Mitch"},{"href":"/users/eric","title":"Eric"},{"href":"/users/luke","title":"Luke Stokes"},{"href":"/users/samsm","title":"Sam Schenkman-Moore"},{"href":"/users/statonjr","title":"Larry Staton Jr."},{"href":"/users/joe","title":"Fred Wilson"},{"href":"/users/chrism","title":"Chris Murphy"},{"href":"/users/test","title":"blah"},{"href":"/users/febeling","title":"Florian Ebeling"},{"href":"/users/A_Edison","title":"Albert Edison"},{"href":"/users/jason","title":"Jason Erickson"},{"href":"/users/stade","title":"Marcus Stade"},{"href":"/users/foobar","title":null},{"href":"/users/tony","title":"Tony Leigh"},{"href":"/users/coyote","title":null},{"href":"/users/bkeepers","title":"Brandon Keepers"}]}}
json
    end

    def bad_embedded_string
%[{"_links":{"self":{"href":"/users"}},"_embedded":{"hd:foo":"some random string"}}]
    end

  end
end
