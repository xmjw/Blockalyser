class CreateAttachment < ActiveRecord::Migration
    def self.up
      #Remove the old Amazon S3 data...
      remove_column :images, :photo_file_name
      remove_column :images, :photo_content_type
      remove_column :images, :photo_file_size
      remove_column :images, :photo_updated_at

      #Create the new File-in-Database columns
      add_column :images, :file_name, :string
      add_column :images, :content_type, :string
      add_column :images, :data, :binary
    end

    def self.down
      #Remove the old Amazon S3 data...
      add_column :images, :photo_file_name,    :string
      add_column :images, :photo_content_type, :string
      add_column :images, :photo_file_size,    :integer
      add_column :images, :photo_updated_at,   :datetime

      #Create the new File-in-Database columns
      remove_column :images, :file_name
      remove_column :images, :content_type
      remove_column :images, :data
    end
end