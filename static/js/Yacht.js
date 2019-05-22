class Yacht {
    constructor(manager) {
        this.manager = manager;
        this.id = null;
        this.yacht = null;
        this.path = [];
        this.color = null;
        this.t = 0, this.dt = 0.01;
        this.startTime = 0; this.duration = 5000;
        this.trail = null;
        this.ind = 0;
        // this.counter = 0;
    }

    addYacht(obj) {
        this.yacht = obj;

    }

    addToScene() {
        this.manager.scene.add(this.yacht);
    }

    initTrail(){
        let material = new THREE.LineBasicMaterial( { color: colorArray[this.color] } );
        material.linewidth = 2; 
        let geometry = new THREE.BufferGeometry();
        let positions = new Float32Array( 100000 * 3 ); // 3 vertices per point
	    geometry.addAttribute( 'position', new THREE.BufferAttribute( positions, 3 ) );

	// drawcalls
	    let drawCount = 0; // draw the first 2 points, only
        geometry.setDrawRange( 0, 0 );
        geometry.dynamic = true;
        // geometry.vertices.push(new THREE.Vector3(this.path[0], 2, this.path[0]));
        this.trail = new THREE.Line( geometry, material );
        this.manager.scene.add(this.trail);
    }

    moveYacht(pos1, pos2, t) {
        let newX = Algorithm.lerp(pos1.x, pos2.x, Algorithm.ease(t)); // interpolate between a and b where// t is first passed through a easing
        let newZ = Algorithm.lerp(pos1.y, pos2.y, Algorithm.ease(t)); // function in this example.
        let newZR = Algorithm.lerp(pos1.a, pos2.a, Algorithm.ease(t));
        this.setPosition(newX, 0, newZ); // set new position
        this.setRotation(0, 0, newZR); //set new rotation
    }

    moveYachtInit() {
        this.yacht.translateY(Algorithm.getRandom(-1000, 1000));
        this.yacht.translateX(Algorithm.getRandom(-1000, 1000));
    }

    setPosition(newX, newY, newZ){
        this.yacht.position.set(newX, newY, newZ);
    }

    setRotation(newX, newY, newZ){
        this.yacht.rotation.z = newZ;
    }
    calcPath(gpsData, check) {
        let path = [];
        for (let i = 0; i < gpsData.length; i++) {
            path[i] = Algorithm.getXY(gpsData[i].latitude, gpsData[i].longitude);
            if(check){
                path[i].x += Algorithm.getRandom(200,250);
                path[i].y += Algorithm.getRandom(200,250);
            }
            path[i].time = gpsData[i].time;
            if (i !== 0)
                path[i].a = Algorithm.getAngle(path[i - 1], path[i]);
        }
        this.path = path;
    }

}