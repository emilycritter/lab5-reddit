desc 'scrape reddit'
task :scrape => :environment do

  original_post_count = Post.count

  require 'rubygems'
  require 'mechanize'

  agent = Mechanize.new

  page = agent.get('https://www.reddit.com/')

  page.search('.thing').take(25) do |reddit_post|

    next if reddit_post.search('a.title')[0].blank?

    the_url = reddit_post.search('a.title')[0]["href"]

    if the_url.to_s.start_with?('/r')
      the_url = "https://www.reddit.com#{the_url}"
    end


    post = Post.where(link_url: the_url).first_or_initialize
    post.title = reddit_post.search('.title .title').text.strip
    post.vote_count = reddit_post.search('.unvoted .unvoted').text.strip
    post.added_by = reddit_post.search('.tagline .author').text.strip

    post.user = User.where(name: post.added_by).first_or_initialize
    post.user.name = reddit_post.search('.tagline .author').text.strip
    post.user.save

    if reddit_post.search('.thumbnail img').any?
      post.photo_id = reddit_post.search('.thumbnail img')[0]["src"]

      if post.photo_id.to_s.start_with?('//b')
        post.photo_id = post.photo_id.split('//')[1].to_s
      end

    end

    post.save
  end


  new_post_count = Post.count
  if new_post_count - original_post_count > 0
    puts "BAM! Created #{new_post_count - original_post_count} posts"
  else
    puts "Ran, but no new posts created"
  end

end
