# dotfiles
--------------------
Uses GNU Stow – https://www.gnu.org/software/stow/

Usage: 
```console
cd ~
git clone https://github.com/Sergushka/dotfiles.git
cd dotfiles
stow *
cat required.txt | xargs -I {} brew install "{}"
```

## Media server

See [media-server/README.md](media-server/README.md) for the pinned Docker Compose
stack, portable service preferences, and private backup/migration instructions.
The media server is a standalone project and is excluded from Stow.
