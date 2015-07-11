# vagrant-stf

A setup scripts of [openstf/stf](https://github.com/openstf/stf/) with vagrant, docker, ansible, nginx, consul, consul-template and registrator.

## Requirements

- Vagrant (Tested on 1.7.2)
- Ansible (Tested on 1.9.1)

## Installation

- Generate Google OAuth2 Credential.
  - Open [Google Developer Console](https://console.developers.google.com/).
  - Create project like "stf".
  - Enable APIs -> `Google+ API` and `Contacts API`
  - Consent screen -> Choose `Email address` and name `Product name`.
  - Credential -> Create new Client ID -> Input your configurations.
    
    |property|value|
    |--:|--:|
    |Application type|Web Application|
    |Authorized JavaScript Origin|http://stf.example.org|
    |Authorized redirect URIs|http://stf.example.org/auth/oauth/callback|

- Edit vars file to suit your environment. Replace `OAUTH_CLIENT_ID` and `OAUTH_CLIENT_SECRET` generated in above.

```
vim ansivle/vars/loval.yml

use_ssl: no
app_scheme: http
app_domain: stf.example.org
app_url: "{{ app_scheme }}://{{ app_domain }}"

auth_method: "auth-oauth2"

env_values:
  - { key: OAUTH_CLIENT_ID, value: "replace_it" }
  - { key: OAUTH_CLIENT_SECRET, value: "replace_it" }
```

- Setup VM and Docker containers.

```
make install
```

- Ensure application is properly launched.

```
sudo echo "172.17.8.101 stf.example.org" > /etc/hosts
```

then open http://stf.example.org/

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request