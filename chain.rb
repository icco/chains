#! /usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require(:default)

chain = MarkovPolo::Chain.new

text = File.read("neuromancer.txt")
words = text.split(" ")

words.each_slice(5) do |wr|
  chain.push wr.join(" ")
end

puts chain.generate
puts chain.generate
puts chain.generate
puts chain.generate
