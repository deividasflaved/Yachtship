const yachtsCount = teams.length;
const timeToWait = yachtsCount * 500;

const x = 575.971737432468;
// const x = 1500;
const y = 1173.3485003119881;
// const y = -1800;
const x1 = 641.87026016711;
const y1 = -2221.313902258259;


let manage = new Manager();
manage.initBasics();
manage.animate();

var btn = document.getElementById("play");
var btn2 = document.getElementById("plays");
console.log(Algorithm.getLonLat(x, y));
manage.replay.slider.oninput = function() {
  manage.replay.changeTime(manage.replay.slider.value / 100);
  // console.log(manage.replay.slider.value / 100)
}

for (let i = 0; i < yachtsCount; i++) {
    if(i === yachtsCount - 1)
        manage.loadObject(filesLoc + "yacht2.obj", teams[i],() =>
        {
            manage.test();
            // manage.test2()
            manage.replay.initSpeedElems();
            manage.replay.loop();
            manage.replay.initPoints();

            btn.addEventListener('click', () => {
                if(!manage.replay.paused){
                    btn.classList.add("btn-img-pause");
                    manage.replay.stopLoop();
                    manage.replay.paused = true;

                }
                else{
                    btn.classList.remove("btn-img-pause");
                    manage.replay.startLoop();
                    manage.replay.paused = false;
                }
            });
            btn2.addEventListener('click', () => {
                manage.replay.changeSpeed();
            });
        });
    else
        manage.loadObject(filesLoc + "yacht2.obj", teams[i]);
}
