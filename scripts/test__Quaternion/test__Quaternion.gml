// GMTL-style test suite for Quaternion
// Angles in DEGREES

suite(function() {
    describe("Quaternion", function() {
        
        // ====================================================================
        // CREATION
        // ====================================================================
        
        test("quat_create() creates identity quaternion", function() {
            var q = quat_create();
            expect(q[0]).toBe(0);
            expect(q[1]).toBe(0);
            expect(q[2]).toBe(0);
            expect(q[3]).toBe(1);
        });

        test("quat_create(x, y, z, w) creates specific quaternion", function() {
            var q = quat_create(1, 2, 3, 4);
            expect(q[0]).toBe(1);
            expect(q[1]).toBe(2);
            expect(q[2]).toBe(3);
            expect(q[3]).toBe(4);
        });

        // ====================================================================
        // SETTERS
        // ====================================================================

        test("quat_set() sets values", function() {
            var q = quat_create();
            quat_set(q, 1, 2, 3, 4);
            expect(q[0]).toBe(1);
            expect(q[1]).toBe(2);
            expect(q[2]).toBe(3);
            expect(q[3]).toBe(4);
        });

        test("quat_identity() resets to identity", function() {
            var q = quat_create(1, 2, 3, 4);
            quat_identity(q);
            expect(q[0]).toBe(0);
            expect(q[3]).toBe(1);
        });

        // ====================================================================
        // CLONE / COPY
        // ====================================================================

        test("quat_clone() creates copy", function() {
            var q = quat_create(1, 2, 3, 4);
            var q2 = quat_clone(q);
            expect(quat_equals(q, q2)).toBeTruthy();
            q2[0] = 99;
            expect(q[0]).toBe(1);
        });

        test("quat_copy() copies values", function() {
            var q = quat_create();
            var src = quat_create(1, 2, 3, 4);
            quat_copy(q, src);
            expect(quat_equals(q, src)).toBeTruthy();
        });

        // ====================================================================
        // CONVERSIONS
        // ====================================================================

        test("quat_set_from_axis_angle() X axis 90 deg", function() {
            var q = quat_create();
            var axis = vec3_create(1, 0, 0);
            quat_set_from_axis_angle(q, axis, 90);
            // Expected: sin(45) i + cos(45) w
            // sin(45) ~= 0.707
            expect(abs(q[0] - 0.707) < 0.001).toBeTruthy();
            expect(q[1]).toBe(0);
            expect(q[2]).toBe(0);
            expect(abs(q[3] - 0.707) < 0.001).toBeTruthy();
        });

        test("quat_set_from_euler() converts XYZ", function() {
            var q = quat_create();
            quat_set_from_euler(q, 90, 0, 0, "YXZ");
    
            expect(abs(q[0] - 0.707) < 0.001).toBeTruthy();  // x
            expect(abs(q[1] - 0) < 0.001).toBeTruthy();      // y
            expect(abs(q[2] - 0) < 0.001).toBeTruthy();      // z
            expect(abs(q[3] - 0.707) < 0.001).toBeTruthy();  // w
        });

        // ====================================================================
        // OPERATIONS
        // ====================================================================

        test("quat_conjugate() negates vector part", function() {
            var q = quat_create(1, 2, 3, 4);
            quat_conjugate(q);
            expect(q[0]).toBe(-1);
            expect(q[1]).toBe(-2);
            expect(q[2]).toBe(-3);
            expect(q[3]).toBe(4);
        });

        test("quat_invert() conjugates for now", function() {
            var q = quat_create(1, 2, 3, 4);
            quat_invert(q);
            expect(q[0]).toBe(-1);
        });

        test("quat_length() returns magnitude", function() {
            var q = quat_create(0, 0, 0, 1);
            expect(quat_length(q)).toBe(1);
            q = quat_create(1, 1, 1, 1); // sq = 4, len = 2
            expect(quat_length(q)).toBe(2);
        });

        test("quat_normalize() makes unit quaternion", function() {
            var q = quat_create(2, 0, 0, 0);
            quat_normalize(q);
            expect(q[0]).toBe(1);
            expect(quat_length(q)).toBe(1);
        });

        test("quat_multiply() combines rotations", function() {
          var q1 = quat_create();
          quat_set_from_axis_angle(q1, [1, 0, 0], 90); // X 90°
      
          var q2 = quat_create();
          quat_set_from_axis_angle(q2, [0, 1, 0], 90); // Y 90°
      
          quat_multiply(q1, q2); // q1 = q1 * q2
      
          // Valori attesi (approssimati)
          var expected = [0.5, 0.5, 0.5, 0.5];
      
          expect(abs(q1[0] - expected[0]) < 0.001).toBeTruthy();
          expect(abs(q1[1] - expected[1]) < 0.001).toBeTruthy();
          expect(abs(q1[2] - expected[2]) < 0.001).toBeTruthy();
          expect(abs(q1[3] - expected[3]) < 0.001).toBeTruthy();
        });

        test("quat_slerp() interpolates", function() {
            var q1 = quat_create(0, 0, 0, 1);
            var q2 = quat_create(1, 0, 0, 0); // Invalid 180 flip test maybe, but technically unit validity matters
            // Let's use valid rotations
            quat_set_from_axis_angle(q2, [1, 0, 0], 90);
            
            var q = quat_clone(q1);
            quat_slerp(q, q2, 0.5);
            
            // Should be 45 degrees
            // 45 deg around X -> [sin(22.5), 0, 0, cos(22.5)]
            // sin(22.5) ~= 0.3826
            // cos(22.5) ~= 0.9238
            expect(abs(q[0] - 0.3826) < 0.001).toBeTruthy();
        });

        // ====================================================================
        // UTILS
        // ====================================================================

        test("quat_from_array/to_array", function() {
            var q = quat_create();
            var arr = [10, 20, 30, 40];
            quat_from_array(q, arr);
            expect(q[0]).toBe(10);
            expect(q[3]).toBe(40);
            
            var arr2 = quat_to_array(q);
            expect(arr2[0]).toBe(10);
        });
    });
});
