/// @desc Sphere functions using arrays [x, y, z, radius]

function sphere_create(x = 0, y = 0, z = 0, r = 0) {
    gml_pragma("forceinline");
    return [x, y, z, r];
}

function sphere_set(s, x, y, z, r) {
    gml_pragma("forceinline");
    s[@0] = x;
    s[@1] = y;
    s[@2] = z;
    s[@3] = r;
}

function sphere_copy(s, src) {
    gml_pragma("forceinline");
    s[@0] = src[0];
    s[@1] = src[1];
    s[@2] = src[2];
    s[@3] = src[3];
}

function sphere_clone(s) {
    gml_pragma("forceinline");
    return [s[0], s[1], s[2], s[3]];
}

/// @func sphere_apply_matrix4(s, m)
/// @desc Transforms the sphere by the given matrix 4.
function sphere_apply_matrix4(s, m) {
    gml_pragma("forceinline");
    var _x = s[0], _y = s[1], z = s[2], r = s[3];
    
    // Transform center
    var w = 1 / (m[3] * x + m[7] * y + m[11] * z + m[15]);
    s[@0] = (m[0] * x + m[4] * y + m[8] * z + m[12]) * w;
    s[@1] = (m[1] * x + m[5] * y + m[9] * z + m[13]) * w;
    s[@2] = (m[2] * x + m[6] * y + m[10] * z + m[14]) * w;
    
    // Transform radius (using max scale)
    var sx = m[0]*m[0] + m[1]*m[1] + m[2]*m[2];
    var sy = m[4]*m[4] + m[5]*m[5] + m[6]*m[6];
    var sz = m[8]*m[8] + m[9]*m[9] + m[10]*m[10];
    var maxScale = sqrt(max(sx, sy, sz));
    
    s[@3] = r * maxScale;
}

/// @func sphere_contains_point(s, px, py, pz)
function sphere_contains_point(s, px, py, pz) {
    gml_pragma("forceinline");
    var dx = px - s[0];
    var dy = py - s[1];
    var dz = pz - s[2];
    return (dx*dx + dy*dy + dz*dz) <= (s[3] * s[3]);
}

/// @func sphere_intersects_sphere(s1, s2)
function sphere_intersects_sphere(s1, s2) {
    gml_pragma("forceinline");
    var rSum = s1[3] + s2[3];
    var dx = s1[0] - s2[0];
    var dy = s1[1] - s2[1];
    var dz = s1[2] - s2[2];
    return (dx*dx + dy*dy + dz*dz) <= (rSum * rSum);
}
