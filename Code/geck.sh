#!/bin/zsh

# Function to check if a command exists
command_exists() {
    command -v “$1” >/dev/null 2>&1
}

# Function to install Xcode developer tools
install_xcode_tools() {
    echo “Installing Xcode developer tools...”
    xcode-select --install
}

# Function to install Homebrew
install_homebrew() {
    echo “Installing Homebrew...”
    /bin/bash -c “$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)”
}

# Function to create a Launchd plist file
create_launchd_plist() {
    cat << EOF > ~/Library/LaunchAgents/com.user.update_and_install.plist
<?xml version=“1.0” encoding=“UTF-8”?>
<!DOCTYPE plist PUBLIC “-//Apple//DTD PLIST 1.0//EN” “http://www.apple.com/DTDs/PropertyList-1.0.dtd”>
<plist version=“1.0”>
<dict>
    <key>Label</key>
    <string>com.user.update_and_install</string>
    <key>Program</key>
    <string>/path/to/update_and_install.sh</string>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <false/>
</dict>
</plist>
EOF
}

# Function to load the Launchd plist
load_launchd_plist() {
    launchctl load ~/Library/LaunchAgents/com.user.update_and_install.plist
}

# Function to unload the Launchd plist
unload_launchd_plist() {
    launchctl unload ~/Library/LaunchAgents/com.user.update_and_install.plist
}

# Main function to perform updates and installations
main() {
    echo “Checking for available software updates...”
    sudo softwareupdate -l

    echo “Installing available software updates...”
    sudo softwareupdate -i -a

    # Check if a restart is required
    if [[ $(sudo softwareupdate -l | grep “restart”) ]]; then
        echo “A restart is required. Loading Launchd plist to resume after restart...”
        create_launchd_plist
        load_launchd_plist
        echo “Restarting...”
        sudo shutdown -r now
        exit 0
    fi

    # Check if Xcode developer tools are installed
    if ! command_exists xcode-select; then
        install_xcode_tools
    else
        echo “Xcode developer tools are already installed.”
    fi

    # Check if Homebrew is installed
    if ! command_exists brew; then
        install_homebrew
    else
        echo “Homebrew is already installed.”
    fi

    # Check if Terminal window should reopen
    if [[ -f ~/Library/LaunchAgents/com.user.update_and_install.plist ]]; then
        open -a Terminal
        unload_launchd_plist
        rm ~/Library/LaunchAgents/com.user.update_and_install.plist
    fi
}

# Run the main function
main
