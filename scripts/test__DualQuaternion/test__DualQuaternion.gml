// GMTL-style test suite for DualQuaternion

suite(function() {
    describe("DualQuaternion", function() {
        
        // ====================================================================
        // CREATION
        // ====================================================================
        
        test("dualquat_create() creates identity dual quaternion", function() {
            var dq = dualquat_create();
            expect(dq[0]).toBe(0);
            expect(dq[1]).toBe(0);
            expect(dq[2]).toBe(0);
            expect(dq[3]).toBe(1);
            expect(dq[4]).toBe(0);
            expect(dq[5]).toBe(0);
            expect(dq[6]).toBe(0);
            expect(dq[7]).toBe(0);
        });

        test("dualquat_create(rx, ry, rz, rw, dx, dy, dz, dw) creates specific dual quaternion", function() {
            var dq = dualquat_create(1, 2, 3, 4, 5, 6, 7, 8);
            expect(dq[0]).toBe(1);
            expect(dq[7]).toBe(8);
        });

        // ====================================================================
        // SETTERS / IDENTITY
        // ====================================================================

        test("dualquat_set() sets values", function() {
            var dq = dualquat_create();
            dualquat_set(dq, 1, 2, 3, 4, 5, 6, 7, 8);
            expect(dq[0]).toBe(1);
            expect(dq[7]).toBe(8);
        });

        test("dualquat_identity() resets to identity", function() {
            var dq = dualquat_create(1, 2, 3, 4, 5, 6, 7, 8);
            dualquat_identity(dq);
            expect(dq[0]).toBe(0);
            expect(dq[3]).toBe(1);
            expect(dq[4]).toBe(0);
        });

        // ====================================================================
        // CLONE / COPY
        // ====================================================================

        test("dualquat_clone() creates copy", function() {
            var dq = dualquat_create(1, 2, 3, 4, 5, 6, 7, 8);
            var dq2 = dualquat_clone(dq);
            expect(dualquat_equals(dq, dq2)).toBeTruthy();
            dq2[0] = 99;
            expect(dq[0]).toBe(1);
        });

        test("dualquat_copy() copies values", function() {
            var dq = dualquat_create();
            var src = dualquat_create(1, 2, 3, 4, 5, 6, 7, 8);
            dualquat_copy(dq, src);
            expect(dualquat_equals(dq, src)).toBeTruthy();
        });

        // ====================================================================
        // CONVERSIONS
        // ====================================================================

        test("dualquat_from_translation_rotation() translation and identity rotation", function() {
            var dq = dualquat_create();
            var translation = [10, 20, 30];
            var rotation = [0, 0, 0, 1]; // identity
            dualquat_from_translation_rotation(dq, translation, rotation);
            
            expect(dq[0]).toBe(0);
            expect(dq[3]).toBe(1);
            
            // Dual part for translation t and rotation r: 0.5 * t * r
            // with r = identity (0,0,0,1), dual part is 0.5 * [tx, ty, tz, 0]
            expect(dq[4]).toBe(5);  // 10 * 0.5
            expect(dq[5]).toBe(10); // 20 * 0.5
            expect(dq[6]).toBe(15); // 30 * 0.5
            expect(dq[7]).toBe(0);
        });

        test("dualquat_to_translation_rotation() extracts correctly", function() {
            var dq = dualquat_create();
            var t1 = [10, 20, 30];
            var r1 = [0, 0, 0, 1];
            dualquat_from_translation_rotation(dq, t1, r1);
            
            var t2 = [0, 0, 0];
            var r2 = [0, 0, 0, 0];
            dualquat_to_translation_rotation(dq, t2, r2);
            
            expect(t2[0]).toBe(10);
            expect(t2[1]).toBe(20);
            expect(t2[2]).toBe(30);
            expect(r2[3]).toBe(1);
        });

        // ====================================================================
        // OPERATIONS
        // ====================================================================

        test("dualquat_multiply() combines transformations", function() {
            // DQ1: translate by 10 on X
            var dq1 = dualquat_create();
            dualquat_from_translation_rotation(dq1, [10, 0, 0], [0, 0, 0, 1]);
            
            // DQ2: translate by 5 on X
            var dq2 = dualquat_create();
            dualquat_from_translation_rotation(dq2, [5, 0, 0], [0, 0, 0, 1]);
            
            dualquat_multiply(dq1, dq2); // result should be translate by 15 on X
            
            var t = [0,0,0], r = [0,0,0,0];
            dualquat_to_translation_rotation(dq1, t, r);
            
            expect(t[0]).toBe(15);
            expect(r[3]).toBe(1);
        });

        test("dualquat_normalize() fixes drift", function() {
            var dq = dualquat_create(0, 0, 0, 2, 0, 0, 0, 1);
            dualquat_normalize(dq);
            // Real part should be normalized to 1 (w=1)
            expect(dq[3]).toBe(1);
        });

        test("dualquat_transform_vec3() rotates and translates", function() {
            var dq = dualquat_create();
            // Rotation 90 deg around Z
            var q = quat_create();
            quat_set_from_axis_angle(q, [0, 0, 1], 90);
            // Translation [10, 0, 0]
            dualquat_from_translation_rotation(dq, [10, 0, 0], q);
            
            var v = [1, 0, 0];
            var target = [0, 0, 0];
            dualquat_transform_vec3(dq, v, target);
            
            // Rotate [1,0,0] 90 deg around Z -> [0,1,0]
            // Translate [0,1,0] by [10,0,0] -> [10,1,0]
            expect(abs(target[0] - 10) < 0.001).toBeTruthy();
            expect(abs(target[1] - 1) < 0.001).toBeTruthy();
            expect(abs(target[2] - 0) < 0.001).toBeTruthy();
        });

        test("dualquat_premultiply() correctly orders transformations", function() {
            // DQ1: translate by 10 on X
            var dq1 = dualquat_create();
            dualquat_from_translation_rotation(dq1, [10, 0, 0], [0, 0, 0, 1]);
            
            // DQ2: translate by 5 on X
            var dq2 = dualquat_create();
            dualquat_from_translation_rotation(dq2, [5, 0, 0], [0, 0, 0, 1]);
            
            dualquat_premultiply(dq1, dq2); // dq1 = dq2 * dq1
            
            var t = [0,0,0], r = [0,0,0,0];
            dualquat_to_translation_rotation(dq1, t, r);
            expect(t[0]).toBe(15);
        });

        test("dualquat_dlerp() interpolates between transformations", function() {
            var dq1 = dualquat_create();
            dualquat_from_translation_rotation(dq1, [0, 0, 0], [0, 0, 0, 1]);
            
            var dq2 = dualquat_create();
            dualquat_from_translation_rotation(dq2, [10, 0, 0], [0, 0, 0, 1]);
            
            var result = dualquat_create();
            dualquat_copy(result, dq1);
            dualquat_dlerp(result, dq2, 0.5);
            
            var t = [0,0,0], r = [0,0,0,0];
            dualquat_to_translation_rotation(result, t, r);
            expect(t[0]).toBe(5);
        });

        test("dualquat_to_matrix4() creates valid transform matrix", function() {
            var dq = dualquat_create();
            dualquat_from_translation_rotation(dq, [10, 20, 30], [0, 0, 0, 1]);
            
            var m = array_create(16);
            dualquat_to_matrix4(dq, m);
            
            expect(m[12]).toBe(10);
            expect(m[13]).toBe(20);
            expect(m[14]).toBe(30);
            expect(m[15]).toBe(1);
            expect(m[0]).toBe(1); // identity rotation
        });

        test("dualquat_from_array() and dualquat_to_array() work correctly", function() {
            var src = [1, 2, 3, 4, 5, 6, 7, 8];
            var dq = dualquat_create();
            dualquat_from_array(dq, src);
            expect(dq[0]).toBe(1);
            expect(dq[7]).toBe(8);
            
            var dest = array_create(8);
            dualquat_to_array(dq, dest);
            expect(dest[0]).toBe(1);
            expect(dest[7]).toBe(8);
        });
    });
});
