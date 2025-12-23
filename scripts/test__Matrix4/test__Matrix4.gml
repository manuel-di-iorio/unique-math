// GMTL-style test suite for Matrix4 (array-based high-performance matrices)
// API follows Three.js Matrix4. Rotation angles are in DEGREES.
suite(function() {
    describe("Matrix4", function() {
        
        // ====================================================================
        // CREATION
        // ====================================================================
        
        test("mat4_create() creates identity matrix", function() {
            var m = mat4_create();
            expect(m[0]).toBe(1);  expect(m[5]).toBe(1);
            expect(m[10]).toBe(1); expect(m[15]).toBe(1);
            expect(m[1]).toBe(0);  expect(m[4]).toBe(0);
        });

        // ====================================================================
        // SETTERS
        // ====================================================================

        test("mat4_set() sets matrix elements in row-major input", function() {
            var m = mat4_create();
            mat4_set(m, 1,2,3,4, 5,6,7,8, 9,10,11,12, 13,14,15,16);
            // Stored in column-major
            expect(m[0]).toBe(1); expect(m[1]).toBe(5); expect(m[2]).toBe(9);  expect(m[3]).toBe(13);
            expect(m[4]).toBe(2); expect(m[5]).toBe(6); expect(m[6]).toBe(10); expect(m[7]).toBe(14);
        });

        test("mat4_identity() resets to identity", function() {
            var m = mat4_create();
            mat4_set(m, 1,2,3,4, 5,6,7,8, 9,10,11,12, 13,14,15,16);
            mat4_identity(m);
            expect(m[0]).toBe(1); expect(m[5]).toBe(1); expect(m[10]).toBe(1); expect(m[15]).toBe(1);
            expect(m[1]).toBe(0); expect(m[4]).toBe(0);
        });

        // ====================================================================
        // CLONE / COPY
        // ====================================================================

        test("mat4_clone() creates independent copy", function() {
            var m = mat4_create();
            mat4_make_translation(m, 10, 20, 30);
            var m2 = mat4_clone(m);
            expect(mat4_equals(m, m2)).toBeTruthy();
            m2[12] = 99;
            expect(m[12]).toBe(10);
        });

        test("mat4_copy() copies matrix values", function() {
            var m = mat4_create();
            var m2 = mat4_create();
            mat4_make_translation(m2, 5, 10, 15);
            mat4_copy(m, m2);
            expect(mat4_equals(m, m2)).toBeTruthy();
        });

        test("mat4_copy_position() copies only translation", function() {
            var m = mat4_create();
            var m2 = mat4_create();
            mat4_make_scale(m2, 2, 2, 2);
            mat4_set_position(m2, 100, 200, 300);
            mat4_copy_position(m, m2);
            expect(m[12]).toBe(100);
            expect(m[13]).toBe(200);
            expect(m[14]).toBe(300);
            expect(m[0]).toBe(1); // Scale not copied
        });

        // ====================================================================
        // DETERMINANT / INVERSION
        // ====================================================================

        test("mat4_determinant() returns 1 for identity", function() {
            var m = mat4_create();
            expect(mat4_determinant(m)).toBe(1);
        });

        test("mat4_determinant() correct for scale matrix", function() {
            var m = mat4_create();
            mat4_make_scale(m, 2, 3, 4);
            expect(mat4_determinant(m)).toBe(24);
        });

        test("mat4_invert() inverts identity to identity", function() {
            var m = mat4_create();
            mat4_invert(m);
            var identity = mat4_create();
            expect(mat4_equals(m, identity)).toBeTruthy();
        });

        test("mat4_invert() correctly inverts translation", function() {
            var m = mat4_create();
            mat4_make_translation(m, 10, 20, 30);
            mat4_invert(m);
            expect(m[12]).toBe(-10);
            expect(m[13]).toBe(-20);
            expect(m[14]).toBe(-30);
        });

        // ====================================================================
        // TRANSPOSE
        // ====================================================================

        test("mat4_transpose() swaps rows and columns", function() {
            var m = mat4_create();
            mat4_set(m, 1,2,3,4, 5,6,7,8, 9,10,11,12, 13,14,15,16);
            mat4_transpose(m);
            expect(m[0]).toBe(1); expect(m[1]).toBe(2); expect(m[2]).toBe(3);
        });

        // ====================================================================
        // EQUALITY
        // ====================================================================

        test("mat4_equals() correctly compares matrices", function() {
            var m1 = mat4_create();
            var m2 = mat4_create();
            expect(mat4_equals(m1, m2)).toBeTruthy();
            m2[0] = 2;
            expect(mat4_equals(m1, m2)).toBeFalsy();
        });

        // ====================================================================
        // MULTIPLICATION
        // ====================================================================

        test("mat4_multiply() with identity returns same matrix", function() {
            var m = mat4_create();
            mat4_make_translation(m, 10, 20, 30);
            var original = mat4_clone(m);
            var identity = mat4_create();
            mat4_multiply(m, identity);
            expect(mat4_equals(m, original)).toBeTruthy();
        });

        test("mat4_multiply_scalar() multiplies all elements", function() {
            var m = mat4_create();
            mat4_multiply_scalar(m, 2);
            expect(m[0]).toBe(2);
            expect(m[5]).toBe(2);
            expect(m[15]).toBe(2);
        });

        // ====================================================================
        // TRANSFORM MAKERS (in DEGREES)
        // ====================================================================

        test("mat4_make_translation() creates translation matrix", function() {
            var m = mat4_create();
            mat4_make_translation(m, 10, 20, 30);
            expect(m[12]).toBe(10);
            expect(m[13]).toBe(20);
            expect(m[14]).toBe(30);
            expect(m[0]).toBe(1);
        });

        test("mat4_make_scale() creates scale matrix", function() {
            var m = mat4_create();
            mat4_make_scale(m, 2, 3, 4);
            expect(m[0]).toBe(2);
            expect(m[5]).toBe(3);
            expect(m[10]).toBe(4);
        });

        test("mat4_make_rotation_x() creates X rotation", function() {
            var m = mat4_create();
            mat4_make_rotation_x(m, 90);
            expect(abs(m[5]) < 0.001).toBeTruthy();
            expect(abs(m[6] + 1) < 0.001).toBeTruthy();
            expect(abs(m[9] - 1) < 0.001).toBeTruthy();
            expect(abs(m[10]) < 0.001).toBeTruthy();
        });

        test("mat4_make_rotation_y() creates Y rotation", function() {
            var m = mat4_create();
            mat4_make_rotation_y(m, 90);
            expect(abs(m[0]) < 0.001).toBeTruthy();
            expect(abs(m[2] - 1) < 0.001).toBeTruthy();
            expect(abs(m[8] + 1) < 0.001).toBeTruthy();
            expect(abs(m[10]) < 0.001).toBeTruthy();
        });

        test("mat4_make_rotation_z() creates Z rotation", function() {
            var m = mat4_create();
            mat4_make_rotation_z(m, 90);
            expect(abs(m[0]) < 0.001).toBeTruthy();
            expect(abs(m[1] + 1) < 0.001).toBeTruthy();
            expect(abs(m[4] - 1) < 0.001).toBeTruthy();
            expect(abs(m[5]) < 0.001).toBeTruthy();
        });

        test("mat4_make_rotation_axis() rotates around axis", function() {
            var m = mat4_create();
            var axis = vec3_create(0, 0, 1);
            mat4_make_rotation_axis(m, axis, 90);
            expect(abs(m[0]) < 0.001).toBeTruthy();
            expect(abs(m[1] - 1) < 0.001).toBeTruthy();
        });

        test("mat4_make_rotation_from_quaternion() from quaternion", function() {
            var m = mat4_create();
            // Identity quaternion
            var q = [0, 0, 0, 1];
            mat4_make_rotation_from_quaternion(m, q);
            expect(m[0]).toBe(1);
            expect(m[5]).toBe(1);
            expect(m[10]).toBe(1);
        });

        test("mat4_make_shear() creates shear matrix", function() {
            var m = mat4_create();
            mat4_make_shear(m, 1, 0, 0, 0, 0, 0);
            expect(m[4]).toBe(1);
            expect(m[0]).toBe(1);
        });

        // ====================================================================
        // PROJECTION
        // ====================================================================

        test("mat4_make_perspective() creates projection matrix", function() {
            var m = mat4_create();
            mat4_make_perspective(m, 60, 1.5, 0.1, 100);
            expect(m[11]).toBe(1);
            expect(m[15]).toBe(0);
        });

        test("mat4_make_orthographic() creates orthographic matrix", function() {
            var m = mat4_create();
            mat4_make_orthographic(m, -1, 1, 1, -1, 0.1, 100);
            expect(m[0]).toBe(1);
            expect(m[5]).toBe(1);
        });

        // ====================================================================
        // LOOK AT
        // ====================================================================

        test("mat4_look_at() creates look at matrix", function() {
            var m = mat4_create();
            var eye = vec3_create(0, 0, 5);
            var target = vec3_create(0, 0, 0);
            var up = vec3_create(0, 1, 0);
            mat4_look_at(m, eye, target, up);
            expect(m[12]).toBe(0);
            expect(m[13]).toBe(0);
            expect(m[14]).toBe(5);
        });

        // ====================================================================
        // BASIS
        // ====================================================================

        test("mat4_make_basis() sets basis vectors", function() {
            var m = mat4_create();
            var _x = vec3_create(1, 0, 0);
            var _y = vec3_create(0, 1, 0);
            var _z = vec3_create(0, 0, 1);
            mat4_make_basis(m, _x, _y, _z);
            var identity = mat4_create();
            expect(mat4_equals(m, identity)).toBeTruthy();
        });

        test("mat4_extract_basis() extracts column vectors", function() {
            var m = mat4_create();
            mat4_make_scale(m, 2, 3, 4);
            var _x = vec3_create();
            var _y = vec3_create();
            var _z = vec3_create();
            mat4_extract_basis(m, _x, _y, _z);
            expect(_x[0]).toBe(2);
            expect(_y[1]).toBe(3);
            expect(_z[2]).toBe(4);
        });

        // ====================================================================
        // COMPOSE / DECOMPOSE
        // ====================================================================

        test("mat4_compose() builds TRS matrix", function() {
            var m = mat4_create();
            var pos = vec3_create(10, 20, 30);
            var quat = [0, 0, 0, 1]; // Identity
            var scl = vec3_create(1, 1, 1);
            mat4_compose(m, pos, quat, scl);
            expect(m[12]).toBe(10);
            expect(m[13]).toBe(20);
            expect(m[14]).toBe(30);
        });

        test("mat4_decompose() extracts TRS components", function() {
            var m = mat4_create();
            mat4_make_translation(m, 5, 10, 15);
            
            var pos = vec3_create();
            var quat = [0, 0, 0, 1];
            var scl = vec3_create();
            
            mat4_decompose(m, pos, quat, scl);
            expect(pos[0]).toBe(5);
            expect(pos[1]).toBe(10);
            expect(pos[2]).toBe(15);
            expect(abs(scl[0] - 1) < 0.001).toBeTruthy();
        });

        // ====================================================================
        // SCALE / POSITION
        // ====================================================================

        test("mat4_scale() scales columns", function() {
            var m = mat4_create();
            var s = vec3_create(2, 3, 4);
            mat4_scale(m, s);
            expect(m[0]).toBe(2);
            expect(m[5]).toBe(3);
            expect(m[10]).toBe(4);
        });

        test("mat4_set_position() sets translation", function() {
            var m = mat4_create();
            mat4_set_position(m, 100, 200, 300);
            expect(m[12]).toBe(100);
            expect(m[13]).toBe(200);
            expect(m[14]).toBe(300);
        });

        test("mat4_get_max_scale_on_axis() returns max scale", function() {
            var m = mat4_create();
            mat4_make_scale(m, 2, 5, 3);
            expect(mat4_get_max_scale_on_axis(m)).toBe(5);
        });

        // ====================================================================
        // SET FROM MATRIX3
        // ====================================================================

        test("mat4_set_from_matrix3() copies upper 3x3", function() {
            var m4 = mat4_create();
            var m3 = mat3_create();
            mat3_make_rotation(m3, 45);
            mat4_set_from_matrix3(m4, m3);
            expect(m4[0]).toBe(m3[0]);
            expect(m4[5]).toBe(m3[4]);
        });

        // ====================================================================
        // ARRAY CONVERSION
        // ====================================================================

        test("mat4_from_array() sets from array", function() {
            var m = mat4_create();
            var arr = [2,0,0,0, 0,3,0,0, 0,0,4,0, 1,2,3,1];
            mat4_from_array(m, arr, 0);
            expect(m[0]).toBe(2);
            expect(m[5]).toBe(3);
            expect(m[10]).toBe(4);
        });

        test("mat4_to_array() copies to array", function() {
            var m = mat4_create();
            var arr = mat4_to_array(m);
            expect(arr[0]).toBe(1);
            expect(arr[15]).toBe(1);
            expect(array_length(arr)).toBe(16);
        });
    });
});
