Installation and Setup:
====================
```


	# install rvm

	\curl -sSL https://get.rvm.io | bash
	echo `source /Users/<your user>/.rvm/scripts/rvm` > ~/.bash_profile

	# install ruby version (takes a while)

	rvm install 2.6.5

  gem install bundler


	# install all dependencies
	bundle install

  # run on localhost
  rackup -p 2030

```
