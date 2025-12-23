// GMTL-style test suite for Sphere

suite(function() {
    describe("Sphere", function() {
        test("sphere_create()", function() {
            var s = sphere_create(1, 2, 3, 4);
            expect(s[0]).toBe(1);
            expect(s[1]).toBe(2);
            expect(s[2]).toBe(3);
            expect(s[3]).toBe(4);
        });
        
        test("sphere_set() and sphere_copy()", function() {
            var s = sphere_create();
            sphere_set(s, 1, 2, 3, 4);
            expect(s[0]).toBe(1);
            var s2 = sphere_create();
            sphere_copy(s2, s);
            expect(sphere_equals(s, s2)).toBeTruthy();
        });
        
        test("sphere_clone() and equals()", function() {
            var s = sphere_create(1, 2, 3, 4);
            var c = sphere_clone(s);
            expect(sphere_equals(s, c)).toBeTruthy();
            c[3] = 5;
            expect(sphere_equals(s, c)).toBeFalsy();
        });

        test("sphere_contains_point()", function() {
            var s = sphere_create(0, 0, 0, 10);
            expect(sphere_contains_point(s, 0, 0, 0)).toBeTruthy();
            expect(sphere_contains_point(s, 10, 0, 0)).toBeTruthy();
            expect(sphere_contains_point(s, 11, 0, 0)).toBeFalsy();
        });
        
        test("sphere_distance_to_point()", function() {
            var s = sphere_create(0, 0, 0, 10);
            expect(sphere_distance_to_point(s, 5, 0, 0)).toBe(-5);
            expect(abs(sphere_distance_to_point(s, 15, 0, 0) - 5) < 0.001).toBeTruthy();
        });
        
        test("sphere_clamp_point() outside clamps to surface", function() {
            var s = sphere_create(0, 0, 0, 10);
            var out = sphere_clamp_point(s, 20, 0, 0);
            expect(abs(out[0] - 10) < 0.001).toBeTruthy();
            expect(abs(out[1]) < 0.001).toBeTruthy();
            expect(abs(out[2]) < 0.001).toBeTruthy();
        });
        
        test("sphere_clamp_point() inside unchanged", function() {
            var s = sphere_create(0, 0, 0, 10);
            var out = sphere_clamp_point(s, 5, 0, 0);
            expect(abs(out[0] - 5) < 0.001).toBeTruthy();
        });
        
        test("sphere_expand_by_point()", function() {
            var s = sphere_create(0, 0, 0, 5);
            sphere_expand_by_point(s, 10, 0, 0);
            expect(abs(s[3] - 10) < 0.001).toBeTruthy();
        });
        
        test("sphere_is_empty() and make_empty()", function() {
            var s = sphere_create(0, 0, 0, -1);
            expect(sphere_is_empty(s)).toBeTruthy();
            sphere_make_empty(s);
            expect(sphere_is_empty(s)).toBeTruthy();
        });
        
        test("sphere_translate()", function() {
            var s = sphere_create(0, 0, 0, 5);
            sphere_translate(s, 10, 10, 10);
            expect(s[0]).toBe(10);
            expect(s[1]).toBe(10);
            expect(s[2]).toBe(10);
        });
        
        test("sphere_get_bounding_box() contains extremes", function() {
            var s = sphere_create(0, 0, 0, 10);
            var b = sphere_get_bounding_box(s);
            expect(box3_contains_point(b, 10, 0, 0)).toBeTruthy();
            expect(box3_contains_point(b, -10, 0, 0)).toBeTruthy();
            expect(box3_contains_point(b, 0, 10, 0)).toBeTruthy();
            expect(box3_contains_point(b, 0, 0, -10)).toBeTruthy();
        });
        
        test("sphere_intersects_box()", function() {
            var s = sphere_create(0, 0, 0, 5);
            var b = box3_create(4, -1, -1, 6, 1, 1);
            expect(sphere_intersects_box(s, b)).toBeTruthy();
            var b2 = box3_create(6, -1, -1, 8, 1, 1);
            expect(sphere_intersects_box(s, b2)).toBeFalsy();
        });
        
        test("sphere_intersects_plane()", function() {
            var s = sphere_create(0, 5, 0, 10);
            var p = plane_create(0, 1, 0, 0);
            expect(sphere_intersects_plane(s, p)).toBeTruthy();
        });
        
        test("sphere_union()", function() {
            var s1 = sphere_create(0, 0, 0, 5);
            var s2 = sphere_create(10, 0, 0, 5);
            sphere_union(s1, s2);
            expect(sphere_contains_point(s1, 0, 0, 0)).toBeTruthy();
            expect(sphere_contains_point(s1, 10, 0, 0)).toBeTruthy();
        });
        
        test("sphere_apply_matrix4() translate and scale", function() {
            var s = sphere_create(0, 0, 0, 5);
            var m = mat4_create();
            mat4_make_translation(m, 10, 10, 10);
            sphere_apply_matrix4(s, m);
            expect(s[0]).toBe(10);
            expect(s[1]).toBe(10);
            expect(s[2]).toBe(10);
            m = mat4_create();
            mat4_make_scale(m, 2, 2, 2);
            sphere_apply_matrix4(s, m);
            expect(abs(s[3] - 10) < 0.001).toBeTruthy();
        });
        
        test("sphere_set_from_points()", function() {
            var pts = [
                vec3_create(0, 0, 0),
                vec3_create(10, 0, 0),
                vec3_create(0, 10, 0)
            ];
            var s = sphere_create();
            sphere_set_from_points(s, pts);
            expect(sphere_contains_point(s, 0, 0, 0)).toBeTruthy();
            expect(sphere_contains_point(s, 10, 0, 0)).toBeTruthy();
            expect(sphere_contains_point(s, 0, 10, 0)).toBeTruthy();
        });
        
        test("sphere_intersects_sphere()", function() {
            var s1 = sphere_create(0, 0, 0, 5);
            var s2 = sphere_create(10, 0, 0, 4); // Dist 10, radii sum 9 -> False
            expect(sphere_intersects_sphere(s1, s2)).toBeFalsy();
            
            var s3 = sphere_create(9, 0, 0, 4); // Dist 9, radii sum 9 -> True
            expect(sphere_intersects_sphere(s1, s3)).toBeTruthy();
        });
    });
});
