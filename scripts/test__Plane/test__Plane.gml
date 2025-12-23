// GMTL-style test suite for Plane

suite(function() {
    describe("Plane", function() {
        test("plane_create()", function() {
            var p = plane_create(0, 1, 0, 5);
            expect(p[1]).toBe(1);
            expect(p[3]).toBe(5);
        });

        test("plane_distance_to_point()", function() {
            // Plane y=0, facing +y, constant=0 -> xz plane
            var p = plane_create(0, 1, 0, 0); // normal (0,1,0), d=0
            expect(plane_distance_to_point(p, 0, 10, 0)).toBe(10);
            expect(plane_distance_to_point(p, 0, -5, 0)).toBe(-5);
        });

        test("plane_set_from_normal_and_coplanar_point()", function() {
            var p = plane_create();
            // Normal (0,1,0), Point (0, 10, 0)
            // Equation: 0*x + 1*y + 0*z + d = 0
            // 1*10 + d = 0 => d = -10
            plane_set_from_normal_and_coplanar_point(p, 0, 1, 0, 0, 10, 0);
            expect(p[3]).toBe(-10);
            expect(plane_distance_to_point(p, 0, 10, 0)).toBe(0);
        });
    });
});
