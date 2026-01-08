// GMTL-style test suite for Line3
suite(function() {
    describe("Line3", function() {
        
        test("line3_create() creates default line", function() {
            var l = line3_create();
            expect(l[0][0]).toBe(0);
            expect(l[1][0]).toBe(0);
        });

        test("line3_set() copies vectors", function() {
            var l = line3_create();
            var v1 = [1, 2, 3];
            var v2 = [4, 5, 6];
            line3_set(l, v1, v2);
            expect(vec3_equals(l[0], v1)).toBeTruthy();
            expect(vec3_equals(l[1], v2)).toBeTruthy();
        });

        test("line3_delta() returns end - start", function() {
            var l = line3_create([0,0,0], [1,2,3]);
            var d = vec3_create();
            line3_delta(l, d);
            expect(d[0]).toBe(1);
            expect(d[1]).toBe(2);
            expect(d[2]).toBe(3);
        });

        test("line3_at() interpolates along line", function() {
            var l = line3_create([1,1,1], [3,3,3]);
            var p = vec3_create();
            line3_at(l, 0.5, p);
            expect(p[0]).toBe(2);
            expect(p[1]).toBe(2);
            expect(p[2]).toBe(2);
        });

        test("line3_closestPointToPoint() clamps to segment", function() {
            var l = line3_create([0,0,0], [10,0,0]);
            var p = [15, 5, 0];
            var target = vec3_create();
            
            // Should clamp to (10, 0, 0)
            line3_closest_point_to_point(l, p, true, target);
            expect(target[0]).toBe(10);
            expect(target[1]).toBe(0);
            
            // Should NOT clamp to (15, 0, 0) if clampToLine is false
            line3_closest_point_to_point(l, p, false, target);
            expect(target[0]).toBe(15);
        });

        test("line3_distance() calculates correct distance", function() {
            var l = line3_create([0,0,0], [3,4,0]);
            expect(line3_distance(l)).toBe(5);
        });

        test("line3_distance_sq_to_line3() finds closest distance between segments", function() {
            var l1 = line3_create([0,0,0], [10,0,0]);
            var l2 = line3_create([5,5,0], [5,-5,0]); // Intersects at (5, 0, 0) in 2D
            var c1 = vec3_create();
            var c2 = vec3_create();
            var distSq = line3_distance_sq_to_line3(l1, l2, c1, c2);
            expect(distSq).toBe(0);
            expect(c1[0]).toBe(5);
            expect(c2[0]).toBe(5);
            expect(c2[1]).toBe(0);
        });
        
        test("line3_distance_sq_to_line3() parallel segments", function() {
            var l1 = line3_create([0,0,0], [10,0,0]);
            var l2 = line3_create([0,2,0], [10,2,0]);
            var c1 = vec3_create();
            var c2 = vec3_create();
            var distSq = line3_distance_sq_to_line3(l1, l2, c1, c2);
            expect(distSq).toBe(4);
        });
    });
});
