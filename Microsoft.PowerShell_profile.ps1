oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerline.omp.json" | Invoke-Expression

# https://github.com/PowerShell/PSReadLine
Import-Module PSReadLine

# Searching for commands with up/down arrow.
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

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
