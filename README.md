[![Build Status](https://img.shields.io/travis/supertylerc/oxidized-web/v1.0.0.svg)](https://travis-ci.org/supertylerc/oxidized-web)
[![Code Quality](https://img.shields.io/codeclimate/github/supertylerc/oxidized-web.svg)](https://codeclimate.com/github/supertylerc/oxidized-web)
[![Coverage Status](https://img.shields.io/coveralls/supertylerc/oxidized-web/v1.0.0.svg)](https://coveralls.io/r/Integralist/Sinderella)

# v1.0.0

## Do Not Use (Yet)

This is a rewrite of [oxidized-web](https://github.com/ytti/oxidized-web).  It
is currently incomplete.  Please do not use this version.  Instead, use either
the version currently on [RubyGems](https://rubygems.org) (preferred) or the
[master branch](https://github.com/ytti/oxidized-web/tree/master).

## Why a Rewrite?

`oxidized-web` is awesome.  There's no doubt about that!  However, it currently
has some inconsistencies in its return data.  It's also not currently easy to
test, and instead of making a bunch of modifications to document and attempt to
test the current incarnation of `oxidized-web`, I've decided to rewrite it.

A lot of the code will be lifted directly from the current `oxidized-web`, but
there will be a focus on testing and clean modularity.

## Roadmap

See the
[v1.0.0 milestone](https://github.com/supertylerc/oxidized-web/milestones/v1.0.0)
in GitHub for the current roadmap.

## Contributions

Please contribute to v1.0.0!  I'm terrible at writing code.  I welcome all of
the help I can get.  :)  See [CONTRIBUTING.md](CONTRIBUTING.md)

## Using with `oxidized`

Due to a change in naming conventions, you must install `oxidized`
(`gem install oxidized`) and edit the `core.rb` file.  Find the line that is:

```ruby
@rest = API::Web.new nodes, CFG.rest
```

Change it to:

```ruby
@rest = Web::WebApp.new nodes, CFG.rest
```

I use [rvm](https://rvm.io) and [gemsets](https://rvm.io/gemsets/creating) to
manage my Ruby environments.  Because of this, I know that I can use the
following command to make this change:

```bash
ruby -pi -e "gsub(/API::Web/, 'Web::WebApp')" ~/.rvm/gems/ruby-2.2.3@oxidized-web-v1/gems/oxidized-0.9.0/lib/oxidized/core.rb
```

Finally, install `oxidized-web`:

```bash
cd /tmp
git clone https://github.com/supertylerc/oxidized-web && cd $_
git checkout v1.0.0
rake install
```

Start `oxidized` and browse to `http://localhost:8888/nodes`.

# Oxidized Web

REST API and web-based interface for
[oxidized](https://github.com/ytti/oxidized).

This is not useful independently.  See
[oxidized](https://github.com/ytti/oxidized) for further instruction details.

# License and Copyright

Copyright 2013-2015 Saku Ytti <saku@ytti.fi>
          2013-2015 Samer Abdel-Hafez <sam@arahant.net>
          2015-2016 Tyler Christiansen <code@tylerc.me>


Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
