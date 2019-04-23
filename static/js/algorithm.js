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
    static toRadians(degrees) {
        return degrees * (Math.PI / 180);
    }

    static calcSpeed(lat1, lon1, lat2, lon2) {
        let R = 6371e3; // metres
        let φ1 = this.toRadians(lat1);
        let φ2 = this.toRadians(lat2);
        let Δφ = this.toRadians((lat2 - lat1));
        let Δλ = this.toRadians((lon2 - lon1));

        let a = Math.sin(Δφ / 2) * Math.sin(Δφ / 2) +
            Math.cos(φ1) * Math.cos(φ2) *
            Math.sin(Δλ / 2) * Math.sin(Δλ / 2);
        let c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

        let d = R * c;
        return (d / 1000) / (timeInterval / 3600);
    }

    static getXY(pos_lat, pos_lon) {
        return {
            x: center_x + ((pos_lon - defLon) / dpp),
            y: center_y - ((pos_lat - defLat) / dpp)
        };
    }

    static getAngle(from, to) {
        return Math.atan2(to.x - from.x, to.y - from.y) - angleOffset;
    }

}