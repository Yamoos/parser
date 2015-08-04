#!/usr/bin/ruby1.9.3
require 'mechanize'
require 'green_shoes'

def connect
	url ="http://www.lostfilm.tv/"
	agent = Mechanize.new
	agent.user_agent_alias = 'Linux Mozilla'
	agent.get(url)
end
def get
	b = connect.search('#new_sd_list').inner_text
	h = Array.new 
	b.delete!("\r, \t").each_line {|s| 
			if s.lstrip.empty?
				s.delete!("\n")
			else
				h<<s.delete!("\n")
			end
	}
	return h
end
def img
	rr=Array.new
	connect.search("img.category_icon").each do |img|
		rr<< 'http://www.lostfilm.tv/'+img.attributes['src'].to_s 
	end
	rr
end


Shoes.app height: 700, width: 400, title: "Lostfilm" do
	stack margin: 10 do
		image 'LostFilm.tv_trans_flat.png' 
	end

	

	stack margin: 5 do
		@s = button "RELOAD!" do
    			@slot.clear {get.each {|f|para f}}
    			puts "reload complite!"
   			end
   		@s.style(align:  "center")
	end
end