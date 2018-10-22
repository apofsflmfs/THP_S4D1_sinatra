require 'pry'

class Comment

attr_reader :author, :content, :gossip_id
  def initialize(author,content,gossip_id)
    @author = author
    @content = content
    @gossip_id = gossip_id
  end

  def save
    CSV.open("./db/comment.csv", "ab") do |csv|
      csv << [@gossip_id,@author,@content]
    end
  end

  def self.all(gossip_id)
    all_comments = []
    CSV.read("./db/comment.csv").each do |csv_line|
      if csv_line[0].to_i == gossip_id.to_i
        all_comments << Comment.new(csv_line[1], csv_line[2],gossip_id)
      end
    end
    return all_comments
  end

end