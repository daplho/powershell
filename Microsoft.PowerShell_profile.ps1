# https://github.com/JanDeDobbeleer/oh-my-posh
$ProfilePath = Split-Path $PROFILE -Parent
oh-my-posh init pwsh --config "$ProfilePath\oh-my-posh-themes\powerline-custom-git.omp.json" | Invoke-Expression

# https://github.com/dahlbyk/posh-git
import-module posh-git

# https://github.com/PowerShell/PSReadLine
Import-Module PSReadLine

# Searching for commands with up/down arrow.
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Sometimes you enter a command but realize you forgot to do something else first.
# This binding will let you save that command in the history so you can recall it,
# but it doesn't actually execute. It also clears the line with RevertLine so the
# undo stack is reset - though redo will still reconstruct the command line.

set-psreadlinekeyhandler -key alt+w `
                         -briefdescription SaveInHistory `
			 -longdescription "Save current line in history but do not execute" `
			 -scriptblock {
  param($key, $arg)
  $line = $null
  $cursor = $null
  [microsoft.powershell.psconsolereadline]::getbufferstate([ref]$line, [ref]$cursor)
  [microsoft.powershell.psconsolereadline]::addtohistory($line)
  [microsoft.powershell.psconsolereadline]::revertline()
}

# Insert text from the clipboard as a string
Set-PSReadLineKeyHandler -Key Ctrl+V `
                         -BriefDescription PasteAsString `
			 -LongDescription "Paste the clipboard text as a string" `
			 -ScriptBlock {
  param($key, $arg)

  Add-Type -Assembly PresentationCore
  if ([System.Windows.Clipboard]::ContainsText())
  {
    # Get clipboard text - remove trailing spaces, convert \r\n to \n, and remove the final \n.
    $text = ([System.Windows.Clipboard]::GetText() -replace "\p{Zs}*`r?`n","`n").TrimEnd()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("@'`n$text`n'@")
  }
  else
  {
    [Microsoft.PowerShell.PSConsoleReadLine]::Ding()
  }
}

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# https://github.com/badmotorfinger/z
Import-Module z

# Aliases
Set-Alias -Name cd -Value pushd -Option AllScope

Function GitAdd {git add -p}
Set-Alias -Name ga -Value GitAdd

Function GitStatus {git status}
Set-Alias -Name gs -Value GitStatus

# Path
$env:PATH += ";C:\Program Files\Vim\vim90"
$env:PATH += ";C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin"
$env:PATH += ";C:\Users\nikokirov\.dotnet\Microsoft.Net.Compilers.4.2.0\tools"
$env:PATH += ";C:\Users\nikokirov\.dotnet\nuget"
