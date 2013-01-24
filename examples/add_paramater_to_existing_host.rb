#!/usr/bin/env ruby

require 'rubygems'
require 'rest-client'
require 'json'
client = RestClient::Resource.new('http://0.0.0.0:3000',
                                  :user     => 'admin',
                                  :password => 'changeme',
                                  :headers  => { :accept => :json })


# hostname to update
host   = ARGV[1] || JSON.parse(client['hosts'].get).last['host']['name']

puts "updating #{host}"

# new parameters to create
# the hash index is a work around for creating unique hash keys
# will be fixed as part of foreman API v2.
new_parameters = { 1 =>
                     {
                       :name   => 'param_name',
                       :value  => 'param value',
                       :nested => true
                     },
                   2 => {
                     :name   => 'another_param_name',
                     :value  => 'param value 2',
                     :nested => true
                   }
}
# perform the actual update
# note, running this twice with the same param name would generate an error
client["hosts/#{host}"].put(:host => { :host_parameters_attributes => new_parameters })

# if we want to update existing params, we would first need to fetch their ID.
existing_parameters = JSON.parse(client["hosts/#{host}"].get)['host']['host_parameters']

# lets say we are looking for the param called 'param_name'
id_to_update = existing_parameters.detect { |p| 'param_name' == p['host_parameter']['name'] }['host_parameter']['id']

new_parameters = { 1 =>
                     {
                       :id     => id_to_update,
                       :name   => 'param_name',
                       :value  => 'param value2',
                       :nested => true
                     },
}
# update the host
client["hosts/#{host}"].put(:host => { :host_parameters_attributes => new_parameters })
