# Steam Deck rEFInd Installer
Get a nice boot menu on your dual (or more) boot Steam Deck. This is mainly for me since I don't want to have to manually do this again. Feel free to use/modify if you find it helpful for you. Feel free to submit issues or pull requests or a message if something is weird or you need it more suited for your Distro, more than happy to help.

## Usage
1. Clone this Repo and CD into this folder.
2. Run Command: `sudo ./install.sh`
3. Reboot!

## Something to know.
I use Fedora, so you'll need to change the conf file if you aren't using it. 
Check the bottom of the refind.conf.deck file and you'll see the boot menu entries. Additionally, `refind_config_location` might need a different directory path. I'm unsure if Ubuntu/Debian/Arch/(Insert Distro Here) uses a different path, Fedora adds an `efi` folder inside the `efi` folder, others might not.
