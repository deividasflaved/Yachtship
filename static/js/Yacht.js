class Yacht {
    constructor(manager) {
        this.manager = manager;
        this.yacht = null;
        // this.counter = 0;
    }
    addYacht(obj) {
        this.yacht = obj;

    }
    addToScene() {
        this.manager.scene.add(this.yacht);
    }
    moveYacht() {
        this.yacht.translateY(this.randomInRange(-1000, 1000));
        this.yacht.translateX(this.randomInRange(-1000, 1000));
        this.yacht.rotation.z = this.randomInRange(0, 360);
        // var color = new THREE.Color(this.randomInRange(0, 1), this.randomInRange(0, 1), this.randomInRange(0, 1));
        // this.yacht.material.color = color;
        // this.yacht.name = 'Yacht' + this.counter++;
    }

    randomInRange(min, max) {
        return Math.random() < 0.5 ? ((1 - Math.random()) * (max - min) + min) : (Math.random() * (max - min) + min);
    }
}