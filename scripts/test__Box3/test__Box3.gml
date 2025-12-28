// GMTL-style test suite for Box3

suite(function() {
    describe("Box3", function() {
        test("box3_create() init as empty inverted box", function() {
            var b = box3_create();
            expect(b[0]).toBe(infinity);
            expect(b[3]).toBe(-infinity);
        });

        test("box3_expand_by_point() expands bbox", function() {
            var b = box3_create(vec3_create(-10, -10, -10), vec3_create(10, 10, 10));
            box3_expand_by_point(b, vec3_create(10, 10, 10));
            box3_expand_by_point(b, vec3_create(-10, -10, -10));
            
            expect(b[0]).toBe(-10);
            expect(b[1]).toBe(-10);
            expect(b[3]).toBe(10);
            expect(b[5]).toBe(10);
        });

        test("box3_contains_point()", function() {
            var b = box3_create(vec3_create(-10, -10, -10), vec3_create(10, 10, 10));
            expect(box3_contains_point(b, vec3_create(0, 0, 0))).toBeTruthy();
            expect(box3_contains_point(b, vec3_create(15, 0, 0))).toBeFalsy();
        });

        test("box3_intersects_box()", function() {
            var b1 = box3_create(vec3_create(0, 0, 0), vec3_create(10, 10, 10));
            var b2 = box3_create(vec3_create(5, 5, 5), vec3_create(15, 15, 15));
            var b3 = box3_create(vec3_create(20, 20, 20), vec3_create(30, 30, 30));
            
            expect(box3_intersects_box(b1, b2)).toBeTruthy();
            expect(box3_intersects_box(b1, b3)).toBeFalsy();
        });
        
        test("box3_get_center()", function() {
            var b = box3_create(vec3_create(0, 0, 0), vec3_create(10, 20, 30));
            var c = box3_get_center(b);
            expect(c[0]).toBe(5);
            expect(c[1]).toBe(10);
            expect(c[2]).toBe(15);
        });
        
        test("box3_get_size()", function() {
            var b = box3_create(vec3_create(0, 0, 0), vec3_create(10, 20, 30));
            var s = box3_get_size(b);
            expect(s[0]).toBe(10);
            expect(s[1]).toBe(20);
            expect(s[2]).toBe(30);
        });
        
        test("box3_clone/copy/equals()", function() {
            var b = box3_create(vec3_create(1, 2, 3), vec3_create(4, 5, 6));
            var c = box3_clone(b);
            expect(box3_equals(b, c)).toBeTruthy();
            var d = box3_create();
            box3_copy(d, b);
            expect(box3_equals(d, b)).toBeTruthy();
        });
        
        test("box3_contains_box()", function() {
            var b = box3_create(vec3_create(0, 0, 0), vec3_create(10, 10, 10));
            var o = box3_create(vec3_create(1, 1, 1), vec3_create(9, 9, 9));
            expect(box3_contains_box(b, o)).toBeTruthy();
            var o2 = box3_create(vec3_create(-1, 1, 1), vec3_create(9, 9, 9));
            expect(box3_contains_box(b, o2)).toBeFalsy();
        });
        
        test("box3_clamp_point()", function() {
            var b = box3_create(vec3_create(0, 0, 0), vec3_create(10, 10, 10));
            var p = box3_clamp_point(b, vec3_create(20, -5, 5));
            expect(p[0]).toBe(10);
            expect(p[1]).toBe(0);
            expect(p[2]).toBe(5);
        });
        
        test("box3_distance_to_point()", function() {
            var b = box3_create(vec3_create(0, 0, 0), vec3_create(10, 10, 10));
            expect(abs(box3_distance_to_point(b, vec3_create(5, 5, 5))) < 0.001).toBeTruthy();
            expect(abs(box3_distance_to_point(b, vec3_create(15, 5, 5)) - 5) < 0.001).toBeTruthy();
            expect(abs(box3_distance_to_point(b, vec3_create(15, 15, 15)) - sqrt(75)) < 0.001).toBeTruthy();
        });
        
        test("box3_expand_by_scalar/vector()", function() {
            var b = box3_create(vec3_create(0, 0, 0), vec3_create(10, 10, 10));
            box3_expand_by_scalar(b, 2);
            expect(box3_equals(b, box3_create(vec3_create(-2, -2, -2), vec3_create(12, 12, 12)))).toBeTruthy();
            box3_expand_by_vector(b, vec3_create(1, 2, 3));
            expect(box3_equals(b, box3_create(vec3_create(-3, -4, -5), vec3_create(13, 14, 15)))).toBeTruthy();
        });
        
        test("box3_is_empty/make_empty()", function() {
            var b = box3_create(vec3_create(0, 0, 0), vec3_create(-1, -1, -1));
            expect(box3_is_empty(b)).toBeTruthy();
            box3_make_empty(b);
            expect(box3_equals(b, box3_create(vec3_create(infinity, infinity, infinity), vec3_create(-infinity, -infinity, -infinity)))).toBeTruthy();
        });
        
        test("box3_intersect()", function() {
            var b = box3_create(vec3_create(0, 0, 0), vec3_create(10, 10, 10));
            var o = box3_create(vec3_create(5, -5, 5), vec3_create(15, 5, 15));
            box3_intersect(b, o);
            expect(box3_equals(b, box3_create(vec3_create(5, 0, 5), vec3_create(10, 5, 10)))).toBeTruthy();
        });
        
        test("box3_union()", function() {
            var b = box3_create(vec3_create(0, 0, 0), vec3_create(10, 10, 10));
            var o = box3_create(vec3_create(5, -5, 5), vec3_create(15, 15, 15));
            box3_union(b, o);
            expect(box3_equals(b, box3_create(vec3_create(0, -5, 0), vec3_create(15, 15, 15)))).toBeTruthy();
        });
        
        test("box3_translate()", function() {
            var b = box3_create(vec3_create(0, 0, 0), vec3_create(10, 10, 10));
            box3_translate(b, vec3_create(5, -5, 3));
            expect(box3_equals(b, box3_create(vec3_create(5, -5, 3), vec3_create(15, 5, 13)))).toBeTruthy();
        });
        
        test("box3_set_from_center_and_size()", function() {
            var b = box3_create();
            box3_set_from_center_and_size(b, vec3_create(10, 20, 30), vec3_create(6, 4, 2));
            expect(box3_equals(b, box3_create(vec3_create(7, 18, 29), vec3_create(13, 22, 31)))).toBeTruthy();
        });
        
        test("box3_set_from_points()", function() {
            var b = box3_create();
            var pts = [vec3_create(-1, 2, -3), vec3_create(5, -3, 7), vec3_create(4, 9, 6)];
            box3_set_from_points(b, pts);
            expect(box3_equals(b, box3_create(vec3_create(-1, -3, -3), vec3_create(5, 9, 7)))).toBeTruthy();
        });
        
        test("box3_set_from_array()", function() {
            var b = box3_create();
            var arr = [0, 0, 0, 10, 5, 8, 5, 10, 3];
            box3_set_from_array(b, arr);
            expect(box3_equals(b, box3_create(vec3_create(0, 0, 0), vec3_create(10, 10, 8)))).toBeTruthy();
        });
        
        test("box3_set_from_buffer_attribute() with offset", function() {
            var b = box3_create();
            var arr = [99,99,99, 0,0,0, 10,5,8, 5,10,3];
            box3_set_from_buffer_attribute(b, arr, 3);
            expect(box3_equals(b, box3_create(vec3_create(0, 0, 0), vec3_create(10, 10, 8)))).toBeTruthy();
        });
        
        test("box3_apply_matrix4() translate and scale", function() {
            var b = box3_create(vec3_create(-1, -1, -1), vec3_create(1, 1, 1));
            var m = mat4_create();
            mat4_make_translation(m, 10, 0, 0);
            box3_apply_matrix4(b, m);
            expect(box3_equals(b, box3_create(vec3_create(9, -1, -1), vec3_create(11, 1, 1)))).toBeTruthy();
            var s = mat4_create();
            mat4_make_scale(s, 2, 3, 4);
            box3_apply_matrix4(b, s);
            expect(box3_contains_point(b, vec3_create(9*2, -1*3, -1*4))).toBeTruthy();
        });
        
        test("box3_get_bounding_sphere()", function() {
            var b = box3_create(vec3_create(-1, -1, -1), vec3_create(1, 1, 1));
            var s = box3_get_bounding_sphere(b);
            expect(abs(s[3] - sqrt(3)) < 0.001).toBeTruthy();
        });
        
        test("box3_get_parameter()", function() {
            var b = box3_create(vec3_create(0, 0, 0), vec3_create(10, 20, 30));
            var t = box3_get_parameter(b, vec3_create(5, 10, 15));
            expect(abs(t[0] - 0.5) < 0.001).toBeTruthy();
            expect(abs(t[1] - 0.5) < 0.001).toBeTruthy();
            expect(abs(t[2] - 0.5) < 0.001).toBeTruthy();
        });
        
        test("box3_intersects_plane()", function() {
            var b = box3_create(vec3_create(-1, -1, -1), vec3_create(1, 1, 1));
            var p = plane_create(vec3_create(0, 1, 0), 0);
            expect(box3_intersects_plane(b, p)).toBeTruthy();
        });
        
        test("box3_intersects_sphere()", function() {
            var b = box3_create(vec3_create(-1, -1, -1), vec3_create(1, 1, 1));
            var s = sphere_create(vec3_create(2, 0, 0), 1);
            expect(box3_intersects_sphere(b, s)).toBeTruthy();
            var s2 = sphere_create(vec3_create(5, 0, 0), 1);
            expect(box3_intersects_sphere(b, s2)).toBeFalsy();
        });
    });
});
