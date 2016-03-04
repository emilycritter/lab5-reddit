class Post < ActiveRecord::Base
  has_many :comments

  validates :title, :vote_count, :added_by, presence: true

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
        post.added_by = reddit_post.search('.tagline .author').text.strip
        post.link_url = reddit_post.search('.title .title').to_s
        post.link_url = post.link_url.split('" tabindex=')[0].to_s
        post.link_url = post.link_url.split(' href="')[1].to_s
        post.photo_id = reddit_post.search('.thumbnail').to_s
        post.photo_id = post.photo_id.split('" width=')[0].to_s
        post.photo_id = post.photo_id.split(' src="')[1].to_s
        puts post.photo_id
        if post.link_url.to_s.start_with?('/r')
          post.link_url = "https://www.reddit.com" + post.link_url
        end
        if post.photo_id.to_s.start_with?('//b')
          post.photo_id = post.photo_id.split('//')[1].to_s
        end
        post.save
      end
    end

    # Remove duplicates
    Post.all.each do |post|
      Post.order("id desc").where(link_url: post.link_url).all.drop(1).each { |r| r.delete }
    end
    puts Post.count
  end


end
