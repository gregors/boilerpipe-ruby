From ruby:2.5
RUN gem install bundler
COPY *gemspec /usr/src/app/
COPY Gemfile /usr/src/app/
COPY lib/boilerpipe/version.rb /usr/src/app/lib/boilerpipe/
COPY bin /usr/src/app/
COPY bin/* /usr/src/app/bin/

WORKDIR /usr/src/app
RUN bin/setup

COPY . /usr/src/app/

CMD ["bundle", "exec", "rspec", "--color", "--format", "doc"]
