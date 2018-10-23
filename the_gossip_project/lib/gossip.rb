require 'csv'

class Gossip
	
	attr_reader :author
	attr_reader :content
	attr_reader :id
	def initialize(author, content)
		@author = author
		@content = content
	end

	def save
		CSV.open("./db/gossip.csv", "ab") do |csv|
			csv << ["#{@author}", "#{@content}"]
		end
	end

	def self.all
		all_gossips = []
		CSV.foreach("./db/gossip.csv") do |csv_line|
			all_gossips << Gossip.new(csv_line[0], csv_line[1])
		end
		return all_gossips
	end

	def self.find(id)
		i = 0
		CSV.foreach("./db/gossip.csv") do |row|
			if(i == id)
				return row
			end
			i = i + 1
		end
	end
end
