class Image < ActiveRecord::Base

  has_attached_file :photo,
    :styles => {
      :thumbnail => "185x185#",
    },
    :storage => :s3,
    :s3_credentials => "#{Rails.root.to_s}/config/s3.yml",
    :s3_host_name => "s3-eu-west-1.amazonaws.com",
    :s3_protocol => "https",
    :path => ":class/:id/:style_:basename.:extension",
    :bucket => "photo.blockalyser.com",
    :url  => ":s3_eu_url"


end
