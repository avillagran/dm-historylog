DataMapper History Log
=======

Automatic log every DataMapper model


Installation
------------

Add dm-crud to Gemfile:

    # Gemfile 
    gem 'dm-historylog', :git => 'http://github.com/avillagran/dm-historylog'

Run:

    bundle install
    

Usage
-----

### Installation

Run the install generator:

    rails g historylog:install

Create historylog table:

    rake db:autoupgrade

### Using

Add include DataMapper::Historylog on your models

    include DataMapper::Historylog

### Example:
    class Example
      include DataMapper::Resource
      include DataMapper::Timestamp
      include DataMapper::Historylog

      property :id,               Serial
      property :name,             String
    
      timestamps :at
      property :deleted_at, ParanoidDateTime
    end

Every action with Example model (Save, Create, Update and Delete) will generate a new record in historylog table.

TODO
----
- Tests
- Documentation!