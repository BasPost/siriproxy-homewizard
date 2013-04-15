require 'cora'
require 'siri_objects'
require 'pp'
require 'open-uri'

########################################################
# HomeWizard Voice Control plugin for Siri Proxy
# Version: 0.0.5
# By: BasPost
#
# Remember to add this plugin to the "config.yml" file!
########################################################

class SiriProxy::Plugin::HomeWizard < SiriProxy::Plugin
  def initialize(config)
    @url = "http://" + config['host'] + "/" + config['password'] + "/"
    
    # ID's van HomeWizard via "get-sensors" command
    # Switches:
    # ID  0 = "wk lamp kast"
    # ID  1 = "wk sfeerlampen"
    # ID  2 = 
    # ID  3 = "kantoor lamp"
    # ID  4 = "keuken spots"
    # ID  5 = "gang lamp"
    # ID  6 = "kantoor spots"
    # ID  7 = "overloop"
    # ID  8 = "keuken achter"
    # ID  9 = "wk spots links"
    # ID 10 = "wk spots achter"
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
  listen_for /(on|off).*(living lamp|living lights|office desklamp|kitchen lights|hal|office lights|upstairs|backdoor|living left|living right)/i do |action, switch|
    kaku_switch(action,switch)
  end

  # Turn on/off a device scenario B
  listen_for /(living lamp|living lights|office desklamp|kitchen lights|hal|office lights|upstairs|backdoor|living left|living right).*(on|off)/i do |switch, action|
    kaku_switch(action,switch)
  end

  # Turn on/off a scene scenario A
  listen_for /(on|off).*(alarm|living room)/i do |action, scene|
    kaku_scene(scene)
  end

  # Turn on/off a scene scenario B
  listen_for /(alarm|living room).*(on|off)/i do |scene, action|
    kaku_scene(scene)
  end

  def kaku_switch(action, switch)
    begin
      if action == "on"
         command = "on"
         say "Ok, I turned on the " + switch + " light" 
      elsif action == "off"
         command = "off"
         say "The " + switch + " is turned off"
      else
        say "Sorry I didn't get that, on or off?"
      end
      open(@url + 'sw/' + @switches[switch] + '/' + command)
      request_completed
    end
  end

  def kaku_scene(scene)
    begin
      if action == "on"
         command = "on"
         say "Ok, I turned on the " + scene + " scene" 
      elsif action == "off"
         command = "off"
         say "The scene " + scene + " is turned off"
      else
         say "Sorry I didn't get that, on or off?"
      end
      open(@url + 'gp/' + @scenes[scene] + '/' + command)
      request_completed
    end
  end

end
