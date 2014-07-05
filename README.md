# elasticsearch Puppet Module for Boxen

[![Build Status](https://travis-ci.org/boxen/puppet-elasticsearch.svg?branch=master)](https://travis-ci.org/boxen/puppet-elasticsearch)

Install [elasticsearch](http://www.elasticsearch.org), a distributed,
RESTful search engine. The `BOXEN_ELASTICSEARCH_PORT` and
`BOXEN_ELASTICSEARCH_URL` environment variables are set.

## Usage

```puppet
include elasticsearch
```

This module supports data bindings via hiera.
See the parameters to the elasticsearch class for overrideable values.

## Required Puppet Modules

* `boxen` >= 3.3.3
* `homebrew`
* `repository`
* `java`
* `stdlib`

## Development

Write code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.
