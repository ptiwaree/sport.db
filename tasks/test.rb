
#########################
#  Fill up sport.db w/ football.db fixtures


### at

##############################
## for testing 
##
## NB: use
#   $ rake -I ../sport.db.ruby/lib update


##########
# TODO: configure - copy to your rake file

#  INCLUDE_PATH = "../football.db"
  
#  BUILD_DIR = "./db"
  
#  SPORT_DB_PATH = "#{BUILD_DIR}/sport.db"

#  SPORT_DB_RUBY_PATH = "../sport.db.ruby"

################

  DB_CONFIG = {
    :adapter   =>  'sqlite3',
    :database  =>  SPORT_DB_PATH
  }

  directory BUILD_DIR

 # task :clean do
 #   rm SPORT_DB_PATH if File.exists?( SPORT_DB_PATH )
 # end

  task :env => BUILD_DIR do
    require "#{SPORT_DB_RUBY_PATH}/lib/sportdb.rb"

    pp DB_CONFIG
    ActiveRecord::Base.establish_connection( DB_CONFIG )
  end

 # task :create => :env do
 #   WorldDB.create
 # end

  task :import => :env do
    puts "hello from import"
    
    reader = SportDB::Reader.new
    
    reader.load_event_with_include_path( 'at/2011_12/bl', INCLUDE_PATH )
    reader.load_event_with_include_path( 'at/2011_12/cup', INCLUDE_PATH )
  end

  desc 'worlddb - test loading of builtin fixtures (update)'
  task :update => [:import]
