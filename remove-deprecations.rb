#!/usr/bin/env ruby

unwanted_text = '[Obsolete("The high level API classes are deprecated and will be removed in the future.")]'
unwanted_regex = /^(\s*)(#{Regexp.quote(unwanted_text)}\s*)$/
replacement = '\1// \2'

Dir.glob("**/*.cs").each do |path|
  text = File.read(path)
  text.gsub!(unwanted_regex, replacement)
  File.open(path, 'wb') { |f| f.write(text) }
end
