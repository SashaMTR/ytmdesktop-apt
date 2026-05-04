# ytmdesktop-apt

APT repository for [YTMDesktop](https://github.com/ytmdesktop/ytmdesktop) — a desktop app for YouTube Music.

> This repo does not claim ownership over the `.deb` files. It simply repackages the official GitHub releases as an APT repository.

## Install

```bash
# 1. Add GPG key
wget -qO- https://SashaMTR.github.io/ytmdesktop-apt/ytmdesktop-apt.gpg | sudo tee /etc/apt/keyrings/ytmdesktop.gpg > /dev/null

# 2. Add repository
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/ytmdesktop.gpg] https://SashaMTR.github.io/ytmdesktop-apt/debian ./" | sudo tee /etc/apt/sources.list.d/ytmdesktop.list

# 3. Install
sudo apt update && sudo apt install youtube-music-desktop-app
```

## Update

Updates automatically via `apt upgrade` once the daily GitHub Actions job picks up a new release.

## How it works

- A GitHub Actions workflow runs daily and checks for new releases on [ytmdesktop/ytmdesktop](https://github.com/ytmdesktop/ytmdesktop/releases)
- If a new `.deb` is found, it downloads it and rebuilds the APT repo metadata
- GitHub Pages serves the repo at `https://SashaMTR.github.io/ytmdesktop-apt/`
