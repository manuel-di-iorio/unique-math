// GMTL-style test suite for SphericalHarmonics3
suite(function() {
    describe("SphericalHarmonics3", function() {
        
        test("sh3_create() creates 9 Vector3 coefficients", function() {
            var sh = sh3_create();
            expect(array_length(sh)).toBe(9);
            for (var i = 0; i < 9; i++) {
                expect(array_length(sh[i])).toBe(3);
                expect(sh[i][0]).toBe(0);
            }
        });

        test("sh3_zero() resets to zeros", function() {
            var sh = sh3_create();
            vec3_set(sh[0], 1, 2, 3);
            sh3_zero(sh);
            expect(sh[0][0]).toBe(0);
        });

        test("sh3_copy() copies coefficients", function() {
            var sh1 = sh3_create();
            var sh2 = sh3_create();
            vec3_set(sh1[4], 10, 20, 30);
            sh3_copy(sh2, sh1);
            expect(sh2[4][0]).toBe(10);
            expect(sh2[4][2]).toBe(30);
        });

        test("sh3_add() adds coefficients", function() {
            var sh1 = sh3_create();
            var sh2 = sh3_create();
            vec3_set(sh1[0], 1, 1, 1);
            vec3_set(sh2[0], 2, 2, 2);
            sh3_add(sh1, sh2);
            expect(sh1[0][0]).toBe(3);
        });

        test("sh3_add_scaled_sh() adds scaled coefficients", function() {
            var sh1 = sh3_create();
            var sh2 = sh3_create();
            vec3_set(sh1[0], 1, 1, 1);
            vec3_set(sh2[0], 2, 2, 2);
            sh3_add_scaled_sh(sh1, sh2, 2);
            expect(sh1[0][0]).toBe(5);
        });

        test("sh3_scale() scales coefficients", function() {
            var sh = sh3_create();
            vec3_set(sh[0], 1, 2, 3);
            sh3_scale(sh, 2);
            expect(sh[0][0]).toBe(2);
            expect(sh[0][1]).toBe(4);
            expect(sh[0][2]).toBe(6);
        });

        test("sh3_from_array() sets from flat array", function() {
            var sh = sh3_create();
            var arr = array_create(27, 1);
            sh3_from_array(sh, arr);
            expect(sh[0][0]).toBe(1);
            expect(sh[8][2]).toBe(1);
        });

        test("sh3_get_at() calculates radiance correctly for constant term", function() {
            var sh = sh3_create();
            vec3_set(sh[0], 1, 1, 1); // Only constant term
            var normal = vec3_create(0, 1, 0);
            var target = vec3_create();
            sh3_get_at(sh, normal, target);
            // Constant radiance should be 1 * 0.282095
            expect(abs(target[0] - 0.282095) < 0.0001).toBeTruthy();
            expect(abs(target[1] - 0.282095) < 0.0001).toBeTruthy();
            expect(abs(target[2] - 0.282095) < 0.0001).toBeTruthy();
        });

        test("sh3_get_irradiance_at() calculates irradiance correctly for constant term", function() {
            var sh = sh3_create();
            vec3_set(sh[0], 1, 1, 1);
            var normal = vec3_create(1, 0, 0);
            var target = vec3_create();
            sh3_get_irradiance_at(sh, normal, target);
            // Irradiance for L00=1 is c4 = 0.886227
            expect(abs(target[0] - 0.886227) < 0.0001).toBeTruthy();
        });

        test("sh3_equals() checks for equality", function() {
            var sh1 = sh3_create();
            var sh2 = sh3_create();
            expect(sh3_equals(sh1, sh2)).toBeTruthy();
            vec3_set(sh1[8], 0.0001, 0, 0);
            expect(sh3_equals(sh1, sh2)).toBeFalsy();
        });
        
        test("sh3_get_basis_at() computes basis coefficients", function() {
            var normal = vec3_create(0, 1, 0);
            var basis = array_create(9);
            sh3_get_basis_at(normal, basis);
            expect(abs(basis[0] - 0.282095) < 0.0001).toBeTruthy();
            expect(abs(basis[1] - 0.488603) < 0.0001).toBeTruthy(); // y = 1
            expect(basis[2]).toBe(0); // z = 0
        });
    });
});
