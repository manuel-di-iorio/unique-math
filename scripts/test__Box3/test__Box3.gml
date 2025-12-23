// GMTL-style test suite for Box3

suite(function() {
    describe("Box3", function() {
        test("box3_create() init as empty inverted box", function() {
            var b = box3_create();
            expect(b[0]).toBe(infinity);
            expect(b[3]).toBe(-infinity);
        });

        test("box3_expand_by_point() expands bbox", function() {
            var b = box3_create();
            box3_expand_by_point(b, 10, 10, 10);
            box3_expand_by_point(b, -10, -10, -10);
            
            expect(b[0]).toBe(-10);
            expect(b[1]).toBe(-10);
            expect(b[3]).toBe(10);
            expect(b[5]).toBe(10);
        });

        test("box3_contains_point()", function() {
            var b = box3_create(-10, -10, -10, 10, 10, 10);
            expect(box3_contains_point(b, 0, 0, 0)).toBeTruthy();
            expect(box3_contains_point(b, 15, 0, 0)).toBeFalsy();
        });

        test("box3_intersects_box()", function() {
            var b1 = box3_create(0, 0, 0, 10, 10, 10);
            var b2 = box3_create(5, 5, 5, 15, 15, 15);
            var b3 = box3_create(20, 20, 20, 30, 30, 30);
            
            expect(box3_intersects_box(b1, b2)).toBeTruthy();
            expect(box3_intersects_box(b1, b3)).toBeFalsy();
        });
        
        test("box3_get_center()", function() {
            var b = box3_create(0, 0, 0, 10, 20, 30);
            var c = box3_get_center(b);
            expect(c[0]).toBe(5);
            expect(c[1]).toBe(10);
            expect(c[2]).toBe(15);
        });
    });
});
