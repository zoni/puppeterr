# == Define: Err
# 
# A defined resource type which installs Err straight from a Git repository
# and into it's own Python virtualenv
#
# === Parameters
#
# *checkout* 
#   (required) The directory to check out the Git repository into.
# *virtualenv*
#   (required) The directory to create the virtualenv in.
# *source*
#    The repository to clone from. Defaults to upstream (git://github.com/gbin/err.git).
# *revision*
#    The specific revision to install. Defaults to the latest commit on master.
# *pythonversion*
#    The version of python to install the virtualenv with. Takes any valid value the
#    --python flag to virtualenv supports. Default to the interpreter that virtualenv
#    was installed with (/usr/bin/python).
#
# === Examples
#
#  err { 'err2':
#    checkout => '/usr/share/err/repo',
#    virtualenv => '/usr/share/err/python2/',
#    pythonversion => 'python2',
#  }
#
#  err { 'err3':
#    checkout => '/usr/share/err/repo',
#    virtualenv => '/usr/share/err/python3/',
#    pythonversion => 'python3',
#  }
#
# === Author
#
# Nick Groenen <zoni@zoni.nl>
#
# === Copyright
#
# The MIT License (MIT)
# Copyright (c) 2013 Nick Groenen
#
# Permission is hereby granted, free of charge, to any person obtaining a 
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense, 
# and/or sell copies of the Software, and to permit persons to whom the 
# Software is furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
# DEALINGS IN THE SOFTWARE.
#
define err($checkout, $virtualenv, $source = "git://github.com/gbin/err.git", $revision = "master", $pythonversion = undef) {
  include err::packages

  if $pythonversion == undef {
    $python = ""
  }
  else {
    $python = "--python ${pythonversion}"
  }

  vcsrepo { $checkout:
    ensure => latest,
    provider => git,
    source => $source,
    revision => $revision,
    notify => Exec["${title}_virtualenv"],
  }
  
  exec { "${title}_virtualenv":
    command => "virtualenv ${python} ${virtualenv}",
    creates => $virtualenv,
    require => Package[$err::packages::virtualenv_pkg],
    path    => "/usr/local/bin:/usr/bin", 
    notify  => Exec["${title}_setup"]
  }

  exec { "${title}_pip":
    command     => "pip install --requirement ${checkout}/requirements.txt",
    path        => "${virtualenv}/bin", 
    require     => [ Vcsrepo[$checkout], Exec["${title}_virtualenv"] ]
  }

  exec { "${title}_setup":
    command     => "python setup.py install",
    cwd         => $checkout,
    path        => "${virtualenv}/bin", 
    refreshonly => true,
    require     => Exec["${title}_pip"],
  }
}
