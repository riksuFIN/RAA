##Console System.

This creates a fully-functional computer terminal/ console/ cmd -like console intended for:
- Highly immersive intel gathering from PC's.
- 'Hacking' into devices to override their functionality (electronic palm scanners on doors, for example)



###TODO LIST:
[] Add ability to add custom commands via function (for mission-side)
[] Add creating new files
[] Finish up sudo/ password challenge
[] Add physical items to tie console into
[] Add nano (or something similar) for opening text files
[] Add support for sound player
[] Add support for viewing pictures
- Multiplayer compatibility:
	[] Use QGVAR(reserved) when opening interface to restrict to only one client at time. No watching screen over shoulder!
	[] All data for each console object is stored on server, but whenever a client opens interface needed data is pulled from server. Upon closing interface all data is once again pushed to server.
		This ensures minimal unnecessary network traffic in MP and full JIP-compatibility.


