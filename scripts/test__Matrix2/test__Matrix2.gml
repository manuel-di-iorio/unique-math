// GMTL-style test suite for Matrix2
suite(function() {
    describe("Matrix2", function() {
        
        test("mat2_create() creates identity matrix by default", function() {
            var m = mat2_create();
            expect(m[0]).toBe(1); // n11
            expect(m[1]).toBe(0); // n21
            expect(m[2]).toBe(0); // n12
            expect(m[3]).toBe(1); // n22
        });

        test("mat2_set() sets elements in row-major order", function() {
            var m = mat2_create();
            mat2_set(m, 1, 2, 3, 4);
            // Column-major: [1, 3, 2, 4]
            expect(m[0]).toBe(1);
            expect(m[1]).toBe(3);
            expect(m[2]).toBe(2);
            expect(m[3]).toBe(4);
        });

        test("mat2_identity() resets to identity", function() {
            var m = mat2_create(1, 2, 3, 4);
            mat2_identity(m);
            expect(m[0]).toBe(1);
            expect(m[3]).toBe(1);
            expect(m[1]).toBe(0);
        });

        test("mat2_from_array() sets from column-major array", function() {
            var m = mat2_create();
            var arr = [10, 20, 30, 40];
            mat2_from_array(m, arr);
            expect(m[0]).toBe(10);
            expect(m[1]).toBe(20);
            expect(m[2]).toBe(30);
            expect(m[3]).toBe(40);
        });
    });
});
