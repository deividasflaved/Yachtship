const defLat = 54.911565;
const defLon = 23.930066;
const center_x = 0;
const center_y = 0;
const dpp = 0.000005;
const angleOffset = 1.5708;
const timeInterval = 5;

class Algorithm {
    constructor() {

    }
    static cleanUpGpsData(gpsData, teamId){
        let cleanedData = [];
        let count = 0;
        for (let i = 0; i < gpsData.length; i++){
            if(gpsData[i].team_id === teamId)
                cleanedData[count++]=gpsData[i];
        }
        return cleanedData;
    }
    static toRadians(degrees) {
        return degrees * (Math.PI / 180);
    }

    // noinspection JSUnusedGlobalSymbols
    static calcSpeed(x1, y1, x2, y2) {
        let d = this.getDistance(x1, y1, x2, y2);
        return (d / 1000) / (timeInterval / 3600);
    }

    static getXY(pos_lat, pos_lon) {
        return {
            x: center_x + ((pos_lon - defLon) / dpp),
            y: center_y - ((pos_lat - defLat) / dpp)
        };
    }
    static getLonLat(x, y) {
        return {
            lon: (x - center_x + defLon / dpp) * dpp,
            lat: (y - center_y + defLat / dpp) * dpp
        }
    }
    static getDistance(x1, y1, x2, y2){
        let lon1, lat1, lon2, lat2;
        let temp = this.getLonLat(x1, y1);
        lon1 = temp.lon;
        lat1 = temp.lat;
        temp = this.getLonLat(x2, y2);
        lon2 = temp.lon;
        lat2 = temp.lat;

        let R = 6371000; // metres
        let φ1 = this.toRadians(lat1);
        let φ2 = this.toRadians(lat2);
        let Δφ = this.toRadians((lat2 - lat1));
        let Δλ = this.toRadians((lon2 - lon1));

        let a = Math.sin(Δφ / 2) * Math.sin(Δφ / 2) +
            Math.cos(φ1) * Math.cos(φ2) *
            Math.sin(Δλ / 2) * Math.sin(Δλ / 2);
        let c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

        return this.roundNumber(R * c); //d = R * c
    }
    static getAngle(from, to) {
        return Math.atan2(to.x - from.x, to.y - from.y) - angleOffset;
    }

    static getRandom(min, max) {
        let minn = Math.ceil(min);
        let maxx = Math.floor(max);
        return Math.floor(Math.random() * (maxx - minn)) + minn; //The maximum is exclusive and the minimum is inclusive
    }

    static formatTime(time)
{
    // Hours, minutes and seconds
    let hrs = ~~(time / 3600);
    let mins = ~~((time % 3600) / 60);
    let secs = ~~time % 60;

    // Output like "1:01" or "4:03:59" or "123:03:59"
    let ret = "";

    // if (hrs > 0) {
        ret += (hrs < 10 ? "0" : "") + hrs + ":" + (mins < 10 ? "0" : "");
    // }

    ret += "" + mins + ":" + (secs < 10 ? "0" : "");
    ret += "" + secs;
    return ret;
}

    static roundNumber(numb){
        return Math.round(numb * 100) / 100;
    }

    static calcDistToLine(objPoint, linePointA,  linePointB){
        let P = objPoint;
        // console.log(this.line.geometry.vertices)
        let A = linePointA;
        let B =  linePointB;

        let D = B.clone().sub(A).normalize();
        let d = P.clone().sub(A).dot(D);
        let X = A.clone().add(D.clone().multiplyScalar(d));
        // console.log(X);
        return this.roundNumber(this.getDistance(objPoint.x, objPoint.z, X.x, X.z));
    }

    static lerp(a, b, t) {return a + (b - a) * t}

    static ease(t) { return t }

    static bubbleSort(inputArr){
        let len = inputArr.length;
        for (let i = 0; i < len; i++) {
            for (let j = 0; j < len - 1; j++) {
                let inputJ = parseFloat(inputArr[j].cells[3].innerText);
                let inputJ1 = parseFloat(inputArr[j + 1].cells[3].innerText);
                if (inputJ > inputJ1) {
                    let tmp = inputArr[j];
                    inputArr[j] = inputArr[j + 1];
                    inputArr[j + 1] = tmp;
                }
            }
        }
        return inputArr;
    };

    static convertSpeedToKnots(speed){
        return speed * 0.539957;
    }

    static formatTable(inputArr){
        inputArr.forEach((tr, i)=>{
            tr.childNodes[0].innerText = i + 1;
            tr.parentNode.appendChild(tr);
        });
    }

    static gapToLeader(obj){

    }
}