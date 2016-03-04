require 'rubygems'
require 'mechanize'
# class Mechanize
# end

agent = Mechanize.new

page = agent.get('https://www.reddit.com/')

titles = []
page.search('.title .title').each do |title|
  titles << title.text.strip
end
puts titles

authors = []
page.search('.zg_byline').each do |author|
  authors << author.text.strip
end
puts authors

prices = []
page.search('.zg_price .price').each do |price|
  prices << price.text.strip
end
puts prices
