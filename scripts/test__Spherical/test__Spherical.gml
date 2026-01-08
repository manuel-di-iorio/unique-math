// GMTL-style test suite for Spherical
suite(function() {
    describe("Spherical", function() {
        
        test("spherical_create() creates default spherical", function() {
            var s = spherical_create();
            expect(s[0]).toBe(1);
            expect(s[1]).toBe(0);
            expect(s[2]).toBe(0);
        });

        test("spherical_set() sets components", function() {
            var s = spherical_create();
            spherical_set(s, 2, 1, 0.5);
            expect(s[0]).toBe(2);
            expect(s[1]).toBe(1);
            expect(s[2]).toBe(0.5);
        });

        test("spherical_copy() copies values", function() {
            var s1 = spherical_create(5, 2, 1);
            var s2 = spherical_create();
            spherical_copy(s2, s1);
            expect(s2[0]).toBe(5);
            expect(s2[1]).toBe(2);
            expect(s2[2]).toBe(1);
        });

        test("spherical_clone() creates a clone", function() {
            var s = spherical_create(3, 1, 0.5);
            var c = spherical_clone(s);
            expect(c[0]).toBe(s[0]);
            expect(c[1]).toBe(s[1]);
            expect(c[2]).toBe(s[2]);
            c[0] = 10;
            expect(s[0]).toBe(3);
        });

        test("spherical_make_safe() clamps phi", function() {
            var s = spherical_create(1, 0, 0);
            spherical_make_safe(s);
            expect(s[1]).toBe(0.0001);
            
            s[1] = pi;
            spherical_make_safe(s);
            expect(s[1]).toBeLessThan(pi);
        });

        test("spherical_set_from_cartesian_coords() converts correctly", function() {
            var s = spherical_create();
            // Up vector (0, 1, 0)
            spherical_set_from_cartesian_coords(s, 0, 1, 0);
            expect(s[0]).toBe(1); // radius
            expect(s[1]).toBe(0); // phi (acos(1) = 0)
            
            // X vector (1, 0, 0)
            spherical_set_from_cartesian_coords(s, 1, 0, 0);
            expect(s[0]).toBe(1);
            expect(abs(s[1] - pi/2) < 0.0001).toBeTruthy(); // phi (acos(0) = pi/2)
            expect(abs(s[2] - pi/2) < 0.0001).toBeTruthy(); // theta (atan2(1, 0) = pi/2)
            
            // Z vector (0, 0, 1)
            spherical_set_from_cartesian_coords(s, 0, 0, 1);
            expect(abs(s[1] - pi/2) < 0.0001).toBeTruthy();
            expect(s[2]).toBe(0); // theta (atan2(0, 1) = 0)
        });

        test("spherical_set_from_vector3() converts from vector", function() {
            var v = vec3_create(0, 1, 0);
            var s = spherical_create();
            spherical_set_from_vector3(s, v);
            expect(s[0]).toBe(1);
            expect(s[1]).toBe(0);
        });
    });
});
