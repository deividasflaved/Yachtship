var yachtsCount = 1;
var timeToWait = yachtsCount * 500;

var manage = new Manager();
manage.initBasics();
manage.animate();
for (var x = 0; x < yachtsCount; x++) {
    manage.loadObject(filesLoc + "yacht2.obj");
}

setTimeout(() => manage.test(), timeToWait);
manage.test2();
var interval;
setTimeout(function() {
    manage.yachts[0].calcPath();
    console.log(manage.yachts[0].path);
    interval = setInterval(function() {
        work();
    }, 1000);
}, timeToWait + 500);
var j = 0;

function work() {
    if (j > 74) {
        clearInterval(interval);
    } else {
        manage.yachts[0].moveYachtTween(manage.yachts[0].path[j]);
        j++;
    }
}