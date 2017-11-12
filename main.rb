require "tempfile"
require 'pry'
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


math_tex_str = <<EOS
\\[
  \\cos (2\\theta) = \\cos^2 \\theta - \\sin^2 \\theta
\\]

EOS
# puts get_whole_tex_str(math_tex_str)

Tempfile.create("", "/tmp") do |in_f|
    Tempfile.create("", "/tmp") do |out_f|
        
        begin
            # $in = in_f
            # $out = out_f
            # # pry
            
            # Generate latex string
            latex_str = get_whole_tex_str(math_tex_str)
            # Write to input tmp file
            in_f.write(latex_str)
            p in_f.gets
            # in_f.puts


            # puts latex_str

            puts(in_f.path) # 
            puts(out_f.path)

            puts("cat ---")
            system("cat #{in_f.path}")
            
            # Run command
            cmd = "docker run --rm -v #{in_f.path}:/latex/hoge.tex -v #{out_f.path}:/latex/hoge-crop.pdf math-svg" # NOTE: Hard cording: "hoge.tex", "/latex"
            system(cmd)


            system("cp #{out_f.path} ./test-out.pdf")
            # # p out_f.gets
        rescue
            # This is to remove tmp files when exception
        end
    end
end