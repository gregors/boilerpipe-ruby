# Boilerpipe

A pure ruby implemenation of the boilerpipe algorithm.

This is a text extraction utility first written by Christian Kohlshutter - [presentation](http://videolectures.net/wsdm2010_kohlschutter_bdu/)

I went directly to the original author's github https://github.com/kohlschutter/boilerpipe and forked that code base here https://github.com/gregors/boilerpipe.

I saw other gems making use of boilerpipe via the [free api](http://boilerpipe-web.appspot.com) but depending on time of day the api goes down due to exceeding the hosting plan. I also checked out some gems making use of Jruby but I had all kinds of dependency and bug issues. So I made some tweaks on my fork and created a new [jruby-boilerpipe gem](https://rubygems.org/gems/jruby-boilerpipe).

This solution works great if you're using Jruby but I wanted a pure ruby solution to use on MRI. Open vim - start coding...

I've only got the ArticleExtractor working but the others should be following quickly as the ArticleExtractor definitley has the most code behind it...

Presently the follow Extractors are implemented
* [x] ArticleExtractor
* [ ] DefaultExtractor
* [ ] LargestContentExtractor
* [ ] KeepEverythingExtractor

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'boilerpipe-ruby', require: 'boilerpipe'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install boilerpipe-ruby

## Usage

    gregors$ irb
    > require 'boilerpipe'
     => true
    > require 'open-uri'
      => true
    > content = open('https://blog.carbonfive.com/2017/08/28/always-squash-and-rebase-your-git-commits/').read; true;
    > output = Boilerpipe::Extractors::ArticleExtractor.text(content).slice(0..40)
     => "Always Squash and Rebase your Git Commits" 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gregors/boilerpipe-ruby.

