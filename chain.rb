#! /usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require(:default)

chain = MarkovPolo::Chain.new

["neuromancer.txt", "chamber_secrets.txt"].each do |fn|
  text = File.read(fn)
  words = text.split(" ").map {|i| i.downcase.gsub(/[^a-z0-9\s]/i, '') }

  words.each_slice(5) do |wr|
    chain.push wr.join(" ")
  end
end

File.write("dump.json", JSON.pretty_generate(chain.to_h))

puts chain.generate
puts chain.generate
puts chain.generate
puts chain.generate
