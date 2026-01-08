// GMTL-style test suite for Cylindrical
suite(function() {
    describe("Cylindrical", function() {
        
        test("cyl_create() creates default cylindrical", function() {
            var c = cyl_create();
            expect(c[0]).toBe(1); // radius
            expect(c[1]).toBe(0); // theta
            expect(c[2]).toBe(0); // y
        });

        test("cyl_set() sets components", function() {
            var c = cyl_create();
            cyl_set(c, 2, 1, 0.5);
            expect(c[0]).toBe(2);
            expect(c[1]).toBe(1);
            expect(c[2]).toBe(0.5);
        });

        test("cyl_copy() copies values", function() {
            var c1 = cyl_create(5, 2, 1);
            var c2 = cyl_create();
            cyl_copy(c2, c1);
            expect(c2[0]).toBe(5);
            expect(c2[1]).toBe(2);
            expect(c2[2]).toBe(1);
        });

        test("cyl_clone() creates a clone", function() {
            var c = cyl_create(3, 1, 0.5);
            var clone = cyl_clone(c);
            expect(clone[0]).toBe(c[0]);
            expect(clone[1]).toBe(c[1]);
            expect(clone[2]).toBe(c[2]);
            clone[0] = 10;
            expect(c[0]).toBe(3);
        });

        test("cyl_set_from_cartesian_coords() converts correctly", function() {
            var c = cyl_create();
            // Point (0, 5, 1) -> radius=1, theta=0, y=5
            cyl_set_from_cartesian_coords(c, 0, 5, 1);
            expect(c[0]).toBe(1);
            expect(c[1]).toBe(0);
            expect(c[2]).toBe(5);
            
            // Point (1, 0, 0) -> radius=1, theta=pi/2, y=0
            cyl_set_from_cartesian_coords(c, 1, 0, 0);
            expect(c[0]).toBe(1);
            expect(abs(c[1] - pi/2) < 0.0001).toBeTruthy();
            expect(c[2]).toBe(0);
        });

        test("cyl_set_from_vector3() converts from vector", function() {
            var v = vec3_create(1, 2, 0); // x=1, y=2, z=0 -> radius=1, theta=pi/2, y=2
            var c = cyl_create();
            cyl_set_from_vector3(c, v);
            expect(c[0]).toBe(1);
            expect(abs(c[1] - pi/2) < 0.0001).toBeTruthy();
            expect(c[2]).toBe(2);
        });
    });
});
