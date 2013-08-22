# elasticsearch Puppet Module for Boxen

[![Build Status](https://travis-ci.org/boxen/puppet-elasticsearch.png?branch=master)](https://travis-ci.org/boxen/puppet-elasticsearch)

Install [elasticsearch](http://www.elasticsearch.org), a distributed,
RESTful search engine. The `BOXEN_ELASTICSEARCH_PORT` and
`BOXEN_ELASTICSEARCH_URL` environment variables are set.

## Usage

```puppet
include elasticsearch
```

## Required Puppet Modules

* `boxen`
* `homebrew`
* `repository`
* `java`
* `stdlib`

## Development

Write code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.
