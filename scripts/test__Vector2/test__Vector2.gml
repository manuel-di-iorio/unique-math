// GMTL-style test suite for Vec2 (array-based high-performance vectors)
// API follows Three.js Vector2. All angles are in DEGREES.
suite(function() {
    describe("Vec2", function() {
        
        // ====================================================================
        // CREATION
        // ====================================================================
        
        test("vec2_create() creates vector with correct components", function() {
            var v = vec2_create(1, 2);
            expect(v[0]).toBe(1);
            expect(v[1]).toBe(2);
        });

        test("vec2_create() with no arguments creates zero vector", function() {
            var v = vec2_create();
            expect(v[0]).toBe(0);
            expect(v[1]).toBe(0);
        });

        // ====================================================================
        // SETTERS
        // ====================================================================

        test("vec2_set() updates components", function() {
            var v = vec2_create(1, 2);
            vec2_set(v, 3, 4);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(4);
        });

        test("vec2_set_scalar() sets all components to same value", function() {
            var v = vec2_create(1, 2);
            vec2_set_scalar(v, 5);
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(5);
        });

        test("vec2_set_x() sets x component", function() {
            var v = vec2_create(1, 2);
            vec2_set_x(v, 10);
            expect(v[0]).toBe(10);
            expect(v[1]).toBe(2);
        });

        test("vec2_set_y() sets y component", function() {
            var v = vec2_create(1, 2);
            vec2_set_y(v, 10);
            expect(v[0]).toBe(1);
            expect(v[1]).toBe(10);
        });

        test("vec2_set_component() sets component by index", function() {
            var v = vec2_create(1, 2);
            vec2_set_component(v, 0, 10);
            vec2_set_component(v, 1, 20);
            expect(v[0]).toBe(10);
            expect(v[1]).toBe(20);
        });

        test("vec2_get_component() gets component by index", function() {
            var v = vec2_create(3, 4);
            expect(vec2_get_component(v, 0)).toBe(3);
            expect(vec2_get_component(v, 1)).toBe(4);
        });

        // ====================================================================
        // CLONE / COPY
        // ====================================================================

        test("vec2_clone() creates independent copy", function() {
            var v = vec2_create(3, 4);
            var v2 = vec2_clone(v);
            expect(vec2_equals(v, v2)).toBeTruthy();
            // Verify independence
            vec2_set(v2, 5, 6);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(4);
        });

        test("vec2_copy() copies vector values", function() {
            var v = vec2_create(1, 1);
            var v2 = vec2_create(5, 6);
            vec2_copy(v, v2);
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(6);
        });

        // ====================================================================
        // ADDITION
        // ====================================================================

        test("vec2_add() adds vectors", function() {
            var v = vec2_create(1, 1);
            var v2 = vec2_create(2, 3);
            vec2_add(v, v2);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(4);
        });

        test("vec2_add_scalar() adds scalar to components", function() {
            var v = vec2_create(1, 2);
            vec2_add_scalar(v, 5);
            expect(v[0]).toBe(6);
            expect(v[1]).toBe(7);
        });

        test("vec2_add_scaled_vector() adds scaled vector", function() {
            var v = vec2_create(1, 2);
            var v2 = vec2_create(2, 3);
            vec2_add_scaled_vector(v, v2, 2);
            expect(v[0]).toBe(5);  // 1 + 2*2
            expect(v[1]).toBe(8);  // 2 + 3*2
        });

        test("vec2_add_vectors() stores sum of two vectors", function() {
            var result = vec2_create();
            var a = vec2_create(1, 2);
            var b = vec2_create(3, 4);
            vec2_add_vectors(result, a, b);
            expect(result[0]).toBe(4);
            expect(result[1]).toBe(6);
        });

        // ====================================================================
        // SUBTRACTION
        // ====================================================================

        test("vec2_sub() subtracts vectors", function() {
            var v = vec2_create(3, 4);
            var v2 = vec2_create(2, 3);
            vec2_sub(v, v2);
            expect(v[0]).toBe(1);
            expect(v[1]).toBe(1);
        });

        test("vec2_sub_scalar() subtracts scalar from components", function() {
            var v = vec2_create(5, 7);
            vec2_sub_scalar(v, 2);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(5);
        });

        test("vec2_sub_vectors() stores difference of two vectors", function() {
            var result = vec2_create();
            var a = vec2_create(5, 6);
            var b = vec2_create(2, 3);
            vec2_sub_vectors(result, a, b);
            expect(result[0]).toBe(3);
            expect(result[1]).toBe(3);
        });

        // ====================================================================
        // MULTIPLICATION
        // ====================================================================

        test("vec2_multiply() multiplies component-wise", function() {
            var v = vec2_create(2, 3);
            vec2_multiply(v, vec2_create(3, 4));
            expect(v[0]).toBe(6);
            expect(v[1]).toBe(12);
        });

        test("vec2_multiply_scalar() multiplies by scalar", function() {
            var v = vec2_create(3, 4);
            vec2_multiply_scalar(v, 2);
            expect(v[0]).toBe(6);
            expect(v[1]).toBe(8);
        });

        // ====================================================================
        // DIVISION
        // ====================================================================

        test("vec2_divide() divides component-wise", function() {
            var v = vec2_create(6, 12);
            vec2_divide(v, vec2_create(2, 3));
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(4);
        });

        test("vec2_divide_scalar() divides by scalar", function() {
            var v = vec2_create(6, 8);
            vec2_divide_scalar(v, 2);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(4);
        });

        // ====================================================================
        // DOT / CROSS
        // ====================================================================

        test("vec2_dot() calculates dot product", function() {
            var a = vec2_create(1, 0);
            var b = vec2_create(0, 1);
            expect(vec2_dot(a, b)).toBe(0);
            
            var c = vec2_create(2, 3);
            var d = vec2_create(4, 5);
            expect(vec2_dot(c, d)).toBe(23); // 2*4 + 3*5 = 23
        });

        test("vec2_cross() calculates cross product", function() {
            var a = vec2_create(1, 0);
            var b = vec2_create(0, 1);
            expect(vec2_cross(a, b)).toBe(1);
            expect(vec2_cross(b, a)).toBe(-1);
        });

        // ====================================================================
        // LENGTH
        // ====================================================================

        test("vec2_length() returns vector magnitude", function() {
            var a = vec2_create(1, 0);
            expect(vec2_length(a)).toBe(1);
            
            var b = vec2_create(3, 4);
            expect(vec2_length(b)).toBe(5);
        });

        test("vec2_length_sq() returns squared magnitude", function() {
            var v = vec2_create(3, 4);
            expect(vec2_length_sq(v)).toBe(25);
        });

        test("vec2_manhattan_length() calculates taxicab length", function() {
            var v = vec2_create(3, -4);
            expect(vec2_manhattan_length(v)).toBe(7);
        });

        test("vec2_set_length() sets vector to specific length", function() {
            var v = vec2_create(3, 4);
            vec2_set_length(v, 10);
            expect(round(vec2_length(v) * 100) / 100).toBe(10);
        });

        // ====================================================================
        // NORMALIZE / NEGATE
        // ====================================================================

        test("vec2_normalize() creates unit vector", function() {
            var c = vec2_create(3, 4);
            vec2_normalize(c);
            expect(round(vec2_length(c) * 1000) / 1000).toBe(1);
        });

        test("vec2_normalize() on zero vector doesn't produce NaN", function() {
            var z = vec2_create(0, 0);
            vec2_normalize(z);
            expect(vec2_length(z)).toBe(0);
            expect(z[0]).toBe(0);
            expect(z[1]).toBe(0);
        });

        test("vec2_negate() negates components", function() {
            var v = vec2_create(3, -4);
            vec2_negate(v);
            expect(v[0]).toBe(-3);
            expect(v[1]).toBe(4);
        });

        // ====================================================================
        // DISTANCE
        // ====================================================================

        test("vec2_distance_to() calculates distance between vectors", function() {
            var a = vec2_create(10, 0);
            var b = vec2_create(5, 0);
            expect(vec2_distance_to(a, b)).toBe(5);
        });

        test("vec2_distance_to_squared() calculates squared distance", function() {
            var a = vec2_create(0, 0);
            var b = vec2_create(3, 4);
            expect(vec2_distance_to_squared(a, b)).toBe(25);
        });

        test("vec2_manhattan_distance_to() calculates taxicab distance", function() {
            var a = vec2_create(1, 2);
            var b = vec2_create(4, 6);
            expect(vec2_manhattan_distance_to(a, b)).toBe(7); // |3| + |4|
        });

        // ====================================================================
        // MIN / MAX / CLAMP
        // ====================================================================

        test("vec2_min() sets component-wise minimum", function() {
            var v = vec2_create(5, 2);
            vec2_min(v, vec2_create(3, 4));
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(2);
        });

        test("vec2_max() sets component-wise maximum", function() {
            var v = vec2_create(5, 2);
            vec2_max(v, vec2_create(3, 4));
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(4);
        });

        test("vec2_clamp() clamps components", function() {
            var v = vec2_create(10, -5);
            vec2_clamp(v, vec2_create(0, 0), vec2_create(5, 5));
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(0);
        });

        test("vec2_clamp_scalar() clamps with scalar bounds", function() {
            var v = vec2_create(10, -5);
            vec2_clamp_scalar(v, 0, 5);
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(0);
        });

        test("vec2_clamp_length() clamps vector length", function() {
            var v = vec2_create(6, 8); // length = 10
            vec2_clamp_length(v, 0, 5);
            expect(round(vec2_length(v) * 100) / 100).toBe(5);
            
            var v2 = vec2_create(3, 0); // length = 3
            vec2_clamp_length(v2, 0, 5);
            expect(vec2_length(v2)).toBe(3); // unchanged
            
            var v3 = vec2_create(1, 0); // length = 1
            vec2_clamp_length(v3, 2, 5);
            expect(round(vec2_length(v3) * 100) / 100).toBe(2); // clamped to min
        });

        // ====================================================================
        // ROUNDING
        // ====================================================================

        test("vec2_floor() floors components", function() {
            var v = vec2_create(3.7, 2.3);
            vec2_floor(v);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(2);
        });

        test("vec2_ceil() ceils components", function() {
            var v = vec2_create(3.1, 2.9);
            vec2_ceil(v);
            expect(v[0]).toBe(4);
            expect(v[1]).toBe(3);
        });

        test("vec2_round() rounds components", function() {
            var v = vec2_create(3.4, 2.6);
            vec2_round(v);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(3);
        });

        test("vec2_round_to_zero() rounds towards zero", function() {
            var v = vec2_create(3.7, -2.7);
            vec2_round_to_zero(v);
            expect(v[0]).toBe(3);   // positive: floor
            expect(v[1]).toBe(-2);  // negative: ceil
        });

        // ====================================================================
        // EQUALITY
        // ====================================================================

        test("vec2_equals() compares vectors correctly", function() {
            var v1 = vec2_create(1, 2);
            var v2 = vec2_create(1, 2);
            var v3 = vec2_create(1, 3);
            expect(vec2_equals(v1, v2)).toBeTruthy();
            expect(vec2_equals(v1, v3)).toBeFalsy();
        });

        // ====================================================================
        // INTERPOLATION
        // ====================================================================

        test("vec2_lerp() interpolates at alpha=0.5", function() {
            var p = vec2_create(0, 0);
            var q = vec2_create(10, 0);
            vec2_lerp(p, q, 0.5);
            expect(p[0]).toBe(5);
            expect(p[1]).toBe(0);
        });

        test("vec2_lerp() at alpha=0 returns start vector", function() {
            var a = vec2_create(1, 2);
            var b = vec2_create(5, 6);
            var c = vec2_clone(a);
            vec2_lerp(c, b, 0);
            expect(c[0]).toBe(1);
            expect(c[1]).toBe(2);
        });

        test("vec2_lerp() at alpha=1 returns end vector", function() {
            var a = vec2_create(1, 2);
            var b = vec2_create(5, 6);
            var c = vec2_clone(a);
            vec2_lerp(c, b, 1);
            expect(c[0]).toBe(5);
            expect(c[1]).toBe(6);
        });

        test("vec2_lerp_vectors() stores interpolation result", function() {
            var result = vec2_create();
            var a = vec2_create(0, 0);
            var b = vec2_create(10, 10);
            vec2_lerp_vectors(result, a, b, 0.5);
            expect(result[0]).toBe(5);
            expect(result[1]).toBe(5);
            // Originals unchanged
            expect(a[0]).toBe(0);
        });

        // ====================================================================
        // ANGLE (in DEGREES)
        // ====================================================================

        test("vec2_angle() returns angle from positive X axis", function() {
            var v = vec2_create(1, 0);
            expect(vec2_angle(v)).toBe(0);
            
            var v2 = vec2_create(0, 1);
            expect(vec2_angle(v2)).toBe(90);
            
            var v3 = vec2_create(-1, 0);
            expect(vec2_angle(v3)).toBe(180);
        });

        test("vec2_angle_to() calculates angle between perpendicular vectors", function() {
            var u = vec2_create(1, 0);
            var v = vec2_create(0, 1);
            expect(round(vec2_angle_to(u, v))).toBe(90);
        });

        test("vec2_angle_to() with zero vector returns 0", function() {
            var u = vec2_create(1, 0);
            var zero = vec2_create(0, 0);
            expect(vec2_angle_to(u, zero)).toBe(0);
        });

        test("vec2_angle_to() with opposite vectors returns 180", function() {
            var u = vec2_create(1, 0);
            var v = vec2_create(-1, 0);
            expect(round(vec2_angle_to(u, v))).toBe(180);
        });

        // ====================================================================
        // ROTATION (in DEGREES)
        // ====================================================================

        test("vec2_rotate_around() rotates around center point", function() {
            var v = vec2_create(2, 0);
            var center = vec2_create(1, 0);
            vec2_rotate_around(v, center, 90);
            expect(round(v[0] * 1000) / 1000).toBe(1);
            expect(round(v[1] * 1000) / 1000).toBe(1);
        });

        test("vec2_rotate_around() rotates by -90 degrees", function() {
            var v = vec2_create(2, 0);
            var center = vec2_create(1, 0);
            vec2_rotate_around(v, center, -90);
            expect(round(v[0] * 1000) / 1000).toBe(1);
            expect(round(v[1] * 1000) / 1000).toBe(-1);
        });

        // ====================================================================
        // RANDOM
        // ====================================================================

        test("vec2_random() sets components between 0 and 1", function() {
            var v = vec2_create();
            vec2_random(v);
            expect(v[0] >= 0 && v[0] < 1).toBeTruthy();
            expect(v[1] >= 0 && v[1] < 1).toBeTruthy();
        });

        // ====================================================================
        // ARRAY CONVERSION
        // ====================================================================

        test("vec2_from_array() sets from array", function() {
            var arr = [1, 2, 3, 4];
            var v = vec2_create();
            vec2_from_array(v, arr, 0);
            expect(v[0]).toBe(1);
            expect(v[1]).toBe(2);
            
            vec2_from_array(v, arr, 2);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(4);
        });

        test("vec2_to_array() copies to array", function() {
            var v = vec2_create(5, 6);
            var arr = vec2_to_array(v);
            expect(arr[0]).toBe(5);
            expect(arr[1]).toBe(6);
        });

        test("vec2_to_array() with offset", function() {
            var v = vec2_create(5, 6);
            var arr = [0, 0, 0, 0];
            vec2_to_array(v, arr, 2);
            expect(arr[0]).toBe(0);
            expect(arr[2]).toBe(5);
            expect(arr[3]).toBe(6);
        });

        test("vec2_from_buffer_attribute() reads from buffer by vertex index", function() {
            // Buffer with 3 vertices: [x0,y0, x1,y1, x2,y2]
            var buffer = [1, 2, 3, 4, 5, 6];
            var v = vec2_create();
            
            vec2_from_buffer_attribute(v, buffer, 0);
            expect(v[0]).toBe(1);
            expect(v[1]).toBe(2);
            
            vec2_from_buffer_attribute(v, buffer, 1);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(4);
            
            vec2_from_buffer_attribute(v, buffer, 2);
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(6);
        });

        // ====================================================================
        // MATRIX
        // ====================================================================

        test("vec2_apply_matrix3() transforms by 3x3 matrix", function() {
            var v = vec2_create(1, 0);
            // Identity matrix (column-major)
            var identity = [1,0,0, 0,1,0, 0,0,1];
            vec2_apply_matrix3(v, identity);
            expect(v[0]).toBe(1);
            expect(v[1]).toBe(0);
            
            // Translation matrix (translate by [5, 3])
            var translate = [1,0,0, 0,1,0, 5,3,1];
            vec2_apply_matrix3(v, translate);
            expect(v[0]).toBe(6);
            expect(v[1]).toBe(3);
        });

        // ====================================================================
        // EXTRA UTILITY
        // ====================================================================

        test("vec2_abs() sets absolute values", function() {
            var v = vec2_create(-3, -4);
            vec2_abs(v);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(4);
        });

        test("vec2_reflect() reflects vector across normal", function() {
            var v = vec2_create(1, -1);
            var normal = vec2_create(0, 1);
            vec2_reflect(v, normal);
            expect(round(v[0] * 1000) / 1000).toBe(1);
            expect(round(v[1] * 1000) / 1000).toBe(1);
        });

        test("vec2_project() projects onto another vector", function() {
            var v = vec2_create(3, 4);
            var onto = vec2_create(1, 0);
            vec2_project(v, onto);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(0);
        });

        test("vec2_perp() creates perpendicular vector", function() {
            var r = vec2_create(1, 0);
            vec2_perp(r);
            expect(r[0]).toBe(0);
            expect(r[1]).toBe(1);
        });

        test("vec2 functions support nesting (chaining)", function() {
            var v = vec2_create();
            var result = vec2_multiply_scalar(vec2_add_scalar(vec2_set(v, 1, 2), 10), 2);
            
            expect(result).toBe(v);
            expect(v[0]).toBe(22); // (1 + 10) * 2
            expect(v[1]).toBe(24); // (2 + 10) * 2
        });
    });
});
