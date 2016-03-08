file File.join("/home", node["user"], node["hg_rails"]["app_name"], "shared", '.env') do
  owner node["user"]
  group node["user"]
  mode "600"
  content node["hg_rails"]["dotenv"].map { |key, value| "#{key}=#{value}"}.join("\n")
end