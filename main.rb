require "tempfile"
require 'pry'

if ARGV.size != 1
    STDERR.puts("Usage: ruby main.rb sample1.math.tex")
    exit(1)
end

# Get input file path
in_file_path = ARGV[0]
if !File.exist?(in_file_path)
    STDERR.puts("'#{in_file_path}' not found")
    exit(1)
end

# Create whole tex string
def get_whole_tex_str(math_tex_str)
<<EOS
\\documentclass[a4paper]{article}
\\pagestyle{empty} %(from: https://askubuntu.com/a/33198)
\\begin{document}

#{math_tex_str}

\\end{document}
EOS
end


# Read input file content
math_tex_str = File.read(in_file_path)

Tempfile.create("", "/tmp") do |in_f|
    Tempfile.create("", "/tmp") do |out_f|
        
        begin
            
            # Generate latex string
            latex_str = get_whole_tex_str(math_tex_str)
            # Write to input tmp file
            in_f << latex_str
            in_f.flush # NOTE: This is necessary
            
            # Run command
            cmd = "docker run --rm -v #{in_f.path}:/latex/hoge.tex -v #{out_f.path}:/latex/hoge-crop.pdf math-svg" # NOTE: Hard cording: "hoge.tex", "/latex"
            system(cmd)


            system("cp #{out_f.path} ./test-out.pdf") # TODO impl
        rescue
            # This is to remove tmp files when exception
        end
    end
end