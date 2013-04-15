require 'cora'
require 'siri_objects'
require 'pp'
require 'open-uri'

########################################################
# HomeWizard Voice Control plugin for Siri Proxy
# Version: 0.0.6
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
      
  end

  # Test if the HomeWizard pugin for Siri Proxy is working
  listen_for /test HomeWizard/i do
    say "HomeWizard plugin for Siri Proxy is up and running!"
    request_completed
  end

  # Turn on/off a device scenario A
  listen_for /(on|off).*(living lamp|living lights|office desk|kitchen lights|hal|office lights|upstairs|backdoor|living left|living right)/i do |action, switch|
    kaku_switch(action, switch)
  end

  # Turn on/off a device scenario B
  listen_for /(living lamp|living lights|office desk|kitchen lights|hal|office lights|upstairs|backdoor|living left|living right).*(on|off)/i do |switch, action|
    kaku_switch(action, switch)
  end

  # Turn on/off a scene scenario A
  listen_for /(on|off).*(alarm|living room)/i do |action, scene|
    kaku_scene(action, scene)
  end

  # Turn on/off a scene scenario B
  listen_for /(alarm|living room).*(on|off)/i do |scene, action|
    kaku_scene(action, scene)
  end

  # Dim a device scenario A
  listen_for /(dim|set).*(living lights|office desk|kitchen lights|office lights|backdoor|living left|living right).*([0-9,].*[0-9])/i do |action, switch, dimlevel|
    kaku_switch_dim(action, switch, dimlevel)
  end

  def kaku_switch(action, switch)
    begin
      if action == "on" then
         command = "on"
         say "Ok, I turned on the " + switch + " light" 
      elsif action == "off" then
         command = "off"
         say "The " + switch + " is turned off"
      else
        say "Sorry I didn't get that, on or off?"
      end
      open(@url + 'sw/' + @switches[switch] + '/' + command)
      request_completed
    end
  end

  def kaku_scene(action, scene)
    begin
      if action == "on" then
         command = "on"
         say "Ok, I turned on the " + scene + " scene" 
      elsif action == "off" then
         command = "off"
         say "The scene " + scene + " is turned off"
      else
         say "Sorry I didn't get that, on or off?"
      end
      open(@url + 'gp/' + @scenes[scene] + '/' + command)
      request_completed
    end
  end

  def kaku_switch_dim(action, switch, dimlevel)
    begin
      if action == "dim" then
         command = dimlevel
         say "I will dim the " + switch + " to" + dimlevel
      elsif action == "set" then
         command = dimlevel
         say "I will set the " + switch + " to" + dimlevel
      else
        say "Sorry I didn't get that, on or off?"
      end
      open(@url + 'sw/dim/' + @switches[switch] + '/' + dimlevel)
      request_completed
    end
  end

end
