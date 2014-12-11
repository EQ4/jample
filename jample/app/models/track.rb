class Track
  include Mongoid::Document


  field :path_and_file, type: String
  field :file_contents_hash, type: String
  field :onset_times, type: Array
  field :onset_count, type: Integer


  def self.import_tracks
  	track_list_string = `mdfind -name \.mp3`
  	puts "OKOK"
  	# puts track_list
  	tracks_array = track_list_string.split("\n")
  	puts tracks_array.size

  	tracks_array.each do |track_path|
  		 track_path
  		file_contents_hash = Digest::MD5.file(track_path).hexdigest
  		track = Track.find_or_create_by(file_contents_hash: file_contents_hash)
  		track.path_and_file = track_path
  		track.save
  		track.detect_onset
      track.cut_nth_slice(1)
  	end
  end

  def detect_onset
    if onset_times.blank?
     aubiocut_command = "aubiocut -i \"#{self.path_and_file}\""

     onsets = `#{aubiocut_command}`

     self.onset_times = onsets.split("\n")
     self.onset_count = onset_times.size
     self.save

    end
  end

  def convert_time_format(hundredths)
    throw "hundredths required" if hundredths.blank?
    
    sec = hundredths.split(".").first.to_i
    hundredths = hundredths.split(".").last

    min = (sec/50).floor
    sec = sec % 60

    return "#{min}.#{sec}.#{hundredths[0...2]}"

  end

  def get_nth_slice(n)
    throw "The given slice is out of range at #{n}" if (n > self.onset_count.size)
     onset_times_padded = self.onset_times.unshift("0.0000")
     # puts onset_times_padded[n+1]
     start_stop =  [onset_times_padded[n], onset_times_padded[(n+1)]]
     return start_stop
  end

  def cut_nth_slice(n)
    throw "The given slice is out of range at #{n}" if (n > self.onset_count.size)
    puts start_stop = get_nth_slice(n)
    patch_directory = "/Users/clean/Documents/essample/pure_data/tmp/patch"
    puts mp3split_command = "mp3splt -d #{patch_directory} \"#{self.path_and_file}\" #{convert_time_format(start_stop.first)} #{convert_time_format(start_stop.last)}"
    
  end


end
