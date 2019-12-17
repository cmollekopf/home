#!/usr/bin/env ruby

require 'thor'
require 'pry'
require 'open3'

module Commandline
    def self.run(cmd, &block)
        output = ""
        exit_status = Open3.popen3(cmd) do |stdin, stdout, stderr, thread|
            output = stdout.read.chomp
            thread.value
        end
        if exit_status != 0
            puts "Nonzero exit code: ", exit_status, "Command: ", cmd
            raise "Command failed"
        end
        if block_given?
            block.call(output)
        else
            puts output
        end
        return output
    end

end

class DockerConnect < Thor
    desc "open", "Open port."
    def open(containername, url, port)
        output = Commandline.run "docker port #{containername}"
        portmap = output.split(/\n/).map { |string|
          [
            string[/\d+(?=\/tcp)/, 0].to_i, # Target port
            # string[/\d.\d.\d.\d:\d+/, 0] # Mapped address
            string[/(?<=:)\d+/, 0] # Mapped port
          ]
        }
        say "Opening #{portmap.to_h[port.to_i]}"
        Commandline.run "firefox #{url}:#{portmap.to_h[port.to_i]}"
    end

end



begin
    DockerConnect.start(ARGV)
rescue => e
    puts e.message
    puts e.backtrace.inspect
end
