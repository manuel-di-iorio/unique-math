// GMTL-style test suite for Capsule

suite(function() {
    describe("Capsule", function() {
        test("capsule_create() with defaults", function() {
            var c = capsule_create();
            expect(c[0]).toBe(0);
            expect(c[1]).toBe(0);
            expect(c[2]).toBe(0);
            expect(c[3]).toBe(0);
            expect(c[4]).toBe(1);
            expect(c[5]).toBe(0);
            expect(c[6]).toBe(1);
        });
        
        test("capsule_create() with custom values", function() {
            var c = capsule_create(vec3_create(1, 2, 3), vec3_create(4, 5, 6), 2);
            expect(c[0]).toBe(1);
            expect(c[1]).toBe(2);
            expect(c[2]).toBe(3);
            expect(c[3]).toBe(4);
            expect(c[4]).toBe(5);
            expect(c[5]).toBe(6);
            expect(c[6]).toBe(2);
        });
        
        test("capsule_set()", function() {
            var c = capsule_create();
            capsule_set(c, vec3_create(10, 20, 30), vec3_create(40, 50, 60), 5);
            expect(c[0]).toBe(10);
            expect(c[1]).toBe(20);
            expect(c[2]).toBe(30);
            expect(c[3]).toBe(40);
            expect(c[4]).toBe(50);
            expect(c[5]).toBe(60);
            expect(c[6]).toBe(5);
        });
        
        test("capsule_clone() and equals()", function() {
            var c = capsule_create(vec3_create(1, 2, 3), vec3_create(4, 5, 6), 2);
            var c2 = capsule_clone(c);
            expect(capsule_equals(c, c2)).toBeTruthy();
            c2[6] = 3;
            expect(capsule_equals(c, c2)).toBeFalsy();
        });
        
        test("capsule_copy()", function() {
            var c = capsule_create(vec3_create(1, 2, 3), vec3_create(4, 5, 6), 2);
            var c2 = capsule_create();
            capsule_copy(c2, c);
            expect(capsule_equals(c, c2)).toBeTruthy();
        });
        
        test("capsule_get_center()", function() {
            var c = capsule_create(vec3_create(0, 0, 0), vec3_create(10, 20, 30), 1);
            var center = capsule_get_center(c);
            expect(center[0]).toBe(5);
            expect(center[1]).toBe(10);
            expect(center[2]).toBe(15);
        });
        
        test("capsule_get_center() with output", function() {
            var c = capsule_create(vec3_create(0, 0, 0), vec3_create(10, 20, 30), 1);
            var out = vec3_create();
            var result = capsule_get_center(c, out);
            expect(result).toBe(out);
            expect(out[0]).toBe(5);
            expect(out[1]).toBe(10);
            expect(out[2]).toBe(15);
        });
        
        test("capsule_translate()", function() {
            var c = capsule_create(vec3_create(0, 0, 0), vec3_create(10, 0, 0), 2);
            capsule_translate(c, vec3_create(5, 10, 15));
            expect(c[0]).toBe(5);
            expect(c[1]).toBe(10);
            expect(c[2]).toBe(15);
            expect(c[3]).toBe(15);
            expect(c[4]).toBe(10);
            expect(c[5]).toBe(15);
            expect(c[6]).toBe(2);
        });
        
        test("capsule_get_start()", function() {
            var c = capsule_create(vec3_create(1, 2, 3), vec3_create(4, 5, 6), 1);
            var start = capsule_get_start(c);
            expect(start[0]).toBe(1);
            expect(start[1]).toBe(2);
            expect(start[2]).toBe(3);
        });
        
        test("capsule_get_finish()", function() {
            var c = capsule_create(vec3_create(1, 2, 3), vec3_create(4, 5, 6), 1);
            var finish = capsule_get_finish(c);
            expect(finish[0]).toBe(4);
            expect(finish[1]).toBe(5);
            expect(finish[2]).toBe(6);
        });
        
        test("capsule_intersects_box() - intersecting at start point", function() {
            var c = capsule_create(vec3_create(0, 0, 0), vec3_create(10, 0, 0), 2);
            var b = box3_create(vec3_create(-3, -3, -3), vec3_create(3, 3, 3));
            expect(capsule_intersects_box(c, b)).toBeTruthy();
        });
        
        test("capsule_intersects_box() - intersecting at finish point", function() {
            var c = capsule_create(vec3_create(0, 0, 0), vec3_create(10, 0, 0), 2);
            var b = box3_create(vec3_create(7, -3, -3), vec3_create(13, 3, 3));
            expect(capsule_intersects_box(c, b)).toBeTruthy();
        });
        
        test("capsule_intersects_box() - intersecting along segment", function() {
            var c = capsule_create(vec3_create(0, 0, 0), vec3_create(10, 0, 0), 2);
            var b = box3_create(vec3_create(4, -3, -3), vec3_create(6, 3, 3));
            expect(capsule_intersects_box(c, b)).toBeTruthy();
        });
        
        test("capsule_intersects_box() - not intersecting", function() {
            var c = capsule_create(vec3_create(0, 0, 0), vec3_create(10, 0, 0), 2);
            var b = box3_create(vec3_create(5, 5, 5), vec3_create(10, 10, 10));
            expect(capsule_intersects_box(c, b)).toBeFalsy();
        });
        
        test("capsule_intersects_box() - degenerate capsule (point)", function() {
            var c = capsule_create(vec3_create(5, 5, 5), vec3_create(5, 5, 5), 2);
            var b = box3_create(vec3_create(0, 0, 0), vec3_create(10, 10, 10));
            expect(capsule_intersects_box(c, b)).toBeTruthy();
        });
        
        test("capsule_intersects_box() - edge case: box touching radius", function() {
            var c = capsule_create(vec3_create(0, 0, 0), vec3_create(10, 0, 0), 2);
            var b = box3_create(vec3_create(4, 2, -1), vec3_create(6, 4, 1));
            expect(capsule_intersects_box(c, b)).toBeFalsy();
        });
        
        test("capsule_intersects_box() - edge case: box just outside radius", function() {
            var c = capsule_create(vec3_create(0, 0, 0), vec3_create(10, 0, 0), 2);
            var b = box3_create(vec3_create(4, 3, -1), vec3_create(6, 5, 1));
            expect(capsule_intersects_box(c, b)).toBeFalsy();
        });
    });
});
