# =================================================
# 定時処理の内容更新を反映(開発環境)
# bundle exec whenever --update-crontab
# 定時処理の内容更新を反映(本番環境)
# RAILS_ENV=production bundle exec whenever --update-crontab
# 無効化
# RAILS_ENV=production bundle exec whenever --clear-crontab
# 現在の設定内容確認
# crontab  -l
# ログはlog/cron.logを確認
# =================================================

#wheneverはバックグラウンドで処理されるものであるため、Railsとは関係のないプロセスである。
#よって、このファイルの中でRailsのメソッドを使いたい場合は下記の記述が必要である。
#つまりconfig/environment.rbを読み込んでいる
require File.expand_path(File.dirname(__FILE__) + "/environment")
# cronを実行する環境変数
# ENV['RAILS_ENV']で環境を判断し、何も入っていなければ入っていなければ：developmentをrails_envに代入
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"


#6時間に一度、data_resetメゾッドが実行される記述
#テストする際は下記を3.minuteとかに変えた方がいいかもしれません。
every 30.minute do
#every 6.hours do
  begin
    runner "DataGuest.data_reset"
  #エラーが出た場合、log/cron.logに書き出す
  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end
