class Image < ActiveRecord::Base

#    has_attached_file :photo,
#    :styles => {
#      :thumbnail => "185x185#",
#    },
#    :storage => :s3,
#    :s3_credentials => "#{Rails.root.to_s}/config/s3.yml",
#    :s3_host_name => "s3-eu-west-1.amazonaws.com",
#    :s3_protocol => "https",
#    :path => ":class/:id/:style_:basename.:extension",
#    :bucket => "photo.blockalyser.com",
#    :url  => ":s3_eu_url"

    def uploaded_file=(incoming_file)
        self.filename = incoming_file.original_filename
        self.content_type = incoming_file.content_type
        self.data = incoming_file.read
    end

    def filename=(new_filename)
        write_attribute("filename", sanitize_filename(new_filename))
    end

    private
    def sanitize_filename(filename)
        #get only the filename, not the whole path (from IE)
        just_filename = File.basename(filename)
        #replace all non-alphanumeric, underscore or periods with underscores
        just_filename.gsub(/[^\w\.\-]/, '_')
    end
end
