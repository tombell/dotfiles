# dotfiles

These are my dotfiles for macOS (and Linux).

## Setup

1. Install [Homebrew](https://brew.sh/) with `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
2. Install [1Password](https://1password.com/) with `brew install 1password`
3. Open and log into **Tom Bell** account in 1Password
4. Save SSH key to `.ssh` directory
5. Check the SSH key works with `ssh git@github.com`
6. Clone the dotfiles repository with `git clone git@github.com:tombell/dotfiles.git .dotfiles`
7. Run the `install` script with `./install`

## Follow Up Setup

These are things I like to setup and configure that I haven't automated yet.

- Enable or disable **Bluetooth** depending on machine
- Disable notifications (and **Play sound for notification**) for certain applications
- Add `~/Downloads` and `~/Code` to directories for **Spotlight** to ignore
- Turn off the following search results for **Spotlight**
    * Documents
    * Folders
    * Fonts
    * Images
    * Movies
    * Music
    * Other
    * PDF Documents
    * Presentations
    * Siri Suggestions
    * Spreadsheets
    * Tips
    * Websites
- Add **Terminal** and **Alacritty** to **Full Disk Access** and **Developer Tools** in **Privacy and Security**
- Update Display size to **More Space**
- Update *Start Screen Saver when inactive* to **Never**
- Update *Require password after screen saver begins or display is turned off* to **Immediately**
