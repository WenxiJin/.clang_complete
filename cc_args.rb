#!/usr/env/ruby -w

=begin
$ mkdir -p build && make -C build -j8 V=1 > compile.log
$ ruby cc_args.rb compile.log
=end

compile_log = ARGV.first
$clang_complete_file = ".clang_complete"

includes = Array.new
defines  = Array.new
warnings = Array.new

if File.exist?($clang_complete_file)
  puts "Deleting old #{$clang_complete_file} file"
  File.delete($clang_complete_file)
end

puts "Parsing compilation log - #{compile_log}"
File.open(compile_log, 'r') do |file|
  file.each_line do |line|
    stripped_line = line.strip
    words = stripped_line.split(" ")
    for word in words
      if word.include?("-I") && (word.split & includes).empty?
        includes.push(word)
      elsif word.include?("-D") && (word.split & defines).empty?
        defines.push(word)
      elsif word.include?("-Wl")
        next
      elsif word.include?("-W") && (word.split & warnings).empty?
        warnings.push(word)
      end
    end
  end
end



def writeClang(content)
  File.open($clang_complete_file, 'a') do |file|
    content.each { |entry|
      file << entry + "\n"
    }
  end
end

writeClang(includes)
writeClang(defines)
writeClang(warnings)

puts "Generating .clang_complete file is done."
