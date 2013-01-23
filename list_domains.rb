#!/usr/bin/env ruby
#
require "rubygems"
require "bundler/setup"
require 'foreman_api'
require 'pry'

options = { :base_url           => 'http://0.0.0.0:3000',
             :enable_validations => false,
             :username => 'admin',
             :password => 'secret',
#             :oauth              => { :consumer_key    => 'secret',
#                                      :consumer_secret => 'shhh' },
}


Domain = ForemanApi::Resources::Domain.new options

domains = Domain.index(:search => 'name ~ com')[0]
# response contains root object of json .e.g [{domain:{name => name, id => id..}}
domains.map! {|d| d['domain']}

domains.each do |domain|
  puts "#{domain['name']}: #{domain['id']}"
end
