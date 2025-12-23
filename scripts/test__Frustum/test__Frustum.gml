// GMTL-style test suite for Frustum

suite(function() {
    describe("Frustum", function() {
        test("frustum_create()", function() {
            var f = frustum_create();
            expect(array_length(f)).toBe(6);
            expect(array_length(f[0])).toBe(4);
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
