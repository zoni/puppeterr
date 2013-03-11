Err
===

Install the [Err](http://gbin.github.com/err/) xmpp/irc chat bot from a Git
repository into it's own Python virtualenv.

Note: I wrote this late on a Sunday night. Though it's tested, it does not 
currently contain actual tests.

Documentation
-------------

This module contains embedded rdoc documentation, use the `puppet doc` tool to generate it.
Alternatively, here's the same documentation in markdown:

### Define: Err

A defined resource type which installs Err straight from a Git repository
and into it's own Python virtualenv

#### Parameters

*checkout* 

  (required) The directory to check out the Git repository into.

*virtualenv*

  (required) The directory to create the virtualenv in.

*source*

   The repository to clone from. Defaults to upstream (git://github.com/gbin/err.git).

*revision*

   The specific revision to install. Defaults to the latest commit on master.

*pythonversion*

   The version of python to install the virtualenv with. Takes any valid value the
   --python flag to virtualenv supports. Default to the interpreter that virtualenv
   was installed with (/usr/bin/python).

#### Examples

     # Install the Python 2 version of Err to /usr/share/err/python2
	 err { 'err2':
	   checkout => '/usr/share/err/repo',
	   virtualenv => '/usr/share/err/python2/',
	   pythonversion => 'python2',
	 }

     # Install the Python 3 version of Err to /usr/share/err/python3
     # using the same Git checkout that was already used for Python 2
	 err { 'err3':
	   checkout => '/usr/share/err/repo',
	   virtualenv => '/usr/share/err/python3/',
	   pythonversion => 'python3',
	 }

### Class: err::packages

Included by the defined resource `err` to install required packages

#### Parameters

None

Author
------

Nick Groenen <zoni@zoni.nl>

Support
-------

Please log any issues at the GitHub [issues](https://github.com/zoni/puppeterr)
page or ask for help in the
[Google plus community](https://plus.google.com/communities/117050256560830486288).

Know issues
-----------

When changing arguments passed to the virtualenv (like changing the Python version),
you'll need to remove the virtualenv by hand first. This module does not currently
detect when it needs to recreate the virtualenv from scratch.

Contributing
------------

1. Fork the repository on GitHub
2. Make epic changes
3. Open a pull request :) 

License
-------

The MIT License (MIT)
Copyright (c) 2013 Nick Groenen

Permission is hereby granted, free of charge, to any person obtaining a 
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense, 
and/or sell copies of the Software, and to permit persons to whom the 
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
DEALINGS IN THE SOFTWARE.

