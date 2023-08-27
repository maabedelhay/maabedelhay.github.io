require "stringex"
class Jekyll < Thor
  desc "new", "create a new post"
  method_option :editor, :default => "subl"
  def new(*title)
    title = title.join(" ")
    date = Time.now.strftime('%Y-%m-%d')
    filename = "_posts/#{date}-#{title.to_url}.markdown"

    if File.exist?(filename)
      abort("#{filename} already exists!")
    end

    puts "Creating new post: #{filename}"
    open(filename, 'w') do |post|
    post.puts "---"
    post.puts "layout: post"
    post.puts "title: #{title}"
	  post.puts "date: #{date} h:m:s"
	  post.puts "categories:"
    post.puts "tags:"
    post.puts "author: Mabd"
    post.puts "---"
    post.puts "* content"
    post.puts "{:toc}"
    end

    system(options[:editor], filename)
  end
end
