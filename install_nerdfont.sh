echo "installing nerd font..."
mkdir -p ~/.local/share/fonts/NerdFonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip
unzip FiraCode.zip -d ~/.local/share/fonts/NerdFonts
rm FiraCode.zip
fc-cache -fv
