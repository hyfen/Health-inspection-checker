#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'rubygems'
require 'csv'
require 'date'

# input files
input_file = "Open_Data_Jan172009-Dec312010.xml"

# output files
establishment_file = "establishments.csv"
inspection_file = "inspections.csv"
infraction_file = "infractions.csv"
establishment_csv = CSV.open(establishment_file, "w")
inspection_csv = CSV.open(inspection_file, "w")
infraction_csv = CSV.open(infraction_file, "w")


class DinesafeDocument < Nokogiri::XML::SAX::Document
  def initialize(establishment_csv, inspection_csv, infraction_csv)
    @row = {}
    @new_row = false
    @row_elem = ""
    @establishment_csv = establishment_csv
    @inspection_csv = inspection_csv
    @infraction_csv = infraction_csv
    
    # track which establishments and inspections we've seen in the file already
    @establishment_ids = []
    @inspection_ids = []
  end

  def cdata_block(string)
    characters(string)
  end

  def characters(string)
    @row[@row_elem] = string.strip if string.strip != ""
  end
  
  def start_element name, attrs = []
    if name == "row"
      @new_row = true
    elsif @new_row
      @row_elem = name
    end
  end

  def end_element name
    if name == "row"
      # we have a new establishment. record it in the csv
      unless @establishment_ids.include?(@row["establishment_id"].to_i)
        @establishment_ids << @row["establishment_id"].to_i
        @establishment_csv << [
          @row["establishment_id"].to_i,
          @row["establishment_name"].to_s,
          @row["establishmenttype"].to_s,
          @row["establishment_address"].to_s,
          @row["minimum_inspections_peryear"].to_s,        
          ]
      end
      
      # we have a new inspection. record it in the csv
      unless @inspection_ids.include?(@row["inspection_id"].to_i)
        @inspection_ids << @row["inspection_id"].to_i
        @inspection_csv << [
          @row["establishment_id"].to_i,
          @row["inspection_id"].to_i,
          @row["establishment_status"].to_s,
          Date.parse(@row["inspection_date"])
          ]
      end
      
      # record infraction details. For Passes, already recored in inspections table
      unless @row["establishment_status"] == "Pass"
        @infraction_csv << [
          @row["inspection_id"].to_i,
          @row["infraction_details"],
          @row["severity"],
          @row["action"],
          @row["court_outcome"],
          @row["amount_fined"]
          ]
        end
      @row = {}
      @new_row = false
    end
  end
end

p = DinesafeDocument.new(establishment_csv, inspection_csv, infraction_csv)
parser = Nokogiri::HTML::SAX::Parser.new(p)
parser.parse(File.read(input_file))