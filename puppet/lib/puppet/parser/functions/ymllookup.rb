# Puppet External YAML Data Sources
#
# This is a parser function to read data from external files, this version
# uses YAML files as data source. It works similar to the extlookup parser
# but tries to implement this without sophisticated workarounds for
# shortcomings of CSV to represent more complex data structures.
#
# Usage:
#
# $ymllookup_datadir    = "/etc/puppet/manifests/extdata"
# $ymllookup_precedence = [ "%{fqdn}", "domain_${domain}", "common" ]
#
# The first variable tells the parser where to look for its YAML data files.
# The second tells it in which order to lookup these datafiles in the
# data directory.
#
# The YAML syntax which is currently supported looks like:
#
# common.yml:
# ---
# resolvers:
#   - 8.8.8.8
#   - 8.8.4.4
# partition_sizes:
#   boot: 120MB
#   root: 9G
#   tmp: 2G
# snmp_contact: "John Sysadmin <sysadmin@example.com>"
#
# This external lookup type has been written by Christian Hofstaedtler and
# Stefan Schlesinger, idea stolen from R.I.Pienaar. ;-)
#
require 'yaml'

module Puppet::Parser::Functions
  newfunction(:ymllookup, :type => :rvalue) do |args|

  if args.length > 3 or args.length < 1
    raise Puppet::ParseError, ("ymllookup(): wrong number of arguments (#{args.length}; must be > 0 and <= 3)")
  end

  key      = args[0]
  default  = args[1]
  datafile = args[2]

  ymllookup_datadir    = lookupvar('ymllookup_datadir')
  ymllookup_precedence = Array.new

  ymllookup_precedence = lookupvar('ymllookup_precedence').collect do |var|
    var.gsub(/%\{(.+?)\}/) do |capture|
      lookupvar($1)
    end
  end

  datafiles = Array.new

  # if we got a custom data file, put it first in the array of search files
  if datafile != ""
    datafiles << ymllookup_datadir + "/#{datafile}.yml" if File.exists?(ymllookup_datadir + "/#{datafile}.yml")
  end

  ymllookup_precedence.each do |d|
    datafiles << ymllookup_datadir + "/#{d}.yml"
  end

  desired = nil

  datafiles.each do |file|
    if desired.nil?
      begin
        result = YAML.load_file(file)
        if result.include?(key):
          desired = result[key]
        end
      rescue
        false
      end
    end
  end

  desired || default or raise Puppet::ParseError, "No match found for '#{key}' in any data file during ymllookup()"
  end
end
