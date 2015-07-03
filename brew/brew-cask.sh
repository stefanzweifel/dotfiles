# Install Brew Cask
install caskroom/cask/brew-brew cask
tap caskroom/versions

# daily
brew cask install alfred
brew cask install bartender
brew cask install onepassword
brew cask install rescuetime
brew cask install dropbox
brew cask install mou
brew cask install vlc
brew cask install the-unarchiver
brew cask install spotify
brew cask install caffeine
brew cask install flux
brew cask install spectacle # window management

# Quick Look plugins
brew cask install qlcolorcode
brew cask install qlstephen
brew cask install qlmarkdown
brew cask install quicklook-json
brew cask install quicklook-csv
brew cask install betterzipql
brew cask install webp-quicklook

# Dev Apps
# cask install skype
brew cask install slack
brew cask install iterm2
brew cask install sequel-pro
brew cask install tower
brew cask install forklift
brew cask install dash
# brew cask install mysqlworkbench
brew cask install imageoptim
brew cask install licecap

brew cask install virtualbox
brew cask install vagrant
brew cask install vagrant-manager

# Browser
brew cask install google-chrome
brew cask install google-chrome-canary

# Editors
# brew cask install atom
brew cask install sublime-text

# Design stuff
brew cask install sketch
brew cask install sketch-toolbox

# Misc
brew cask install liteicon
brew cask install keepingyouawake

# link dir into Alfred
brew cask alfred link

# cleanup
brew cask cleanup
