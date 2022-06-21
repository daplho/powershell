# Setup:

1. Install 'App Installer' from Win Store (this will setup 'winget').
2. Install 'WindowsTerminal.Preview' using 'winget'
3. Install 'vim.vim' using 'winget'
4. Install 'Microsoft.PowerShell' using 'winget'
5. Update ExecutionPolicy (needed for 'PowerShellGet' installs):
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```
6. Clone this repo ('powershell') from github into the same directory as $PROFILE
7. Install [oh-my-posh](https://github.com/JanDeDobbeleer/oh-my-posh)
8. Install CascadiaCode Nerd Font
```
oh-my-posh font install
[select CascadiaCode]
```
9. Install [posh-git](https://github.com/dahlbyk/posh-git)
10. Upgrade [PSReadLine](https://github.com/PowerShell/PSReadLine#upgrading)
11. Install [z](https://github.com/badmotorfinger/z)
