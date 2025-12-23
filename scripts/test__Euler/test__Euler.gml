// GMTL-style test suite for Euler
// Angles in DEGREES

suite(function() {
    describe("Euler", function() {
        
        test("euler_create()", function() {
            var e = euler_create();
            expect(e[0]).toBe(0);
            expect(e[1]).toBe(0);
            expect(e[2]).toBe(0);
            expect(e[3]).toBe("XYZ");
        });

        test("euler_set()", function() {
            var e = euler_create();
            euler_set(e, 10, 20, 30, "YXZ");
            expect(e[0]).toBe(10);
            expect(e[1]).toBe(20);
            expect(e[2]).toBe(30);
            expect(e[3]).toBe("YXZ");
        });

        test("euler_set_from_quaternion() convert", function() {
            var e = euler_create();
            // Quaternion for 90 deg around X
            // 0.707, 0, 0, 0.707
            var q = [0.70710678, 0, 0, 0.70710678];
            euler_set_from_quaternion(e, q, "XYZ");
            
            expect(abs(e[0] - 90) < 0.01).toBeTruthy();
            expect(abs(e[1]) < 0.01).toBeTruthy();
            expect(abs(e[2]) < 0.01).toBeTruthy();
        });
    });
});
