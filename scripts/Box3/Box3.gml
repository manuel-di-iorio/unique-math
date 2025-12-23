/// @desc Box3 functions using arrays [minX, minY, minZ, maxX, maxY, maxZ]

/// @func box3_create(minX, minY, minZ, maxX, maxY, maxZ)
function box3_create(minX = infinity, minY = infinity, minZ = infinity, maxX = -infinity, maxY = -infinity, maxZ = -infinity) {
    gml_pragma("forceinline");
    return [minX, minY, minZ, maxX, maxY, maxZ];
}

function box3_set(b, minX, minY, minZ, maxX, maxY, maxZ) {
    gml_pragma("forceinline");
    b[@0] = minX; b[@1] = minY; b[@2] = minZ;
    b[@3] = maxX; b[@4] = maxY; b[@5] = maxZ;
}

function box3_copy(b, src) {
    gml_pragma("forceinline");
    array_copy(b, 0, src, 0, 6);
}

function box3_clone(b) {
    gml_pragma("forceinline");
    return [b[0], b[1], b[2], b[3], b[4], b[5]];
}

/// @func box3_expand_by_point(b, x, y, z)
function box3_expand_by_point(b, x, y, z) {
    gml_pragma("forceinline");
    if (x < b[0]) b[@0] = x;
    if (y < b[1]) b[@1] = y;
    if (z < b[2]) b[@2] = z;
    if (x > b[3]) b[@3] = x;
    if (y > b[4]) b[@4] = y;
    if (z > b[5]) b[@5] = z;
}

/// @func box3_contains_point(b, x, y, z)
function box3_contains_point(b, x, y, z) {
    gml_pragma("forceinline");
    return x >= b[0] && x <= b[3] &&
           y >= b[1] && y <= b[4] &&
           z >= b[2] && z <= b[5];
}

/// @func box3_intersects_box(b, other)
function box3_intersects_box(b, other) {
    gml_pragma("forceinline");
    // Intersects if overlap on all axes
    return other[3] >= b[0] && other[0] <= b[3] &&
           other[4] >= b[1] && other[1] <= b[4] &&
           other[5] >= b[2] && other[2] <= b[5];
}

/// @func box3_get_center(b, out)
/// @desc Stores the center in the output vector (or creates new).
function box3_get_center(b, out = undefined) {
    gml_pragma("forceinline");
    out ??= array_create(3);
    out[@0] = (b[0] + b[3]) * 0.5;
    out[@1] = (b[1] + b[4]) * 0.5;
    out[@2] = (b[2] + b[5]) * 0.5;
    return out;
}

/// @func box3_get_size(b, out)
/// @desc Stores the size in the output vector.
function box3_get_size(b, out = undefined) {
    gml_pragma("forceinline");
    out ??= array_create(3);
    out[@0] = b[3] - b[0];
    out[@1] = b[4] - b[1];
    out[@2] = b[5] - b[2];
    return out;
}
