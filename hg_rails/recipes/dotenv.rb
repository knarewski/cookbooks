dotenv_path = File.join("/home", node["user"], node["hg_rails"]["app_name"])
dotenv_path = File.join(dotenv_path, "shared") unless ["development", "test"].include?(node["hg_rails"]["env"])
dotenv_path = File.join(dotenv_path, ".env")

file dotenv_path do
  owner node["user"]
  group node["user"]
  mode "600"
  content node["hg_rails"]["dotenv"].map { |key, value| "#{key}=#{value}"}.join("\n")
end