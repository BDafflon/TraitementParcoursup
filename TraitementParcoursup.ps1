				
Param ([String]$listing,
		[String]$inputfolder,
		[Int]$limit,
		[String]$outputfolder)
		
$vide =""

if ($listing -eq $vide -or $inputfolder -eq $vide -or $output -eq $vide -or $limit -eq 0){
    Write-Host "erreur de parametre"
    Write-Host "utilisation : TraitementParcoursup.ps1 -listing /path/to/students/folder -folder /path/to/Input/folder -output /path/to/output/folder -limit limit"   
}
else{

Write-Host "Start"

$txt="numero;accepter;motif;";
$cpt=0;
$foldername=-join ((48..57) + (97..122) | Get-Random -Count 10 | % {[char]$_})

New-Item -ItemType directory -Force -Path "$outputfolder/$foldername"
New-Item -ItemType directory -Force -Path "$outputfolder/$foldername/dossier"

foreach($line in Get-Content $listing) {
Write-Host "$line"
    if($cpt -gt $limit){

		
		$MonFichier = New-Item -type file "$outputfolder/$foldername/data.csv" -Force
		add-content $MonFichier $txt
		
		Copy-Item -Path "./dep/data2.html" -Destination "$outputfolder/$foldername/"
		Copy-Item -Path "./dep/recrutement.js" -Destination "$outputfolder/$foldername/"
		Compress-Archive -Path "$outputfolder/$foldername/" -DestinationPath "$outputfolder/$foldername.zip"
		
		$foldername =-join ((65..90) + (97..122) | Get-Random -Count 10 | % {[char]$_})
		New-Item -ItemType directory -Force -Path "$outputfolder/$foldername"
		New-Item -ItemType directory -Force -Path "$outputfolder/$foldername/dossier"
			
		$cpt=0

		$txt="numero;accepter;motif;";
		If ((Test-Path "$inputfolder/dossiers_0691860X_Géniemécaniqueetproductique-$line-N$line.pdf") -eq $True) {
			$txt="$txt`n$line;;;"
			$cpt=$cpt+1
			Copy-Item -Path "$inputfolder/dossiers_0691860X_Géniemécaniqueetproductique-$line-N$line.pdf" -Destination "$outputfolder/$foldername/dossier"
			
			.\pdf2htmlEX.exe "$outputfolder/$foldername/dossier/dossiers_0691860X_Géniemécaniqueetproductique-$line-N$line.pdf" "$outputfolder/$foldername/dossier/dossiers_0691860X_Géniemécaniqueetproductique-$line-N$line.html"
			.\dep\coloration\coloration3c.ps1 -file "$outputfolder/$foldername/dossier/dossiers_0691860X_Géniemécaniqueetproductique-$line-N$line.html"  -negatif .\coloration\negatif.txt -positif .\coloration\positif.txt -blue .\coloration\blue.txt
	
		}
		
	}
	else{
	
			Write-Host "$inputfolder/dossiers_0691860X_Géniemécaniqueetproductique-$line-N$line.pdf"
			
		If ((Test-Path "$inputfolder/dossiers_0691860X_Géniemécaniqueetproductique-$line-N$line.pdf") -eq $True) {
			$txt="$txt`n$line;;;"
			$cpt=$cpt+1
			Copy-Item -Path "$inputfolder/dossiers_0691860X_Géniemécaniqueetproductique-$line-N$line.pdf" -Destination "$outputfolder/$foldername/dossier"
			
			.\pdf2htmlEX.exe "$outputfolder/$foldername/dossier/dossiers_0691860X_Géniemécaniqueetproductique-$line-N$line.pdf" "$outputfolder/$foldername/dossier/dossiers_0691860X_Géniemécaniqueetproductique-$line-N$line.html"
			.\dep\coloration\coloration3c.ps1 -file "$outputfolder/$foldername/dossier/dossiers_0691860X_Géniemécaniqueetproductique-$line-N$line.html"  -negatif .\coloration\negatif.txt -positif .\coloration\positif.txt -blue .\coloration\blue.txt
			Remove-Item -Path "$outputfolder/$foldername/dossier/dossiers_0691860X_Géniemécaniqueetproductique-$line-N$line.pdf" -Force
		}
		else{
		Write-Host "dossier introuvacle"
		}
	}
	
	
	}
	$MonFichier = New-Item -type file "$outputfolder/$foldername/data.csv" -Force
	add-content $MonFichier $txt
	Copy-Item -Path "./dep/data2.html" -Destination "$outputfolder/$foldername/"
	Copy-Item -Path "./dep/recrutement.js" -Destination "$outputfolder/$foldername/"
		
}
		
		
		
 
