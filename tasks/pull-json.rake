namespace :halidator do

  desc "Pull down json from the various endpoints and write it to files for testing etc."
  task :pull_json do
    dir = File.dirname(__FILE__) + "/../json/"
    commands = {
      :dtime_root => "http://dev-api.dtime.com",
      :haltalk_users => "http://haltalk.herokuapp.com/users.json",
      :haltalk_posts_latest => 'http://haltalk.herokuapp.com/posts/latest.json',
      :haltalk_users_mike_posts => "http://haltalk.herokuapp.com/users/mike/posts.json"
    }
    commands.each do |key, url|
      com = %{curl -H "Accept: application/json" #{url} -o #{dir}#{key}.json}
      puts com
      system com
    end
  end
end
