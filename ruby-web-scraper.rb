require 'nokogiri'
require 'open-uri'
require 'colorize'

class RedditPost
  def initialize(div)
    @div = div
  end

  def to_s
    "#{title}\n#{subreddit} - #{url}\n\n"
  end

  def title
    @div.css('a.title').first.content.white
  end

  def subreddit
    @div.css('a.subreddit').first.content.yellow rescue nil
  end

  def raw_url
    @div.css('a.title').first[:href]
  end

  def safe_domain
    'https://www.reddit.com' if raw_url.start_with? '/r/'
  end

  def url
    "#{safe_domain}#{raw_url}".blue
  end
end

def subreddit(name)
  Nokogiri::HTML(open("https://www.reddit.com/" + name))
end

def front_page
  subreddit("")
end

def each_post_from reddit
  reddit.css('div.thing').each_with_index do |div, index|
    yield RedditPost.new(div), index
  end
end

def subreddit_or_front_page
  if ARGV.empty?
    front_page
  else
    subreddit("r/#{ARGV[0]}")
  end
end

def limit
  ARGV[1] ? ARGV[1].to_i - 1 : -1
end

each_post_from subreddit_or_front_page do |post, index|
  puts post
  exit if limit == index
end
