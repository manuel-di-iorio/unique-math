// GMTL-style test suite for Triangle (array-based high-performance triangles)
suite(function() {
    describe("Triangle", function() {
        
        // ====================================================================
        // CREATION
        // ====================================================================
        
        test("tri_create() creates triangle with zero vectors by default", function() {
            var tri = tri_create();
            expect(vec3_length(tri[0])).toBe(0);
            expect(vec3_length(tri[1])).toBe(0);
            expect(vec3_length(tri[2])).toBe(0);
        });

        test("tri_create(a, b, c) creates triangle with specified vertices", function() {
            var a = vec3_create(1, 0, 0);
            var b = vec3_create(0, 1, 0);
            var c = vec3_create(0, 0, 1);
            var tri = tri_create(a, b, c);
            expect(vec3_equals(tri[0], a)).toBeTruthy();
            expect(vec3_equals(tri[1], b)).toBeTruthy();
            expect(vec3_equals(tri[2], c)).toBeTruthy();
        });

        // ====================================================================
        // SETTERS
        // ====================================================================

        test("tri_set() updates vertices", function() {
            var tri = tri_create();
            var a = vec3_create(1, 1, 1);
            var b = vec3_create(2, 2, 2);
            var c = vec3_create(3, 3, 3);
            tri_set(tri, a, b, c);
            expect(vec3_equals(tri[0], a)).toBeTruthy();
            expect(vec3_equals(tri[1], b)).toBeTruthy();
            expect(vec3_equals(tri[2], c)).toBeTruthy();
        });

        // ====================================================================
        // PROPERTIES
        // ====================================================================

        test("tri_get_area() calculates correct area", function() {
            // Right triangle with base 2 and height 2
            var tri = tri_create(
                vec3_create(0, 0, 0),
                vec3_create(2, 0, 0),
                vec3_create(0, 2, 0)
            );
            expect(tri_get_area(tri)).toBe(2);
        });

        test("tri_get_midpoint() calculates correct center", function() {
            var tri = tri_create(
                vec3_create(0, 0, 0),
                vec3_create(3, 0, 0),
                vec3_create(0, 3, 0)
            );
            var mid = vec3_create();
            tri_get_midpoint(tri, mid);
            expect(mid[0]).toBe(1);
            expect(mid[1]).toBe(1);
            expect(mid[2]).toBe(0);
        });

        test("tri_get_normal() calculates correct unit normal", function() {
            var tri = tri_create(
                vec3_create(0, 0, 0),
                vec3_create(1, 0, 0),
                vec3_create(0, 1, 0)
            );
            var normal = vec3_create();
            tri_get_normal(tri, normal);
            expect(normal[0]).toBe(0);
            expect(normal[1]).toBe(0);
            expect(normal[2]).toBe(1);
        });

        // ====================================================================
        // BARYCENTRIC & INTERPOLATION
        // ====================================================================

        test("tri_get_barycoord() for point at vertices", function() {
            var a = vec3_create(1, 0, 0);
            var b = vec3_create(0, 1, 0);
            var c = vec3_create(0, 0, 1);
            var tri = tri_create(a, b, c);
            var result = vec3_create();
            
            tri_get_barycoord(tri, a, result);
            expect(result[0]).toBe(1); expect(result[1]).toBe(0); expect(result[2]).toBe(0);
            
            tri_get_barycoord(tri, b, result);
            expect(result[0]).toBe(0); expect(result[1]).toBe(1); expect(result[2]).toBe(0);
            
            tri_get_barycoord(tri, c, result);
            expect(result[0]).toBe(0); expect(result[1]).toBe(0); expect(result[2]).toBe(1);
        });

        test("tri_contains_point() tests point inclusion", function() {
            var tri = tri_create(
                vec3_create(0, 0, 0),
                vec3_create(2, 0, 0),
                vec3_create(0, 2, 0)
            );
            expect(tri_contains_point(tri, vec3_create(0.5, 0.5, 0))).toBeTruthy();
            expect(tri_contains_point(tri, vec3_create(1.5, 1.5, 0))).toBeFalsy();
            expect(tri_contains_point(tri, vec3_create(-0.1, 0.5, 0))).toBeFalsy();
        });

        test("tri_get_interpolation() interpolates vector values", function() {
            var tri = tri_create(
                vec3_create(0, 0, 0),
                vec3_create(1, 0, 0),
                vec3_create(0, 1, 0)
            );
            var v1 = [10, 0, 0];
            var v2 = [0, 20, 0];
            var v3 = [0, 0, 30];
            var point = vec3_create(1/3, 1/3, 0);
            var target = vec3_create();
            
            tri_get_interpolation(tri, point, v1, v2, v3, target);
            // Result should be approx (v1+v2+v3)/3
            expect(round(target[0] * 10) / 10).toBe(3.3);
            expect(round(target[1] * 10) / 10).toBe(6.7);
            expect(round(target[2] * 10) / 10).toBe(10);
        });

        // ====================================================================
        // CLOSEST POINT
        // ====================================================================

        test("tri_closest_point_to_point() returns closest point on surface", function() {
            var tri = tri_create(
                vec3_create(0, 0, 0),
                vec3_create(1, 0, 0),
                vec3_create(0, 1, 0)
            );
            var target = vec3_create();
            
            // Point directly above midpoint
            tri_closest_point_to_point(tri, vec3_create(0.2, 0.2, 5), target);
            expect(target[0]).toBe(0.2);
            expect(target[1]).toBe(0.2);
            expect(target[2]).toBe(0);
            
            // Point outside near vertex B
            tri_closest_point_to_point(tri, vec3_create(2, -1, 0), target);
            expect(target[0]).toBe(1);
            expect(target[1]).toBe(0);
            expect(target[2]).toBe(0);
        });

        // ====================================================================
        // UTILITIES
        // ====================================================================

        test("tri_equals() compares triangles", function() {
            var tri1 = tri_create(vec3_create(0,0,0), vec3_create(1,0,0), vec3_create(0,1,0));
            var tri2 = tri_create(vec3_create(0,0,0), vec3_create(1,0,0), vec3_create(0,1,0));
            var tri3 = tri_create(vec3_create(0,0,0), vec3_create(1,0,0), vec3_create(0,0,1));
            
            expect(tri_equals(tri1, tri2)).toBeTruthy();
            expect(tri_equals(tri1, tri3)).toBeFalsy();
        });

        test("tri_intersects_box() basic overlap test", function() {
            var tri = tri_create(
                vec3_create(-1, -1, 0),
                vec3_create(1, -1, 0),
                vec3_create(0, 1, 0)
            );
            var box = box3_create(vec3_create(-0.5, -0.5, -0.5), vec3_create(0.5, 0.5, 0.5));
            expect(tri_intersects_box(tri, box)).toBeTruthy();
            
            var farBox = box3_create(vec3_create(10, 10, 10), vec3_create(11, 11, 11));
            expect(tri_intersects_box(tri, farBox)).toBeFalsy();
        });
    });
});
