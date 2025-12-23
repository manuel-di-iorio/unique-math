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
    });
});
