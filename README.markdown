wordpress-scripts
=================

A small collection of utilities to manage wordpress installations.

**Waning:** these are early versions which I use for small tasks. If you find
a bug or have suggestions, contact me at <jbernal@warp.es>

Scripts
-------

### wp-dump

wp-dump helps you to backup your wordpress database. Just tell where is the wordpress directory and where to put the dump file

#### Syntax

`$ wp-dump wordpress-dir outfile`

`outfile` will be a gzipped SQL dump, so you should use the `.sql.gz` extension

### wp-import

wp-import helps you to restore your wordpress database. Just tell where is the wordpress directory and where to read the backup file

wp-import expects the backup to be a **gzipped dump**

#### Syntax

`$ wp-import wordpress-dir infile`

### publish.sh

publish.sh is useful if you:

* Manage your plugins with [git](http://git.or.cz/)
* Want to publish versions to a remote server using scp

#### Syntax

`$ publish.sh plugin_name version`

publish.sh will replace version numbers in your code (see Requirements), tag
the release with git, create a tarball and upload it to the specified server.

#### Requirements

First, you need a config file called `~/.wpplugins`. An sample way to do this is

`$ echo myserver.example.com:public_html/plugins/ > ~/.wpplugins`

where `myserver.example.com` is your server and `public_html/plugins/` is the
path (relative from your $HOME) to upload the tarballs

publish.sh can also replace version numbers in your plugin. It will detect these two cases

* Plugin header: Version 0.1
* Version constant: define(plugin\_name\_version, '0.1');

License
-------

(The MIT License)

Copyright (c) 2008 Jorge Bernal <jbernal@warp.es>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.