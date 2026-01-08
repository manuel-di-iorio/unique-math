// GMTL-style test suite for Vec4 (array-based high-performance vectors)
// All angles are in DEGREES.
suite(function() {
    describe("Vec4", function() {
        
        // ====================================================================
        // CREATION
        // ====================================================================
        
        test("vec4_create() creates vector with correct components", function() {
            var v = vec4_create(1, 2, 3, 4);
            expect(v[0]).toBe(1);
            expect(v[1]).toBe(2);
            expect(v[2]).toBe(3);
            expect(v[3]).toBe(4);
        });

        test("vec4_create() with no arguments creates (0, 0, 0, 1) vector", function() {
            var v = vec4_create();
            expect(v[0]).toBe(0);
            expect(v[1]).toBe(0);
            expect(v[2]).toBe(0);
            expect(v[3]).toBe(1);
        });

        // ====================================================================
        // SETTERS
        // ====================================================================

        test("vec4_set() updates components", function() {
            var v = vec4_create(1, 2, 3, 4);
            vec4_set(v, 4, 5, 6, 7);
            expect(v[0]).toBe(4);
            expect(v[1]).toBe(5);
            expect(v[2]).toBe(6);
            expect(v[3]).toBe(7);
        });

        test("vec4_set_scalar() sets all components to same value", function() {
            var v = vec4_create(1, 2, 3, 4);
            vec4_set_scalar(v, 5);
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(5);
            expect(v[2]).toBe(5);
            expect(v[3]).toBe(5);
        });

        test("vec4_set_x/y/z/w() sets individual components", function() {
            var v = vec4_create(1, 2, 3, 4);
            vec4_set_x(v, 10);
            vec4_set_y(v, 20);
            vec4_set_z(v, 30);
            vec4_set_w(v, 40);
            expect(v[0]).toBe(10);
            expect(v[1]).toBe(20);
            expect(v[2]).toBe(30);
            expect(v[3]).toBe(40);
        });

        test("vec4_set_component() sets component by index", function() {
            var v = vec4_create(1, 2, 3, 4);
            vec4_set_component(v, 0, 10);
            vec4_set_component(v, 1, 20);
            vec4_set_component(v, 2, 30);
            vec4_set_component(v, 3, 40);
            expect(v[0]).toBe(10);
            expect(v[1]).toBe(20);
            expect(v[2]).toBe(30);
            expect(v[3]).toBe(40);
        });

        test("vec4_get_component() gets component by index", function() {
            var v = vec4_create(3, 4, 5, 6);
            expect(vec4_get_component(v, 0)).toBe(3);
            expect(vec4_get_component(v, 1)).toBe(4);
            expect(vec4_get_component(v, 2)).toBe(5);
            expect(vec4_get_component(v, 3)).toBe(6);
        });

        // ====================================================================
        // CLONE / COPY
        // ====================================================================

        test("vec4_clone() creates independent copy", function() {
            var v = vec4_create(3, 4, 5, 6);
            var v2 = vec4_clone(v);
            expect(vec4_equals(v, v2)).toBeTruthy();
            // Verify independence
            vec4_set(v2, 10, 20, 30, 40);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(4);
            expect(v[2]).toBe(5);
            expect(v[3]).toBe(6);
        });

        test("vec4_copy() copies vector values", function() {
            var v = vec4_create(1, 1, 1, 1);
            var v2 = vec4_create(5, 6, 7, 8);
            vec4_copy(v, v2);
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(6);
            expect(v[2]).toBe(7);
            expect(v[3]).toBe(8);
        });

        // ====================================================================
        // ADDITION
        // ====================================================================

        test("vec4_add() adds vectors", function() {
            var v = vec4_create(1, 2, 3, 4);
            var v2 = vec4_create(4, 5, 6, 7);
            vec4_add(v, v2);
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(7);
            expect(v[2]).toBe(9);
            expect(v[3]).toBe(11);
        });

        test("vec4_add_scalar() adds scalar to components", function() {
            var v = vec4_create(1, 2, 3, 4);
            vec4_add_scalar(v, 5);
            expect(v[0]).toBe(6);
            expect(v[1]).toBe(7);
            expect(v[2]).toBe(8);
            expect(v[3]).toBe(9);
        });

        test("vec4_add_scaled_vector() adds scaled vector", function() {
            var v = vec4_create(1, 2, 3, 4);
            var v2 = vec4_create(2, 3, 4, 5);
            vec4_add_scaled_vector(v, v2, 2);
            expect(v[0]).toBe(5);  // 1 + 2*2
            expect(v[1]).toBe(8);  // 2 + 3*2
            expect(v[2]).toBe(11); // 3 + 4*2
            expect(v[3]).toBe(14); // 4 + 5*2
        });

        test("vec4_add_vectors() stores sum of two vectors", function() {
            var result = vec4_create();
            var a = vec4_create(1, 2, 3, 4);
            var b = vec4_create(4, 5, 6, 7);
            vec4_add_vectors(result, a, b);
            expect(result[0]).toBe(5);
            expect(result[1]).toBe(7);
            expect(result[2]).toBe(9);
            expect(result[3]).toBe(11);
        });

        // ====================================================================
        // SUBTRACTION
        // ====================================================================

        test("vec4_sub() subtracts vectors", function() {
            var v = vec4_create(5, 7, 9, 11);
            var v2 = vec4_create(1, 2, 3, 4);
            vec4_sub(v, v2);
            expect(v[0]).toBe(4);
            expect(v[1]).toBe(5);
            expect(v[2]).toBe(6);
            expect(v[3]).toBe(7);
        });

        test("vec4_sub_scalar() subtracts scalar from components", function() {
            var v = vec4_create(5, 7, 9, 11);
            vec4_sub_scalar(v, 2);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(5);
            expect(v[2]).toBe(7);
            expect(v[3]).toBe(9);
        });

        test("vec4_sub_vectors() stores difference of two vectors", function() {
            var result = vec4_create();
            var a = vec4_create(5, 6, 7, 8);
            var b = vec4_create(2, 3, 4, 5);
            vec4_sub_vectors(result, a, b);
            expect(result[0]).toBe(3);
            expect(result[1]).toBe(3);
            expect(result[2]).toBe(3);
            expect(result[3]).toBe(3);
        });

        // ====================================================================
        // MULTIPLICATION / DIVISION
        // ====================================================================

        test("vec4_multiply() multiplies component-wise", function() {
            var v = vec4_create(2, 3, 4, 5);
            vec4_multiply(v, vec4_create(3, 4, 5, 6));
            expect(v[0]).toBe(6);
            expect(v[1]).toBe(12);
            expect(v[2]).toBe(20);
            expect(v[3]).toBe(30);
        });

        test("vec4_multiply_scalar() multiplies by scalar", function() {
            var v = vec4_create(3, 4, 5, 6);
            vec4_multiply_scalar(v, 2);
            expect(v[0]).toBe(6);
            expect(v[1]).toBe(8);
            expect(v[2]).toBe(10);
            expect(v[3]).toBe(12);
        });

        test("vec4_divide() divides component-wise", function() {
            var v = vec4_create(6, 12, 20, 30);
            vec4_divide(v, vec4_create(2, 3, 4, 5));
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(4);
            expect(v[2]).toBe(5);
            expect(v[3]).toBe(6);
        });

        test("vec4_divide_scalar() divides by scalar", function() {
            var v = vec4_create(6, 8, 10, 12);
            vec4_divide_scalar(v, 2);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(4);
            expect(v[2]).toBe(5);
            expect(v[3]).toBe(6);
        });

        // ====================================================================
        // DOT
        // ====================================================================

        test("vec4_dot() calculates dot product", function() {
            var a = vec4_create(1, 2, 3, 4);
            var b = vec4_create(5, 6, 7, 8);
            expect(vec4_dot(a, b)).toBe(70); // 1*5+2*6+3*7+4*8 = 5+12+21+32 = 70
        });

        // ====================================================================
        // LENGTH
        // ====================================================================

        test("vec4_length() returns vector magnitude", function() {
            var a = vec4_create(1, 0, 0, 0);
            expect(vec4_length(a)).toBe(1);
            
            var b = vec4_create(2, 2, 2, 2);
            expect(vec4_length(b)).toBe(4); // sqrt(4+4+4+4) = sqrt(16) = 4
        });

        test("vec4_length_sq() returns squared magnitude", function() {
            var v = vec4_create(1, 2, 2, 1);
            expect(vec4_length_sq(v)).toBe(10); // 1+4+4+1 = 10
        });

        test("vec4_manhattan_length() calculates taxicab length", function() {
            var v = vec4_create(3, -4, 5, -6);
            expect(vec4_manhattan_length(v)).toBe(18); // 3+4+5+6 = 18
        });

        test("vec4_set_length() sets vector to specific length", function() {
            var v = vec4_create(2, 2, 2, 2);
            vec4_set_length(v, 10);
            expect(round(vec4_length(v) * 100) / 100).toBe(10);
        });

        // ====================================================================
        // NORMALIZE / NEGATE
        // ====================================================================

        test("vec4_normalize() creates unit vector", function() {
            var v = vec4_create(1, 2, 3, 4);
            vec4_normalize(v);
            expect(round(vec4_length(v) * 1000) / 1000).toBe(1);
        });

        test("vec4_negate() negates components", function() {
            var v = vec4_create(3, -4, 5, -1);
            vec4_negate(v);
            expect(v[0]).toBe(-3);
            expect(v[1]).toBe(4);
            expect(v[2]).toBe(-5);
            expect(v[3]).toBe(1);
        });

        // ====================================================================
        // MIN / MAX / CLAMP
        // ====================================================================

        test("vec4_min() sets component-wise minimum", function() {
            var v = vec4_create(5, 2, 8, 1);
            vec4_min(v, vec4_create(3, 4, 6, 2));
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(2);
            expect(v[2]).toBe(6);
            expect(v[3]).toBe(1);
        });

        test("vec4_max() sets component-wise maximum", function() {
            var v = vec4_create(5, 2, 8, 1);
            vec4_max(v, vec4_create(3, 4, 6, 2));
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(4);
            expect(v[2]).toBe(8);
            expect(v[3]).toBe(2);
        });

        test("vec4_clamp() clamps components", function() {
            var v = vec4_create(10, -5, 8, 2);
            vec4_clamp(v, vec4_create(0, 0, 0, 0), vec4_create(5, 5, 5, 5));
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(0);
            expect(v[2]).toBe(5);
            expect(v[3]).toBe(2);
        });

        test("vec4_clamp_scalar() clamps with scalar bounds", function() {
            var v = vec4_create(10, -5, 3, 7);
            vec4_clamp_scalar(v, 0, 5);
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(0);
            expect(v[2]).toBe(3);
            expect(v[3]).toBe(5);
        });

        // ====================================================================
        // ROUNDING
        // ====================================================================

        test("vec4_floor() floors components", function() {
            var v = vec4_create(3.7, 2.3, 4.9, 1.1);
            vec4_floor(v);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(2);
            expect(v[2]).toBe(4);
            expect(v[3]).toBe(1);
        });

        test("vec4_ceil() ceils components", function() {
            var v = vec4_create(3.1, 2.9, 4.01, 1.99);
            vec4_ceil(v);
            expect(v[0]).toBe(4);
            expect(v[1]).toBe(3);
            expect(v[2]).toBe(5);
            expect(v[3]).toBe(2);
        });

        // ====================================================================
        // INTERPOLATION
        // ====================================================================

        test("vec4_lerp() interpolates at alpha=0.5", function() {
            var p = vec4_create(0, 0, 0, 0);
            var q = vec4_create(10, 20, 30, 40);
            vec4_lerp(p, q, 0.5);
            expect(p[0]).toBe(5);
            expect(p[1]).toBe(10);
            expect(p[2]).toBe(15);
            expect(p[3]).toBe(20);
        });

        // ====================================================================
        // RANDOM
        // ====================================================================

        test("vec4_random() sets components between 0 and 1", function() {
            var v = vec4_create();
            vec4_random(v);
            for(var i=0; i<4; i++) {
                expect(v[i] >= 0 && v[i] < 1).toBeTruthy();
            }
        });

        // ====================================================================
        // MATRIX / QUATERNION TRANSFORMS
        // ====================================================================

        test("vec4_apply_matrix4() transforms by 4x4 matrix", function() {
            var v = vec4_create(1, 2, 3, 4);
            var m = [
                1, 0, 0, 0,
                0, 1, 0, 0,
                0, 0, 1, 0,
                0, 0, 0, 1
            ];
            vec4_apply_matrix4(v, m);
            expect(v[0]).toBe(1);
            expect(v[1]).toBe(2);
            expect(v[2]).toBe(3);
            expect(v[3]).toBe(4);
        });

        test("vec4_set_axis_angle_from_quaternion() works", function() {
            var v = vec4_create();
            var q = quat_create();
            quat_set_from_axis_angle(q, [0, 1, 0], 90);
            vec4_set_axis_angle_from_quaternion(v, q);
            
            expect(abs(v[0])).toBeLessThan(0.001);
            expect(abs(v[1] - 1)).toBeLessThan(0.001);
            expect(abs(v[2])).toBeLessThan(0.001);
            expect(abs(v[3] - 90)).toBeLessThan(0.001);
        });

        test("vec4_set_axis_angle_from_rotation_matrix() works", function() {
            var v = vec4_create();
            var m = mat4_create();
            mat4_make_rotation_y(m, 90);
            vec4_set_axis_angle_from_rotation_matrix(v, m);
            
            expect(abs(v[0])).toBeLessThan(0.001);
            expect(abs(v[1] + 1)).toBeLessThan(0.001);
            expect(abs(v[2])).toBeLessThan(0.001);
            expect(abs(v[3] - 90)).toBeLessThan(0.001);
        });
        
    });
});
