require 'reverse_markdown'
require 'yaml'


['dodatkowe-materialy-do-nauki', 'kurs-programowania-java', 'o-mnie', '_posts'].each do |dir|
  Dir.glob(dir + '/*.html') do |file_name|
    file_content = nil
    File.open(file_name) do |file|
      output = []
      magic_lines = 0
      html_to_convert = []
      header = []
    
      file.each do |line|
        line.rstrip!
      
        if magic_lines >= 2
          html_to_convert.push(line)
        else 
          header.push(line)
        end
    
        if line == '---'
          magic_lines += 1
        end
      end
    
      header = YAML.load(header.join("\n"))
      if header.has_key?('excerpt')
        header.delete('excerpt')
        header['excerpt_separator'] = '<!--more-->'
      end

      unless header.has_key?('permalink')
        permalink = header['title']
        permalink = permalink.downcase()
        [[' ', '-'], ['---', '-'], ['ą', 'a'], ['ć', 'c'],
         ['ę', 'e'], ['ł', 'l'], ['ń', 'n'], ['ó', 'o'],
         ['ś', 's'], ['ź', 'z'], ['ż', 'z']].each do |from, to|
           permalink.gsub!(from, to)
        end
        header['permalink'] = '/' + permalink + '/'
      end
      header = YAML.dump(header) + "---\n"

      result = ReverseMarkdown.convert(html_to_convert.join())
      file_content = header + result
    end
    md_file, _, _ = file_name.rpartition('.')
    md_file = md_file + '.md'
    File.open(md_file, 'w') do |file|
      file.write(file_content)
    end
  end
end
