#!/usr/bin/env ruby
require "optparse"
require "open-uri" 
require 'net/http'
require "json"
require 'text-table'

def getAll(url)
    exchanges = []
    begin
      open(url) do |d|
        json = JSON.parse(d.read)
        json.each do |a|
          exchanges << a
        end
      end
    return true, exchanges
  end
  rescue SocketError => e
  return false, "Could not connect to the API"
end
    
def getLine(url, symbol)
    begin
      open(url) do |d| 
        json = JSON.parse(d.read)
        json.each do |a|
          a[1]['lines'].each do |v|
            if v['id'] == symbol
              return true, v                    
            end
          end
        end
        return false, "Could not find line. Please use one of the following ID's bakerloo, central, district, docklands, hammersmithcity, jubilee, metropolitan, northern, piccadilly, overground, victoria, waterloocity"
      end
      rescue SocketError => e 
      return false, "Could not connect to the API"
    end
end


table = Text::Table.new :horizontal_padding    => 1,
                            :vertical_boundary     => '-',
                            :horizontal_boundary   => '|',
                            :boundary_intersection => '-'

case ARGV[0]
  when nil
    info = getAll("http://api.tubeupdates.com/?method=get.status&format=json")
    #if failed to connect then display the error message
    if info[0] == false
      puts info[1]
    else
      table.head = ["Line", "Status"]
      info[1][0][1]["lines"].each_with_index do |lines|
        status = "%s" % lines["status"].split.map(&:capitalize).join(' ')
        names = "%s" % lines["name"].gsub("\&amp;", '&')
        table.rows << [names, status]
      end
    puts table.to_s
    end
  else
  
  info = getLine("http://api.tubeupdates.com/?method=get.status&format=json", ARGV[0])
  
  if info[0] == false
    puts info[1]
  else
    name = info[1]['name'].gsub("\&amp;", '&')
    status = info[1]['status'].split.map(&:capitalize).join(' ')
      if status == "good service"
         status = status.green
      else
         status = status.red
      end
    
    puts "Line: " + name
    puts "Status: " + status
      if info[1]['messages'].empty?
         puts "Messages: None"
      else
         puts "Messages: " 
         info[1]['messages'].each do |d|
         puts d.gsub("\&amp;", '&')
         puts "\n" 
      end 
    end
  end 
end