DECODED_DATA_BAG = Chef::EncryptedDataBagItem.load(node["data_bag_name"], "secrets")
deployment_keys_secrets = DECODED_DATA_BAG["deployment_keys"] || {}

default["deployment_keys"] = {}
default["deployment_keys"]["private"] = deployment_keys_secrets["private"]
default["deployment_keys"]["public"] = deployment_keys_secrets["public"]
