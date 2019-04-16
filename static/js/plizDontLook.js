// var scene = new THREE.Scene();
// var camera = new THREE.PerspectiveCamera( 75, window.innerWidth/window.innerHeight, 0.1, 7000 );
// var mesh = null;
// var renderer = new THREE.WebGLRenderer();
var targetPositionX = 1000;
// renderer.setSize( window.innerWidth, window.innerHeight );
// document.getElementById('start').appendChild( renderer.domElement );

// var material = new THREE.MeshPhongMaterial({
//     color: 0x000055,
//     wireframe: false
// });

// controls = new THREE.OrbitControls(camera, renderer.domElement);
// var loader = new THREE.OBJLoader();

// loadObject();


var xDistance = 300;
var zDistance = 100;
// function loadObject() {
//     loader.load(
//         'http://127.0.0.1:8000/static/other/yacht2.obj',
//         function(object) {
//             controls.reset();
//             scene.remove(mesh);
//             object.traverse((obj) => {
//                 if (obj instanceof THREE.Mesh) {
//                     obj.material = material;
//                     mesh = obj;
//                 }
//             });
//             mesh.rotation.x = - Math.PI / 2;
//             //scene.add(mesh);
//             loadSomething();
//             loop();
//             setCameraPos();
//         });
// }
var mesh1
function loadSomething(){
    var xOffset = -80;

for(var i = 0; i < 4; i++){
    for(var j = 0; j < 3; j++){
            mesh1  = mesh.clone();
            mesh1.position.x = (xDistance * i) + xOffset;
            mesh1.position.z = (zDistance * j) + 100;
            //console.log(mesh1.position);
            scene.add(mesh1);
            //console.log(scene.children.length);
    }
};
}
// var light = new THREE.DirectionalLight( 0xffffff, 0.5 );
// scene.add( light )

// var waterGeometry = new THREE.PlaneBufferGeometry( 10000, 10000 );

// water = new THREE.Water(
//     waterGeometry,
//     {
//         textureWidth: 512,
//         textureHeight: 512,
//         waterNormals: new THREE.TextureLoader().load( 'http://127.0.0.1:8000/static/other/waternormals.jpg', function ( texture ) {
//             texture.wrapS = texture.wrapT = THREE.RepeatWrapping;
//         } ),
//         alpha: 1.0,
//         sunDirection: light.position.clone().normalize(),
//         sunColor: 0xffffff,
//         waterColor: 0x001e0f,
//         distortionScale: 3.7,
//         fog: scene.fog !== undefined
//     }
// );
// water.rotation.x = - Math.PI / 2;
// scene.add( water );


    // // Add Sky
    // var sky = new THREE.Sky();
    // sky.scale.setScalar( 450000 );
    // scene.add( sky );

    // creates the shape
// var geometry = new THREE.CubeGeometry( 9000, 9000, 9000 );
// var loc = "http://127.0.0.1:8000/static/other/";
// var cubeMaterials = [
//     new THREE.MeshBasicMaterial({ map: new THREE.TextureLoader().load( loc + 'nightsky_ft.png' ), side: THREE.DoubleSide }), //front side
//     new THREE.MeshBasicMaterial({ map: new THREE.TextureLoader().load( loc + 'nightsky_bk.png' ), side: THREE.DoubleSide }), //back side
//     new THREE.MeshBasicMaterial({ map: new THREE.TextureLoader().load( loc + 'nightsky_up.png' ), side: THREE.DoubleSide }), //up side
//     new THREE.MeshBasicMaterial({ map: new THREE.TextureLoader().load( loc + 'nightsky_dn.png' ), side: THREE.DoubleSide }), //down side
//     new THREE.MeshBasicMaterial({ map: new THREE.TextureLoader().load( loc + 'nightsky_rt.png' ), side: THREE.DoubleSide }), //right side
//     new THREE.MeshBasicMaterial({ map: new THREE.TextureLoader().load( loc + 'nightsky_lf.png' ), side: THREE.DoubleSide }) //left side
// ];

// var cubeMaterial = new THREE.MeshFaceMaterial( cubeMaterials );
// var cube = new THREE.Mesh( geometry, cubeMaterial );
// scene.add( cube );


//Sets Camera position to make object in center
function setCameraPos(){
    mesh.geometry.computeBoundingBox();
    bound = mesh.geometry.boundingBox;
    camera.position.y = (bound.max.y + bound.min.y) / 2;
    camera.position.z = bound.max.y - bound.min.y;
    controls.target = new THREE.Vector3(0, camera.position.y, 0);
}

function loop(){

    // render the scene
    renderer.render(scene, camera);

    // Check the object's X position
    if (mesh1.position.x <= targetPositionX) {
        mesh1.position.x += 0.5; // You decide on the increment, higher value will mean the objects moves faster
    }

    // call the loop function again
    requestAnimationFrame(loop);
}

// var animate = function () {
// 	requestAnimationFrame( animate );
// 	renderer.render(scene, camera);
// };
// animate();


// loadObject2(objLoc) {
//     let material = new THREE.MeshPhongMaterial({
//         wireframe: false
//     });
//     var promise1 = new Promise(resolve => {
//         new THREE.OBJLoader().load(objLoc, resolve);
//     });
//     promise1.then((object)=> {
//             object.traverse((obj) => {
                
//                 if (obj instanceof THREE.Mesh) {
//                     obj.material = material;
//                     this.mesh = obj;
//                 }
//             });
//             this.mesh.rotation.x = - Math.PI / 2;
//             let temp = new Yacht(this);
//             temp.addYacht(this.mesh);
//             this.yachts.push(temp);
//             this.yachts[this.yachts.length-1].addToScene();
//             this.yachts[this.yachts.length-1].moveYacht();
        
//       });
//     // this.loader.load(
//     //     objLoc,
        
//     //     });
// }