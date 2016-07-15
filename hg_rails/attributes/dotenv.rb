secrets = Chef::EncryptedDataBagItem.load(node["data_bag_name"], "secrets")
environment_secrets = secrets[node.chef_environment] || {}

dotenv_attrs = secrets["dotenv"] || {}
environment_dotenv_attrs = environment_secrets["dotenv"] || {}

default["hg_rails"]["dotenv"] = Chef::Mixin::DeepMerge.deep_merge(dotenv_attrs, environment_dotenv_attrs)
