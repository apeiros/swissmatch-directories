README
======


Summary
-------
Query address data from swiss directory providers.


Installation
------------
Install the gem: `gem install swissmatch-directories`  
Depending on how you installed rubygems, you have to use `sudo`:
`sudo gem install swissmatch-directories`  
In Ruby: `require 'swissmatch/directories'`


Usage
-----
    require 'swissmatch/directories'
    directories = SwissMatch::Directories.create(:telsearch, api_token: your_token)
    params      = {first_name: 'Stefan', last_name: 'Rusterholz'}
    directories.addresses(params).each do |address|
      puts address,""
    end


Relevant Classes and Modules
----------------------------
* __{SwissMatch::Directories}__
  Convenience methods to create and access directory services
* __{SwissMatch::Directories::Service}__
  The basic API to use directory services


Links
-----

* [Main Project](https://github.com/apeiros/swissmatch)
* [Online API Documentation](http://rdoc.info/github/apeiros/swissmatch-directories/)
* [Public Repository](https://github.com/apeiros/swissmatch-directories)
* [Bug Reporting](https://github.com/apeiros/swissmatch-directories/issues)
* [RubyGems Site](https://rubygems.org/gems/swissmatch-directories)
* [Swiss Posts MAT[CH]](http://www.post.ch/match)


License
-------

You can use this code under the {file:LICENSE.txt BSD-2-Clause License}, free of charge.
If you need a different license, please ask the author.


Credits
-------

* [Simon Hürlimann](https://github.com/huerlisi) for contributions
* [AWD Switzerland](http://www.awd.ch/) for donating time to work on this gem.
