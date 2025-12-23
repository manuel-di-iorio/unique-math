// GMTL-style test suite for Box2

suite(function() {
    describe("Box2", function() {
        test("box2_create()", function() {
            var b = box2_create();
            expect(b[0]).toBe(infinity);
        });

        test("box2_expand_by_point()", function() {
            var b = box2_create();
            box2_expand_by_point(b, 10, 20);
            expect(b[0]).toBe(10);
            expect(b[1]).toBe(20);
            expect(b[2]).toBe(10);
            expect(b[3]).toBe(20);
        });
    });
});
