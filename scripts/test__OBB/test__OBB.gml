// GMTL-style test suite for OBB
suite(function() {
    describe("OBB", function() {
        
        test("obb_create() creates default OBB", function() {
            var obb = obb_create();
            expect(obb[0]).toBe(0); // center X
            expect(obb[3]).toBe(1); // halfSize X
            expect(obb[6]).toBe(1); // rotation[0] (Identity)
        });

        test("obb_contains_point() tests points inside/outside", function() {
            var obb = obb_create([0,0,0], [1,1,1]);
            expect(obb_contains_point(obb, [0,0,0])).toBeTruthy();
            expect(obb_contains_point(obb, [0.5, 0.5, 0.5])).toBeTruthy();
            expect(obb_contains_point(obb, [1.1, 0, 0])).toBeFalsy();
        });

        test("obb_contains_point() with rotation", function() {
            var obb = obb_create([0,0,0], [1,1,1]);
            // Rotate 45 degrees around Z
            var angle = 45;
            var c = dcos(angle);
            var s = dsin(angle);
            
            // Create a temp rotation matrix and set it in the OBB
            var rot = mat3_create();
            mat3_set(rot, 
                c, -s, 0,
                s,  c, 0,
                0,  0, 1
            );
            for (var i = 0; i < 9; i++) obb[6 + i] = rot[i];
            
            // Point [1.2, 0, 0] should be outside AABB but inside rotated OBB
            expect(obb_contains_point(obb, [1.2, 0, 0])).toBeTruthy();
            expect(obb_contains_point(obb, [2, 0, 0])).toBeFalsy();
        });

        test("obb_intersects_sphere()", function() {
            var obb = obb_create([0,0,0], [1,1,1]);
            var sphere = [2, 0, 0, 1.1]; // Intersects
            expect(obb_intersects_sphere(obb, sphere)).toBeTruthy();
            
            sphere[3] = 0.5; // No longer intersects
            expect(obb_intersects_sphere(obb, sphere)).toBeFalsy();
        });

        test("obb_intersects_obb() SAT test", function() {
            var obb1 = obb_create([0,0,0], [1,1,1]);
            var obb2 = obb_create([1.5, 0, 0], [1,1,1]); // Overlaps
            expect(obb_intersects_obb(obb1, obb2)).toBeTruthy();
            
            obb2[0] = 2.5; // center X, no overlap
            expect(obb_intersects_obb(obb1, obb2)).toBeFalsy();
            
            // Overlap by rotation
            obb2[0] = 2.0;
            // Rotate obb2 45 deg
            var rot = mat3_create();
            var c = dcos(45);
            var s = dsin(45);
            mat3_set(rot, c,-s,0, s,c,0, 0,0,1);
            for (var i = 0; i < 9; i++) obb2[6 + i] = rot[i];
            
            expect(obb_intersects_obb(obb1, obb2)).toBeTruthy();
        });

        test("obb_intersect_ray()", function() {
            var obb = obb_create([0,0,0], [1,1,1]);
            var ray = [5, 0, 0, -1, 0, 0]; // Origin [5,0,0], Dir [-1,0,0]
            var target = [0,0,0];
            var result = obb_intersect_ray(obb, ray, target);
            expect(result != undefined).toBeTruthy();
            expect(target[0]).toBe(1);
            
            ray = [5, 5, 5, 1, 1, 1]; // Points away
            expect(obb_intersect_ray(obb, ray, target) == undefined).toBeTruthy();
        });
        
        test("obb_apply_matrix4()", function() {
            var obb = obb_create([0,0,0], [1,1,1]);
            var m = mat4_create();
            mat4_make_translation(m, 10, 0, 0);
        obb_apply_matrix4(obb, m);
        expect(obb[0]).toBe(10); // center X
        
        mat4_identity(m);
        mat4_make_scale(m, 2, 2, 2);
        obb_apply_matrix4(obb, m);
            expect(obb[3]).toBe(2); // halfSize X
            expect(obb[4]).toBe(2); // halfSize Y
            expect(obb[5]).toBe(2); // halfSize Z
        });
    });
});
