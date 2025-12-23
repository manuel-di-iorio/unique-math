// GMTL-style test suite for Ray

suite(function() {
    describe("Ray", function() {
        test("ray_create()", function() {
            var r = ray_create(0, 0, 0, 0, 0, 1);
            expect(r[5]).toBe(1);
        });

        test("ray_at()", function() {
            var r = ray_create(0, 0, 0, 1, 0, 0);
            var p = ray_at(r, 10);
            expect(p[0]).toBe(10);
            expect(p[1]).toBe(0);
        });

        test("ray_intersect_sphere()", function() {
            var r = ray_create(0, 0, 0, 1, 0, 0); // Ray along +X
            var s = sphere_create(10, 0, 0, 2); // Sphere at X=10 radius 2
            
            // Should hit at 10-2 = 8
            var t = ray_intersect_sphere(r, s);
            expect(abs(t - 8) < 0.001).toBeTruthy();
            
            // Miss
            var s2 = sphere_create(10, 5, 0, 2);
            var t2 = ray_intersect_sphere(r, s2);
            expect(t2).toBe(-1);
        });

        test("ray_intersect_box()", function() {
            var r = ray_create(0, 0, 0, 1, 0, 0); // Ray along +X
            var b = box3_create(5, -1, -1, 7, 1, 1); // Box X [5, 7]
            
            var t = ray_intersect_box(r, b);
            expect(abs(t - 5) < 0.001).toBeTruthy();
            
            var bMiss = box3_create(5, 5, 5, 7, 7, 7);
            expect(ray_intersect_box(r, bMiss)).toBe(-1);
        });
        
        test("ray_equals()", function() {
            var r1 = ray_create(0, 0, 0, 1, 0, 0);
            var r2 = ray_clone(r1);
            expect(ray_equals(r1, r2)).toBeTruthy();
            r2[3] = 0;
            expect(ray_equals(r1, r2)).toBeFalsy();
        });
        
        test("ray_recast()", function() {
            var r = ray_create(0, 0, 0, 1, 0, 0);
            ray_recast(r, 5);
            expect(r[0]).toBe(5);
            expect(r[1]).toBe(0);
            expect(r[2]).toBe(0);
        });
        
        test("ray_intersect_plane_and_distance()", function() {
            var r = ray_create(0, -5, 0, 0, 1, 0);
            var p = plane_create(0, 1, 0, 0);
            var hit = ray_intersect_plane(r, p);
            expect(hit != undefined).toBeTruthy();
            if (hit) {
                expect(abs(hit[0]) < 0.001).toBeTruthy();
                expect(abs(hit[1]) < 0.001).toBeTruthy();
                expect(abs(hit[2]) < 0.001).toBeTruthy();
            }
            var d = ray_distance_to_plane(r, p);
            expect(abs(d - 5) < 0.001).toBeTruthy();
        });
        
        test("ray_intersects_plane_sphere_box()", function() {
            var r = ray_create(0, -5, 0, 0, 1, 0);
            var p = plane_create(0, 1, 0, 0);
            expect(ray_intersects_plane(r, p)).toBeTruthy();
            var s = sphere_create(0, 0, 0, 2);
            expect(ray_intersects_sphere(r, s)).toBeTruthy();
            var b = box3_create(-1, -1, -1, 1, 1, 1);
            expect(ray_intersects_box(r, b)).toBeTruthy();
        });
        
        test("ray_distance_to_point()", function() {
            var r = ray_create(0, 0, 0, 1, 0, 0);
            var d = ray_distance_to_point(r, 0, 5, 0);
            expect(abs(d - 5) < 0.001).toBeTruthy();
            var d2 = ray_distance_sq_to_point(r, 0, 5, 0);
            expect(abs(d2 - 25) < 0.001).toBeTruthy();
        });
        
        test("ray_closest_point_to_point()", function() {
            var r = ray_create(0, 0, 0, 1, 0, 0);
            var c = ray_closest_point_to_point(r, 5, 5, 0);
            expect(abs(c[0] - 5) < 0.001).toBeTruthy();
            expect(abs(c[1] - 0) < 0.001).toBeTruthy();
            expect(abs(c[2] - 0) < 0.001).toBeTruthy();
        });
        
        test("ray_distance_sq_to_segment()", function() {
            var r = ray_create(0, 0, 0, 1, 0, 0);
            var v0 = [5, -5, 0];
            var v1 = [5, 5, 0];
            var outRay = [0, 0, 0];
            var outSeg = [0, 0, 0];
            var d2 = ray_distance_sq_to_segment(r, v0, v1, outRay, outSeg);
            expect(abs(d2 - 25) < 0.001).toBeTruthy();
            expect(abs(outRay[0] - 5) < 0.001).toBeTruthy();
            expect(abs(outSeg[0] - 5) < 0.001).toBeTruthy();
        });
        
        test("ray_intersect_sphere_point()", function() {
            var r = ray_create(0, 0, 0, 1, 0, 0);
            var s = sphere_create(10, 0, 0, 2);
            var hit = ray_intersect_sphere_point(r, s);
            expect(hit != undefined).toBeTruthy();
            if (hit) {
                expect(abs(hit[0] - 8) < 0.001).toBeTruthy();
                expect(abs(hit[1]) < 0.001).toBeTruthy();
                expect(abs(hit[2]) < 0.001).toBeTruthy();
            }
        });
        
        test("ray_intersect_triangle()", function() {
            var r = ray_create(0, 0, 0, 1, 0, 0);
            var a = [5, 1, 0];
            var b = [5, -1, 1];
            var c = [5, -1, -1];
            var hit = ray_intersect_triangle(r, a, b, c, false);
            expect(hit != undefined).toBeTruthy();
            if (hit) {
                expect(abs(hit[0] - 5) < 0.001).toBeTruthy();
                expect(abs(hit[1]) < 0.001).toBeTruthy();
                expect(abs(hit[2]) < 0.001).toBeTruthy();
            }
        });
        
        test("ray_apply_matrix4()", function() {
            var r = ray_create(0, 0, 0, 1, 0, 0);
            var m = mat4_create();
            mat4_make_translation(m, 5, 7, 9);
            ray_apply_matrix4(r, m);
            expect(r[0]).toBe(5);
            expect(r[1]).toBe(7);
            expect(r[2]).toBe(9);
        });
    });
});
