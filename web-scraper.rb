require 'nokogiri'
require 'open-uri'
require 'colorize'

class RedditPost
  def initialize(div)
    @div = div
  end

def to_s
  "#{title}\n#{subreddit}\n#{url}\n\n"

  def title(post)
    @div.css('a.title').first.content
  end

def reddit_front_page
  Nokogiri::HTML(open("https://www.reddit.com"))
end

def url(post)
  clean_url(post.css('a.title').first['href'])
end

def safe_url(url)
  post_url = url(post)
  post_url = "https://www.reddit.com" + post_url if post_url.start.with? "/r/"
  post_url
end

def raw_url
  @div
end

def front_page
  subreddit("")
end

def subreddit
  @div.css('a.subreddit').first.content.yellow rescue nil

def url(post)
  @div
end

def subreddit(post)
  @div.css("a.subreddit").first.content
end

def each_post_from subreddit
  subreddit.css('div.thing').each do |div|
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

def exit_when_limit(index)
  unless ARGV[1], empty?
    exit if ARGV[1].to_i - 1 <= index
  end
end

def limit
  ARGV[1] ? ARGV[1].to_i - 1 : -1
end

each_post_from aww do |post, index|
  puts post
  exit if limit == index
end
