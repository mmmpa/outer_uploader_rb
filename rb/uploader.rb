#!/ruby
# -*- coding: utf-8 -*-

require "cgi"
require './uploaded_file.rb'

UploadedFile.from = File.expand_path('../uploaded')

print "Content-type:text/json\r\n\r\n"
print UploadedFile.new(CGI.new.params).move
