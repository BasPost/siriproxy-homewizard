siriproxy-homewizard
====================

This is a simple plugin for SiriProxy to voice command a HomeWizard system.
It's in a very very early stage!
It is based on and inspired by the LightManger plugin by Joep Verhaeg
(`https://github.com/joepv/SiriProxy-LightManager`)


Setup
-----

Edit the SiriProxy config file (`~/.siriproxy/config.yml`) so that it contains the following lines:

	- name: 'siriproxy-homewizard'
	  git: 'git://github.com/baspost/siriproxy-homewizard.git'
	  host: 'xxx.xxx.xxx.xxx'
	  password: '.....'

You have to change the switches and scene names and id's for your situation in the file (`~/lib/siriproxy-homewizard`)
The id's you can get using the 'get-sensors' command by opening the following url in your favorite browser:
(`http://<homewizard's ip adress>/<homewizard's password>/get-sensors`)


Usage
-----
Turn on/off kaku switches by saying:
* Turn 'on' 'desk lamp'
* Please turn 'on' the 'kitchen lights'
* Siri, could you please turn 'off' the 'office light'?
* 'desk lamp' 'off'

Dim a kaku switch by saying:
* Dim the living lights to 50%
* Set the desktop lamp at 50

Turn on/off kaku scenes by saying:
* Turn 'on' the 'living room'
* Siri, turn 'on' the 'alarm' lights
* 'living room' 'off'

Note:
The plugin uses keywords which are marked with '..' So it doesn't mather in what order you say it.
The keywords are the names you used in the HomeWizard and used in the file (`~/lib/siriproxy-homewizard`)
and matches it's ID


Version History
---------
* 0.0.5 - Initial Release
* 0.0.6 - added "dim" command, first test
* 0.0.8 - New cleaner code


Future
------
* use JSON to automatic get sensor-id's and status of sensors
* If you use HomeWizard compatible Cresta Weather Station sensors , ask siri for the current values
  example: "Siri, what is the current outside temperature?" or "What is the current windspeed?"
Copyright (c) 2013, Bas Post
