Param ([String]$file,
        [String]$positif,
        [String]$negatif, 
		[String]$blue)
$vide =""

if ( $file -eq $vide -or $positif -eq $vide -or $negatif -eq $vide  -or $blue -eq $vide ){
    Write-Host "erreur de parametre"
    Write-Host "utilisation : ./coloration.ps1 -file /path/to/file -positif /path/to/file/with/positive/word -negatif /path/to/file/with/negative/word -blue /path/to/file/with/blue/word "   
}
else{

$dir = Get-Location
   Write-Host $dir


foreach($line in Get-Content $positif) {
   
   Write-Host $line
   (gc -Encoding UTF8 $file) -creplace "$line\b" , "<span style=background-color:lime>$line</span>" | Out-File -encoding UTF8 $file
 
}

foreach($line in Get-Content $negatif) {
   
   Write-Host $line
   (gc -Encoding UTF8 $file) -creplace "$line\b" , "<span style=background-color:tomato>$line</span>" | Out-File -encoding UTF8 $file
 
}
foreach($line in Get-Content $blue) {
   
   Write-Host $line
   (gc -Encoding UTF8 $file) -creplace "$line\b"   , "<span style=color:blue>$line</span>" | Out-File -encoding UTF8 $file
 
}
}

 
 