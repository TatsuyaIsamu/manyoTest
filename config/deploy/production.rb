server '35.74.161.253', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/isamutatsuya/.ssh/id_rsa.pub'