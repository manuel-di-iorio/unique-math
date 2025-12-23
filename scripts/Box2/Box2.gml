/// @desc Box2 functions using arrays [minX, minY, maxX, maxY]

function box2_create(minX = infinity, minY = infinity, maxX = -infinity, maxY = -infinity) {
    gml_pragma("forceinline");
    return [minX, minY, maxX, maxY];
}

function box2_set(b, minX, minY, maxX, maxY) {
    gml_pragma("forceinline");
    b[@0] = minX; b[@1] = minY;
    b[@2] = maxX; b[@3] = maxY;
}

function box2_expand_by_point(b, x, y) {
    gml_pragma("forceinline");
    if (x < b[0]) b[@0] = x;
    if (y < b[1]) b[@1] = y;
    if (x > b[2]) b[@2] = x;
    if (y > b[3]) b[@3] = y;
}

function box2_contains_point(b, x, y) {
    gml_pragma("forceinline");
    return x >= b[0] && x <= b[2] && y >= b[1] && y <= b[3];
}

function box2_intersects_box(b, other) {
    gml_pragma("forceinline");
    return other[2] >= b[0] && other[0] <= b[2] &&
           other[3] >= b[1] && other[1] <= b[3];
}
