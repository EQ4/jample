include TimeHelpers


class Track
  include Mongoid::Document


  field :path_and_file, type: String
  field :file_contents_hash, type: String
  field :onset_times, type: Array
  field :onset_count, type: Integer

  has_many :samples


  def self.import_tracks
    # track_list_string = `mdfind -name \.mp3`
    track_list_string = `find ~/  -name *.mp3`
    puts "OKOK"
  	# puts track_list
  	tracks_array = track_list_string.split("\n")
  	puts tracks_array.size
    missing_files = Track.nin(path_and_file: tracks_array)
    missing_files.each  do |missing_file|
      missing_file.destroy
    end

    tracks_array.each do |track_path|
     track_path
     file_contents_hash = Digest::MD5.file(track_path).hexdigest
     track = Track.find_or_create_by(file_contents_hash: file_contents_hash)
     track.path_and_file = track_path
     track.save
     track.detect_onset
      # track.cut_nth_slice(1) rescue nil
    end
  end

  def slice_track_at_every_onset_fixed_length(length_in_slice_count)
    puts number_of_slices
    return if number_of_slices.blank?
    number_of_slices.times do |index|
      padded_stop_index = [(index + length_in_slice_count),number_of_slices].min # don't go out of bounds
      sample = Sample.create(
        start_onset_index: index, 
        stop_onset_index: padded_stop_index 
        )
      self.samples << sample

    end
    self.save
  end

  def number_of_slices
    self.onset_count
    
  end


  def detect_onset
    if onset_times.blank?
     aubiocut_command = "aubiocut -i \"#{self.path_and_file}\""

     puts onsets = `#{aubiocut_command}`

     self.onset_times = onsets.split("\n")
     self.onset_count = onset_times.size
     self.save

   end
 end

 def track_name
  path_and_file.split('/').last

end



end
