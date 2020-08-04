#!/usr/bin/env ruby

unwanted_text = '[Obsolete("The high level API classes are deprecated and will be removed in the future.")]'
unwanted_regex = /^(\s*)(#{Regexp.quote(unwanted_text)}\s*)$/
replacement = '\1// \2'

pragma = '#pragma warning disable 0618 // UNET transport deprecation'

Dir.glob("**/*.cs").each do |path|
  text = File.read(path)
  text.gsub!(unwanted_regex, replacement)
  unless (text.lines[0] || '').strip.start_with?(pragma.strip)
    text = pragma.strip + "\n" + text
  end
  File.open(path, 'wb') { |f| f.write(text) }
end
