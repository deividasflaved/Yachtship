// x = { lat: 25, lon: -40 }; calcDistance(x, calcDestination(x, 90.000000001, 92))

EARTH_RADIUS = 6378137
NMI = 1852

var angularArithmetic = {
    '+': function(a, b) { return angle360(a + b) }
  , '-': function(a, b) { return calcShift(b, a) }
}

function avgAngle(xs) {
    var a = 0
    _.each(xs, function(x, i) {
        a += calcShift(a, x) / (i + 1)
    })
    return a
}

function calcPos(wind, heading, spinnaker) {
    if (wind == null) return ''
    var a = calcShift(wind, heading)
    var b = a > 0 ? 'S' : 'P'
    a = Math.abs(a)
    return (a < 30 && spinnaker ? 'SR' : /*a < 30 ? 'GR' :*/ a < 80 && spinnaker ? 'BR' : a < 120 ? 'CR' : 'CH') + b
}

function posTack(p) {
    return p[2]
}

function posSpin(p) {
    return p[0] != 'C'
}

function posKind(p) {
    return p.substr(0, 2)
}

function posSign(p) {
    switch(posKind(p)) {
        case 'CH': return  1
        case 'CR':
        case 'BR': return  0
        case 'SR': return -1
        default  : return  undefined
    }
}

function posUp(p) {
    return posKind(p) == 'CH'
}

function posDown(p) {
    return posKind(p) == 'SR'
}

function posReach(p) {
    var k = posKind(p)
    return k == 'CR' || k == 'BR'
}

function toRadians(value) {
    return value * Math.PI / 180
}

function toDegrees(value) {
    return value / Math.PI * 180
}

function angle360(angle) {
    while (angle > 360) angle -= 360
    while (angle <   0) angle += 360
    return angle
}

function angle180(angle) {
    while (angle >  180) angle -= 360
    while (angle < -180) angle += 360
    return angle
}

function calcShift(b1, b2) {
    var shift = b2 - b1
    if (shift > +180) shift -= 360
    if (shift < -180) shift += 360
    return shift
}

function calcBisector(a1, a2) {
    return angle360(a1 + calcShift(a1, a2) / 2)
}

function calcSpeed(d, t) {
    return ms2kn(d / (t + 1e-9) * 1e3)
}

function ms2kn(x) {
    return x / NMI * 3600
}

function kn2ms(x) {
    return x * NMI / 3600
}

function calcDirection(p1, p2) {
    p2 = calcNearestPoint(p1, p2)
    var lat1 = toRadians(p1.lat), lon1 = toRadians(p1.lon), lat2 = toRadians(p2.lat), lon2 = toRadians(p2.lon)
    var dLon = lon2 - lon1
    var y = Math.sin(dLon) * Math.cos(lat2)
    var x = Math.cos(lat1) * Math.sin(lat2) - Math.sin(lat1) * Math.cos(lat2) * Math.cos(dLon)
    var brng = Math.atan2(y, x) / Math.PI * 180
    if (brng < 0) brng += 360
    return brng
}

function calcDistance(p1, p2, line) {
    p2 = calcNearestPoint(p1, p2, line)
    var lat1 = toRadians(p1.lat), lon1 = toRadians(p1.lon), lat2 = toRadians(p2.lat), lon2 = toRadians(p2.lon)
    var x = (lon2 - lon1) * Math.cos((lat1 + lat2) / 2)
    var y = (lat2 - lat1)
    return Math.sqrt(x * x + y * y) * EARTH_RADIUS
}

function calcProjection(p1, p2, direction) {
    p2 = calcNearestPoint(p1, p2)
    var distance = calcDistance(p1, p2)
    var bearing = calcDirection(p1, p2)
    return Math.cos(toRadians(direction) - toRadians(bearing)) * distance
}

function calcNearestPoint(p1, p2, line) {
    if (!p2) return p1.gate
    if (!p2.gate || p2.type === "Mark with offset") return p2

    var A = p1.lat - p2.lat
    var B = p1.lon - p2.lon
    var C = p2.gate.lat - p2.lat
    var D = p2.gate.lon - p2.lon
    var param = (A * C + B * D) / (C * C + D * D)

    if (line || (param > 0 && param < 1)) {
        return { lat: p2.lat + param * C, lon: p2.lon + param * D }
    } else if (param <= 0) {
        return p2
    } else {
        return p2.gate
    }
}

function calcDLat(p1, p2, p3) {
    if (!p3) return p2.lat - p1.lat
    return p2.lat + (p3.lat - p2.lat) / (p3.lon - p2.lon) * (p1.lon - p2.lon) - p1.lat
}

function calcCross(p1, p2, p3, p4) {
    return signum(calcDLat(p1, p3, p4)) != signum(calcDLat(p2, p3, p4))
}

function calcDestination(p1, bearing, distance) {
    var d = distance / EARTH_RADIUS
    var lat1 = toRadians(p1.lat), lon1 = toRadians(p1.lon);
    brng = toRadians(bearing)
    var lat2 = lat1 + d * Math.cos(brng)
    var dLat = lat2 - lat1
    var dPhi = Math.log(Math.tan(lat2/2 + Math.PI/4) / Math.tan(lat1/2 + Math.PI/4))
    var q = Math.abs(dPhi) > 1e-9 ? dLat/dPhi : Math.cos(lat1) // E-W line gives dPhi=0
    var dLon = d * Math.sin(brng) / q
    // check for some daft bugger going past the pole
    if (Math.abs(lat2) > Math.PI/2) lat2 = lat2 > 0 ? Math.PI - lat2 : -(Math.PI - lat2)
    lon2 = (lon1 + dLon + 3*Math.PI) % (2*Math.PI) - Math.PI
    return { lat: toDegrees(lat2), lon: toDegrees(lon2), alt: p1.alt }
}

function calcMiddle(p1, p2) {
    if (!p2) p2 = p1.gate
    if (!p2) return p1
    return { lat: (p1.lat + p2.lat) / 2, lon: (p1.lon + p2.lon) / 2, alt: ((p1.alt || 0) + (p2.alt || 0)) / 2 }
}

function extendBounds(a, b) {
    var lat1 = a.lat || a.lat1, lon1 = a.lon || a.lon1, lat2 = a.lat2, lon2 = a.lon2
    if (typeof(b) === 'object') {
        return {
            lat1: Math.min(lat1, b.lat1)
          , lon1: Math.min(lon1, b.lon1)
          , lat2: Math.max(lat2, b.lat2)
          , lon2: Math.max(lon2, b.lon2)
        }
    } else {
        return {
            lat1: Math.min(lat1, lat2) - b
          , lon1: Math.min(lon1, lon2) - b
          , lat2: Math.max(lat1, lat2) + b
          , lon2: Math.max(lon1, lon2) + b
        }
    }
}

function calcDelta(p1, p2) {
  return { lat: p2.lat - p1.lat, lon: p2.lon - p1.lon }
}

/*
function calcVMG(p1, p2, wp) {
  var d1 = calcDistance(p1, wp)
  var d2 = calcDistance(p2, wp)
  return calcSpeed(d1 - d2, p2.time - p1.time)
}
*/
