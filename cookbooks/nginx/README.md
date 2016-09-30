# nginx Cookbook

TODO: Installs nginx to run on port 8080 (for example if you want to put varnish in front).

## Requirements

OS: CentOS 6.x, RHEL 6.x

### Chef

- Chef 12.0 or later

### Cookbooks

Cookbooks dependencies: This install 'nginx' package from EPEL repo, hence 'yum-epel' cookbook is necessary (available in supermarket). Other recommended (not necessary) cookbooks are:
1. yum
2. chef-client

## Attributes

default['nginx']['port'] - You can change this to the port number on which you want nginx to run. If not mentioned, nginx will run on default port 80

default['nginx']['document_root'] - Defined the document root of nginx web server.

## Contributing

TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Authors: Aman Hanjrah (aman.hanjrah@gmail.com)
