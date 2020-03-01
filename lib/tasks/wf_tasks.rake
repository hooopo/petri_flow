# frozen_string_literal: true

desc "Wf tasks"

task wf: :environment do
  url = "http://service-technology.org/files/lola/lola-2.0.tar.gz"
  path = Rails.root.join("tmp", "lola.tar.gz").to_s
  puts "Downloading, wait!"
  puts `wget http://service-technology.org/files/lola/lola-2.0.tar.gz -v -t0 -O #{path}` unless File.exist?(path)
  puts `cd #{Rails.root.join("tmp")} && tar -zxvf lola.tar.gz`
  puts `cd #{Rails.root.join("tmp/lola-2.0")} && ./configure`
  puts `cd #{Rails.root.join("tmp/lola-2.0")} && make`
  puts `cd #{Rails.root.join("tmp/lola-2.0")} && sudo make install`
  puts `lola --help`
end
