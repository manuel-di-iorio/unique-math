// GMTL-style test suite for Octree
suite(function() {
    describe("Octree", function() {
        
        test("octree_create() creates empty octree", function() {
            var oct = octree_create();
            expect(array_length(oct[OCTREE.triangles])).toBe(0);
            expect(oct[OCTREE.subNodes] == undefined).toBeTruthy();
        });

        test("octree_add_triangle() expands bounds", function() {
            var oct = octree_create();
            var tri = tri_create([0,0,0], [1,0,0], [0,1,0]);
            octree_add_triangle(oct, tri);
            expect(oct[OCTREE.bounds][3]).toBe(1); // maxX
            expect(oct[OCTREE.bounds][4]).toBe(1); // maxY
            expect(array_length(oct[OCTREE.triangles])).toBe(1);
        });

        test("octree_build() subdivides", function() {
            var oct = octree_create();
            // Add 10 triangles in different places
            for (var i = 0; i < 10; i++) {
                var v0 = [i, 0, 0];
                var v1 = [i+0.5, 0, 0];
                var v2 = [i, 0.5, 0];
                octree_add_triangle(oct, tri_create(v0, v1, v2));
            }
            // Set leaf threshold to 2 to force split
            oct[OCTREE.trianglesPerLeaf] = 2;
            octree_build(oct);
            
            expect(oct[OCTREE.subNodes] != undefined).toBeTruthy();
            expect(array_length(oct[OCTREE.subNodes])).toBeGreaterThan(0);
        });

        test("octree_ray_intersect() detects hit", function() {
            var oct = octree_create();
            var tri = tri_create([-1, -1, -5], [1, -1, -5], [0, 1, -5]);
            octree_add_triangle(oct, tri);
            octree_build(oct);
            
            var ray = ray_create([0, 0, 0], [0, 0, -1]);
            var hit = octree_ray_intersect(oct, ray);
            
            expect(hit).toBeTruthy();
            expect(hit.distance).toBe(5);
            expect(hit.point[2]).toBe(-5);
        });

        test("octree_sphere_intersect() detects hit", function() {
            var oct = octree_create();
            var tri = tri_create([-10, 0, -10], [10, 0, -10], [0, 0, 10]); // Y=0 plane
            octree_add_triangle(oct, tri);
            octree_build(oct);
            
            var sphere = sphere_create([0, 0.5, 0], 1); // Centered at 0,0.5,0 with R=1 hits Y=0
            var hit = octree_sphere_intersect(oct, sphere);
            
            expect(hit).toBeTruthy();
            expect(hit.depth).toBeGreaterThan(0);
        });

        test("octree_capsule_intersect() detects hit", function() {
            var oct = octree_create();
            var tri = tri_create([-10, 0, -10], [10, 0, -10], [0, 0, 10]);
            octree_add_triangle(oct, tri);
            octree_build(oct);
            
            var capsule = capsule_create([0, 5, 0], [0, -5, 0], 0.5); // Vertical capsule intersecting Y=0
            var hit = octree_capsule_intersect(oct, capsule);
            
            expect(hit).toBeTruthy();
            expect(abs(hit.depth - 0.5) < 0.001).toBeTruthy();
        });

        test("octree_clear() empties octree", function() {
            var oct = octree_create();
            octree_add_triangle(oct, tri_create([0,0,0], [1,0,0], [0,1,0]));
            octree_build(oct);
            octree_clear(oct);
            
            expect(array_length(oct[OCTREE.triangles])).toBe(0);
            expect(oct[OCTREE.subNodes] == undefined).toBeTruthy();
        });
    });
});
