# encoding: utf-8

##
# Backup Generated: backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t backup [-c <path_to_configuration_file>]
#
Backup::Model.new(:nastachku_production_backup, 'Nastachku backup') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  # split_into_chunks_of 250

  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    db.name               = "my_database_name"
    db.username           = "my_username"
    db.password           = "my_password"
    # db.host               = "localhost"
    # db.port               = 5432
    # db.socket             = "/tmp/pg.sock"
    # db.skip_tables        = ["skip", "these", "tables"]
    # db.only_tables        = ["only", "these" "tables"]
    # db.additional_options = ["-xc", "-E=utf8"]
    # Optional: Use to set the location of this utility
    #   if it cannot be found by name in your $PATH
    # db.pg_dump_utility = "/opt/local/bin/pg_dump"
  end

  ##
  # Local (Copy) [Storage]
  #
  store_with Local do |local|
    local.path = "/var/tmp/"
    local.keep = 5
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip do |compression|
    compression.best = true
    compression.fast = false
  end

end
