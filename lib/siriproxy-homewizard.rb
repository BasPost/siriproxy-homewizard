require 'cora'
require 'siri_objects'
require 'pp'
require 'open-uri'

########################################################
# HomeWizard Voice Control plugin for Siri Proxy
# Version: 0.0.8
# By: BasPost
#
# Remember to add this plugin to the "config.yml" file!
########################################################

class SiriProxy::Plugin::HomeWizard < SiriProxy::Plugin
  def initialize(config)
    @url = "http://" + config['host'] + "/" + config['password'] + "/"
    
    # ID's van HomeWizard via "get-sensors" command
    # Switches:
    # ID  0 = "wk lamp kast"      dim: nee
    # ID  1 = "wk sfeerlampen"    dim: ja
    # ID  2 = 
    # ID  3 = "kantoor lamp"      dim: ja
    # ID  4 = "keuken spots"      dim: ja
    # ID  5 = "gang lamp"         dim: nee
    # ID  6 = "kantoor spots"     dim: ja
    # ID  7 = "overloop"          dim: nee
    # ID  8 = "keuken achter"     dim: ja
    # ID  9 = "wk spots links"    dim: ja
    # ID 10 = "wk spots achter"   dim: ja
    # 
    # Scenes:
    # ID  0 = "sfeerlicht auto"
    # ID  1 = "sfeer handmatig"
    # ID  2 = "alarm"
    # ID  3 = "werkdagen"
    # ID  4 = "afwezig"
    # ID  5 = "woonkamer aan"
     
    @switches =  {'living lamp' => '0','living lights' => '1','office desk' => '3','kitchen lights' => '4','hal' => '5','office lights' => '6', 'upstairs' => '7', 'backdoor' => '8', 'living left' => '9', 'living right' => '10'}
    @scenes = {'living room' => '5'}
        
    @responses = [ "One moment.", "Your wish is my command.", "Just a second.", "OK.", "No problem.", "Hold on a second.", "Fine with me.", "Give me a second." ]
      
  end

  # Test if the HomeWizard pugin for Siri Proxy is working
  listen_for /test HomeWizard/i do
    say "HomeWizard plugin for Siri Proxy is up and running!"
    request_completed
  end

  # Turn on/off a device scenario A
  listen_for /(on|off).*(living lamp|living lights|office desk|kitchen lights|hal|office lights|upstairs|backdoor|living left|living right)/i do |cmd, src|
    kaku_switch(src,cmd)
  end

  # Turn on/off a device scenario B
  listen_for /(living lamp|living lights|office desk|kitchen lights|hal|office lights|upstairs|backdoor|living left|living right).*(on|off)/i do |src, cmd|
    kaku_switch(src,cmd)
  end

  # Dim a device scenario A
  listen_for /(dim).*(living lights|office desk|kitchen lights|office lights|backdoor|living left|living right).*([0-9,].*[0-9])/i do |cmd, src, lvl|
    kaku_switch(src,lvl)
  end

  # Dim a device scenario B
  listen_for /(living lights|office desk|kitchen lights|office lights|backdoor|living left|living right).*([0-9,].*[0-9])/i do |src, lvl|
    kaku_switch(src,lvl)
  end

  # Turn on/off a scene scenario A
  listen_for /(on|off).*(alarm|living room)/i do |cmd, src|
    kaku_scene(src,cmd)
  end

  # Turn on/off a scene scenario B
  listen_for /(alarm|living room).*(on|off)/i do |src, cmd|
    kaku_scene(src,cmd)
  end

  def kaku_switch(switch, command)
    begin
      case command
        when "on"
          signal = "on"
          path = 'sw/'
          say "Turning on your " + switch + " light.", spoken: @responses[rand(@responses.size)]
        when "off"
          signal = "off"
          path = "sw/"
          say "Turning off your " + switch + " light.", spoken: @responses[rand(@responses.size)]
        else
          signal = command
          path = "sw/dim/"
          say "Dimming your " + switch + " light to " + command + "%", spoken: @responses[rand(@responses.size)]
        end
      open(@url + path + @switches[switch] + '/' + signal)
      request_completed
    rescue Exception => e
      say e.to_s, spoken: "Uh oh! Something bad happened..."
      request_completed
    end
  end

  def kaku_scene(scene, command)
    begin
      case command
        when "on"
          signal = "on"
          say "Turning on your " + scene + " scene.", spoken: @responses[rand(@responses.size)]
        when "off"
          signal = "off"
          say "Turning off your " + scene + " scene.", spoken: @responses[rand(@responses.size)]
        else
          say "Sorry I didn't get that, could you repeat that?"
        end
      open(@url + 'gp/' + @scenes[scene] + '/' + signal)
      request_completed
    rescue Exception => e
      say e.to_s, spoken: "Uh oh! Something bad happened..."
      request_completed
    end
  end

end
