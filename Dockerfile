FROM ruby:latest
RUN gem install halidator
CMD halidate
