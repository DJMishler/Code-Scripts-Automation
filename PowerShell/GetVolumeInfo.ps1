Get-WmiObject -Class Win32_Volume -Filter 'DriveType = 3' | 
FT Name, @{n='Capacity';e={$_.Capacity/1GB}; FormatString='N2'}, Freespace