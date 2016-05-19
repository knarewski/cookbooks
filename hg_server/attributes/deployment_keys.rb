DECODED_DATA_BAG = Chef::EncryptedDataBagItem.load(node["data_bag_name"], "secrets")

default["deployment_keys"] = {}
default["deployment_keys"]["private"] = DECODED_DATA_BAG["deployment_keys"]["private"]
default["deployment_keys"]["public"] = DECODED_DATA_BAG["deployment_keys"]["public"]