// GMTL-style test suite for Vec3 (array-based high-performance vectors)
// API follows Three.js Vector3. All angles are in DEGREES.
suite(function() {
    describe("Vec3", function() {
        
        // ====================================================================
        // CREATION
        // ====================================================================
        
        test("vec3_create() creates vector with correct components", function() {
            var v = vec3_create(1, 2, 3);
            expect(v[0]).toBe(1);
            expect(v[1]).toBe(2);
            expect(v[2]).toBe(3);
        });

        test("vec3_create() with no arguments creates zero vector", function() {
            var v = vec3_create();
            expect(v[0]).toBe(0);
            expect(v[1]).toBe(0);
            expect(v[2]).toBe(0);
        });

        // ====================================================================
        // SETTERS
        // ====================================================================

        test("vec3_set() updates components", function() {
            var v = vec3_create(1, 2, 3);
            vec3_set(v, 4, 5, 6);
            expect(v[0]).toBe(4);
            expect(v[1]).toBe(5);
            expect(v[2]).toBe(6);
        });

        test("vec3_set_scalar() sets all components to same value", function() {
            var v = vec3_create(1, 2, 3);
            vec3_set_scalar(v, 5);
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(5);
            expect(v[2]).toBe(5);
        });

        test("vec3_set_x/y/z() sets individual components", function() {
            var v = vec3_create(1, 2, 3);
            vec3_set_x(v, 10);
            vec3_set_y(v, 20);
            vec3_set_z(v, 30);
            expect(v[0]).toBe(10);
            expect(v[1]).toBe(20);
            expect(v[2]).toBe(30);
        });

        test("vec3_set_component() sets component by index", function() {
            var v = vec3_create(1, 2, 3);
            vec3_set_component(v, 0, 10);
            vec3_set_component(v, 1, 20);
            vec3_set_component(v, 2, 30);
            expect(v[0]).toBe(10);
            expect(v[1]).toBe(20);
            expect(v[2]).toBe(30);
        });

        test("vec3_get_component() gets component by index", function() {
            var v = vec3_create(3, 4, 5);
            expect(vec3_get_component(v, 0)).toBe(3);
            expect(vec3_get_component(v, 1)).toBe(4);
            expect(vec3_get_component(v, 2)).toBe(5);
        });

        // ====================================================================
        // CLONE / COPY
        // ====================================================================

        test("vec3_clone() creates independent copy", function() {
            var v = vec3_create(3, 4, 5);
            var v2 = vec3_clone(v);
            expect(vec3_equals(v, v2)).toBeTruthy();
            // Verify independence
            vec3_set(v2, 10, 20, 30);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(4);
            expect(v[2]).toBe(5);
        });

        test("vec3_copy() copies vector values", function() {
            var v = vec3_create(1, 1, 1);
            var v2 = vec3_create(5, 6, 7);
            vec3_copy(v, v2);
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(6);
            expect(v[2]).toBe(7);
        });

        // ====================================================================
        // ADDITION
        // ====================================================================

        test("vec3_add() adds vectors", function() {
            var v = vec3_create(1, 2, 3);
            var v2 = vec3_create(4, 5, 6);
            vec3_add(v, v2);
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(7);
            expect(v[2]).toBe(9);
        });

        test("vec3_add_scalar() adds scalar to components", function() {
            var v = vec3_create(1, 2, 3);
            vec3_add_scalar(v, 5);
            expect(v[0]).toBe(6);
            expect(v[1]).toBe(7);
            expect(v[2]).toBe(8);
        });

        test("vec3_add_scaled_vector() adds scaled vector", function() {
            var v = vec3_create(1, 2, 3);
            var v2 = vec3_create(2, 3, 4);
            vec3_add_scaled_vector(v, v2, 2);
            expect(v[0]).toBe(5);  // 1 + 2*2
            expect(v[1]).toBe(8);  // 2 + 3*2
            expect(v[2]).toBe(11); // 3 + 4*2
        });

        test("vec3_add_vectors() stores sum of two vectors", function() {
            var result = vec3_create();
            var a = vec3_create(1, 2, 3);
            var b = vec3_create(4, 5, 6);
            vec3_add_vectors(result, a, b);
            expect(result[0]).toBe(5);
            expect(result[1]).toBe(7);
            expect(result[2]).toBe(9);
        });

        // ====================================================================
        // SUBTRACTION
        // ====================================================================

        test("vec3_sub() subtracts vectors", function() {
            var v = vec3_create(5, 7, 9);
            var v2 = vec3_create(1, 2, 3);
            vec3_sub(v, v2);
            expect(v[0]).toBe(4);
            expect(v[1]).toBe(5);
            expect(v[2]).toBe(6);
        });

        test("vec3_sub_scalar() subtracts scalar from components", function() {
            var v = vec3_create(5, 7, 9);
            vec3_sub_scalar(v, 2);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(5);
            expect(v[2]).toBe(7);
        });

        test("vec3_sub_vectors() stores difference of two vectors", function() {
            var result = vec3_create();
            var a = vec3_create(5, 6, 7);
            var b = vec3_create(2, 3, 4);
            vec3_sub_vectors(result, a, b);
            expect(result[0]).toBe(3);
            expect(result[1]).toBe(3);
            expect(result[2]).toBe(3);
        });

        // ====================================================================
        // MULTIPLICATION
        // ====================================================================

        test("vec3_multiply() multiplies component-wise", function() {
            var v = vec3_create(2, 3, 4);
            vec3_multiply(v, vec3_create(3, 4, 5));
            expect(v[0]).toBe(6);
            expect(v[1]).toBe(12);
            expect(v[2]).toBe(20);
        });

        test("vec3_multiply_scalar() multiplies by scalar", function() {
            var v = vec3_create(3, 4, 5);
            vec3_multiply_scalar(v, 2);
            expect(v[0]).toBe(6);
            expect(v[1]).toBe(8);
            expect(v[2]).toBe(10);
        });

        test("vec3_multiply_vectors() stores product of two vectors", function() {
            var result = vec3_create();
            var a = vec3_create(2, 3, 4);
            var b = vec3_create(5, 6, 7);
            vec3_multiply_vectors(result, a, b);
            expect(result[0]).toBe(10);
            expect(result[1]).toBe(18);
            expect(result[2]).toBe(28);
        });

        // ====================================================================
        // DIVISION
        // ====================================================================

        test("vec3_divide() divides component-wise", function() {
            var v = vec3_create(6, 12, 20);
            vec3_divide(v, vec3_create(2, 3, 4));
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(4);
            expect(v[2]).toBe(5);
        });

        test("vec3_divide_scalar() divides by scalar", function() {
            var v = vec3_create(6, 8, 10);
            vec3_divide_scalar(v, 2);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(4);
            expect(v[2]).toBe(5);
        });

        // ====================================================================
        // DOT / CROSS
        // ====================================================================

        test("vec3_dot() calculates dot product", function() {
            var a = vec3_create(1, 0, 0);
            var b = vec3_create(0, 1, 0);
            expect(vec3_dot(a, b)).toBe(0);
            
            var c = vec3_create(1, 2, 3);
            var d = vec3_create(4, 5, 6);
            expect(vec3_dot(c, d)).toBe(32); // 1*4 + 2*5 + 3*6 = 32
        });

        test("vec3_cross() calculates cross product", function() {
            var a = vec3_create(1, 0, 0);
            var b = vec3_create(0, 1, 0);
            vec3_cross(a, b);
            expect(a[0]).toBe(0);
            expect(a[1]).toBe(0);
            expect(a[2]).toBe(1); // i x j = k
        });

        test("vec3_cross_vectors() stores cross product of two vectors", function() {
            var result = vec3_create();
            var a = vec3_create(1, 0, 0);
            var b = vec3_create(0, 1, 0);
            vec3_cross_vectors(result, a, b);
            expect(result[0]).toBe(0);
            expect(result[1]).toBe(0);
            expect(result[2]).toBe(1);
        });

        // ====================================================================
        // LENGTH
        // ====================================================================

        test("vec3_length() returns vector magnitude", function() {
            var a = vec3_create(1, 0, 0);
            expect(vec3_length(a)).toBe(1);
            
            var b = vec3_create(0, 3, 4);
            expect(vec3_length(b)).toBe(5);
        });

        test("vec3_length_sq() returns squared magnitude", function() {
            var v = vec3_create(1, 2, 2);
            expect(vec3_length_sq(v)).toBe(9);
        });

        test("vec3_manhattan_length() calculates taxicab length", function() {
            var v = vec3_create(3, -4, 5);
            expect(vec3_manhattan_length(v)).toBe(12);
        });

        test("vec3_set_length() sets vector to specific length", function() {
            var v = vec3_create(0, 3, 4);
            vec3_set_length(v, 10);
            expect(round(vec3_length(v) * 100) / 100).toBe(10);
        });

        // ====================================================================
        // NORMALIZE / NEGATE
        // ====================================================================

        test("vec3_normalize() creates unit vector", function() {
            var v = vec3_create(0, 3, 4);
            vec3_normalize(v);
            expect(round(vec3_length(v) * 1000) / 1000).toBe(1);
        });

        test("vec3_normalize() on zero vector doesn't produce NaN", function() {
            var z = vec3_create(0, 0, 0);
            vec3_normalize(z);
            expect(vec3_length(z)).toBe(0);
            expect(z[0]).toBe(0);
            expect(z[1]).toBe(0);
            expect(z[2]).toBe(0);
        });

        test("vec3_negate() negates components", function() {
            var v = vec3_create(3, -4, 5);
            vec3_negate(v);
            expect(v[0]).toBe(-3);
            expect(v[1]).toBe(4);
            expect(v[2]).toBe(-5);
        });

        // ====================================================================
        // DISTANCE
        // ====================================================================

        test("vec3_distance_to() calculates distance between vectors", function() {
            var a = vec3_create(0, 0, 0);
            var b = vec3_create(0, 3, 4);
            expect(vec3_distance_to(a, b)).toBe(5);
        });

        test("vec3_distance_to_squared() calculates squared distance", function() {
            var a = vec3_create(0, 0, 0);
            var b = vec3_create(1, 2, 2);
            expect(vec3_distance_to_squared(a, b)).toBe(9);
        });

        test("vec3_manhattan_distance_to() calculates taxicab distance", function() {
            var a = vec3_create(1, 2, 3);
            var b = vec3_create(4, 6, 8);
            expect(vec3_manhattan_distance_to(a, b)).toBe(12); // |3| + |4| + |5|
        });

        // ====================================================================
        // MIN / MAX / CLAMP
        // ====================================================================

        test("vec3_min() sets component-wise minimum", function() {
            var v = vec3_create(5, 2, 8);
            vec3_min(v, vec3_create(3, 4, 6));
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(2);
            expect(v[2]).toBe(6);
        });

        test("vec3_max() sets component-wise maximum", function() {
            var v = vec3_create(5, 2, 8);
            vec3_max(v, vec3_create(3, 4, 6));
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(4);
            expect(v[2]).toBe(8);
        });

        test("vec3_clamp() clamps components", function() {
            var v = vec3_create(10, -5, 8);
            vec3_clamp(v, vec3_create(0, 0, 0), vec3_create(5, 5, 5));
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(0);
            expect(v[2]).toBe(5);
        });

        test("vec3_clamp_scalar() clamps with scalar bounds", function() {
            var v = vec3_create(10, -5, 3);
            vec3_clamp_scalar(v, 0, 5);
            expect(v[0]).toBe(5);
            expect(v[1]).toBe(0);
            expect(v[2]).toBe(3);
        });

        test("vec3_clamp_length() clamps vector length", function() {
            var v = vec3_create(6, 0, 8); // length = 10
            vec3_clamp_length(v, 0, 5);
            expect(round(vec3_length(v) * 100) / 100).toBe(5);
            
            var v2 = vec3_create(3, 0, 0); // length = 3
            vec3_clamp_length(v2, 5, 10);
            expect(round(vec3_length(v2) * 100) / 100).toBe(5);
        });

        // ====================================================================
        // ROUNDING
        // ====================================================================

        test("vec3_floor() floors components", function() {
            var v = vec3_create(3.7, 2.3, 4.9);
            vec3_floor(v);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(2);
            expect(v[2]).toBe(4);
        });

        test("vec3_ceil() ceils components", function() {
            var v = vec3_create(3.1, 2.9, 4.01);
            vec3_ceil(v);
            expect(v[0]).toBe(4);
            expect(v[1]).toBe(3);
            expect(v[2]).toBe(5);
        });

        test("vec3_round() rounds components", function() {
            var v = vec3_create(3.4, 2.6, 4.6);
            vec3_round(v);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(3);
            expect(v[2]).toBe(5);
        });

        test("vec3_round_to_zero() rounds towards zero", function() {
            var v = vec3_create(3.7, -2.7, 4.9);
            vec3_round_to_zero(v);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(-2);
            expect(v[2]).toBe(4);
        });

        // ====================================================================
        // EQUALITY
        // ====================================================================

        test("vec3_equals() compares vectors correctly", function() {
            var v1 = vec3_create(1, 2, 3);
            var v2 = vec3_create(1, 2, 3);
            var v3 = vec3_create(1, 2, 4);
            expect(vec3_equals(v1, v2)).toBeTruthy();
            expect(vec3_equals(v1, v3)).toBeFalsy();
        });

        // ====================================================================
        // INTERPOLATION
        // ====================================================================

        test("vec3_lerp() interpolates at alpha=0.5", function() {
            var p = vec3_create(0, 0, 0);
            var q = vec3_create(10, 20, 30);
            vec3_lerp(p, q, 0.5);
            expect(p[0]).toBe(5);
            expect(p[1]).toBe(10);
            expect(p[2]).toBe(15);
        });

        test("vec3_lerp() at alpha=0 returns start vector", function() {
            var a = vec3_create(1, 2, 3);
            var b = vec3_create(5, 6, 7);
            var c = vec3_clone(a);
            vec3_lerp(c, b, 0);
            expect(vec3_equals(c, a)).toBeTruthy();
        });

        test("vec3_lerp() at alpha=1 returns end vector", function() {
            var a = vec3_create(1, 2, 3);
            var b = vec3_create(5, 6, 7);
            var c = vec3_clone(a);
            vec3_lerp(c, b, 1);
            expect(vec3_equals(c, b)).toBeTruthy();
        });

        test("vec3_lerp_vectors() stores interpolation result", function() {
            var result = vec3_create();
            var a = vec3_create(0, 0, 0);
            var b = vec3_create(10, 20, 30);
            vec3_lerp_vectors(result, a, b, 0.5);
            expect(result[0]).toBe(5);
            expect(result[1]).toBe(10);
            expect(result[2]).toBe(15);
        });

        // ====================================================================
        // ANGLE (in DEGREES)
        // ====================================================================

        test("vec3_angle_to() calculates angle between perpendicular vectors", function() {
            var u = vec3_create(1, 0, 0);
            var v = vec3_create(0, 1, 0);
            expect(round(vec3_angle_to(u, v))).toBe(90);
        });

        test("vec3_angle_to() with zero vector returns 0", function() {
            var u = vec3_create(1, 0, 0);
            var zero = vec3_create(0, 0, 0);
            expect(vec3_angle_to(u, zero)).toBe(0);
        });

        test("vec3_angle_to() with opposite vectors returns 180", function() {
            var u = vec3_create(1, 0, 0);
            var v = vec3_create(-1, 0, 0);
            expect(round(vec3_angle_to(u, v))).toBe(180);
        });

        // ====================================================================
        // ROTATION
        // ====================================================================

        test("vec3_apply_axis_angle() rotates around axis", function() {
            var v = vec3_create(1, 0, 0);
            var axis = vec3_create(0, 0, 1);
            vec3_apply_axis_angle(v, axis, 90);
            expect(round(v[0] * 1000) / 1000).toBe(0);
            expect(round(v[1] * 1000) / 1000).toBe(1);
            expect(round(v[2] * 1000) / 1000).toBe(0);
        });

        test("vec3_apply_quaternion() applies quaternion rotation", function() {
            var v = vec3_create(1, 0, 0);
            // 90 degree rotation around Z axis: quat = [0, 0, sin(45°), cos(45°)]
            var s = sin(pi/4);
            var c = cos(pi/4);
            var q = [0, 0, s, c];
            vec3_apply_quaternion(v, q);
            expect(abs(v[0]) < 0.001).toBeTruthy();
            expect(abs(v[1] - 1) < 0.001).toBeTruthy();
            expect(abs(v[2]) < 0.001).toBeTruthy();
        });

        // ====================================================================
        // RANDOM
        // ====================================================================

        test("vec3_random() sets components between 0 and 1", function() {
            var v = vec3_create();
            vec3_random(v);
            expect(v[0] >= 0 && v[0] < 1).toBeTruthy();
            expect(v[1] >= 0 && v[1] < 1).toBeTruthy();
            expect(v[2] >= 0 && v[2] < 1).toBeTruthy();
        });

        test("vec3_random_direction() creates unit vector", function() {
            var v = vec3_create();
            vec3_random_direction(v);
            expect(abs(vec3_length(v) - 1) < 0.001).toBeTruthy();
        });

        // ====================================================================
        // PROJECTION / REFLECTION
        // ====================================================================

        test("vec3_project_on_vector() projects onto another vector", function() {
            var v = vec3_create(3, 4, 0);
            var onto = vec3_create(1, 0, 0);
            vec3_project_on_vector(v, onto);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(0);
            expect(v[2]).toBe(0);
        });

        test("vec3_project_on_plane() projects onto plane", function() {
            var v = vec3_create(1, 2, 3);
            var normal = vec3_create(0, 1, 0);
            vec3_project_on_plane(v, normal);
            expect(v[0]).toBe(1);
            expect(v[1]).toBe(0);
            expect(v[2]).toBe(3);
        });

        test("vec3_reflect() reflects vector across normal", function() {
            var v = vec3_create(1, -1, 0);
            var normal = vec3_create(0, 1, 0);
            vec3_reflect(v, normal);
            expect(round(v[0] * 1000) / 1000).toBe(1);
            expect(round(v[1] * 1000) / 1000).toBe(1);
            expect(round(v[2] * 1000) / 1000).toBe(0);
        });

        // ====================================================================
        // ARRAY CONVERSION
        // ====================================================================

        test("vec3_from_array() sets from array", function() {
            var arr = [1, 2, 3, 4, 5, 6];
            var v = vec3_create();
            vec3_from_array(v, arr, 0);
            expect(v[0]).toBe(1);
            expect(v[1]).toBe(2);
            expect(v[2]).toBe(3);
            
            vec3_from_array(v, arr, 3);
            expect(v[0]).toBe(4);
            expect(v[1]).toBe(5);
            expect(v[2]).toBe(6);
        });

        test("vec3_to_array() copies to array", function() {
            var v = vec3_create(5, 6, 7);
            var arr = vec3_to_array(v);
            expect(arr[0]).toBe(5);
            expect(arr[1]).toBe(6);
            expect(arr[2]).toBe(7);
        });

        test("vec3_from_buffer_attribute() reads from buffer by vertex index", function() {
            // Buffer with 2 vertices: [x0,y0,z0, x1,y1,z1]
            var buffer = [1, 2, 3, 4, 5, 6];
            var v = vec3_create();
            
            vec3_from_buffer_attribute(v, buffer, 0);
            expect(v[0]).toBe(1);
            expect(v[1]).toBe(2);
            expect(v[2]).toBe(3);
            
            vec3_from_buffer_attribute(v, buffer, 1);
            expect(v[0]).toBe(4);
            expect(v[1]).toBe(5);
            expect(v[2]).toBe(6);
        });

        // ====================================================================
        // MATRIX TRANSFORMATION
        // ====================================================================

        test("vec3_apply_matrix3() transforms by 3x3 matrix", function() {
            var v = vec3_create(1, 0, 0);
            // Identity matrix (column-major)
            var identity = [1,0,0, 0,1,0, 0,0,1];
            vec3_apply_matrix3(v, identity);
            expect(v[0]).toBe(1);
            expect(v[1]).toBe(0);
            expect(v[2]).toBe(0);
        });

        test("vec3_apply_matrix4() transforms by 4x4 matrix", function() {
            var v = vec3_create(1, 0, 0);
            // Identity matrix (column-major)
            var identity = [1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1];
            vec3_apply_matrix4(v, identity);
            expect(v[0]).toBe(1);
            expect(v[1]).toBe(0);
            expect(v[2]).toBe(0);
            
            // Translation matrix (translate by [5, 3, 2])
            var translate = [1,0,0,0, 0,1,0,0, 0,0,1,0, 5,3,2,1];
            vec3_apply_matrix4(v, translate);
            expect(v[0]).toBe(6);
            expect(v[1]).toBe(3);
            expect(v[2]).toBe(2);
        });

        // ====================================================================
        // MATRIX EXTRACTION
        // ====================================================================

        test("vec3_set_from_matrix_position() extracts position from 4x4 matrix", function() {
            // Matrix with translation [10, 20, 30]
            var m = [1,0,0,0, 0,1,0,0, 0,0,1,0, 10,20,30,1];
            var v = vec3_create();
            vec3_set_from_matrix_position(v, m);
            expect(v[0]).toBe(10);
            expect(v[1]).toBe(20);
            expect(v[2]).toBe(30);
        });

        test("vec3_set_from_matrix_scale() extracts scale from 4x4 matrix", function() {
            // Matrix with scale [2, 3, 4]
            var m = [2,0,0,0, 0,3,0,0, 0,0,4,0, 0,0,0,1];
            var v = vec3_create();
            vec3_set_from_matrix_scale(v, m);
            expect(v[0]).toBe(2);
            expect(v[1]).toBe(3);
            expect(v[2]).toBe(4);
        });

        // ====================================================================
        // SPHERICAL / CYLINDRICAL
        // ====================================================================

        test("vec3_set_from_spherical_coords() sets from spherical coordinates", function() {
            var v = vec3_create();
            vec3_set_from_spherical_coords(v, 1, pi/2, 0);
            expect(abs(v[0] - 1) < 0.001).toBeTruthy();
            expect(abs(v[1]) < 0.001).toBeTruthy();
            expect(abs(v[2]) < 0.001).toBeTruthy();
        });

        test("vec3_set_from_cylindrical_coords() sets from cylindrical coordinates", function() {
            var v = vec3_create();
            vec3_set_from_cylindrical_coords(v, 1, 0, 5);
            expect(abs(v[0] - 1) < 0.001).toBeTruthy();
            expect(v[1]).toBe(5);
            expect(abs(v[2]) < 0.001).toBeTruthy();
        });

        // ====================================================================
        // EXTRA UTILITY
        // ====================================================================

        test("vec3_abs() sets absolute values", function() {
            var v = vec3_create(-3, -4, -5);
            vec3_abs(v);
            expect(v[0]).toBe(3);
            expect(v[1]).toBe(4);
            expect(v[2]).toBe(5);
        });

        // ====================================================================
        // EULER
        // ====================================================================

        test("vec3_apply_euler() rotates vector by Euler angles", function() {
            var v = vec3_create(1, 0, 0);
            vec3_apply_euler(v, [0, 0, 90], "XYZ"); // Rotate 90° around Z
            expect(abs(v[0]) < 0.001).toBeTruthy();
            expect(abs(v[1] - 1) < 0.001).toBeTruthy();
            expect(abs(v[2]) < 0.001).toBeTruthy();
        });

        test("vec3_set_from_euler() copies Euler components", function() {
            var v = vec3_create();
            var euler = [45, 90, 180];
            vec3_set_from_euler(v, euler);
            expect(v[0]).toBe(45);
            expect(v[1]).toBe(90);
            expect(v[2]).toBe(180);
        });

        // ====================================================================
        // SPHERICAL / CYLINDRICAL (from struct)
        // ====================================================================

        test("vec3_set_from_spherical() sets from spherical array", function() {
            var v = vec3_create();
            // spherical = [radius, phi, theta]
            vec3_set_from_spherical(v, [1, pi/2, 0]);
            expect(abs(v[0] - 1) < 0.001).toBeTruthy();
            expect(abs(v[1]) < 0.001).toBeTruthy();
            expect(abs(v[2]) < 0.001).toBeTruthy();
        });

        test("vec3_set_from_cylindrical() sets from cylindrical array", function() {
            var v = vec3_create();
            // cylindrical = [radius, theta, y]
            vec3_set_from_cylindrical(v, [1, 0, 5]);
            expect(abs(v[0] - 1) < 0.001).toBeTruthy();
            expect(v[1]).toBe(5);
            expect(abs(v[2]) < 0.001).toBeTruthy();
        });

        // ====================================================================
        // COLOR
        // ====================================================================

        test("vec3_set_from_color() sets from color array", function() {
            var v = vec3_create();
            vec3_set_from_color(v, [0.5, 0.75, 1.0]);
            expect(v[0]).toBe(0.5);
            expect(v[1]).toBe(0.75);
            expect(v[2]).toBe(1.0);
        });

        test("vec3_set_from_color_gml() sets from GML color", function() {
            var v = vec3_create();
            var col = make_colour_rgb(255, 128, 0);
            vec3_set_from_color_gml(v, col);
            expect(v[0]).toBe(1);
            expect(round(v[1] * 100) / 100).toBe(0.5);
            expect(v[2]).toBe(0);
        });

        // ====================================================================
        // CAMERA PROJECTION
        // ====================================================================

        test("vec3_project() applies view and projection matrices from camera", function() {
            var v = vec3_create(1, 0, 0);
            // Mock camera with identity matrices
            var identity = [1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1];
            var camera = {
                matrixWorld: identity,
                matrixWorldInverse: identity,
                projectionMatrix: identity,
                projectionMatrixInverse: identity
            };
            vec3_project(v, camera);
            expect(v[0]).toBe(1);
            expect(v[1]).toBe(0);
            expect(v[2]).toBe(0);
        });

        test("vec3_unproject() applies inverse matrices from camera", function() {
            var v = vec3_create(1, 0, 0);
            // Mock camera with identity matrices
            var identity = [1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1];
            var camera = {
                matrixWorld: identity,
                matrixWorldInverse: identity,
                projectionMatrix: identity,
                projectionMatrixInverse: identity
            };
            vec3_unproject(v, camera);
            expect(v[0]).toBe(1);
            expect(v[1]).toBe(0);
            expect(v[2]).toBe(0);
        });
    });
});
