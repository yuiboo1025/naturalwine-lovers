# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + "/environment")
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

#30分に一度、data_resetメゾッドが実行される記述
#テストする際は下記を3.minuteとかに変えた方がいいかもしれません。
every 30.minute do
  begin
    runner "Guestuser::DataGuest.data_reset"
  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end
