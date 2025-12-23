/// @desc Plane functions using arrays [nx, ny, nz, constant]

function plane_create(nx = 0, ny = 1, nz = 0, constant = 0) {
    gml_pragma("forceinline");
    return [nx, ny, nz, constant];
}

function plane_set(p, nx, ny, nz, constant) {
    gml_pragma("forceinline");
    p[@0] = nx;
    p[@1] = ny;
    p[@2] = nz;
    p[@3] = constant;
}

function plane_copy(p, src) {
    gml_pragma("forceinline");
    p[@0] = src[0];
    p[@1] = src[1];
    p[@2] = src[2];
    p[@3] = src[3];
}

function plane_clone(p) {
    gml_pragma("forceinline");
    return [p[0], p[1], p[2], p[3]];
}

/// @func plane_normalize(p)
/// @desc Normalizes the plane normal and adjusts constant.
function plane_normalize(p) {
    gml_pragma("forceinline");
    var nx = p[0], ny = p[1], nz = p[2];
    var len = sqrt(nx*nx + ny*ny + nz*nz);
    if (len > 0) {
        var invLen = 1 / len;
        p[@0] *= invLen;
        p[@1] *= invLen;
        p[@2] *= invLen;
        p[@3] *= invLen;
    }
}

/// @func plane_distance_to_point(p, px, py, pz)
/// @desc Returns signed distance from point to plane.
function plane_distance_to_point(p, px, py, pz) {
    gml_pragma("forceinline");
    return p[0] * px + p[1] * py + p[2] * pz + p[3];
}

/// @func plane_set_from_normal_and_coplanar_point(p, nx, ny, nz, px, py, pz)
/// @desc Sets plane from normal and a point on the plane.
function plane_set_from_normal_and_coplanar_point(p, nx, ny, nz, px, py, pz) {
    gml_pragma("forceinline");
    p[@0] = nx;
    p[@1] = ny;
    p[@2] = nz;
    p[@3] = -(nx * px + ny * py + nz * pz);
}
