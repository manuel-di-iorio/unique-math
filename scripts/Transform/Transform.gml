/// @desc Transform functions.
/// A Transform is an array containing 3 sub-arrays: [Position, Rotation, Scale]
/// Position is Vec3 [x, y, z]
/// Rotation is Quaternion [x, y, z, w]
/// Scale is Vec3 [x, y, z]

function transform_create(pos = undefined, rot = undefined, scl = undefined) {
    gml_pragma("forceinline");
    pos ??= [0, 0, 0];
    rot ??= [0, 0, 0, 1];
    scl ??= [1, 1, 1];
    return [pos, rot, scl];
}

function transform_copy(t, src) {
    gml_pragma("forceinline");
    array_copy(t[0], 0, src[0], 0, 3);
    array_copy(t[1], 0, src[1], 0, 4);
    array_copy(t[2], 0, src[2], 0, 3);
}

function transform_clone(t) {
    gml_pragma("forceinline");
    return [
        [t[0][0], t[0][1], t[0][2]],
        [t[1][0], t[1][1], t[1][2], t[1][3]],
        [t[2][0], t[2][1], t[2][2]]
    ];
}

/// @func transform_set(t, pos, rot, scl)
/// @desc Sets components from other vectors/quaternions by value copying.
function transform_set(t, pos, rot, scl) {
    gml_pragma("forceinline");
    if (pos != undefined) array_copy(t[0], 0, pos, 0, 3);
    if (rot != undefined) array_copy(t[1], 0, rot, 0, 4);
    if (scl != undefined) array_copy(t[2], 0, scl, 0, 3);
}

/// @func transform_compose_matrix(t, m)
/// @desc Composes a 4x4 matrix from the transform.
function transform_compose_matrix(t, m) {
    gml_pragma("forceinline");
    mat4_compose(m, t[0], t[1], t[2]);
}

/// @func transform_decompose_matrix(t, m)
/// @desc Decomposes a matrix into this transform.
function transform_decompose_matrix(t, m) {
    gml_pragma("forceinline");
    mat4_decompose(m, t[0], t[1], t[2]);
}

