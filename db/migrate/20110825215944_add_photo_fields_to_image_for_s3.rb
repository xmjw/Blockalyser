class AddPhotoFieldsToImageForS3 < ActiveRecord::Migration
  def self.up
    add_column :images, :photo_file_name,    :string
    add_column :images, :photo_content_type, :string
    add_column :images, :photo_file_size,    :integer
    add_column :images, :photo_updated_at,   :datetime
    remove_column :images, :filename
  end

  def self.down
    remove_column :images, :photo_file_name
    remove_column :images, :photo_content_type
    remove_column :images, :photo_file_size
    remove_column :images, :photo_updated_at
    add_column :images, :filename,        :string
    end
end
