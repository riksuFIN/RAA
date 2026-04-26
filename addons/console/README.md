## Console System.

This creates a fully-functional computer terminal/ console/ cmd -like console intended for:
- Highly immersive intel gathering from PC's.
- 'Hacking' into devices to override their functionality (electronic palm scanners on doors, for example)



### TODO LIST:
- [ ] Add ability to add custom commands via function (for mission maker to create mission-specific commands like "open [door]")
- [x] Finish up sudo/ password challenge
- [ ] Add a laptop (physical item) to use console with
- [ ] Enable carrying laptop
- [x] Add cat (or something similar) for opening text files
- [ ] Add command to create a text file (touch and/ or parameter for cat)
- [ ] Add command for sound player
- [ ] Add command for viewing pictures
- [ ] Add command to view videos
- [ ] Add command for moving files within file system
- [ ] Add command chmod to make files executeable. Allows running script files stored inside console's filesystem in actual game.
	- [ ] Think about security, especially in MP. Is it smart to let users execute any random files...
- [ ] Add command for triggering (pre-defined?) scripts. Different from above, since it only runs scripts defined by mission maker.
	Still risky? Propably less risky though..
- [ ] Add item: USB stick (storage). For saving and transporting files from one device to another
	How to figure out which USB stick in player's inventory contains what data?

Multiplayer compatibility:
- [x] Use QGVAR(reserved) when opening interface to restrict to only one client at time. No watching screen over shoulder!
	This greatly simplifies data sync between clients
- [x] All data for each console object is stored on server, but whenever a client opens interface needed data is pulled from server. Upon closing interface all data is once again pushed to server.
	This ensures minimal unnecessary network traffic in MP and full JIP-compatibility.

Long-term plans:
- [ ] Add a "normal screen" for device, like palm scanner or door entry keypad with hidden button/ push combination to access console
	- [ ] Access console: With hidden key combination
	- [ ] Access console: By inserting a "USB stick (console)" to USB slot on device
		- [ ] Add "USB stick (console)" as physical inventory item