/// @func transform_look_at(t, target, up)
/// @desc Updates the rotation of the transform to look at the target.
function transform_look_at(t, target, up) {
    gml_pragma("forceinline");
    // We can use mat4_look_at to get a matrix, then extract quaternion
    // Or do quat_look_at logic directly?
    // Since we have Matrix4 functions:
    
    // Create a temp matrix for the lookAt rotation
    var m = global.__MAT4_TEMP;
    
    // mat4_look_at creates a VIEW matrix (inverse of object matrix)
    // We usually want the object orientation.
    // Object matrix looks at Z?
    // GameMaker/OpenGL: Forward is usually -Z or +Z depending on hand.
    // Three.js: LookAt sets rotation so +Z is backwards (camera looks down -Z).
    // Let's assume typical Object LookAt logic where +Z points to target or -Z points to target.
    
    // Using mat4_look_at (view matrix):
    // Eye = t[0], Target = target
    // ViewMatrix moves world so Eye is at 000.
    // Rotation part of ViewMatrix is Inverse of Camera Rotation.
    
    // So:
    // M_view = mat4_look_at(eye, target, up)
    // M_cam = invert(M_view)
    // Rotation = extract_rotation(M_cam)
    
    // But mat4_look_at implementation we have:
    // Constructs a matrix using basis vectors built from (eye - target) (forward is Z).
    
    mat4_look_at(m, t[0], target, up);
    
    // The matrix constructed by mat4_look_at puts the eye at origin of view.
    // So the rotation in m is the View Rotation (which rotates world to camera).
    // We want the Camera World Rotation.
    // So we need to invert the rotation.
    // Since it's a rotation matrix, transpose is invert.
    
    // Extract rotation from m (upper 3x3)
    // m is [xx, xy, xz, 0, yx, yy, yz, 0, zx, zy, zz, 0, ...] as view matrix
    // Invert it (transpose rotation part)
    
    // Un-transpose checks:
    // View Matrix:
    // Rx Ry Rz 0
    // Ux Uy Uz 0
    // Fx Fy Fz 0
    // ...
    // where R, U, F are the basis axes of the camera in world space.
    // Wait, standard LookAt(eye, target, up):
    // Z = normalize(eye - target)
    // X = normalize(cross(up, Z))
    // Y = cross(Z, X)
    // Matrix:
    // [ Xx Yx Zx 0 ]
    // [ Xy Yy Zy 0 ]
    // [ Xz Yz Zz 0 ]
    // [ -dot(X,e) -dot(Y,e) -dot(Z,e) 1 ]
    
    // The rotation part [Xx Yx Zx; Xy Yy Zy; Xz Yz Zz] is the transponse of [X; Y; Z].
    // If [X,Y,Z] are the axes of the camera in World Space, then the rotation part of View Matrix is indeed the transpose (inverse).
    
    // So the Rotation Quaternion we want matches the basis [X, Y, Z].
    // So we need to take the transpose of the rotation part of `m`.
    
    // Let's transpose `m` rotation locally
    var m00 = m[0], m01 = m[4], m02 = m[8]; // Column 0 of view = Row 0 of world
    var m10 = m[1], m11 = m[5], m12 = m[9];
    var m20 = m[2], m21 = m[6], m22 = m[10];
    
    // We want to construct quaternion from the transpose (which is the world orient):
    // World Matrix Rotation:
    // Xx Xy Xz
    // Yx Yy Yz
    // Zx Zy Zz
    // which corresponds to elements:
    // m[0] m[1] m[2]
    // m[4] m[5] m[6]
    // m[8] m[9] m[10]
    // of the ViewMatrix?
    
    // mat4_look_at source:
    // m[@0] = xx; m[@1] = xy; m[@2] = xz; ...
    // So m[0], m[1], m[2] IS X axis.
    // Wait, m[@0] is mat[0][0] (col 0 row 0).
    // So the first column IS X vector.
    // In mat4_look_at:
    // m[@0] = xx; m[@4] = yx; m[@8] = zx; ??
    // No, standard GML matrix_build_lookat:
    // Builds a view matrix.
    // The standard OpenGL view matrix:
    // Row 0: s.x, s.y, s.z
    // Row 1: u.x, u.y, u.z
    // Row 2: -f.x, -f.y, -f.z
    // Stored in column major:
    // m[0]=s.x, m[1]=u.x, m[2]=-f.x
    // m[4]=s.y, m[5]=u.y, m[6]=-f.y
    // ...
    // So columns are different from World Basis.
    
    // We want the World Basis Quaternion.
    // Camera Right = s
    // Camera Up = u
    // Camera Forward = -f (usually camera looks down -Z)
    
    // So World Rotation Matrix should have columns: [s, u, -f] ?
    // Or [s, u, f] ?
    // If identity, s=(1,0,0), u=(0,1,0), f=(0,0,1).
    // View look down -Z?
    // If I look along -Z, f = (0,0,1) (from eye(0) to target(-1) -> f = 0 - (-1) = 1 in Z).
    // Z axis of basis is +1 Z.
    // So yes, Z axis is backwards.
    
    // So to extract object rotation:
    // We want the quaternion representing the rotation from Identity to this Basis.
    // Basis is:
    // X axis = Row 0 of View Matrix (if transposed back to columns) -> First row elements?
    // Let's rely on `matrix_build_lookat` behavior.
    
    // Actually, `mat4_look_at` in our library calls `matrix_build_lookat`.
    // We need to INVERT it to get the object transform.
    // We can use `mat4_invert`.
    
    mat4_invert(m); // Now m is the World Matrix of the camera/object
    
    // Now extract quaternion
    quat_set_from_rotation_matrix(t[1], m);
}
