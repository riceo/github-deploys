Description
===========

This cookbook creates a deploy user, generate it a keypair, then uses the Github API to add the public key to the user's list of authenticated keys on Github.

The end goal is to configure a local user account that has access to all required Github repos for deploying code.

Todo:

- Replace setting the Github API credentials with checking an encrypted databag. ++security.

Requirements
============

- Debian family (Tested on Debian 6.0 and Ubuntu 12.10)
- Github Account
- Github API keys

Attributes
==========


    default[:github_deploys][:deploy_user] = "deploy"
    default[:github_deploys][:github_api][:endpoint_path] = "/user/keys"
    default[:github_deploys][:github_api][:username] = "SET_YOUR_GITHUB_USERNAME"
    default[:github_deploys][:github_api][:email] = "SET_YOUR_GITHUB_USER_EMAIL"
    default[:github_deploys][:github_api][:password] = "GITHUB_PASSWORD"


Usage
=====

Ensure your github credentials are set in the above attributes, then add the default recipe to your runlist.


License and Author
=====

Author: Aaron Rice <<aaron@duedil.com>>

Copyright: 2010-2013, [DueDil](http://www.duedil.com) Limited

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
