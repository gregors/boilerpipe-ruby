# Boilerpipe

[![CircleCI](https://circleci.com/gh/gregors/boilerpipe-ruby/tree/master.svg?style=shield)](https://circleci.com/gh/gregors/boilerpipe-ruby/tree/master)
[![Gem Version](https://badge.fury.io/rb/boilerpipe-ruby.svg)](https://badge.fury.io/rb/boilerpipe-ruby)

A pure ruby implemenation of the boilerpipe algorithm.

This is a text extraction utility first written by Christian Kohlshutter - [presentation](http://videolectures.net/wsdm2010_kohlschutter_bdu/)

I went directly to the original author's github https://github.com/kohlschutter/boilerpipe and forked that code base here https://github.com/gregors/boilerpipe.

I saw other gems making use of boilerpipe via the [free api](http://boilerpipe-web.appspot.com) but depending on time of day the api goes down due to exceeding the hosting plan. I also checked out some gems making use of Jruby but I had all kinds of dependency and bug issues. So I made some tweaks on my fork and created a new [jruby-boilerpipe gem](https://rubygems.org/gems/jruby-boilerpipe).

This solution works great if you're using Jruby but I wanted a pure ruby solution to use on MRI. Open vim - start coding...

Here's a high level [diagram](boilerpipe_flow.md) of how the system works.

# TLDR

Just use either ArticleExtractor, DefaultExtractor or KeepEverythingExtractor - try out the others when you feel like experimenting...

Presently the follow Extractors are implemented
* [x] ArticleExtractor
* [x] ArticleSentenceExtractor
* [x] CanolaExtractor
* [x] DefaultExtractor
* [x] KeepEverythingExtractor
* [x] KeepEverythingWithMinKWordsExtractor
* [x] LargestContentExtractor
* [x] NumWordsRulesExtractor


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
    
    > Boilerpipe::Extractors::ArticleExtractor.text(content).slice(0..40)
     => "Always Squash and Rebase your Git Commits" 
    
    > Boilerpipe::Extractors::DefaultExtractor.text(content).slice(0..40)
     => "Posted on\nWhat is the squash rebase workf"
    
    > Boilerpipe::Extractors::LargestContentExtractor.text(content).slice(0, 40)
     => "git push origin master\nWhy should you ad"
    
    > Boilerpipe::Extractors::KeepEverythingExtractor.text(content).slice(0..40)
     => "Toggle Navigation\nCarbon Five\nAbout\nWork\n"

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

### Running Tests on Docker

The default run command will run the tests

    docker build -t boilerpipe .
    docker run -it --rm boilerpipe

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gregors/boilerpipe-ruby.

