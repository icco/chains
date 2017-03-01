#! /usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require(:default)

def clean_string strarr
  strarr.map {|i| i.downcase.gsub(/[^a-z0-9\s]/i, '').strip }.reject { |c| c.empty? }
end

chain = MarkovPolo::Chain.new

if File.exists? "dump.json"
  chain.load JSON.parse(File.read("dump.json"))
end

["neuromancer.txt", "chamber_secrets.txt"].each do |fn|
  text = File.read(fn)
  words = clean_string(text.split("."))

  words.each do |wr|
    chain.push wr
  end
end

loop do
  out = chain.generate
  parser = Gingerice::Parser.new
  fixed = parser.parse out

  p fixed["result"]
  clean_string([fixed["result"]]).each do |s|
    chain.push s
  end
  File.write("dump.json", JSON.pretty_generate(chain.to_h))
  sleep 5
end
