var yachtsCount = 5;
var timeToWait = yachtsCount*500;

var manage = new Manager();
manage.initBasics();
manage.animate();
for (var x = 0; x < yachtsCount; x++) {
    manage.loadObject(filesLoc + "yacht2.obj");
}
// manage.test();
setTimeout(()=> manage.test(),timeToWait);
manage.test2();
// setInterval(()=> manage.test3(),1000);
// manage.test();
// setTimeout(function() {
//     for (var x = 0; x < yachtsCount; x++) {
//         manage.yachts[x].addToScene();
//         manage.yachts[x].moveYacht();
//     }
// }, timeToWait);