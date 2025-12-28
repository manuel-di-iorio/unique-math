suite(function() {
    describe("Box2", function() {
        test("box2_create()", function() {
            var b = box2_create();
            expect(b[0]).toBe(infinity);
        });

        test("box2_expand_by_point()", function() {
            var b = box2_create();
            box2_expand_by_point(b, vec2_create(10, 20));
            expect(b[0]).toBe(10);
            expect(b[1]).toBe(20);
            expect(b[2]).toBe(10);
            expect(b[3]).toBe(20);
        });
        
        test("box2_copy() and clone()", function() {
            var b = box2_create(vec2_create(0, 0), vec2_create(5, 5));
            var c = box2_clone(b);
            expect(box2_equals(b, c)).toBeTruthy();
            var d = box2_create();
            box2_copy(d, b);
            expect(box2_equals(d, b)).toBeTruthy();
        });
        
        test("box2_contains_point()", function() {
            var b = box2_create(vec2_create(0, 0), vec2_create(10, 10));
            expect(box2_contains_point(b, vec2_create(5, 5))).toBeTruthy();
            expect(box2_contains_point(b, vec2_create(-1, 5))).toBeFalsy();
        });
        
        test("box2_clamp_point()", function() {
            var b = box2_create(vec2_create(0, 0), vec2_create(10, 10));
            var p = box2_clamp_point(b, 20, -5);
            expect(p[0]).toBe(10);
            expect(p[1]).toBe(0);
        });
        
        test("box2_contains_box()", function() {
            var b = box2_create(vec2_create(0, 0), vec2_create(10, 10));
            var o = box2_create(vec2_create(2, 2), vec2_create(8, 8));
            expect(box2_contains_box(b, o)).toBeTruthy();
            var o2 = box2_create(vec2_create(-1, 2), vec2_create(8, 8));
            expect(box2_contains_box(b, o2)).toBeFalsy();
        });
        
        test("box2_distance_to_point()", function() {
            var b = box2_create(vec2_create(0, 0), vec2_create(10, 10));
            expect(abs(box2_distance_to_point(b, vec2_create(5, 5))) < 0.001).toBeTruthy();
            expect(abs(box2_distance_to_point(b, vec2_create(15, 5)) - 5) < 0.001).toBeTruthy();
            expect(abs(box2_distance_to_point(b, vec2_create(15, 15)) - sqrt(50)) < 0.001).toBeTruthy();
            expect(abs(box2_distance_to_point(b, vec2_create(15, 5)) - 5) < 0.001).toBeTruthy();
            expect(abs(box2_distance_to_point(b, vec2_create(15, 15)) - sqrt(50)) < 0.001).toBeTruthy();
        });
        
        test("box2_expand_by_scalar()", function() {
            var b = box2_create(vec2_create(0, 0), vec2_create(10, 10));
            box2_expand_by_scalar(b, 2);
            expect(b[0]).toBe(-2);
            expect(b[2]).toBe(12);
        });
        
        test("box2_expand_by_vector()", function() {
            var b = box2_create(vec2_create(0, 0), vec2_create(10, 10));
            box2_expand_by_vector(b, vec2_create(3, 4));
            expect(b[0]).toBe(-3);
            expect(b[3]).toBe(14);
        });
        
        test("box2_get_center() and get_size()", function() {
            var b = box2_create(vec2_create(0, 0), vec2_create(10, 20));
            var c = box2_get_center(b);
            expect(c[0]).toBe(5);
            expect(c[1]).toBe(10);
            var s = box2_get_size(b);
            expect(s[0]).toBe(10);
            expect(s[1]).toBe(20);
        });
        
        test("box2_get_parameter()", function() {
            var b = box2_create(vec2_create(0, 0), vec2_create(10, 20));
            var t = box2_get_parameter(b, vec2_create(5, 10));
            expect(abs(t[0] - 0.5) < 0.001).toBeTruthy();
            expect(abs(t[1] - 0.5) < 0.001).toBeTruthy();
        });
        
        test("box2_is_empty() and make_empty()", function() {
            var b = box2_create(vec2_create(0, 0), vec2_create(-1, -1));
            expect(box2_is_empty(b)).toBeTruthy();
            box2_make_empty(b);
            expect(b[0]).toBe(infinity);
            expect(b[2]).toBe(-infinity);
        });
        
        test("box2_intersect()", function() {
            var b = box2_create(vec2_create(0, 0), vec2_create(10, 10));
            var o = box2_create(vec2_create(5, 5), vec2_create(15, 15));
            box2_intersect(b, o);
            expect(box2_equals(b, [5, 5, 10, 10])).toBeTruthy();
        });
        
        test("box2_union()", function() {
            var b = box2_create(vec2_create(0, 0), vec2_create(10, 10));
            var o = box2_create(vec2_create(5, -5), vec2_create(15, 15));
            box2_union(b, o);
            expect(box2_equals(b, [0, -5, 15, 15])).toBeTruthy();
        });
        
        test("box2_translate()", function() {
            var b = box2_create(vec2_create(0, 0), vec2_create(10, 10));
            box2_translate(b, vec2_create(5, -5));
            expect(box2_equals(b, box2_create(vec2_create(5, -5), vec2_create(15, 5)))).toBeTruthy();
        });
        
        test("box2_set_from_center_and_size()", function() {
            var b = box2_create();
            box2_set_from_center_and_size(b, vec2_create(10, 20), vec2_create(6, 4));
            expect(box2_equals(b, box2_create(vec2_create(7, 18), vec2_create(13, 22)))).toBeTruthy();
        });
        
        test("box2_set_from_points()", function() {
            var b = box2_create();
            var pts = [vec2_create(-1, 2), vec2_create(5, -3), vec2_create(4, 9)];
            box2_set_from_points(b, pts);
            expect(box2_equals(b, box2_create(vec2_create(-1, -3), vec2_create(5, 9)))).toBeTruthy();
        });
    });
});
