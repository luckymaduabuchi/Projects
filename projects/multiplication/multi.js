const num1 = Math.ceil(Math.random()*10);
const num2 = Math.ceil(Math.random()*10);

const question = document.getElementById("h1");
question.innerHTML = 'what is'+ " "+ num1 + " "+ "multiply by"+" "+ num2 + "?";

const formEL = document.getElementById("form");

const correctAns = num1 * num2 ;
const userAns =document.getElementById("input");
let score = JSON.parse(localStorage.getItem("score"));
if (!score) {
    score=0;
}

formEL.addEventListener("submit", ()=>{
const Answer = +userAns.value;
if (correctAns===Answer) {
    score++;
    updateStorage();
    } else {
    score--;
    updateStorage();
    if (score <= 0) {
        score=0;
        updateStorage();
    }
}
})
function updateStorage() {
    localStorage.setItem("score", JSON.stringify(score));
    
}
const realScore = document.getElementById("h4").innerHTML = "score:"+ score;