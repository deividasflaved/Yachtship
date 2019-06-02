// const x = 638.9868854761005;
// const y = 1218.417993665355;
// const x1 = 641.87026016711;
// const y1 = -2221.313902258259;

class Replay {
    constructor(manager) {
        this.manager = manager;
        this.duration = [0.25, 0.5, 1, 2, 4, 5];
        this.currentSpeed = 5;
        this.elapsed = 0;
        this.paused = false;
        this.loop = this.loop.bind(this);
        this.clock = new Clock();
        this.speedArray = [];
        this.leader = null;
        this.slider = document.getElementById("myRange");
        this.elapsedTimeTxt = document.getElementById("elapsedTime");
        this.material = new THREE.LineBasicMaterial({color: 0x0000ff});
        this.geometry = new THREE.Geometry();
        this.line = null;
        this.roundedTimePast = null;
        this.trArray = [];
        this.gapArray = [];
        this.stageOfYacht = [];
        this.trailLenght = 60 / 5; // real time seconds / saving entry
    }

    initSpeedElems() {
        this.manager.yachts.forEach((yacht) => {
            let elem = document.getElementById("speed" + yacht.id);
            this.speedArray.push(elem);
            if (yacht.path.length > 0 && this.leader == null)
                this.leader = yacht;

            elem = document.getElementById("trId" + yacht.id);
            this.trArray.push(elem);

            elem = document.getElementById("gap" + yacht.id);
            this.gapArray.push(elem);

            this.stageOfYacht.push(0);
        });
        this.speedArray[this.leader.id].innerText = 0;
    }

    drawLine(yacht) {
        let angle = Algorithm.getAngle({x: x1, y: y1}, {x: x, y: y}) + 1.5708;
        let new_x1 = yacht.position.x + 3000 * Math.cos((angle * 180 / Math.PI) * Math.PI / 180);
        let new_x2 = yacht.position.x - 3000 * Math.cos((angle * 180 / Math.PI) * Math.PI / 180);
        let new_y1 = yacht.position.z + 3000 * Math.sin((angle * 180 / Math.PI) * Math.PI / 180);
        let new_y2 = yacht.position.z - 3000 * Math.sin((angle * 180 / Math.PI) * Math.PI / 180);

        manage.scene.remove(this.line);

        this.geometry = new THREE.Geometry();
        this.geometry.vertices.push(new THREE.Vector3(new_x2, 2, new_y2));
        this.geometry.vertices.push(new THREE.Vector3(new_x1, 2, new_y1));
        this.line = new THREE.Line(this.geometry, this.material);

        manage.scene.add(this.line);
    }

    initPoints(){
        if(race['start'] != null) {
            manage.loadMark(filesLoc + "mark.obj", Algorithm.raceGpsToXY(race['start']), () => console.log('start done'));
            manage.loadMark(filesLoc + "mark.obj", Algorithm.raceGpsToXY(race['finish']), () => console.log('finish done'));
            manage.loadMark(filesLoc + "mark.obj", Algorithm.raceGpsToXY(race['referee']), () => {
                let geometry = new THREE.Geometry();
                let material = new THREE.LineBasicMaterial({color: 0xFF0000});
                geometry.vertices.push(new THREE.Vector3(manage.marks[0].position.x, 2, manage.marks[0].position.z));
                geometry.vertices.push(new THREE.Vector3(manage.marks[2].position.x, 2, manage.marks[2].position.z));
                let line = new THREE.Line(geometry, material);
                manage.scene.add(line);
                geometry = new THREE.Geometry();
                material = new THREE.LineBasicMaterial({color: 0xFF0000});
                geometry.vertices.push(new THREE.Vector3(manage.marks[1].position.x, 2, manage.marks[1].position.z));
                geometry.vertices.push(new THREE.Vector3(manage.marks[2].position.x, 2, manage.marks[2].position.z));
                line = new THREE.Line(geometry, material);
                manage.scene.add(line);
            });
            manage.loadMark(filesLoc + "mark.obj", Algorithm.raceGpsToXY(race['checkpoint']), () => console.log('checkpoint done'));
        }

        // let geometry = new THREE.Geometry();
        // geometry.vertices.push(new THREE.Vector3(start.position))
        // console.log();
    }


    drawTrail(yacht, startIndex) {
        let material = new THREE.LineBasicMaterial({color: colorArray[yacht.color], linewidth: 2});
        let geometry = new THREE.Geometry();
        let trailLength = this.trailLenght;

        if (startIndex - this.trailLenght < 0)
            trailLength = startIndex;

        for (let i = startIndex - trailLength; i < startIndex + 1; i++) {
            geometry.vertices.push(new THREE.Vector3(yacht.path[i].x, 2, yacht.path[i].y));
        }

        manage.scene.remove(yacht.trail);
        yacht.trail = new THREE.Line(geometry, material);
        manage.scene.add(yacht.trail);
    }

