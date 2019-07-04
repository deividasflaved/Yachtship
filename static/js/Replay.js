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
        this.checkpointLine = [];
        this.points = [];
        this.angle = null;
        this.max = 0;
        this.trailLenght = 180 / 5; // real time seconds / saving entry
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
            let stage = 0;
            yacht.path.forEach((elem, i)=>{
                if(i != 0) {
                    if(yacht.path[i].stageOfYacht % 2 == 0){
                        if(Algorithm.calcDistToLine(new THREE.Vector3(yacht.path[i].x, 0, yacht.path[i].y),
                                new THREE.Vector3(this.checkpointLine['x1'], 0, this.checkpointLine['y1']*(-1)),
                                new THREE.Vector3(this.checkpointLine['x2'], 0, this.checkpointLine['y2']*(-1))) <= 5) {
                            for(let j = i; j<yacht.path.length; j++)
                                yacht.path[j].stageOfYacht++;
                        }
                    }
                    else if(yacht.path[i].stageOfYacht % 2 == 1){
                        if(Algorithm.calcDistToLine(new THREE.Vector3(yacht.path[i].x, 0, yacht.path[i].y),
                                new THREE.Vector3(this.checkpointLine['x3'], 0, this.checkpointLine['y3']*(-1)),
                                new THREE.Vector3(this.checkpointLine['x4'], 0, this.checkpointLine['y4']*(-1))) <= 5) {
                            for(let j = i; j<yacht.path.length; j++)
                                yacht.path[j].stageOfYacht++;
                        }
                    }
                }
            });
        });
        this.speedArray[this.leader.id].innerText = 0;
        this.loop();
    }
    drawLine(yacht) {
        let new_x1 = yacht.position.x + 3000 * Math.cos((this.angle * 180 / Math.PI) * Math.PI / 180);
        let new_x2 = yacht.position.x - 3000 * Math.cos((this.angle * 180 / Math.PI) * Math.PI / 180);
        let new_y1 = yacht.position.z + 3000 * Math.sin((this.angle * 180 / Math.PI) * Math.PI / 180);
        let new_y2 = yacht.position.z - 3000 * Math.sin((this.angle * 180 / Math.PI) * Math.PI / 180);
        manage.scene.remove(this.line);

        this.geometry = new THREE.Geometry();
        this.geometry.vertices.push(new THREE.Vector3(new_x2, 2, new_y2));
        this.geometry.vertices.push(new THREE.Vector3(new_x1, 2, new_y1));
        this.line = new THREE.Line(this.geometry, this.material);

        manage.scene.add(this.line);
    }

    initPoints(){
        if(race['start'] != null) {
            this.points['start'] = Algorithm.raceGpsToXY(race['start']);
            this.points['finish'] = Algorithm.raceGpsToXY(race['finish']);
            this.points['referee'] = Algorithm.raceGpsToXY(race['referee']);
            this.points['checkpoint'] = Algorithm.raceGpsToXY(race['checkpoint'])['checkpoint1'];
            this.points['checkpoint2'] = Algorithm.raceGpsToXY(race['checkpoint'])['checkpoint2'];
            manage.loadMark(filesLoc + "mark.obj", this.points['start'], () => console.log('start done'));
            manage.loadMark(filesLoc + "mark.obj", this.points['finish'], () => console.log('finish done'));

            manage.loadMark(filesLoc + "mark.obj", this.points['referee'], () => {

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
            manage.loadMark(filesLoc + "mark.obj", Algorithm.raceGpsToXY(race['checkpoint'])['checkpoint1']);
            manage.loadMark(filesLoc + "mark.obj", Algorithm.raceGpsToXY(race['checkpoint'])['checkpoint2']);

            this.points['checkpoint'].y *= -1;
            this.points['checkpoint2'].y *= -1;

            this.angle = Algorithm.getAngle({x: this.points['checkpoint2'].x, y: this.points['checkpoint2'].y}, {x: this.points['checkpoint'].x, y: this.points['checkpoint'].y});


            this.checkpointLine['x1'] = this.points['checkpoint'].x + 3000 * Math.cos((this.angle * 180 / Math.PI) * Math.PI / 180);
            this.checkpointLine['x2'] = this.points['checkpoint'].x - 3000 * Math.cos((this.angle * 180 / Math.PI) * Math.PI / 180);
            this.checkpointLine['y1'] = this.points['checkpoint'].y + 3000 * Math.sin((this.angle * 180 / Math.PI) * Math.PI / 180);
            this.checkpointLine['y2'] = this.points['checkpoint'].y - 3000 * Math.sin((this.angle * 180 / Math.PI) * Math.PI / 180);

            this.checkpointLine['x3'] = this.points['checkpoint2'].x + 3000 * Math.cos((this.angle * 180 / Math.PI) * Math.PI / 180);
            this.checkpointLine['x4'] = this.points['checkpoint2'].x - 3000 * Math.cos((this.angle * 180 / Math.PI) * Math.PI / 180);
            this.checkpointLine['y3'] = this.points['checkpoint2'].y + 3000 * Math.sin((this.angle * 180 / Math.PI) * Math.PI / 180);
            this.checkpointLine['y4'] = this.points['checkpoint2'].y - 3000 * Math.sin((this.angle * 180 / Math.PI) * Math.PI / 180);

            this.angle = Algorithm.getAngle({x: this.points['checkpoint2'].x, y: this.points['checkpoint2'].y}, {x: this.points['checkpoint'].x, y: this.points['checkpoint'].y}) + 1.4331239;
        }
        this.initSpeedElems();

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
                    this.speedArray[yacht.id].innerText = Math.round(Algorithm.convertSpeedToKnots(Algorithm.calcSpeed(yacht.path[roundedTime].x,
                        yacht.path[roundedTime].y, yacht.path[roundedTime + 1].x,
                        yacht.path[roundedTime + 1].y) * 100)) / 100;
                    if (yacht.path[roundedTime].stageOfYacht % 2 == 0 && this.leader.path[roundedTime] != null && this.max == yacht.path[roundedTime].stageOfYacht) {
                        this.getLeaderCheckpoint(yacht, roundedTime);
                    }

                    if (yacht.path[roundedTime].stageOfYacht % 2 == 1 && this.leader.path[roundedTime] != null && this.max == yacht.path[roundedTime].stageOfYacht) {
                        this.getLeaderStart(yacht, roundedTime);
                    }
                    if(this.points.checkpoint != null)
                        this.drawLine(this.leader.yacht);
                    if (this.roundedTimePast != roundedTime) {
                        this.drawTrail(yacht, roundedTime);
                    }
                    if (yacht != this.leader && this.roundedTimePast != roundedTime && this.points.checkpoint != null) {

                        manage.yachts.forEach((yachtt)=>{
                            if(yachtt.path[roundedTime].stageOfYacht>this.max)
                                this.max = yachtt.path[roundedTime].stageOfYacht;
                        });
                        if(this.max == yacht.path[roundedTime].stageOfYacht)
                            this.gapArray[yacht.id].innerText = Algorithm.calcDistToLine(yacht.yacht.position, this.geometry.vertices[0], this.geometry.vertices[1]);
                        else if(this.max % 2 == 1)
                            this.gapArray[yacht.id].innerText = Algorithm.roundNumber(Algorithm.calcDistToLine(new THREE.Vector3(this.points['checkpoint'].x,0,this.points['checkpoint'].y*(-1)), this.geometry.vertices[0], this.geometry.vertices[1]) +
                                Algorithm.getDistance(yacht.yacht.position.x,yacht.yacht.position.z,this.points['checkpoint'].x,this.points['checkpoint'].y*(-1)));
                        else if(this.max % 2 == 0)
                            this.gapArray[yacht.id].innerText = Algorithm.roundNumber(Algorithm.calcDistToLine(new THREE.Vector3(this.points['checkpoint2'].x,0,this.points['checkpoint2'].y*(-1)), this.geometry.vertices[0], this.geometry.vertices[1]) +
                                Algorithm.getDistance(yacht.yacht.position.x,yacht.yacht.position.z,this.points['checkpoint2'].x,this.points['checkpoint2'].y*(-1)));

                        Algorithm.formatTable(Algorithm.bubbleSort(this.trArray));
                    }
                }
            });
        this.slider.value = this.clock.getElapsedTime() / this.duration[this.currentSpeed] * 100;
        this.elapsedTimeTxt.innerText = "Elapsed:\n" + Algorithm.formatTime(Math.floor(this.clock.getElapsedTime() * 5 / this.duration[this.currentSpeed]));
        this.roundedTimePast = roundedTime;
        requestAnimationFrame(this.loop);
    }

    getLeaderCheckpoint(yacht, i) {

        if (Algorithm.calcDistToLine(new THREE.Vector3(this.leader.path[i].x, 0, this.leader.path[i].y),
                                new THREE.Vector3(this.checkpointLine['x1'], 0, this.checkpointLine['y1']*(-1)),
                                new THREE.Vector3(this.checkpointLine['x2'], 0, this.checkpointLine['y2']*(-1)))
                                                            >
            Algorithm.calcDistToLine(new THREE.Vector3(yacht.path[i].x, 0, yacht.path[i].y),
                                new THREE.Vector3(this.checkpointLine['x1'], 0, this.checkpointLine['y1']*(-1)),
                                new THREE.Vector3(this.checkpointLine['x2'], 0, this.checkpointLine['y2']*(-1)))) {
            this.leader = yacht;
            this.gapArray[this.leader.id].innerText = 0;
            Algorithm.formatTable(Algorithm.bubbleSort(this.trArray));
        }

    }
    getLeaderStart(yacht, i) {
        if (Algorithm.calcDistToLine(new THREE.Vector3(this.leader.path[i].x, 0, this.leader.path[i].y),
                                new THREE.Vector3(this.checkpointLine['x3'], 0, this.checkpointLine['y3']*(-1)),
                                new THREE.Vector3(this.checkpointLine['x4'], 0, this.checkpointLine['y4']*(-1)))
                                                            >
            Algorithm.calcDistToLine(new THREE.Vector3(yacht.path[i].x, 0, yacht.path[i].y),
                                new THREE.Vector3(this.checkpointLine['x3'], 0, this.checkpointLine['y3']*(-1)),
                                new THREE.Vector3(this.checkpointLine['x4'], 0, this.checkpointLine['y4']*(-1)))) {
            this.leader = yacht;
            this.gapArray[this.leader.id].innerText = 0;
            Algorithm.formatTable(Algorithm.bubbleSort(this.trArray));
        }
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
    getCurrentSpeed(){
        return 5/this.duration[this.currentSpeed];
    }
}