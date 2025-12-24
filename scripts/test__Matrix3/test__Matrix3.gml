// GMTL-style test suite for Matrix3 (array-based high-performance matrices)
suite(function() {
    describe("Matrix3", function() {
        
        // ====================================================================
        // CREATION
        // ====================================================================
        
        test("mat3_create() creates identity matrix", function() {
            var m = mat3_create();
            expect(m[0]).toBe(1); expect(m[1]).toBe(0); expect(m[2]).toBe(0);
            expect(m[3]).toBe(0); expect(m[4]).toBe(1); expect(m[5]).toBe(0);
            expect(m[6]).toBe(0); expect(m[7]).toBe(0); expect(m[8]).toBe(1);
        });

        // ====================================================================
        // SETTERS
        // ====================================================================

        test("mat3_set() sets matrix elements in row-major input", function() {
            var m = mat3_create();
            mat3_set(m, 1, 2, 3, 4, 5, 6, 7, 8, 9);
            // Stored in column-major: col0=(1,4,7), col1=(2,5,8), col2=(3,6,9)
            expect(m[0]).toBe(1); expect(m[1]).toBe(4); expect(m[2]).toBe(7);
            expect(m[3]).toBe(2); expect(m[4]).toBe(5); expect(m[5]).toBe(8);
            expect(m[6]).toBe(3); expect(m[7]).toBe(6); expect(m[8]).toBe(9);
        });

        test("mat3_identity() resets to identity", function() {
            var m = mat3_create();
            mat3_set(m, 1, 2, 3, 4, 5, 6, 7, 8, 9);
            mat3_identity(m);
            expect(m[0]).toBe(1); expect(m[1]).toBe(0); expect(m[2]).toBe(0);
            expect(m[3]).toBe(0); expect(m[4]).toBe(1); expect(m[5]).toBe(0);
            expect(m[6]).toBe(0); expect(m[7]).toBe(0); expect(m[8]).toBe(1);
        });

        // ====================================================================
        // CLONE / COPY
        // ====================================================================

        test("mat3_clone() creates independent copy", function() {
            var m = mat3_create();
            mat3_set(m, 1, 2, 3, 4, 5, 6, 7, 8, 9);
            var m2 = mat3_clone(m);
            expect(mat3_equals(m, m2)).toBeTruthy();
            // Verify independence
            m2[0] = 99;
            expect(m[0]).toBe(1);
        });

        test("mat3_copy() copies matrix values", function() {
            var m = mat3_create();
            var m2 = mat3_create();
            mat3_set(m2, 1, 2, 3, 4, 5, 6, 7, 8, 9);
            mat3_copy(m, m2);
            expect(mat3_equals(m, m2)).toBeTruthy();
        });

        // ====================================================================
        // DETERMINANT / INVERSION
        // ====================================================================

        test("mat3_determinant() returns correct value for identity", function() {
            var m = mat3_create();
            expect(mat3_determinant(m)).toBe(1);
        });

        test("mat3_determinant() returns correct value for scaled matrix", function() {
            var m = mat3_create();
            mat3_make_scale(m, 2, 3);
            expect(mat3_determinant(m)).toBe(6); // 2 * 3 * 1
        });

        test("mat3_invert() inverts identity to identity", function() {
            var m = mat3_create();
            mat3_invert(m);
            var identity = mat3_create();
            expect(mat3_equals(m, identity)).toBeTruthy();
        });

        test("mat3_invert() correctly inverts scale matrix", function() {
            var m = mat3_create();
            mat3_make_scale(m, 2, 4);
            mat3_invert(m);
            expect(m[0]).toBe(0.5);
            expect(m[4]).toBe(0.25);
        });

        test("mat3_invert() on singular matrix produces zero matrix", function() {
            var m = mat3_create();
            mat3_set(m, 1, 2, 3, 4, 5, 6, 7, 8, 9); // Singular matrix
            mat3_invert(m);
            for (var i = 0; i < 9; i++) {
                expect(m[i]).toBe(0);
            }
        });

        // ====================================================================
        // TRANSPOSE
        // ====================================================================

        test("mat3_transpose() swaps rows and columns", function() {
            var m = mat3_create();
            mat3_set(m, 1, 2, 3, 4, 5, 6, 7, 8, 9);
            mat3_transpose(m);
            // After transpose: row becomes column
            expect(m[0]).toBe(1); expect(m[1]).toBe(2); expect(m[2]).toBe(3);
            expect(m[3]).toBe(4); expect(m[4]).toBe(5); expect(m[5]).toBe(6);
            expect(m[6]).toBe(7); expect(m[7]).toBe(8); expect(m[8]).toBe(9);
        });

        test("mat3_transpose_into_array() writes transposed to array", function() {
            var m = mat3_create();
            mat3_set(m, 1, 2, 3, 4, 5, 6, 7, 8, 9);
            var arr = array_create(9);
            mat3_transpose_into_array(m, arr);
            expect(arr[0]).toBe(1); expect(arr[1]).toBe(2); expect(arr[2]).toBe(3);
            expect(arr[3]).toBe(4); expect(arr[4]).toBe(5); expect(arr[5]).toBe(6);
            expect(arr[6]).toBe(7); expect(arr[7]).toBe(8); expect(arr[8]).toBe(9);
        });

        // ====================================================================
        // EQUALITY
        // ====================================================================

        test("mat3_equals() correctly compares matrices", function() {
            var m1 = mat3_create();
            var m2 = mat3_create();
            expect(mat3_equals(m1, m2)).toBeTruthy();
            
            m2[0] = 2;
            expect(mat3_equals(m1, m2)).toBeFalsy();
        });

        // ====================================================================
        // MULTIPLICATION
        // ====================================================================

        test("mat3_multiply() with identity returns same matrix", function() {
            var m = mat3_create();
            mat3_set(m, 1, 2, 3, 4, 5, 6, 7, 8, 9);
            var original = mat3_clone(m);
            var identity = mat3_create();
            mat3_multiply(m, identity);
            expect(mat3_equals(m, original)).toBeTruthy();
        });

        test("mat3_multiply_scalar() multiplies all elements", function() {
            var m = mat3_create();
            mat3_multiply_scalar(m, 2);
            expect(m[0]).toBe(2);
            expect(m[4]).toBe(2);
            expect(m[8]).toBe(2);
        });

        test("mat3_multiply_matrices() stores result of a*b", function() {
            var result = mat3_create();
            var a = mat3_create();
            var b = mat3_create();
            mat3_make_scale(a, 2, 2);
            mat3_make_translation(b, 5, 5);
            mat3_multiply_matrices(result, a, b);
            // scale * translate: scale affects translation
            expect(result[6]).toBe(10); // 5 * 2
            expect(result[7]).toBe(10); // 5 * 2
        });

        // ====================================================================
        // 2D TRANSFORMS (in DEGREES)
        // ====================================================================

        test("mat3_make_rotation() creates rotation matrix", function() {
            var m = mat3_create();
            mat3_make_rotation(m, 90);
            // 90 degrees: cos=0, sin=1
            expect(abs(m[0]) < 0.001).toBeTruthy();
            expect(abs(m[1] - 1) < 0.001).toBeTruthy();
            expect(abs(m[3] + 1) < 0.001).toBeTruthy();
            expect(abs(m[4]) < 0.001).toBeTruthy();
        });

        test("mat3_make_scale() creates scale matrix", function() {
            var m = mat3_create();
            mat3_make_scale(m, 2, 3);
            expect(m[0]).toBe(2);
            expect(m[4]).toBe(3);
            expect(m[8]).toBe(1);
        });

        test("mat3_make_translation() creates translation matrix", function() {
            var m = mat3_create();
            mat3_make_translation(m, 10, 20);
            expect(m[6]).toBe(10);
            expect(m[7]).toBe(20);
            expect(m[0]).toBe(1);
            expect(m[4]).toBe(1);
        });

        test("mat3_rotate() applies rotation to existing matrix", function() {
            var m = mat3_create();
            mat3_rotate(m, 90);
            expect(abs(m[0]) < 0.001).toBeTruthy();
            expect(abs(m[1] - 1) < 0.001).toBeTruthy();
        });

        test("mat3_scale() applies scale to existing matrix", function() {
            var m = mat3_create();
            mat3_scale(m, 2, 3);
            expect(m[0]).toBe(2);
            expect(m[3]).toBe(0);
            expect(m[4]).toBe(3);
        });

        test("mat3_translate() applies translation", function() {
            var m = mat3_create();
            mat3_translate(m, 10, 20);
            expect(m[6]).toBe(10);
            expect(m[7]).toBe(20);
        });

        // ====================================================================
        // EXTRACT / CONVERT
        // ====================================================================

        test("mat3_extract_basis() extracts column vectors", function() {
            var m = mat3_create();
            mat3_set(m, 1, 2, 3, 4, 5, 6, 7, 8, 9);
            var _x = vec3_create();
            var _y = vec3_create();
            var _z = vec3_create();
            mat3_extract_basis(m, _x, _y, _z);
            // Column 0: (1, 4, 7)
            expect(_x[0]).toBe(1); expect(_x[1]).toBe(4); expect(_x[2]).toBe(7);
            // Column 1: (2, 5, 8)
            expect(_y[0]).toBe(2); expect(_y[1]).toBe(5); expect(_y[2]).toBe(8);
            // Column 2: (3, 6, 9)
            expect(_z[0]).toBe(3); expect(_z[1]).toBe(6); expect(_z[2]).toBe(9);
        });

        test("mat3_set_from_matrix4() extracts upper 3x3", function() {
            var m3 = mat3_create();
            // 4x4 identity with some values
            var m4 = [1,0,0,0, 0,1,0,0, 0,0,1,0, 10,20,30,1];
            mat3_set_from_matrix4(m3, m4);
            expect(m3[0]).toBe(1); expect(m3[4]).toBe(1); expect(m3[8]).toBe(1);
            expect(m3[6]).toBe(0); // Not the translation
        });

        test("mat3_get_normal_matrix() computes inverse transpose", function() {
            var m3 = mat3_create();
            // 4x4 scale matrix: scale by 2
            var m4 = [2,0,0,0, 0,2,0,0, 0,0,2,0, 0,0,0,1];
            mat3_get_normal_matrix(m3, m4);
            // Normal matrix of uniform scale is 1/scale
            expect(m3[0]).toBe(0.5);
            expect(m3[4]).toBe(0.5);
            expect(m3[8]).toBe(0.5);
        });

        // ====================================================================
        // ARRAY CONVERSION
        // ====================================================================

        test("mat3_from_array() sets from array", function() {
            var m = mat3_create();
            var arr = [9, 8, 7, 6, 5, 4, 3, 2, 1];
            mat3_from_array(m, arr, 0);
            expect(m[0]).toBe(9);
            expect(m[8]).toBe(1);
        });

        test("mat3_to_array() copies to array", function() {
            var m = mat3_create();
            var arr = mat3_to_array(m);
            expect(arr[0]).toBe(1);
            expect(arr[4]).toBe(1);
            expect(arr[8]).toBe(1);
            expect(array_length(arr)).toBe(9);
        });

        // ====================================================================
        // UV TRANSFORM
        // ====================================================================

        test("mat3_set_uv_transform() creates UV matrix", function() {
            var m = mat3_create();
            mat3_set_uv_transform(m, 0, 0, 1, 1, 0, 0, 0);
            // With no transform, should be identity-like
            expect(m[0]).toBe(1);
            expect(m[4]).toBe(1);
            expect(m[8]).toBe(1);
        });
    });
});