    loop() {
        let roundedTime = Math.floor(this.clock.getElapsedTime() / this.duration[this.currentSpeed]);
        let t = 1 - (((roundedTime + 1) - this.clock.getElapsedTime() / this.duration[this.currentSpeed]));
        this.manager.yachts.forEach((yacht) => {
            if (yacht.path.length > 0)
                if (yacht.path[roundedTime] != null && yacht.path[roundedTime + 1] != null) {
                    yacht.moveYacht(yacht.path[roundedTime], yacht.path[roundedTime + 1], t);
                    //TODO if yachts arent the first ones moving might cause issues
                    this.speedArray[yacht.id].innerText = Math.round(Algorithm.convertSpeedToKnots(Algorithm.calcSpeed(yacht.path[roundedTime].x,
                        yacht.path[roundedTime].y, yacht.path[roundedTime + 1].x,
                        yacht.path[roundedTime + 1].y) * 100)) / 100;
                    // console.log(yacht.path[roundedTime].a, Algorithm.getAngle(yacht.path[roundedTime], {x: x, y: y}), Algorithm.getAngle(yacht.path[roundedTime], {x: x1, y: y1}));
                    if (this.stageOfYacht[yacht.id] % 2 == 0 && this.leader.path[roundedTime] != null) {
                        this.getLeader(yacht, roundedTime)
                    }
                    this.drawLine(this.leader.yacht);
                    if (this.roundedTimePast != roundedTime) {
                        this.drawTrail(yacht, roundedTime);
                    }
                    if (yacht != this.leader && this.roundedTimePast != roundedTime) {
                        this.gapArray[yacht.id].innerText = Algorithm.calcDistToLine(yacht.yacht.position, this.geometry.vertices[0], this.geometry.vertices[1]);
                        Algorithm.formatTable(Algorithm.bubbleSort(this.trArray));
                    }

                    // if(Algorithm.calcDistToLine(new THREE.Vector3(x, 0, y), this.geometry.vertices[0], this.geometry.vertices[1])< 2) {
                    //     this.movingToCheckpoint = false;
                    //     console.log(Algorithm.calcDistToLine(new THREE.Vector3(x, 0, y), this.geometry.vertices[0], this.geometry.vertices[1]))
                    // }
                }
        });
        this.slider.value = this.clock.getElapsedTime() / this.duration[this.currentSpeed] * 100;
        this.elapsedTimeTxt.innerText = "Elapsed:\n" + Algorithm.formatTime(Math.floor(this.clock.getElapsedTime() * 5 / this.duration[this.currentSpeed]));
        this.roundedTimePast = roundedTime;
        requestAnimationFrame(this.loop);
    }

    getLeader(yacht, i) {

        if (Algorithm.getDistance(this.leader.path[i].x, this.leader.path[i].y, x, y) > Algorithm.getDistance(yacht.path[i].x, yacht.path[i].y, x, y)) {
            this.leader = yacht;
            this.gapArray[this.leader.id].innerText = 0;
            Algorithm.formatTable(Algorithm.bubbleSort(this.trArray));
        }

        // if (Algorithm.getDistance(this.leader.path[i].x, this.leader.path[i].y, x1, y1 ) > Algorithm.getDistance(yacht.path[i].x, yacht.path[i].y, x1, y1 )) {
        //     this.leader = yacht;
        //     this.gapArray[this.leader.id].innerText = 0;
        //     Algorithm.formatTable(Algorithm.bubbleSort(this.trArray));
        // }
        // TODO check later
    }

    stopLoop() {
        this.elapsed = this.clock.getElapsedTime();
        this.clock.stop();
    }

    startLoop() {
        this.clock.start();
        this.clock.elapsedTime = this.elapsed;
    }

    changeTime(time) {
        time *= this.duration[this.currentSpeed];
        this.elapsed = time;
        this.clock.elapsedTime = time;
    }

    changeSpeed() {
        let speedBefore = this.duration[this.currentSpeed];

        if (this.currentSpeed <= 0)
            this.currentSpeed = this.duration.length - 1;
        else
            this.currentSpeed--;

        let speedAfter = this.duration[this.currentSpeed];
        let temp = speedAfter / speedBefore;

        this.elapsed = this.clock.getElapsedTime() * temp;
        this.clock.elapsedTime = this.clock.getElapsedTime() * temp;
    }
}