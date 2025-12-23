// GMTL-style test suite for Plane (array-based)

suite(function() {
    describe("Plane", function() {
        test("plane_create() and normalize()", function() {
            var p = plane_create(0, 2, 0, 10);
            plane_normalize(p);
            expect(abs(p[1] - 1) < 0.001).toBeTruthy();
            expect(abs(p[3] - 5) < 0.001).toBeTruthy();
        });

        test("plane_distance_to_point()", function() {
            var p = plane_create(0, 1, 0, -5);
            var d = plane_distance_to_point(p, 0, 7, 0);
            expect(abs(d - 2) < 0.001).toBeTruthy();
        });

        test("plane_set_from_normal_and_coplanar_point()", function() {
            var p = plane_create();
            plane_set_from_normal_and_coplanar_point(p, 0, 1, 0, 0, 5, 0);
            var d = plane_distance_to_point(p, 0, 5, 0);
            expect(abs(d) < 0.001).toBeTruthy();
        });

        test("plane_coplanar_point()", function() {
            var p = plane_create(0, 1, 0, -5);
            var pt = plane_coplanar_point(p);
            expect(abs(pt[0]) < 0.001).toBeTruthy();
            expect(abs(pt[1] - 5) < 0.001).toBeTruthy();
            expect(abs(pt[2]) < 0.001).toBeTruthy();
        });

        test("plane_project_point()", function() {
            var p = plane_create(0, 1, 0, -5);
            var proj = plane_project_point(p, 3, 8, -2);
            expect(abs(proj[0] - 3) < 0.001).toBeTruthy();
            expect(abs(proj[1] - 5) < 0.001).toBeTruthy();
            expect(abs(proj[2] + 2) < 0.001).toBeTruthy();
        });

        test("plane_translate()", function() {
            var p = plane_create(0, 1, 0, -5);
            plane_translate(p, 0, 2, 0);
            var d = plane_distance_to_point(p, 0, 5, 0);
            expect(abs(d - -2) < 0.001).toBeTruthy();
        });

        test("plane_negate() and equals()", function() {
            var p = plane_create(0, 1, 0, -5);
            var q = plane_clone(p);
            plane_negate(q);
            expect(plane_equals(p, q)).toBeFalsy();
            plane_negate(q);
            expect(plane_equals(p, q)).toBeTruthy();
        });

        test("plane_intersects_sphere() and distance_to_sphere()", function() {
            var p = plane_create(0, 1, 0, -5);
            var s = sphere_create(0, 6, 0, 2);
            expect(plane_intersects_sphere(p, s)).toBeTruthy();
            var ds = plane_distance_to_sphere(p, s);
            expect(abs(ds - (1 - 2)) < 0.001).toBeTruthy(); // center distance 1 minus radius 2 = -1
        });

        test("plane_intersect_line() and intersects_line()", function() {
            var p = plane_create(1, 0, 0, -5); // x = 5
            var line = [0, 0, 0, 10, 0, 0]; // segment along X
            expect(plane_intersects_line(p, line)).toBeTruthy();
            var hit = plane_intersect_line(p, line);
            expect(hit != undefined).toBeTruthy();
            if (hit) {
                expect(abs(hit[0] - 5) < 0.001).toBeTruthy();
                expect(abs(hit[1]) < 0.001).toBeTruthy();
                expect(abs(hit[2]) < 0.001).toBeTruthy();
            }
        });

        test("plane_intersects_box()", function() {
            var p = plane_create(1, 0, 0, -5); // x = 5
            var b = box3_create(0, -1, -1, 10, 1, 1);
            expect(plane_intersects_box(p, b)).toBeTruthy();
            var b2 = box3_create(-10, -1, -1, 4, 1, 1);
            expect(plane_intersects_box(p, b2)).toBeFalsy();
        });

        test("plane_apply_matrix4() translation moves plane point", function() {
            var p = plane_create(0, 1, 0, -5); // y=5
            var m = mat4_create();
            mat4_make_translation(m, 0, 2, 0);
            plane_apply_matrix4(p, m);
            var pt = plane_coplanar_point(p);
            expect(abs(pt[1] - 7) < 0.001).toBeTruthy();
        });
    });
});
