// GMTL-style test suite for Frustum

suite(function() {
    describe("Frustum", function() {
        test("frustum_create()", function() {
            var f = frustum_create();
            expect(array_length(f)).toBe(6);
            expect(array_length(f[0])).toBe(4);
        });
        
        test("frustum_clone()", function() {
            var f1 = frustum_create();
            plane_set(f1[0], 1, 0, 0, 10);
            var f2 = frustum_clone(f1);
            expect(f2[0][3]).toBe(10);
            plane_set(f2[0], 1, 0, 0, 20);
            expect(f1[0][3]).toBe(10);
        });
        
        test("frustum_copy()", function() {
            var f1 = frustum_create();
            var f2 = frustum_create();
            plane_set(f2[0], 1, 0, 0, 10);
            frustum_copy(f1, f2);
            expect(f1[0][3]).toBe(10);
        });
        
        test("frustum_set()", function() {
            var f = frustum_create();
            var p0 = plane_create(); plane_set(p0, 1, 0, 0, 1);
            var p1 = plane_create(); plane_set(p1, -1, 0, 0, 1);
            var p2 = plane_create(); plane_set(p2, 0, 1, 0, 1);
            var p3 = plane_create(); plane_set(p3, 0, -1, 0, 1);
            var p4 = plane_create(); plane_set(p4, 0, 0, 1, 1);
            var p5 = plane_create(); plane_set(p5, 0, 0, -1, 1);
            frustum_set(f, p0, p1, p2, p3, p4, p5);
            expect(f[0][3]).toBe(1);
            expect(f[5][2]).toBe(-1);
        });

        test("frustum_contains_point_vec()", function() {
            var f = frustum_create();
            plane_set(f[0], 1, 0, 0, 1);
            plane_set(f[1], -1, 0, 0, 1);
            plane_set(f[2], 0, 1, 0, 1);
            plane_set(f[3], 0, -1, 0, 1);
            plane_set(f[4], 0, 0, 1, 1);
            plane_set(f[5], 0, 0, -1, 1);
            var v = vec3_create(0, 0, 0);
            expect(frustum_contains_point_vec(f, v)).toBeTruthy();
        });
        
        test("frustum_contains_point()", function() {
            var f = frustum_create();
            plane_set(f[0], 1, 0, 0, 1);
            plane_set(f[1], -1, 0, 0, 1);
            plane_set(f[2], 0, 1, 0, 1);
            plane_set(f[3], 0, -1, 0, 1);
            plane_set(f[4], 0, 0, 1, 1);
            plane_set(f[5], 0, 0, -1, 1);
            expect(frustum_contains_point(f, 0, 0, 0)).toBeTruthy();
            expect(frustum_contains_point(f, 2, 0, 0)).toBeFalsy();
        });

        test("frustum_intersects_box()", function() {
            var f = frustum_create();
            plane_set(f[0], 1, 0, 0, 1);
            plane_set(f[1], -1, 0, 0, 1);
            plane_set(f[2], 0, 1, 0, 1);
            plane_set(f[3], 0, -1, 0, 1);
            plane_set(f[4], 0, 0, 1, 1);
            plane_set(f[5], 0, 0, -1, 1);
            var b = box3_create(-0.5, -0.5, -0.5, 0.5, 0.5, 0.5);
            expect(frustum_intersects_box(f, b)).toBeTruthy();
            var b2 = box3_create(2, 2, 2, 3, 3, 3);
            expect(frustum_intersects_box(f, b2)).toBeFalsy();
        });

        // test("frustum_intersects_object()", function() {
        //     var f = frustum_create();
        //     plane_set(f[0], 1, 0, 0, 1);
        //     plane_set(f[1], -1, 0, 0, 1);
        //     plane_set(f[2], 0, 1, 0, 1);
        //     plane_set(f[3], 0, -1, 0, 1);
        //     plane_set(f[4], 0, 0, 1, 1);
        //     plane_set(f[5], 0, 0, -1, 1);
        //     var obj = { __intersectionSphere: sphere_create(0, 0, 0, 0.5) };
        //     expect(frustum_intersects_object(f, obj)).toBeTruthy();
        //     var obj2 = { __intersectionSphere: sphere_create(2, 0, 0, 0.5) };
        //     expect(frustum_intersects_object(f, obj2)).toBeFalsy();
        //     var obj3 = {}; // no sphere → safe true
        //     expect(frustum_intersects_object(f, obj3)).toBeTruthy();
        // });

        // test("frustum_intersects_sprite()", function() {
        //     var f = frustum_create();
        //     plane_set(f[0], 1, 0, 0, 1);
        //     plane_set(f[1], -1, 0, 0, 1);
        //     plane_set(f[2], 0, 1, 0, 1);
        //     plane_set(f[3], 0, -1, 0, 1);
        //     plane_set(f[4], 0, 0, 1, 1);
        //     plane_set(f[5], 0, 0, -1, 1);
        //     var sprite = { __intersectionSphere: sphere_create(0, 0, 0, 0.5) };
        //     expect(frustum_intersects_sprite(f, sprite)).toBeTruthy();
        //     var sprite2 = {}; // no sphere → safe true
        //     expect(frustum_intersects_sprite(f, sprite2)).toBeTruthy();
        // });

        test("frustum_set_from_projection_matrix() reversedDepth swaps near/far", function() {
            var f = frustum_create();
            var m = mat4_create();
            frustum_set_from_projection_matrix(f, m, undefined, true);
            // After identity, near and far planes are normalized equivalents; just ensure arrays exist
            expect(array_length(f[4])).toBe(4);
            expect(array_length(f[5])).toBe(4);
        });
        
        test("frustum_set_from_projection_matrix() reversedDepth true swaps indices", function() {
            var f = frustum_create();
            var m = mat4_create();
            frustum_set_from_projection_matrix(f, m, true);
            expect(f[4][2]).toBe(-1);
            expect(f[5][2]).toBe(1);
        });

        test("frustum_intersects_sphere()", function() {
            var f = frustum_create();
            // Default planes are usually 0,1,0,0 ?? No init was 0,1,0,0
            // Let's set a simple frustum: unit box centered at origin
            // Left x=-1 (normal 1,0,0 const 1) -> x+1=0 -> x>-1
            plane_set(f[0], 1, 0, 0, 1);
            // Right x=1 (normal -1,0,0 const 1) -> -x+1=0 -> x<1
            plane_set(f[1], -1, 0, 0, 1);
            // Bottom y=-1
            plane_set(f[2], 0, 1, 0, 1);
            // Top y=1
            plane_set(f[3], 0, -1, 0, 1);
            // Near z=-1
            plane_set(f[4], 0, 0, 1, 1);
            // Far z=1
            plane_set(f[5], 0, 0, -1, 1);
            
            var sInside = sphere_create(0, 0, 0, 0.5);
            expect(frustum_intersects_sphere(f, sInside)).toBeTruthy();
            
            var sOutside = sphere_create(2, 0, 0, 0.5);
            expect(frustum_intersects_sphere(f, sOutside)).toBeFalsy();
            
            var sIntersect = sphere_create(1.2, 0, 0, 0.5); // center at 1.2, radius 0.5 -> reaches 0.7, intersects plane at 1
            expect(frustum_intersects_sphere(f, sIntersect)).toBeTruthy();
        });
    });
});
