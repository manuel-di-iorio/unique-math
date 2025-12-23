/// @desc Ray functions using arrays [ox, oy, oz, dx, dy, dz]

function ray_create(ox = 0, oy = 0, oz = 0, dx = 0, dy = 0, dz = -1) {
    gml_pragma("forceinline");
    return [ox, oy, oz, dx, dy, dz];
}

function ray_set(r, ox, oy, oz, dx, dy, dz) {
    gml_pragma("forceinline");
    r[@0] = ox; r[@1] = oy; r[@2] = oz;
    r[@3] = dx; r[@4] = dy; r[@5] = dz;
}

function ray_copy(r, src) {
    gml_pragma("forceinline");
    array_copy(r, 0, src, 0, 6);
}

function ray_clone(r) {
    gml_pragma("forceinline");
    return [r[0], r[1], r[2], r[3], r[4], r[5]];
}

/// @func ray_at(r, t, out)
/// @desc Returns vector at distance t along ray.
function ray_at(r, t, out = undefined) {
    gml_pragma("forceinline");
    out ??= array_create(3);
    out[@0] = r[0] + r[3] * t;
    out[@1] = r[1] + r[4] * t;
    out[@2] = r[2] + r[5] * t;
    return out;
}

/// @func ray_recenter(r, ox, oy, oz)
function ray_recenter(r, ox, oy, oz) {
    gml_pragma("forceinline");
    r[@0] = ox; r[@1] = oy; r[@2] = oz;
}

/// @func ray_look_at(r, tx, ty, tz)
/// @desc Adjusts direction to look at target.
function ray_look_at(r, tx, ty, tz) {
    gml_pragma("forceinline");
    var dx = tx - r[0];
    var dy = ty - r[1];
    var dz = tz - r[2];
    var len = sqrt(dx*dx + dy*dy + dz*dz);
    if (len > 0) {
        var invLen = 1 / len;
        r[@3] = dx * invLen;
        r[@4] = dy * invLen;
        r[@5] = dz * invLen;
    }
}

/// @func ray_intersect_sphere(r, sphere)
/// @desc Returns the distance to intersection or -1 if none.
function ray_intersect_sphere(r, sphere) {
    gml_pragma("forceinline");
    var sx = sphere[0], sy = sphere[1], sz = sphere[2], radius = sphere[3];
    
    var vx = sx - r[0];
    var vy = sy - r[1];
    var vz = sz - r[2];
    
    var tca = vx * r[3] + vy * r[4] + vz * r[5];
    if (tca < 0) return -1; // Behind origin
    
    var d2 = (vx*vx + vy*vy + vz*vz) - tca*tca;
    var radius2 = radius*radius;
    
    if (d2 > radius2) return -1; // Outside radius
    
    var thc = sqrt(radius2 - d2);
    
    // t0 = first intersection
    var t0 = tca - thc;
    
    // t1 = second intersection
    // var t1 = tca + thc; 
    
    if (t0 < 0) {
        // origin inside?
        t0 = tca + thc;
        if (t0 < 0) return -1;
    }
    
    return t0;
}

function ray_intersect_box(r, box) {
    var ox = r[0], oy = r[1], oz = r[2];
    var dx = r[3], dy = r[4], dz = r[5];

    var tmin = -1000000;
    var tmax = 1000000;

    // X slab
    if (dx != 0) {
        var tx1 = (box[0] - ox) / dx;
        var tx2 = (box[3] - ox) / dx;
        tmin = max(tmin, min(tx1, tx2));
        tmax = min(tmax, max(tx1, tx2));
    } else if (ox < box[0] || ox > box[3]) {
        return -1; // parallel and outside
    }

    // Y slab
    if (dy != 0) {
        var ty1 = (box[1] - oy) / dy;
        var ty2 = (box[4] - oy) / dy;
        tmin = max(tmin, min(ty1, ty2));
        tmax = min(tmax, max(ty1, ty2));
    } else if (oy < box[1] || oy > box[4]) {
        return -1;
    }

    // Z slab
    if (dz != 0) {
        var tz1 = (box[2] - oz) / dz;
        var tz2 = (box[5] - oz) / dz;
        tmin = max(tmin, min(tz1, tz2));
        tmax = min(tmax, max(tz1, tz2));
    } else if (oz < box[2] || oz > box[5]) {
        return -1;
    }

    if (tmax < 0 || tmin > tmax) return -1;

    return (tmin >= 0) ? tmin : tmax;
}

