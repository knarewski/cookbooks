dotenv_attrs = Chef::EncryptedDataBagItem.load(node["data_bag_name"], "secrets")["dotenv"]

default["hg_rails"]["dotenv"] = dotenv_attrs || {}