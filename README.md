# Theme Park Database

[![CircleCI](https://circleci.com/gh/imbenjamin/tpdb.svg?style=svg)](https://circleci.com/gh/imbenjamin/tpdb) [![Ruby](https://github.com/imbenjamin/tpdb/workflows/Ruby/badge.svg)](https://github.com/imbenjamin/tpdb/actions?query=workflow%3ARuby)

## To Run Locally on OSX (from scratch!)
### Set up environment
1. Install Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`
2. Install RVM: `\curl -sSL https://get.rvm.io | bash -s stable`
3. Install Ruby 2.5.3: `rvm install ruby-2.5.3`
4. Install Postgres: [here](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads) and `brew install postgresql`
5. Install ImageMagick: `brew install imagemagick`
6. Install Bundler: `gem install bundler`

### Set up environment variables
7. Google Maps Embed API key: `GMAPS_EMBED_KEY`

### Install Dependencies
8. Bundle Install: `bundle install`

### Set up Database
9. Ensure local Postgres server is running (eg. using a tool like [pgAdmin](https://www.pgadmin.org/))
10. For development, create a user with name `tpdb_user` and password `tpdb` with superuser permissions.
11. Setup TPDB database: `rake db:setup` or `bundle exec rake db:setup`

### Run Server
12. Start server on localhost:3000:  `rails server`

### Run tests
13. Test with Rspec: `rspec` or `bundle exec rspec`