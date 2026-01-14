## Bootstrapping Home Manager
If you clone this repo on a fresh-ish (`aarch64-darwin`) machine, follow these steps to set up Home Manager (HM).

1. Open a Terminal window, which will need to use `zsh` since `fish` is installed through HM
1. If install is not fresh, clean up leftover bits
  1. Delete the `_nixbld` group via **Users & Groups** in **System Settings**
  1. Delete all the `_nixbld$i` users via `for i in {1..32}; do sudo dscl . delete /Users/_nixbld$i; done;`
  1. Clear the cache via `rm -rf ~/.cache/nix`
1. [Install Nix](https://nixos.org/download/)
2. Add `experimental-features = nix-command flakes` to `/etc/nix/nix.conf`
2. Run `nix shell github:nix-community/home-manager/`
1. Change to this directory and run `home-manager switch`
1. If the above finishes successfully, test that everything's set up by opening a new Terminal window and seeing if i.e. `fish` is installed. 
