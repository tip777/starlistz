# encoding: utf-8

##
# Backup Generated: mysql_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t mysql_backup [-c <path_to_configuration_file>]
#
Backup::Model.new(:mysql_backup, 'Description for mysql_backup') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

  ##
  # MySQL [Database]
  #
  database MySQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = ENV["DB_NAME"]
    db.username           = ENV["DB_USERNAME"]
    db.password           = ENV["DB_PASSWORD"]
    db.host               = ENV["DB_HOSTNAME"]
    db.port               = 3306
    db.socket             = "/tmp/mysql.sock"
    # Note: when using `skip_tables` with the `db.name = :all` option,
    # table names should be prefixed with a database name.
    # e.g. ["db_name.table_to_skip", ...]
    # db.skip_tables        = ["skip", "these", "tables"]
    # db.only_tables        = ["only", "these", "tables"]
    # db.additional_options = ["--quick", "--single-transaction"]
  end

  ##
  # Amazon Simple Storage Service [Storage]
  #
  # Available Regions:
  #
  #  - ap-northeast-1
  #  - ap-southeast-1
  #  - eu-west-1
  #  - us-east-1
  #  - us-west-1
  #
  store_with S3 do |s3|
    s3.access_key_id     = ENV["AWS_ACCESS_KEY_ID"]
    s3.secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
    s3.region            = "us-east-1"
    s3.bucket            = "db-backup-heroku"
    s3.path              = "/#{Time.zone.now.strftime("%Y%m%d%H%M")}/"
    s3.keep              = 10
  end

end
