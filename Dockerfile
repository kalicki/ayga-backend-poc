FROM ruby:2.5-alpine
LABEL maintainer="Filipe Kalicki <filipe.kalicki@gmail.com>"

# Variables
ARG BACKEND='/ayga-backend'
ARG PORT=3000

# Create directory & set working
RUN mkdir $BACKEND
WORKDIR $BACKEND

# Copy local machine to container
ADD Gemfile* $BACKEND/

# Install dependencies only for production
RUN bundle install --jobs 20 --retry 5 --without development test

# Add everything from current directory to directory in container
ADD . $BACKEND

EXPOSE $PORT
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"] 