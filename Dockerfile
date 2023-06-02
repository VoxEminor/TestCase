FROM ruby:3.1.2
ENV DATABASE_NAME=zadanie_development
ENV TEST_DATABASE_NAME = zadanie_test
ENV DATABASE_USER=evgeny
ENV DATABASE_PASSWORD=123
ENV DATABASE_HOST=postgres
RUN apt-get update 
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install  
COPY ./ .
RUN rm -rf /myapp/config/credentials.yml.enc
RUN EDITOR="mate --wait" bin/rails credentials:edit
CMD   rails  db:migrate && RAILS_ENV=development rails server -b 0.0.0.0
#CMD RAILS_LOG_TO_STDOUT=1 RAILS_ENV=development bundle exec puma
