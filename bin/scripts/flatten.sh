#!/bin/ruby
require 'pry'
require 'fileutils'
files = Dir.glob("**/*").reject {|fn| File.directory?(fn) }
files.each { |dir|
    newName = dir.gsub('/', '_')
    unless newName == dir
        FileUtils.mv(dir, newName)
    end
}
# binding.pry
