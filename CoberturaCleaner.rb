
# Created by Bento-iOS Team  08/15/2016

puts 'Running Cobertura Cleaner Ruby'

ARGV.each do|arg|
  puts "Reading file: #{arg}"

parsing = false
adding = false
count = 0

   begin
      file = File.new(arg, "r")
      outfile = File.new('out.xml', "a")
      while (line = file.gets)
          myStr = String.new(line)
          count = count+1

         if  parsing == false
           outfile.write("#{myStr}")
            if myStr.include? "<packages>"
               parsing = true
            end
         end

         if parsing == true
            if myStr.include? "<package" and myStr.include? "name=" and myStr.include? "VMNVideoPlayerSDK" and !myStr.include? "Pods"
		adding = true
                if myStr.include? "VMNVideoPlayerSDK.VMNVideoPlayerTests"
                    adding = false
               end
	    end

            if myStr.include? "</package>" and adding == true
               outfile.write("#{myStr}")
               adding = false
            end

            if adding == true
               outfile.write("#{myStr}")
            end

            if myStr.include? "</packages>"
               outfile.write("#{myStr}")
               parsing = false
            end

          end
      end

      outfile.close
      file.close

   rescue => err
      puts "Exception: #{err}"
      err
   end
end
