/// @desc Euler functions using arrays [x, y, z, order]
/// Angles are in DEGREES.
/// Order is a string: "XYZ", "YXZ", "ZXY", "ZYX", "YZX", "XZY". Default is "XYZ".

function euler_create(x = 0, y = 0, z = 0, order = "XYZ") {
    gml_pragma("forceinline");
    return [x, y, z, order];
}

function euler_set(e, x, y, z, order = "XYZ") {
    gml_pragma("forceinline");
    e[@0] = x;
    e[@1] = y;
    e[@2] = z;
    e[@3] = order;
}

function euler_copy(e, src) {
    gml_pragma("forceinline");
    e[@0] = src[0];
    e[@1] = src[1];
    e[@2] = src[2];
    e[@3] = src[3];
}

function euler_clone(e) {
    gml_pragma("forceinline");
    return [e[0], e[1], e[2], e[3]];
}

/// @func euler_set_from_rotation_matrix(e, m, order)
/// @desc Sets euler angles from rotation matrix.
function euler_set_from_rotation_matrix(e, m, order = undefined) {
    gml_pragma("forceinline");
    
    // Default order if not provided
    if (order == undefined) order = e[3];
    else e[@3] = order; // Update order
    
    // Clamp matrix elements to [-1, 1] to avoid NaNs from asin/acos?
    // GML's darcsin/darccos handle inputs naturally but clamping is safer for floats
    
    var m11 = m[0], m12 = m[4], m13 = m[8];
    var m21 = m[1], m22 = m[5], m23 = m[9];
    var m31 = m[2], m32 = m[6], m33 = m[10];
    
    var _x, _y, _z;
    
    switch (order) {
        case "XYZ":
            _y = darcsin(clamp(m13, -1, 1));
            if (abs(m13) < 0.9999999) {
                _x = darctan2(-m23, m33);
                _z = darctan2(-m12, m11);
            } else {
                _x = darctan2(m32, m22);
                _z = 0;
            }
            break;
            
        case "YXZ":
            _x = darcsin(-clamp(m23, -1, 1));
            if (abs(m23) < 0.9999999) {
                _y = darctan2(m13, m33);
                _z = darctan2(m21, m22);
            } else {
                _y = darctan2(-m31, m11);
                _z = 0;
            }
            break;
            
        case "ZXY":
            _x = darcsin(clamp(m32, -1, 1));
            if (abs(m32) < 0.9999999) {
                _y = darctan2(-m31, m33);
                _z = darctan2(-m12, m22);
            } else {
                _y = 0;
                _z = darctan2(m21, m11);
            }
            break;
            
        case "ZYX":
            _y = darcsin(-clamp(m31, -1, 1));
            if (abs(m31) < 0.9999999) {
                _x = darctan2(m32, m33);
                _z = darctan2(m21, m11);
            } else {
                _x = 0;
                _z = darctan2(-m12, m22);
            }
            break;
            
        case "YZX":
            _z = darcsin(clamp(m21, -1, 1));
            if (abs(m21) < 0.9999999) {
                _x = darctan2(-m23, m22);
                _y = darctan2(-m31, m11);
            } else {
                _x = 0;
                _y = darctan2(m13, m33);
            }
            break;
            
        case "XZY":
            _z = darcsin(-clamp(m12, -1, 1));
            if (abs(m12) < 0.9999999) {
                _x = darctan2(m32, m22);
                _y = darctan2(m13, m11);
            } else {
                _x = darctan2(-m23, m33);
                _y = 0;
            }
            break;
            
        default: // XYZ
             _y = darcsin(clamp(m13, -1, 1));
            if (abs(m13) < 0.9999999) {
                _x = darctan2(-m23, m33);
                _z = darctan2(-m12, m11);
            } else {
                _x = darctan2(m32, m22);
                _z = 0;
            }
    }
    
    e[@0] = _x;
    e[@1] = _y;
    e[@2] = _z;
}

/// @func euler_set_from_quaternion(e, q, order)
/// @desc Sets euler angles from quaternion.
function euler_set_from_quaternion(e, q, order = undefined) {
    gml_pragma("forceinline");
    // Matrix conversion is often easier/robust
    // We can build a rotation matrix from quaternion then extract euler
    
    // OR direct math (Three.js impl)
    if (order == undefined) order = e[3];
    else e[@3] = order;

    var _x = q[0], _y = q[1], _z = q[2], _w = q[3];
    var x2 = _x + _x, y2 = _y + _y, z2 = _z + _z;
    var xx = _x * x2, xy = _x * y2, xz = _x * z2;
    var yy = _y * y2, yz = _y * z2, zz = _z * z2;
    var wx = _w * x2, wy = _w * y2, wz = _w * z2;
    
    // Matrix elements
    var m11 = 1 - (yy + zz);
    var m12 = xy - wz;
    var m13 = xz + wy;
    
    var m21 = xy + wz;
    var m22 = 1 - (xx + zz);
    var m23 = yz - wx;
    
    var m31 = xz - wy;
    var m32 = yz + wx;
    var m33 = 1 - (xx + yy);

    // Reuse matrix extraction logic (duplicated for performance/independence or could wrap)
    // For now I'll duplicate the logic to avoid creating a temp matrix array
    
    var rx, ry, rz;
     switch (order) {
        case "XYZ":
            ry = darcsin(clamp(m13, -1, 1));
            if (abs(m13) < 0.9999999) {
                rx = darctan2(-m23, m33);
                rz = darctan2(-m12, m11);
            } else {
                rx = darctan2(m32, m22);
                rz = 0;
            }
            break;
        case "YXZ":
            rx = darcsin(-clamp(m23, -1, 1));
            if (abs(m23) < 0.9999999) {
                ry = darctan2(m13, m33);
                rz = darctan2(m21, m22);
            } else {
                ry = darctan2(-m31, m11);
                rz = 0;
            }
            break;
        case "ZXY":
            rx = darcsin(clamp(m32, -1, 1));
            if (abs(m32) < 0.9999999) {
                ry = darctan2(-m31, m33);
                rz = darctan2(-m12, m22);
            } else {
                ry = 0;
                rz = darctan2(m21, m11);
            }
            break;
        case "ZYX":
            ry = darcsin(-clamp(m31, -1, 1));
            if (abs(m31) < 0.9999999) {
                rx = darctan2(m32, m33);
                rz = darctan2(m21, m11);
            } else {
                rx = 0;
                rz = darctan2(-m12, m22);
            }
            break;
        case "YZX":
            rz = darcsin(clamp(m21, -1, 1));
            if (abs(m21) < 0.9999999) {
                rx = darctan2(-m23, m22);
                ry = darctan2(-m31, m11);
            } else {
                rx = 0;
                ry = darctan2(m13, m33);
            }
            break;
        case "XZY":
            rz = darcsin(-clamp(m12, -1, 1));
            if (abs(m12) < 0.9999999) {
                rx = darctan2(m32, m22);
                ry = darctan2(m13, m11);
            } else {
                rx = darctan2(-m23, m33);
                ry = 0;
            }
            break;
        default: // XYZ
             ry = darcsin(clamp(m13, -1, 1));
            if (abs(m13) < 0.9999999) {
                rx = darctan2(-m23, m33);
                rz = darctan2(-m12, m11);
            } else {
                rx = darctan2(m32, m22);
                rz = 0;
            }
    }
    
    e[@0] = rx;
    e[@1] = ry;
    e[@2] = rz;
}

function euler_equals(e1, e2) {
    gml_pragma("forceinline");
    return (e1[0] == e2[0] && e1[1] == e2[1] && e1[2] == e2[2] && e1[3] == e2[3]);
}
