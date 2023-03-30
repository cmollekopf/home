#!/usr/bin/env ruby

require "net/imap"
require 'thor'

class IMAP < Net::IMAP

    def getmetadata(mailbox, entry)
      synchronize do
        send_command("GETMETADATA", mailbox, entry)
        return @responses.delete("METADATA")[-1]
      end
    end

    def setmetadata(mailbox, entry, value)
      # send_command("SETMETADATA", mailbox, [entry, IMAP.encode_utf7(value)])
      # FIXME I can't make this to send the value quoted.
      # The implementation does not support it: https://github.com/ruby/net-imap/blob/e5bcb677d0cb11c2de38dd5a67fca3de3a90d5fb/lib/net/imap/command_data.rb#L54
      send_command("SETMETADATA", mailbox, [entry, value])
    end
end


class ImapCli < Thor
  class_option :host
  class_option :port
  class_option :username
  class_option :password
  class_option :ssl, :type => :boolean
  class_option :debug, :type => :boolean

  no_commands {
    def imap()
      if !@imap
        if options[:ssl]
          @imap = IMAP.new(options[:host], :port => options[:port], :ssl => {
            :verify_mode => OpenSSL::SSL::VERIFY_NONE
          })
        else
          @imap = IMAP.new(options[:host], :port => options[:port], :ssl => false)
        end
        if options[:debug]
          IMAP.debug = true
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

  desc "namespace", "Namespace."
  def namespace()
    p imap.namespace()
  end

  desc "capability", "Capability."
  def capability()
    p imap.capability()
  end

  desc "select", "Select."
  def select(folder)
    p imap.select(folder)
  end

  desc "create", "Create."
  def create(folder)
    p imap.create(folder)
  end

  desc "getmetadata", "Getmetadata."
  def getmetadata(folder, entry)
    p imap.getmetadata(folder, entry)
  end

  desc "getacl", "getacl."
  def getacl(folder)
    p imap.getacl(folder)
  end

  desc "setmetadata", "Setmetadata."
  def setmetadata(folder, entry, value)
    p imap.setmetadata(folder, entry, value)
  end

  desc "download", "Download."
  def download(folder, destination)
    imap.select(folder)
    Dir.mkdir destination unless File.exists? destination
    imap.uid_fetch(1..-1, "RFC822").each do |mail|
      uid = mail.attr["UID"]
      p uid
      File.write("#{destination}#{uid}.", mail.attr["RFC822"])
    end
  end

end

begin
    ImapCli.start(ARGV)
rescue => e
    puts e.message
    puts e.backtrace.inspect
end
