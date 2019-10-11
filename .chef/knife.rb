# get chef properties fron environment variables
user = ENV['CHEF_CLIENT'] 
organization = ENV['CHEF_ORGANIZATION']
server = ENV['CHEF_SERVER']
client_pem = ENV['CHEF_CLIENT_PEM']
org_pem = ENV['CHEF_ORGANIZATION_PEM']


# create pem keys for client and organization
current_dir =  File.absolute_path(File.dirname(__FILE__))
clientFile = File.open "#{current_dir}/#{user}.pem", "w"
clientFile.write(client_pem)
clientFile.close

orgFile = File.open "#{current_dir}/#{organization}-validator.pem", "w"
orgFile.write(org_pem)
orgFile.close

# knife config
log_level :info
log_location STDOUT
node_name "#{user}"
client_key "#{current_dir}/#{user}.pem"
validation_client_name "#{organization}-validator"
validation_key "#{current_dir}/#{organization}-validator.pem"
chef_server_url "#{server}/organizations/#{organization}"
cookbook_path ["/projects"]
