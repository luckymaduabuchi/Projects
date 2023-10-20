const getHours = document.getElementById("hours");
const getMinutes = document.getElementById("minutes");
const getSeconds = document.getElementById("seconds");
const getAM = document.getElementById("ampm");


function getClock() {
    let h = new Date().getHours();
    let m = new Date().getMinutes();
    let s = new Date().getSeconds();
    let ampm = "AM"
    
    if (h > 12) {
        h = h - 12;
        ampm = "PM";
    }

h = h < 10 ? "0" + h : h;
m = m < 10 ? "0" + m : m;
s = s < 10 ? "0" + s : s;


getHours.innerText = h;
getMinutes.innerText= m;
getSeconds.innerText = s;
getAM.innerText = ampm;

setTimeout(() => {
    getClock();
  }, 1000);

}
getClock();

