class Gossip
  attr_reader :author, :content
  def initialize(author,content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author,@content]
    end
  end

  def update(new_author, new_content,update_index)
    array_csv_lines = CSV.read("./db/gossip.csv")

    CSV.open("db/gossip.csv", "wb") do |csv|
      array_csv_lines.each_with_index do |line,ind|
        if ind == update_index.to_i
          csv << [new_author,new_content]
        else
          csv << [line[0],line[1]]
        end
      end
    end
    
  end

  def self.find(id_gossip)
    array_csv_lines = CSV.read("./db/gossip.csv")
    gossip_csv = array_csv_lines[id_gossip.to_i]
    return Gossip.new(gossip_csv[0],gossip_csv[1])
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

end
