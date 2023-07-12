# $b.LastPointCreationTime
# Returns date string: 04/12/2023 12:23:12

$culture = (Get-Culture)

IF($b.LastPointCreationTime -ne ''){
  $utc_string=([DateTime]::Parse($b.LastPointCreationTime,$culture).ToUniversalTime())
  $utc_epoch=((New-TimeSpan -Start (Get-Date "01/01/1970") -End $utc_string).TotalSeconds)
  
  # Add to $b as $b.LastPointCreationTimeUTC
  $b | Add-Member -Type NoteProperty -Name 'LastPointCreationTimeUTC' -Value $utc_epoch  
}
