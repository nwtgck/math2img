require "tempfile"
require "file_utils"
require "option_parser"


out_ext = "png"

opt = OptionParser.new do |opt|
    opt.on("-e EXTENSION", "--out-extension=EXTENSION"){|v| out_ext = v}
end.parse!
# opt.parse!(ARGV)

if ARGV.size != 1
    STDERR.puts("Usage: ruby main.rb sample1.math.tex")
    exit(1)
end

# Get input file path
in_file_path = ARGV[0]
if !File.exists?(in_file_path)
    STDERR.puts("'#{in_file_path}' not found")
    exit(1)
end

# Create whole tex string
def get_whole_tex_str(math_tex_str : String): String
<<-EOS
\\documentclass[a4paper]{article}
\\pagestyle{empty} %(from: https://askubuntu.com/a/33198)
\\begin{document}

#{math_tex_str}

\\end{document}
EOS
end



# Read input file content
math_tex_str = File.read(in_file_path)

# Set temp directory as "/tmp"
ENV["TMPDIR"] = "/tmp"

Tempfile.open("in") do |in_f|
    Tempfile.open("out") do |out_f|
        begin            
            # Generate latex string
            latex_str = get_whole_tex_str(math_tex_str)
            # Write to input tmp file
            in_f << latex_str
            in_f.flush # NOTE: This is necessary
            
            # Run command
            cmd = "docker run --rm -v #{in_f.path}:/latex/hoge.tex -v #{out_f.path}:/latex/hoge.#{out_ext} nwtgck/math-to-image #{out_ext}" # NOTE: Hard cording: "hoge.tex", "/latex"
            system(cmd)

            # Copy output to <in_file_path>.<out_ext>
            FileUtils.cp(out_f.path, "#{in_file_path}.#{out_ext}")
        rescue ex
            # This is to remove tmp files when exception
            STDERR.puts("Crystal Error: #{ex}")
        end
    end
end