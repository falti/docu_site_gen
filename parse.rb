require 'yaml'

def yaml_to_meta(path_to_yaml)
  data = YAML.load_file(path_to_yaml)
  data.map{|var_name, value| {"name" => var_name, "type" => friendly_type(value)}}
end

def friendly_type(value)
  {TrueClass => "boolean", FalseClass => "boolean", String => "string", Float => "float", Integer => "int"}.fetch(value.class, "unknown type")
end

puts "Loading all variables"

role_paths = Dir.glob("roles/**/main.yml")

role_name_groups = role_paths.map{|role| role.scan(/^roles\/([^\/]+)\//).flatten.first}



roles = role_name_groups.zip(role_paths).map{|role,file_path| {role => yaml_to_meta(file_path)} }.reduce{| col, current| col.merge(current)}

roles.each do |role_name, variables|

  role = {"name" => role_name, "description" => "TBD", "variables" => variables}
  
  yml = role.to_yaml
  yml_path = "site/_data/roles"

  yml_file_name = "#{yml_path}/#{role_name}.yml"

  File.open(yml_file_name, "w") do |f|
    f << yml
  end

end

