class Yacht {
    constructor(manager) {
        this.manager = manager;
        this.yacht = null;
        this.path = [];
        // this.counter = 0;
    }
    addYacht(obj) {
        this.yacht = obj;

    }
    addToScene() {
        this.manager.scene.add(this.yacht);
    }
    moveYacht(pos) {
        this.yacht.position.x = pos['x'];
        this.yacht.position.z = pos['y'];
        this.yacht.rotation.z = pos['a'];
    }
    moveYachtInit() {
        this.yacht.translateY(this.randomInRange(-1000, 1000));
        this.yacht.translateX(this.randomInRange(-1000, 1000));
    }
    moveYachtTween(pos) {
        let position = {
            x: this.yacht.position.x,
            y: this.yacht.position.z,
            z: this.yacht.rotation.z
        };
        let target = {
            x: pos['x'],
            y: pos['y'],
            z: pos['a']
        };
        let tween = new TWEEN.Tween(position).to(target, 1000);
        tween.onUpdate(() => {
            this.yacht.position.x = position.x;
            this.yacht.position.z = position.y;
            this.yacht.rotation.z = position.z;
        });
        tween.easing(TWEEN.Easing.Linear.None);
        tween.start();

    }

    calcPath() {
        let path = [];
        var latArray = [54.9220681563019, 54.9220895720645, 54.9220378138124, 54.9220349639654, 54.9220350477844, 54.9220578046515, 54.9221576750278, 54.9221784202382, 54.921914935112, 54.9215298285707, 54.920984795317, 54.9204428633675, 54.9199562519788, 54.9194688443094, 54.9189836997538, 54.918476594612, 54.9179806793108, 54.9175243265926, 54.917237246409, 54.9169012997299, 54.9164439411833, 54.9159068288281, 54.9153804453089, 54.9149643676355, 54.9146851245313, 54.914351273328, 54.9140465911477, 54.9135702475905, 54.9132645595818, 54.9132184591144, 54.9131546309217, 54.9131349753588, 54.9131109192967, 54.9130971729755, 54.9131115479394, 54.9131913017481, 54.9132968718186, 54.9133455287665, 54.9133464926853, 54.9133182037621, 54.9132690858095, 54.9132616259157, 54.9132607458159, 54.9132607458159, 54.9132607458159, 54.9132607458159, 54.9132607458159, 54.9132607458159, 54.9132607458159, 54.9132607458159, 54.9132738215848, 54.9130094144493, 54.9124442646279, 54.9117397237569, 54.9110853904858, 54.9105325620621, 54.9099950306117, 54.9095907714217, 54.9093051580712, 54.9089984642341, 54.9086244218051, 54.9081756127998, 54.9077281868085, 54.9071801360696, 54.9066243320703, 54.9060599785298, 54.905492439866, 54.9053039727732, 54.9052959680557, 54.9052415695041, 54.9053810443729, 54.9054874945431, 54.9056421406567, 54.9056751234456, 54.9056982574984];
        var lonArray = [23.934377906844, 23.9343556109815, 23.9343116898089, 23.9342725463211, 23.9342644996941, 23.9339673612266, 23.9334227889776, 23.9332553185522, 23.933072425425, 23.9328919630497, 23.9325747918337, 23.9322750549763, 23.9320211671292, 23.931787982583, 23.9315346814692, 23.931283140555, 23.9310138300061, 23.9309155941009, 23.9315708912909, 23.9322488196194, 23.932427689433, 23.9324513264, 23.9325009472668, 23.9324552658945, 23.9324110932648, 23.9323389250785, 23.9321411959826, 23.9317996334284, 23.9316041674464, 23.9310758560895, 23.9301061537116, 23.9291604235768, 23.9287780411541, 23.9284225646406, 23.9280392602086, 23.9276833645999, 23.9272201806306, 23.9267989899963, 23.9264288451522, 23.9258608873933, 23.9253373537212, 23.9251018222421, 23.9251014031469, 23.9251014031469, 23.9251014031469, 23.9251014031469, 23.9251014031469, 23.9251014031469, 23.9251014031469, 23.9251014031469, 23.9248615130782, 23.9245687332004, 23.9248288236558, 23.9251371100544, 23.9256219193339, 23.9263653103262, 23.9270839747041, 23.9276184886693, 23.9280027989298, 23.9283952396363, 23.9288198668509, 23.9292855653911, 23.9298728853464, 23.9305364806205, 23.9312403928488, 23.9317948557436, 23.9319486636668, 23.9319139625877, 23.9319107774645, 23.9321124460548, 23.9327119197696, 23.9332225453108, 23.9330554101616, 23.9329740218818, 23.93294585868];

        for (var i = 0; i < latArray.length; i++) {
            path[i] = Algorithm.getXY(latArray[i], lonArray[i]);
            if (i != 0)
                path[i].a = Algorithm.getAngle(path[i - 1], path[i]);
        }
        this.path = path;
    }

    randomInRange(min, max) {
        return Math.random() < 0.5 ? ((1 - Math.random()) * (max - min) + min) : (Math.random() * (max - min) + min);
    }

}