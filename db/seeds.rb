# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

normal  = Level.get_severity(Level::NORMAL)
warning = Level.get_severity(Level::WARNING)
error   = Level.get_severity(Level::ERROR)

Status.create!( :name         => "Down", 
                :slug         => "down", 
                :image        => "cross-circle", 
                :severity     => error,
                :description  => "The service is currently down" )

Status.create!( :name         => "Up", 
                :slug         => "up", 
                :image        => "tick-circle", 
                :severity     => normal,
                :description  => "The service is up" )

Status.create!( :name         => "Warning", 
                :slug         => "warning", 
                :image        => "exclamation", 
                :severity     => warning,
                :description  => "The service is experiencing intermittent problems" )