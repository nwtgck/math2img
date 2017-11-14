require "tempfile"
require "file_utils"
require "option_parser"

if !File.exists?(`which docker`.chomp)
    STDERR.puts("Error: Install Docker to run math2img")
    exit(1)
end

out_ext = "png"

opt = OptionParser.new do |opt|
    opt.on("-e EXTENSION", "--out-extension=EXTENSION"){|v| out_ext = v}
end.parse!
# opt.parse!(ARGV)

if ARGV.size == 0
    STDERR.puts("Usage: math2img sample1.math.tex")
    exit(1)
end


# Create whole tex string
def get_whole_tex_str(math_tex_str : String): String
<<-EOS
\\documentclass[a4paper]{article}
\\pagestyle{empty} %(from: https://askubuntu.com/a/33198)
\\usepackage{mathtools}
\\begin{document}

#{math_tex_str}

\\end{document}
EOS
end

# Generate image including .svg, .png or .pdf
def generate_img(in_file_path, out_ext)

    # If file doesn't exist
    if !File.exists?(in_file_path)
        STDERR.puts("'#{in_file_path}' not found")
        return
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
                cmd = "docker run --rm -v #{in_f.path}:/latex/hoge.tex -v #{out_f.path}:/latex/hoge.#{out_ext} nwtgck/math2img #{out_ext}" # NOTE: Hard cording: "hoge.tex", "/latex"
                system(cmd)

                # Copy output to <in_file_path>.<out_ext>
                FileUtils.cp(out_f.path, "#{in_file_path}.#{out_ext}")
            rescue ex
                # This is to remove tmp files when exception
                STDERR.puts("Crystal Error: #{ex}")
            end
        end
    end
end

# File patters
file_patterns = ARGV

file_patterns
    .flat_map{|ptn| Dir.glob(ptn)}
    .each{|in_file_path|
        # Generate image including .svg, .png or .pdf
        generate_img(in_file_path, out_ext)
    }




