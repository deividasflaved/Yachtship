const doc = document.getElementById('start');
const filesLoc = window.location.protocol + "//" + window.location.host + "/static/other/";
const canvasId = "canvas";
const sidebar = document.getElementById('sidebar');
const button = document.getElementById('toggle');
const colorArray = ['#e6194B', '#f58231', '#ffe119',
    '#bfef45', '#f032e6','#9A6324'];

class Manager {
    constructor() {
        this.world = new World(this);
        this.scene = new THREE.Scene();
        this.renderer = new THREE.WebGLRenderer();
        this.yachts = [];
        this.marks = [];
        this.replay = new Replay(this);
        this.usedColors = [];

        this.animate = this.animate.bind(this);

        this.loader = new THREE.OBJLoader();

        this.camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 14000);
        this.controls = new THREE.OrbitControls(this.camera, this.renderer.domElement);

        button.addEventListener('click', _ => {
            sidebar.classList.toggle('collapsed');
        });
    }

    initScene() {
        this.renderer.setSize(window.innerWidth - (window.innerWidth * 0.10), window.innerHeight - (window.innerHeight * 0.10));
        let container = document.getElementById(canvasId);
        container.appendChild(this.renderer.domElement);
        window.addEventListener('resize', () => {
            this.renderer.setSize(window.innerWidth - (window.innerWidth * 0.10), window.innerHeight - (window.innerHeight * 0.10));
            this.camera.aspect = window.innerWidth / window.innerHeight;
            this.camera.updateProjectionMatrix();
        });
    }

    initCameraPos() {
        this.camera.position.z = 200;
        this.camera.position.y = 50;
        this.camera.rotation.x = -45;
        this.controls.update();
    }

    initBasics() {
        this.initScene();
        this.world.initLight();
        this.world.initWater();
        this.world.initSkybox();
        this.initCameraPos();
    }

    loadObject(objLoc, obj, callback = null) {
        let material = new THREE.MeshPhongMaterial({
            color: 0xffffff,
            wireframe: false
        });
        this.loader.load(
            objLoc,
            (object) => {
                let mesh = null;
                object.traverse((obj) => {
                    if (obj instanceof THREE.Mesh) {
                        obj.material = material;
                        mesh = obj;
                    }
                });
                mesh.rotation.x = -Math.PI / 2;
                let temp = new Yacht(this);
                temp.addYacht(mesh);
                temp.yacht.name = obj['team_name'];
                temp.calcPath(Algorithm.cleanUpGpsData(gpsData, obj['id']));


                if(temp.path.length != 0) {
                    let rnd = Math.floor(Math.random() * colorArray.length);

                    while(this.usedColors.includes(rnd))
                        rnd = Math.floor(Math.random() * colorArray.length);
                    this.usedColors.push(rnd);
                    temp.color = rnd;

                    temp.id = this.yachts.length;
                    this.yachts.push(temp);
                    this.yachts[this.yachts.length - 1].addToScene();
                    this.yachts[this.yachts.length - 1].moveYachtInit();
                }
                if (callback !== null) callback();
            });
    }
    loadMark(objLoc, pos, callback = null){
        let material = new THREE.MeshPhongMaterial({
            color: 0xE6331A,
            wireframe: false
        });
        this.loader.load(
            objLoc,
            (object) => {
                let mesh = null;
                object.traverse((obj) => {
                    if (obj instanceof THREE.Mesh) {
                        obj.material = material;
                        mesh = obj;
                    }
                });
                mesh.rotation.x = -Math.PI / 2;
                mesh.position.set(pos.x, 0, pos.y);
                mesh.scale.set(5, 5, 5);
                manage.scene.add(mesh);
                this.marks.push(mesh);
                if (callback !== null) callback();
            });
    }

    animate() {
        requestAnimationFrame(this.animate);
        this.world.water.material.uniforms["time"].value += 1.0 / 60.0;
        this.renderer.render(this.scene, this.camera);
    }

    removeUnusedYachts(){
        this.yachts.forEach((yacht)=>{
           if(yacht.path <= 0) {
               this.scene.remove(yacht);
           }
        });
    }

    test() {
        let testElem = document.getElementById("sidebarTableBody");
        let count = 1;
        let speedId = 0;
        let trId = 0;
        let gapId = 0;
        this.yachts.forEach((yacht) => {
            testElem.innerHTML += "<tr id=\'trId" + trId++ + "\'>" +
                "<td class=\"td-border\" style='background-color: " + colorArray[yacht.color] + "'>" + count++ + "</td>" +
                "<td class=\"td-border\">" + yacht.yacht.name + "</td>" +
                "<td class=\"td-border\" id=\'speed" + speedId++ + "\'>" + Algorithm.getRandom(10,50) + "</td>" +
                "<td class=\"td-border\" id=\'gap" + gapId++ + "\'>0</td>" +
                "</tr>"
                // '\n' + yacht.yacht.name;
        });
    }
    // test2() {
    //     //test
    //     this.a = [
    //         [],
    //         []
    //     ];
    //     this.b = [
    //         [],
    //         []
    //     ];
    //     this.counter = 0;
    //     //test
    //     let ctx = canvastest1.getContext("2d");
    //     ctx.canvas.width = window.innerWidth * 0.9;
    //     ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
    //     ctx.beginPath();
    //     ctx.moveTo(30, 75);
    //     for (let i = 1; i < 26; i++) {
    //         let x = Algorithm.getRandom(50 * i, 50 * (i + 1));
    //         let y = Algorithm.getRandom(10, 130);
    //         ctx.lineTo(x, y);
    //         this.a[0].push(x);
    //         this.a[1].push(y);
    //     }
    //
    //     ctx.strokeStyle = 'blue';
    //     ctx.lineWidth = 3;
    //     ctx.stroke();
    //
    //     ctx.beginPath();
    //     ctx.moveTo(30, 100);
    //     for (let i = 1; i < 26; i++) {
    //         let x = Algorithm.getRandom(50 * i, 50 * (i + 1));
    //         let y = Algorithm.getRandom(10, 130);
    //         ctx.lineTo(x, y);
    //         this.b[0].push(x);
    //         this.b[1].push(y);
    //     }
    //     ctx.strokeStyle = 'red';
    //     ctx.setLineDash([5, 3]);
    //     ctx.lineWidth = 3;
    //     ctx.stroke();
    //
    //     ctx = canvastest2.getContext("2d");
    //     ctx.canvas.width = window.innerWidth*0.9;
    //     // ctx.moveTo(100, 10);
    //     // ctx.lineTo(150, 100);
    //     // ctx.lineTo(300,20);
    //     // ctx.lineTo(800,70);
    //     // ctx.stroke();
    //
    //     ctx = canvastest3.getContext("2d");
    //     ctx.canvas.width = window.innerWidth*0.9;
    //     // ctx.moveTo(100, 10);
    //     // ctx.lineTo(200, 100);
    //     // ctx.lineTo(300,100);
    //     // ctx.lineTo(500,70);
    //     // ctx.stroke();
    // }
    // test3() {
    //     let ctx = canvastest1.getContext("2d");
    //     ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
    //
    //     ctx.beginPath();
    //     ctx.moveTo(30, 75);
    //     for (let i = 1; i < 26; i++) {
    //         ctx.lineTo(this.a[0][i - 1], this.a[1][i - 1]);
    //     }
    //
    //     ctx.strokeStyle = 'blue';
    //     ctx.lineWidth = 3;
    //     ctx.setLineDash([]);
    //     ctx.stroke();
    //
    //     ctx.beginPath();
    //     ctx.moveTo(30, 100);
    //     for (let i = 1; i < 26; i++) {
    //         ctx.lineTo(this.b[0][i - 1], this.b[1][i - 1]);
    //     }
    //     ctx.strokeStyle = 'red';
    //     ctx.setLineDash([5, 3]);
    //     ctx.lineWidth = 3;
    //     ctx.stroke();
    //
    //     ctx.beginPath();
    //     ctx.moveTo(30 + (10 * this.counter), 0);
    //     ctx.lineTo(30 + (10 * this.counter), 150);
    //     ctx.strokeStyle = 'black';
    //     ctx.setLineDash([5, 3]);
    //     ctx.lineWidth = 3;
    //     ctx.stroke();
    //     this.counter++;
    // }
}