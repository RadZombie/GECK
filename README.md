# GECK
![image](https://github.com/RadZombie/GECK/assets/2079297/b70508cb-68e7-4b24-ba61-42ed9a2a95b2)

>_"There is hope, however. A slim hope that few know of. The old disks speak of an item called the Garden of Eden Creation Kit. It is said that it can bring life to the wasteland."_
>
>\- Arroyo Elder, Mother of the Chosen One

Tool to set up new macOS devices.

##v .1
###Intent: to set up new _personal_ macOS devices with minimal interaction by the user.
###Process/User Experience:
1. User runs `curl thregan.com/geck | zsh ` to download the main script and run it. User interaction ends. Script execution begins and performs the following:
2. Install any and all  software updates. If a restart is necessary, the terminal will re-open and resume running the script after the install.
3. Install Xcode developer tools.
5. Install all brews/casks from brewfile manifest.
6. Download and set .zshprofile file.
7. Install latest version of python via pyenv.
8. Install all apps from Mac App Store from mac_app_store manifest file.
9. Install autokpkg.
10. Install all items in autopkg recipes list manifest.

Speedbumps to consider:
- macOS Gatekeeper app authorization for apps downloaded from ther Internet.
- Some installation steps will require the terminal session to be restarted. How can the script resume automatically where it left off and continue printing progress messages in the terminal.
