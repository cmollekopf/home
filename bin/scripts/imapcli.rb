#!/usr/bin/env ruby

require "net/imap"
require 'thor'

class ImapCli < Thor
  class_option :host
  class_option :port
  class_option :username
  class_option :password
  class_option :ssl, :type => :boolean

  no_commands {
    def imap()
      if !@imap
        if options[:ssl]
          @imap = Net::IMAP.new(options[:host], :port => options[:port], :ssl => {
            :verify_mode => OpenSSL::SSL::VERIFY_NONE
          })
        else
          @imap = Net::IMAP.new(options[:host], :port => options[:port], :ssl => false)
        end
        @imap.login(options[:username], options[:password])
      end
      @imap
    end
  }

  desc "login", "Login."
  def login()
    imap()
  end

  desc "list", "List."
  def list()
    p imap.list("", "**")
  end

  desc "select", "Select."
  def select(folder)
    p imap.select(folder)
  end

end

begin
    ImapCli.start(ARGV)
rescue => e
    puts e.message
    puts e.backtrace.inspect
end
