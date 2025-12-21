function validator1() {
  var bool = true;
  var x = 0;
  var password = document.getElementById('newpass').value;
  var bar = document.getElementById("barx");
  var al = document.getElementById("alertx");

  //controllo numeri
  var check=/[0-9]/;
  if(check.test(password)){
    x = x + 20;
  }
  //controllo minuscole
  var check2=/[a-z]/;
  if(check2.test(password)){
    x = x + 20;
  }
  //controllo maiuscole
  var check3=/[A-Z]/;
  if(check3.test(password)){
    x = x + 20;
  }
  //controllo simboli
  var check4=/[$-/:-?{-~!"^_`\[\]]/;
  if(check4.test(password)){
    x = x + 20;
  }
  // controllo lunghezza (minore o uguale a 10 caratteri)
  if(password.length >=10){
    x = x + 20;
  }

  // risultato
  bar.style.width = x + "%";
  // voto massimo 100
  if (x == 100) {
    bar.style.backgroundColor = "green";
    al.innerHTML = "Strong";
  }
  if (x >60) {
    bar.style.backgroundColor = "green";
    al.innerHTML = "Good";
  }
  if (x <=40) {
    bar.style.backgroundColor = "yellow";
    al.innerHTML = "Weak";
	bool=false;
  }
  //voto minimo 20
  if (x <=20) {
    bar.style.backgroundColor = "red";
    al.innerHTML = "Bad";
	bool=false;
  }

  if(password.length == 0){
    x == 0;
    al.innerHTML = "";
	bool=false;
  }

  //controllo spazi bianchi
  var check5=/\s\S/;
  if(check5.test(password)){
    al.innerHTML = "Password must not contain white spaces";
    bar.style.backgroundColor = "red";
	bool=false;
  }
  return bool;
}
