// GMTL-style test suite for Euler
// Angles in DEGREES

suite(function() {
    describe("Euler", function() {
        
        test("euler_create()", function() {
            var e = euler_create();
            expect(e[0]).toBe(0);
            expect(e[1]).toBe(0);
            expect(e[2]).toBe(0);
        });

        test("euler_set()", function() {
            var e = euler_create();
            euler_set(e, 10, 20, 30);
            expect(e[0]).toBe(10);
            expect(e[1]).toBe(20);
            expect(e[2]).toBe(30);
        });

        test("euler_set_from_quaternion() convert", function() {
            var e = euler_create();
            // Quaternion for 90 deg around X
            // 0.707, 0, 0, 0.707
            var q = [0.70710678, 0, 0, 0.70710678];
            euler_set_from_quaternion(e, q);
            
            expect(abs(e[0] - 90) < 0.01).toBeTruthy();
            expect(abs(e[1]) < 0.01).toBeTruthy();
            expect(abs(e[2]) < 0.01).toBeTruthy();
        });
        
        test("euler_from_array()", function() {
            var e = euler_create();
            var arr = [45, 90, 180];
            euler_from_array(e, arr);
            expect(e[0]).toBe(45);
            expect(e[1]).toBe(90);
            expect(e[2]).toBe(180);
        });

        test("euler_from_array() with offset", function() {
            var e = euler_create();
            var arr = [0, 45, 90, 180];
            euler_from_array(e, arr, 1);
            expect(e[0]).toBe(45);
            expect(e[1]).toBe(90);
            expect(e[2]).toBe(180);
        });

        test("euler_to_array()", function() {
            var e = euler_create(10, 20, 30);
            var out = euler_to_array(e);
            expect(out[0]).toBe(10);
            expect(out[1]).toBe(20);
            expect(out[2]).toBe(30);
        });

        test("euler_to_array() with offset", function() {
            var e = euler_create(10, 20, 30);
            var out = array_create(6, 0);
            euler_to_array(e, out, 2);
            expect(out[2]).toBe(10);
            expect(out[3]).toBe(20);
            expect(out[4]).toBe(30);
        });

        test("euler_set_from_vector3()", function() {
            var e = euler_create();
            var v = vec3_create(5, 6, 7);
            euler_set_from_vector3(e, v);
            expect(e[0]).toBe(5);
            expect(e[1]).toBe(6);
            expect(e[2]).toBe(7);
        });

        test("euler_set_from_vector3() with order", function() {
            var e = euler_create();
            var v = vec3_create(5, 6, 7);
            euler_set_from_vector3(e, v);
        });
    });
});
