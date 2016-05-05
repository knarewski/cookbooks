# HG Cookbooks

HG cookboks for Ubuntu/Debian servers provisioning.

### Prerequisites

* ruby
* chef
* berkshelf
* knife
* knife-solo (https://matschaffer.github.io/knife-solo/)

### Available cookbooks

* `hg_development` - Development tools setup
* `hg_rails` - Rails stack setup (Ruby, RoR, database, dotenv)
* `hg_server` - Server setup (creating users, deployment keys, MySQL, Redis etc.)

### Berkshelf

sample Berskfile file:

```ruby
# knife solo data bag edit synerise_mailers secrets

source "https://api.berkshelf.com"

cookbook "hg_server", git: 'git@github.com:Synerise/cookbooks.git', rel: "hg_server/",           tag: "1.0.1"
cookbook "hg_rails", git: 'git@github.com:Synerise/cookbooks.git', rel: "hg_rails/",             tag: "1.0.1"
cookbook "hg_development", git: 'git@github.com:Synerise/cookbooks.git', rel: "hg_development/", tag: "1.0.1"
```

## Useful commands

`knife solo cook username@host --why-run` - will explain what would be changed in actual run


## Sample setup on Vagrant

0. Get server that you would like to configure, for case of this example we will assume that you will use Vagrant machine (sample Vagrantfile is present here in the repository). Make sure it is running.
1. Add to existing Gemfile or create new with following:
```ruby
source "https://rubygems.org"

gem 'chef' # you can add require: false in all of these if you wish
gem "knife-solo"
gem "knife-solo_data_bag"
gem "berkshelf"
```
2. Run `bundle install`
3. Run `bundle exec knife solo init ./chef/`
4. Create `Berskfile` file within `./chef/` directory (example content is presented above)
5. Within `./chef/nodes` create json file connected with node that you wish to provision. For Vagrant example it is `127.0.0.1.json`. Within `run_list` key specify array of recipes to be run and of course specify all required node params and data_bags for provisioning (it depends on cookbook you will be using).
6. Run `knife solo prepare vagrant@127.0.0.1 -p 2222` to install Chef on server (2222 port is internal setting of Vagrant)
7. Finally run `knife solo cook vagrant@127.0.0.1 -p 2222`