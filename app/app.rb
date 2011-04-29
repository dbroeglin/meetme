class Meetme < Padrino::Application
  register Padrino::Mailer
  register Padrino::Helpers
  register Sinatra::Asterisk

  ##
  # Application configuration options
  #
  # set :raise_errors, true     # Show exceptions (default for development)
  # set :public, "foo/bar"      # Location for static assets (default root/public)
  # set :reload, false          # Reload application files (default in development)
  # set :default_builder, "foo" # Set a custom form builder (default 'StandardFormBuilder')
  # set :locale_path, "bar"     # Set path for I18n translations (defaults to app/locale/)
  # enable  :sessions           # Disabled by default
  # disable :flash              # Disables rack-flash (enabled by default if sessions)
  # layout  :my_layout          # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
  #

  ##
  # You can configure for a specified environment like:
  #
  #   configure :development do
  #     set :foo, :bar
  #     disable :asset_stamp # no asset timestamping for dev
  #   end
  #

  connect_to_manager "127.0.0.1", "meetme", "meetmetest"
  start_agi_server

  cmd = "dialplan add extension meetme,1,Agi,agi://localhost:4573/meetme into default replace"
  action = org.asteriskjava.manager.action.CommandAction::new(cmd)
  puts manager.sendAction(action).result.join("\n")

  get '/' do
    render 'conferences/index' 
  end


  agi /.*/ do
      puts "===== Called #{request}"
      channel.answer
      channel.exec "Wait", "1"
      conf = nil
      while conf.nil? 
        number = channel.getData("en_US_f_Allison/conf-getconfno")
        conf   = Conference.first(:number => number)
        channel.streamFile "en_US_f_Allison/conf-invalid" if conf.nil?
      end
      channel.exec "Authenticate", "#{conf.pin},,#{conf.pin..to_s.length}"
      channel.exec "Meetme", "#{number},d"
      channel.hangup
  end

  on_event do
    puts "EVENT: " + event.inspect
  end

  ##
  # You can manage errors like:
  #
  #   error 404 do
  #     render 'errors/404'
  #   end
  #
end
