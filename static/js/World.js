class World {
    constructor(manager) {
        this.manager = manager;
    }

    initWater() {
        let waterGeometry = new THREE.PlaneBufferGeometry(10000, 10000);

        this.water = new THREE.Water(waterGeometry, {
            textureWidth: 512,
            textureHeight: 512,
            waterNormals: new THREE.TextureLoader().load(
                filesLoc + 'waternormals.jpg',
                function(texture) {
                    texture.wrapS = texture.wrapT = THREE.RepeatWrapping;
                }),
            alpha: 1.0,
            sunDirection: this.light.position.clone().normalize(),
            sunColor: 0xffffff,
            waterColor: 0x001e0f,
            distortionScale: 3.7,
        });
        this.water.rotation.x = -Math.PI / 2;
        this.manager.scene.add(this.water);

    }

    initLight() {
        this.light = new THREE.DirectionalLight(0xffffff, 0.6);
        this.manager.scene.add(this.light);
    }

    initSkybox() {
        let geometry = new THREE.CubeGeometry(9000, 9000, 9000);
        let cubeMaterials = [
            new THREE.MeshBasicMaterial({
                map: new THREE.TextureLoader().load(filesLoc + 'nightsky_ft.png'),
                side: THREE.DoubleSide
            }), //front side
            new THREE.MeshBasicMaterial({
                map: new THREE.TextureLoader().load(filesLoc + 'nightsky_bk.png'),
                side: THREE.DoubleSide
            }), //back side
            new THREE.MeshBasicMaterial({
                map: new THREE.TextureLoader().load(filesLoc + 'nightsky_up.png'),
                side: THREE.DoubleSide
            }), //up side
            new THREE.MeshBasicMaterial({
                map: new THREE.TextureLoader().load(filesLoc + 'nightsky_dn.png'),
                side: THREE.DoubleSide
            }), //down side
            new THREE.MeshBasicMaterial({
                map: new THREE.TextureLoader().load(filesLoc + 'nightsky_rt.png'),
                side: THREE.DoubleSide
            }), //right side
            new THREE.MeshBasicMaterial({
                map: new THREE.TextureLoader().load(filesLoc + 'nightsky_lf.png'),
                side: THREE.DoubleSide
            }) //left side
        ];

        let cubeMaterial = new THREE.MeshFaceMaterial(cubeMaterials);
        let cube = new THREE.Mesh(geometry, cubeMaterial);
        this.manager.scene.add(cube);
    }
}