const doc = document.getElementById('start');
// const filesLoc = "http://127.0.0.1:8000/static/other/";
// const filesLoc = "http://192.168.1.187:8000/static/other/";
const filesLoc = "http://deividux652.pythonanywhere.com/static/other/";
const canvasId = "canvas";
const sidebar = document.getElementById('sidebar');
const button = document.getElementById('toggle');
const canvastest1 = document.getElementById('test-canvas1');
const canvastest2 = document.getElementById('test-canvas2');
const canvastest3 = document.getElementById('test-canvas3');

class Manager {
    constructor() {
        
        this.world = new World(this);
        this.scene = new THREE.Scene();
        this.renderer = new THREE.WebGLRenderer();

        this.yachts = [];

        this.animate = this.animate.bind(this);

        this.loader = new THREE.OBJLoader();

        this.camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 7000);
        this.controls = new THREE.OrbitControls(this.camera, this.renderer.domElement);

        button.addEventListener('click', _ => {
            sidebar.classList.toggle('collapsed');
          });
    }

    initScene() {
        this.renderer.setSize(window.innerWidth, window.innerHeight);
        let container = document.getElementById(canvasId);
        container.appendChild(this.renderer.domElement);
        window.addEventListener('resize', () => {
            this.renderer.setSize(window.innerWidth, window.innerHeight);
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


    loadObject(objLoc) {
        let material = new THREE.MeshPhongMaterial({
            color: 0x000055,
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
                // ⌄⌄⌄⌄⌄⌄⌄temporary for testing purposes⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄
                temp.yacht.name = "LTU" + this.getRandom(10000,99999).toString();
                // ^^^^^^^temporary for testing purposes^^^^^^^^^^^^^
                this.yachts.push(temp);
                this.yachts[this.yachts.length - 1].addToScene();
                this.yachts[this.yachts.length - 1].moveYacht();
            });
    }

    animate() {
        requestAnimationFrame(this.animate);
        this.world.water.material.uniforms["time"].value += 1.0 / 60.0;
        this.renderer.render(this.scene, this.camera);
        TWEEN.update();
    }

    test() {
        let testElem = document.getElementById("sidebar");
        this.yachts.forEach((yacht) => {
            testElem.innerText += '\n' + yacht.yacht.name;
            // console.log(yacht);
        });
    }
    test2() {
        //test
        this.a = [
            [],
            []
        ];
        this.b = [
            [],
            []
        ];
        this.counter = 0;
        //test
        let ctx = canvastest1.getContext("2d");
        ctx.canvas.width = window.innerWidth;
        ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
        ctx.beginPath();
        ctx.moveTo(30, 75);
        for (let i = 1; i < 26; i++) {
            let x = this.getRandom(50 * i, 50 * (i + 1));
            let y = this.getRandom(10, 130);
            ctx.lineTo(x, y);
            this.a[0].push(x);
            this.a[1].push(y);
        }

        ctx.strokeStyle = 'blue';
        ctx.lineWidth = 3;
        ctx.stroke();

        ctx.beginPath();
        ctx.moveTo(30, 100);
        for (let i = 1; i < 26; i++) {
            let x = this.getRandom(50 * i, 50 * (i + 1));
            let y = this.getRandom(10, 130);
            ctx.lineTo(x, y);
            this.b[0].push(x);
            this.b[1].push(y);
        }
        ctx.strokeStyle = 'red';
        ctx.setLineDash([5, 3]);
        ctx.lineWidth = 3;
        ctx.stroke();

        ctx = canvastest2.getContext("2d");
        ctx.canvas.width = window.innerWidth;
        // ctx.moveTo(100, 10);
        // ctx.lineTo(150, 100);
        // ctx.lineTo(300,20);
        // ctx.lineTo(800,70);
        // ctx.stroke(); 

        ctx = canvastest3.getContext("2d");
        ctx.canvas.width = window.innerWidth;
        // ctx.moveTo(100, 10);
        // ctx.lineTo(200, 100);
        // ctx.lineTo(300,100);
        // ctx.lineTo(500,70);
        // ctx.stroke(); 
    }
    test3() {
        let ctx = canvastest1.getContext("2d");
        ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);

        ctx.beginPath();
        ctx.moveTo(30, 75);
        for (let i = 1; i < 26; i++) {
            ctx.lineTo(this.a[0][i - 1], this.a[1][i - 1]);
        }

        ctx.strokeStyle = 'blue';
        ctx.lineWidth = 3;
        ctx.setLineDash([]);
        ctx.stroke();

        ctx.beginPath();
        ctx.moveTo(30, 100);
        for (let i = 1; i < 26; i++) {
            ctx.lineTo(this.b[0][i - 1], this.b[1][i - 1]);
        }
        ctx.strokeStyle = 'red';
        ctx.setLineDash([5, 3]);
        ctx.lineWidth = 3;
        ctx.stroke();

        ctx.beginPath();
        ctx.moveTo(30 + (10 * this.counter), 0);
        ctx.lineTo(30 + (10 * this.counter), 150);
        ctx.strokeStyle = 'black';
        ctx.setLineDash([5, 3]);
        ctx.lineWidth = 3;
        ctx.stroke();
        this.counter++;
    }
    getRandom(min, max) {
        min = Math.ceil(min);
        max = Math.floor(max);
        return Math.floor(Math.random() * (max - min)) + min; //The maximum is exclusive and the minimum is inclusive
    }
}