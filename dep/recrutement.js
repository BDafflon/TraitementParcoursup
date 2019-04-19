  

 

var listeCandidat=[];
var lecteur="";
function nextCandidat(){
console.log(listeCandidat);

for (var i = 0; i < listeCandidat.length; i++) {
    var counter = listeCandidat[i];
	console.log("Candidat "+counter);
    if(counter.accepter=="" ){
		if(counter.numero==""){
			introuvable(counter.numero)
		}else{
    	document.getElementById("A2").value =counter.numero ;
    	document.getElementById('iframecontent').src = "./dossier/dossiers_0691860X_Géniemécaniqueetproductique-"+counter.numero+"-N"+counter.numero+".html"
		document.getElementById('bar').value = document.getElementById('bar').value +1;
		
    	return;
		}
    	}
}
alert("FINI");
finish("resultat"+lecteur,listeCandidat);
}

function introuvable(num){
	for (var i = 0; i < listeCandidat.length; i++) {
    var counter = listeCandidat[i];
    console.log("C"+counter);
    if(counter.numero==num){
    	listeCandidat[i].accepter="INTROUVABLE";
    	next();
    	return;
    	}
}
}


function load(){
file= "data.csv";
var xhr = new XMLHttpRequest();


    var rawFile = new XMLHttpRequest();
    rawFile.open("GET", file, false);
    rawFile.onreadystatechange = function ()
    {
        if(rawFile.readyState === 4)
        {
            if(rawFile.status === 200 || rawFile.status == 0)
            {
                var allText = rawFile.responseText;
				console.log(allText);
               	listeCandidat =csvUpload(allText);
				console.log(listeCandidat);
            }
        }
    }
    rawFile.send(null);
}


function next(){
	if(lecteur == "")
		lecteur = resultat = window.prompt("Votre nom :");
		 document.getElementById('demarrer').disabled = true;
		 
if ( listeCandidat.length != 0){
	nextCandidat();
}
else{
load();
document.getElementById('bar').max = listeCandidat.length;
nextCandidat();
}
}



function accetper(){
	var candidat= document.getElementById("A2").value;
	console.log("C"+candidat);
	for (var i = 0; i < listeCandidat.length; i++) {
    var counter = listeCandidat[i];
    console.log("C"+counter);
    if(counter.numero==candidat){
    	listeCandidat[i].accepter="OUI";
    	next();
    	return;
    	}
}
}

function presquerefuser(){
	var candidat= document.getElementById("A2").value;
	console.log("C"+candidat);
	for (var i = 0; i < listeCandidat.length; i++) {
    var counter = listeCandidat[i];
    console.log("C"+counter);
    if(counter.numero==candidat){
    	listeCandidat[i].accepter="Plutot non";
    	next();
    	return;
    	}
}
}


function refuser(){
	var candidat= document.getElementById("A2").value;
	console.log("C"+candidat);
	for (var i = 0; i < listeCandidat.length; i++) {
    var counter = listeCandidat[i];
    console.log("C"+counter);
    if(counter.numero==candidat){
    	listeCandidat[i].accepter="NON";
    	resultat = window.prompt("Motif ?");
    	listeCandidat[i].motif=resultat.replace(";",",");
    	next();
    	return;
    	}
}
}


function finish(exportName, exportObj){
	
	var csv = "numero;decision;motif \r\n";
	for (var i = 0; i < listeCandidat.length; i++) {
		var counter = listeCandidat[i];
	
		csv = csv+listeCandidat[i].numero+";"+listeCandidat[i].accepter+";"+listeCandidat[i].motif+"\r\n";
	
	}
	
    var dataStr = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
    var downloadAnchorNode = document.createElement('a');
    downloadAnchorNode.setAttribute("href",     dataStr);
    downloadAnchorNode.setAttribute("download", exportName + ".csv");
    document.body.appendChild(downloadAnchorNode); // required for firefox
    downloadAnchorNode.click();
    downloadAnchorNode.remove();
  
}

function save(){
	finish("data",listeCandidat);
	document.getElementById('demarrer').disabled = false;
	document.getElementById('iframecontent').src =""
	 
}

function csvUpload(csvText){
    var allTextLines = csvText.split(/\r\n|\n/);
    var headers = allTextLines[0].split(';');
     

    for (var i=1; i<allTextLines.length; i++) {
        var data = allTextLines[i].split(';');
         
             var line = "{numero:'"+data[0]+"',accepter:'',motif:''}";
			 var ligneJson = JSON.stringify(eval("(" + line + ")"));
			objson = JSON.parse(ligneJson);
			listeCandidat.push(objson);
				
            
    
	
    }
	return listeCandidat;
	 
}
 
 
 // tell the embed parent frame the height of the content
    if (window.parent && window.parent.parent){
      window.parent.parent.postMessage(["resultsFrame", {
        height: document.body.getBoundingClientRect().height,
        slug: "xhYZb"
      }], "*")
    }

    // always overwrite window.name, in case users try to set it manually
    window.name = "result"
   