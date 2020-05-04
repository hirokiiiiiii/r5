FROM ruby:2.6.4

# 必要なパッケージのインストール（基本的に必要になってくるものだと思うので削らないこと）
RUN apt update -qq && apt install -y build-essential nodejs

# 作業ディレクトリの作成、設定
RUN mkdir /app
##作業ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照
ENV APP_ROOT /app
WORKDIR $APP_ROOT

# ホスト側（ローカル）のGemfileを追加する（ローカルのGemfileは【３】で作成）
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# bundlerのバージョンを2系にする
ENV BUNDLER_VERSION='2.1.2'
RUN gem install bundler --no-document -v '2.1.2'

# Gemfileのbundle install
RUN bundle install
ADD . $APP_ROOT
