#! /usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require(:default)

chain = MarkovPolo::Chain.new

text = File.read("neuromancer.txt")
words = text.split(" ").map {|i| i.downcase.gsub(/[^a-z0-9\s]/i, '') }

words.each_slice(5) do |wr|
  chain.push wr.join(" ")
end

File.write("dump.json", JSON.pretty_generate(chain.to_h))

puts chain.generate
puts chain.generate
puts chain.generate
puts chain.generate
