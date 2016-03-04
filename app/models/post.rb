class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user_id

  def scrape_posts
    require 'rubygems'
    require 'mechanize'
    # class Mechanize
    # end

    agent = Mechanize.new

    page = agent.get('https://www.reddit.com/')

    page.search('.thing').each_with_index do |reddit_post, i|
      if i < 25
        post = Post.new
        post.title = reddit_post.search('.title .title').text.strip
        post.vote_count = reddit_post.search('.unvoted .unvoted').text.strip
        user = User.new
        user.username = reddit_post.search('.tagline .author').text.strip
        post.user_id = user.id
        post.link_url = reddit_post.search('.title .title').to_s
        post.link_url = post.link_url.split('" tabindex=')[0].to_s
        post.link_url = post.link_url.split(' href="')[1].to_s
        if post.link_url.to_s.start_with?('/r')
          post.link_url = "https://www.reddit.com" + post.link_url
        end
        post.save
      end
    end
    Post.group_by{|x| [x.link_url]}.flat_map{|_,x| x.drop(1)}.destroy_all
    puts Post.count
  end


end
