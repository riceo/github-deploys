module GithubAPI
	def upload_key(user, pass, title, path_to_key)

		http         = Net::HTTP.new('api.github.com', 443)
		http.use_ssl = true
		path 		 = node[:github_deploys][:github_api][:endpoint_path]

		begin
			key = File.read(path_to_key).strip!
		rescue
			Chef::Log.fatal("Unable to open key file")
		end

		data = "{\"title\": \"#{title}\", \"key\": \"#{key}\"}"

		headers = {
			'Content-Type'  => 'application/x-www-form-urlencoded',
			'Authorization' =>  "Basic " + Base64.encode64("#{user}:#{pass}").chop
		}

		response = http.post(path, data, headers)

		if response.code == "201"
			Chef::Log.info("Github SSH key successfully added for #{title}")
			return true
		else
			Chef::Log.warn("Unable to add Github SSH key for #{title}")
			Chef::Log.warn("#{response.code}: #{response.message} - #{response.body}")
			Chef::Log.warn("#{user}:#{pass}")
			return false
		end

	end
end
