# The main purpose of this script is to dynamically take in a drive value for SQL installation.  It will ask you which drive you want use
# as the main drive.

$NewDriveLetter = Read-Host 'What Drive Letter for SQL Installation?'

$NewDriveLetter2 = $NewDriveLetter.Trim(":\")

$NewDriveLetter2

#(Get-Content -Path "C:\Users\Diego\Desktop\changeletter.txt").Replace("R:\", $NewDriveLetter + ":\") | Set-Content "C:\Users\Diego\Desktop\changeletter.txt"

# For Installations using C: Drive
If (((Get-Content C:\Users\Diego\Desktop\changeletter.txt) | Select-String 'C:\\' -Quiet) -eq $true){
    (Get-Content -Path "C:\Users\Diego\Desktop\changeletter.txt").Replace("C:\", $NewDriveLetter2 + ":\") | Set-Content "C:\Users\Diego\Desktop\changeletter.txt"
}

# For Installations using D: Drive
If (((Get-Content C:\Users\Diego\Desktop\changeletter.txt) | Select-String 'D:\\' -Quiet) -eq $true){
    (Get-Content -Path "C:\Users\Diego\Desktop\changeletter.txt").Replace("D:\", $NewDriveLetter2 + ":\") | Set-Content "C:\Users\Diego\Desktop\changeletter.txt"
}
# For Installations using E: Drive
If (((Get-Content C:\Users\Diego\Desktop\changeletter.txt) | Select-String 'E:\\' -Quiet) -eq $true){
    (Get-Content -Path "C:\Users\Diego\Desktop\changeletter.txt").Replace("E:\", $NewDriveLetter2 + ":\") | Set-Content "C:\Users\Diego\Desktop\changeletter.txt"
}

# For Installations using R: Drive
If (((Get-Content C:\Users\Diego\Desktop\changeletter.txt) | Select-String 'R:\\' -Quiet) -eq $true){
    (Get-Content -Path "C:\Users\Diego\Desktop\changeletter.txt").Replace("R:\", $NewDriveLetter2 + ":\") | Set-Content "C:\Users\Diego\Desktop\changeletter.txt"
}

# For Installations using S: Drive
If (((Get-Content C:\Users\Diego\Desktop\changeletter.txt) | Select-String 'S:\\' -Quiet) -eq $true){
    (Get-Content -Path "C:\Users\Diego\Desktop\changeletter.txt").Replace("S:\", $NewDriveLetter2 + ":\") | Set-Content "C:\Users\Diego\Desktop\changeletter.txt"
}

# For Installations using T: Drive
If (((Get-Content C:\Users\Diego\Desktop\changeletter.txt) | Select-String 'T:\\' -Quiet) -eq $true){
    (Get-Content -Path "C:\Users\Diego\Desktop\changeletter.txt").Replace("T:\", $NewDriveLetter2 + ":\") | Set-Content "C:\Users\Diego\Desktop\changeletter.txt"
}

# For Installations using U: Drive
If (((Get-Content C:\Users\Diego\Desktop\changeletter.txt) | Select-String 'U:\\' -Quiet) -eq $true){
    (Get-Content -Path "C:\Users\Diego\Desktop\changeletter.txt").Replace("U:\", $NewDriveLetter2 + ":\") | Set-Content "C:\Users\Diego\Desktop\changeletter.txt"
}
