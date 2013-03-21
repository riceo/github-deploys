#
# Cookbook Name:: github_deploys
# Recipe:: default
#
# Copyright 2013, Duedil Limited
#

# connect to the linkedin API, upload the key
# Create a code deploys group

user node[:github_deploys][:deploy_user] do
  comment "Github Deploy user"
  shell "/bin/false"
  home "/home/#{node[:github_deploys][:deploy_user]}"
  supports :manage_home => true
end

path_to_key = "/home/#{node[:github_deploys][:deploy_user]}/.ssh/id_rsa"

execute "generate_keypair" do
	command "ssh-keygen -t rsa -N '' -C '#{node[:github_deploys][:github_api][:user_email]}' -f #{path_to_key}"
	user node[:github_deploys][:deploy_user]
	not_if { ::File.exists?("/home/#{node[:github_deploys][:deploy_user]}/.ssh")}
end

ruby_block "upload_key_to_github" do
	block do

		class Chef::Resource::RubyBlock
		  include GithubAPI
		end

		upload_key(
			node[:github_deploys][:github_api][:user_email],
			node[:github_deploys][:github_api][:password],
			node[:fqdn],
			"#{path_to_key}.pub")
	end
end
