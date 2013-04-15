siriproxy-homewizard
====================

This is a simple plugin for SiriProxy to voice command a HomeWizard system.
It's in a very very early stage!

For now you can only turn on and off kaku (click on, click off) switches and scenes.



Setup
-----

Edit the SiriProxy config file (`~/.siriproxy/config.yml`) so that it contains the following lines:

	- name: 'siriproxy-homewizard'
	  git: 'git://github.com/baspost/siriproxy-homewizard.git'
	  host: 'xxx.xxx.xxx.xxx'
	  password: '.....'

You have to change the switches names and id's for your situation in the file (`~/lib/siriproxy-homewizard`)
The id's you can get using the 'get-sensors' command by opening the following url in your favorite browser:
(`http://<homewizard's ip adress>/<homewizard's password>/get-sensors`)


Usage
-----
Turn on/off kaku switches by saying:
* Turn 'on' 'desk lamp'
* Please turn 'on' the 'kitchen lights'
* Siri, could you please turn 'off' the 'office light'?
* 'desk lamp' 'off'

Turn on/off kaku scenes by saying:
* Turn 'on' the 'living room'
* Siri, turn 'on' the 'alarm' lights
* 'living room' 'off'

Dim a device by saying:
* Dim the living lights to 50%
* Set the desktop lamp at 50

Note:
The plugin uses keywords which are marked with '' So it doesn't mather in what order you say it.
The keywords are the names you used in the HomeWizard and filled in the file (`~/lib/siriproxy-homewizard`)
and matches it's ID


Licensing
---------
* 0.0.5 - Initial Release
* 0.0.6 - added "dim" command, first test

Copyright (c) 2013, Bas Post
