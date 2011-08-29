

require 'aws/s3'

#AWS::S3::DEFAULT_HOST = "s3-eu-west-1.amazonaws.com"
AWS::S3::DEFAULT_HOST.replace "s3-eu-west-1.amazonaws.com"


# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Blockalyser::Application.initialize!
