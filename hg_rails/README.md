# Description

This cookbook installs and configures rails environment for you.

# Available recipes

 * `recipe["hg_rails::default"]` - installs RVM and rubies for given users
 * `recipe["hg_rails::database"]` - prepares database.yml
 * `recipe["hg_rails::dotenv"]` - prepares .env file

# Common attributes
```ruby
node["user"] = nil # user for whom we configure everything
node["data_bag_name"] = nil # name of data bag used to keep secrets
node["hg_rails"]["env"] = "production" # Rails environment for given app
node["hg_rails"]["app_name"] = nil # Application name (used in creating directories, db names etc.)
```

# Recipes description
### default

Installs RVM with Rubies for given user

[go here for further info](https://github.com/martinisoft/chef-rvm/tree/v0.9.4)

Available attributes with defaults:

```ruby
node["hg_rails"]["rvm"]["user_installs"] = [] # Array of rubies to be installed.

example:
[
  {
    "user": "rails_app",
    "default_ruby": "2.2.2",
    "rubies": ["2.2.2"],
    "upgrade": false,
    "rvmrc": {
      "rvm_gemset_create_on_use_flag": 1
    },
    "global_gems": [
      { "name": "passenger" },
      { "name": "bundler"}
    ]
  }
]
# More examples in RVM repository
```

### Database

Creates `database.yml` file. Depends on app env it uses `/home/:user/:app_name/config/database.yml` or `/home/:user/:app_name/shared/config/database.yml`.

Available attributes with defaults:

```ruby
node["hg_rails"]["database"]["port"] = 3306
node["hg_rails"]["database"]["pool"] = 50
node["hg_rails"]["database"]["adapter"] = "mysql2"
node["hg_rails"]["database"]["username"] = nil
node["hg_rails"]["database"]["database"] = nil
node["hg_rails"]["database"]["password"] = nil
node["hg_rails"]["database"]["host"]     = nil

```

If you are not setting up `development` or `test` env you can (and SHOULD) use encrypted data bag. Structure should be as follows:

```
# bag: "#{data_bag_name}"
# item: "secrets"

structure:
{
  "database": {
    "host": "something.com",
    "username": "root",
    "password": "pass"
  }
}
```

You can also specify additional databases to be included in database.yml with following:

```ruby
node["hg_rails"]["database"]["additional_databases"]["database_name"]["port"] = 3306
node["hg_rails"]["database"]["additional_databases"]["database_name"]["pool"] = 50
node["hg_rails"]["database"]["additional_databases"]["database_name"]["adapter"] = "mysql2"
node["hg_rails"]["database"]["additional_databases"]["database_name"]["username"] = "tester"
node["hg_rails"]["database"]["additional_databases"]["database_name"]["database"] = "test_database"
node["hg_rails"]["database"]["additional_databases"]["database_name"]["password"] = "qwerty"
node["hg_rails"]["database"]["additional_databases"]["database_name"]["host"]     = nil
```

Note that `username`, `database` and `password` probably should be handled via data_bag as follows:

```
{
  "database": {
    ...,
    "additional_databases": {
      "database_name": {
        "database": "test",
        "username": "user123",
        "password": "qwerty"
      }
    }
  }
}
```

### dotenv

Scaffolds `.env` file within `/home/:user/:app_name/` (for development/test env) or within `/home/:user/:app_name/shared/.env` (for other envs).

Available attributes with defaults:

```ruby
node["hg_rails"]["dotenv"] = {}

# example:

node["hg_rails"]["dotenv"] = {
 app_secret: "some_secret",
 fb_api_key: "apikey"
}
```
