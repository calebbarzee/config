#!/bin/sh
    
# this isn't light weight on the installs
# TODO: make a less comprehensive minimal setup script

# get rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update

# install difftastic
# copy config for git, zsh, atuin

# install core CLI tools and neovim dependencies
sudo apt install \
zsh \
zsh-autosuggestions \
zsh-syntax-highlighting \
ripgrep \
fd-find \
bat \
git \
libtool \
libtool-bin \
autoconf \
automake \
cmake \
g++ \
pkg-config \
unzip \
netcat \
network-manager \
ffmpeg \
7zip \
jq \
poppler-utils \
fzf \
zoxide

echo "installing nerd font..."
mkdir -p ~/.local/share/fonts/NerdFonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip
unzip FiraCode.zip -d ~/.local/share/fonts/NerdFonts
rm FiraCode.zip
fc-cache -fv

echo "installing zsh-you-should-use..."
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ~/.config/zsh/zsh-you-should-use 
echo "copying config for zsh..."
cp -a ./zsh/. ~/.config/zsh/

echo "installing difftastic..."
curl -s https://api.github.com/repos/Wilfred/difftastic/releases/latest | \
grep "browser_download_url.*aarch64.*linux" | cut -d '"' -f 4 | wget -i -
tar -xzf difft-aarch64-unknown-linux-gnu.tar.gz && rm difft-aarch64-unknown-linux-gnu.tar.gz
sudo cp ./difft /usr/local/bin/difft && rm ./difft

echo "copying config for git..."
cp -a ./git/. ~/.config/git/

echo "installing zoxide..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

echo "installing atuin..."
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
echo "copying config for atuin..."
cp -a ./atuin/. ~/.config/atuin/
    
echo "installing yazi..."
# git clone https://github.com/sxyazi/yazi.git yazi_repo
# cd yazi_repo
# cargo build --release --locked
# copy target/release binary
# cd ..
# rm -r yazi_repo
curl -s https://api.github.com/repos/sxyazi/yazi/releases/latest | \
grep "browser_download_url.*aarch64.*linux.*gnu" | cut -d '"' -f 4 | wget -i -
unzip yazi-aarch64-unknown-linux-gnu.zip
cd yazi-aarch64-unknown-linux-gnu
sudo cp ya yazi /usr/local/bin/
cd ..
rm -rf yazi-aarch64-unknown-linux-gnu
echo "copying config for yazi..."
cp -a ./yazi/. ~/.config/yazi/

echo "installing starship..."
curl -sS https://starship.rs/install.sh | sh
cp ./starship.toml ~/.config/starship.toml

echo "installing neovim..."
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd ..
rm -rf neovim
echo "copying config for nvim..."
cp -a ./nvim/. ~/.config/nvim/
nvim
