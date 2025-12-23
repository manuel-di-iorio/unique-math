// GMTL-style test suite for Sphere

suite(function() {
    describe("Sphere", function() {
        test("sphere_create()", function() {
            var s = sphere_create(1, 2, 3, 4);
            expect(s[0]).toBe(1);
            expect(s[1]).toBe(2);
            expect(s[2]).toBe(3);
            expect(s[3]).toBe(4);
        });

        test("sphere_contains_point()", function() {
            var s = sphere_create(0, 0, 0, 10);
            expect(sphere_contains_point(s, 0, 0, 0)).toBeTruthy();
            expect(sphere_contains_point(s, 10, 0, 0)).toBeTruthy();
            expect(sphere_contains_point(s, 11, 0, 0)).toBeFalsy();
        });

        test("sphere_intersects_sphere()", function() {
            var s1 = sphere_create(0, 0, 0, 5);
            var s2 = sphere_create(10, 0, 0, 4); // Dist 10, radii sum 9 -> False
            expect(sphere_intersects_sphere(s1, s2)).toBeFalsy();
            
            var s3 = sphere_create(9, 0, 0, 4); // Dist 9, radii sum 9 -> True
            expect(sphere_intersects_sphere(s1, s3)).toBeTruthy();
        });
    });
});
