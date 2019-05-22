// const x = 638.9868854761005;
// const y = 1218.417993665355;
// const x1 = 641.87026016711;
// const y1 = -2221.313902258259;
class Replay {
    constructor(manager) {
        this.manager = manager;
        this.duration = [0.25, 0.5, 1, 2, 4, 5]; this.currentSpeed = 5; this.elapsed = 0;
        this.paused = false;
        this.loop = this.loop.bind(this);
        this.clock = new Clock();
        this.speedArray = [];
        this.leader = null;
        this.slider = document.getElementById("myRange");
        this.elapsedTimeTxt = document.getElementById("elapsedTime");
        this.material = new THREE.LineBasicMaterial( { color: 0x17a2b8 } ); //#17a2b8
        this.material.linewidth= 1.5;
        this.geometry = new THREE.Geometry();
        this.line = null;
        this.roundedTimePast = null;
        this.trArray = [];
        this.gapArray = [];
        this.stageOfYacht = [];
        // this.ind = 0;
    }

    initSpeedElems(){
        this.manager.yachts.forEach((yacht) => {
            let elem = document.getElementById("speed" + yacht.id);
            this.speedArray.push(elem);
            if(yacht.path.length > 0  && this.leader == null)
                this.leader = yacht;

            elem = document.getElementById("trId" + yacht.id);
            this.trArray.push(elem);

            elem = document.getElementById("gap" + yacht.id);
            this.gapArray.push(elem);

            this.stageOfYacht.push(0);

            
        });
        this.speedArray[this.leader.id].innerText = 0;
        console.log(this.manager.scene);
    }
    drawLine(yacht){
        let angle = Algorithm.getAngle({x : x1, y : y1},{x : x, y : y})+1.5708;
        let new_x1 =  yacht.position.x + 3000 * Math.cos((angle*180/Math.PI) * Math.PI / 180);
        let new_x2 =  yacht.position.x - 3000 * Math.cos((angle*180/Math.PI) * Math.PI / 180);
        let new_y1 =  yacht.position.z + 3000 * Math.sin((angle*180/Math.PI) * Math.PI / 180);
        let new_y2 =  yacht.position.z - 3000 * Math.sin((angle*180/Math.PI) * Math.PI / 180);

        manage.scene.remove(this.line);

        this.geometry = new THREE.Geometry();
        this.geometry.vertices.push(new THREE.Vector3( new_x2, 2, new_y2) );
        this.geometry.vertices.push(new THREE.Vector3( new_x1, 2, new_y1) );
        this.line = new THREE.Line( this.geometry, this.material );

        manage.scene.add(this.line);
    }
    drawTrail(yacht){
        
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
                    if(this.stageOfYacht[yacht.id] % 2 == 0){
                        this.getLeader(yacht, roundedTime)
                    }
                    this.drawLine(this.leader.yacht);
                    if(yacht != this.leader && this.roundedTimePast != roundedTime) {
                        this.gapArray[yacht.id].innerText = Algorithm.calcDistToLine(yacht.yacht.position, this.geometry.vertices[0], this.geometry.vertices[1]);
                        Algorithm.formatTable(Algorithm.bubbleSort(this.trArray));
                    }
                    // if(Algorithm.calcDistToLine(new THREE.Vector3(x, 0, y), this.geometry.vertices[0], this.geometry.vertices[1])< 2) {
                    //     this.movingToCheckpoint = false;
                    //     console.log(Algorithm.calcDistToLine(new THREE.Vector3(x, 0, y), this.geometry.vertices[0], this.geometry.vertices[1]))
                    // }
                    // this.manager.scene.remove(yacht.trail);
                    let positions = yacht.trail.geometry.attributes.position.array;
                    positions[yacht.ind++] = yacht.yacht.position.x;
                    positions[yacht.ind++] = 2;
                    positions[yacht.ind++] = yacht.yacht.position.z;
                    // yacht.trail.geometry.attributes.position[ind++]= (new THREE.Vector3(yacht.yacht.position.x, 2, yacht.yacht.position.z));
                    // this.manager.scene.add(yacht.trail);
                    // yacht.trail.geometry.attributes.position.needsUpdate = true;
                    // yacht.trail.geometry.setDrawRange(0, yacht.trail.geometry.vertices.length);
                    // console.log(yacht.trail.geometry);
                    if(this.roundedTimePast != roundedTime ){
                        // this.manager.scene.remove(yacht.trail);
                        yacht.trail.geometry.setDrawRange( 0, yacht.ind/3 );
                        yacht.trail.geometry.attributes.position.needsUpdate = true;
                        // this.manager.scene.add(yacht.trail);
                    }
                    if(this.roundedTimePast != roundedTime && roundedTime == 30){
                        // this.manager.scene.remove(yacht.trail);
                    }
                    // console.log(this.manager);
                }
                else{
                    // this.manager.scene.add(yacht.trail);
                }
        });
        
        this.slider.value = this.clock.getElapsedTime() / this.duration[this.currentSpeed] * 100;
        this.elapsedTimeTxt.innerText = "Elapsed:\n" +  Algorithm.formatTime( Math.floor(this.clock.getElapsedTime()*5/this.duration[this.currentSpeed]));
        this.roundedTimePast = roundedTime;
        requestAnimationFrame(this.loop);
    }
    getLeader(yacht, i){
        if(this.leader.path[i]!=null)
        if(Algorithm.getDistance(this.leader.path[i].x, this.leader.path[i].y, x, y ) > Algorithm.getDistance(yacht.path[i].x, yacht.path[i].y, x, y )) {
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
    changeSpeed(){
        let speedBefore = this.duration[this.currentSpeed];

        if(this.currentSpeed <= 0)
            this.currentSpeed = this.duration.length - 1;
        else
            this.currentSpeed--;

        let speedAfter = this.duration[this.currentSpeed];
        let temp = speedAfter / speedBefore;

        this.elapsed = this.clock.getElapsedTime() * temp;
        this.clock.elapsedTime = this.clock.getElapsedTime() * temp;
    }
}