// GMTL-style test suite for BVH
suite(function() {
    describe("BVH", function() {
        
        test("bvh_create() creates empty node", function() {
            var node = bvh_create();
            expect(node[BVH_NODE.left]).toBe(undefined);
            expect(node[BVH_NODE.right]).toBe(undefined);
            expect(node[BVH_NODE.data]).toBe(undefined);
        });

        test("bvh_build() builds hierarchy", function() {
            var objects = [
                { aabb: [0, 0, 0, 1, 1, 1], id: 0 },
                { aabb: [5, 5, 5, 6, 6, 6], id: 1 },
                { aabb: [10, 10, 10, 11, 11, 11], id: 2 },
                { aabb: [15, 15, 15, 16, 16, 16], id: 3 }
            ];
            var get_aabb = function(obj) { return obj.aabb; };
            
            var root = bvh_build(objects, get_aabb);
            
            expect(is_array(root)).toBe(true);
            expect(root[BVH_NODE.aabb][0]).toBe(0);
            expect(root[BVH_NODE.aabb][3]).toBe(16);
            expect(is_array(root[BVH_NODE.left])).toBe(true);
            expect(is_array(root[BVH_NODE.right])).toBe(true);
        });

        test("bvh_query_box() finds overlapping objects", function() {
            var objects = [
                { aabb: [0, 0, 0, 1, 1, 1], id: 0 },
                { aabb: [5, 5, 5, 6, 6, 6], id: 1 },
                { aabb: [10, 10, 10, 11, 11, 11], id: 2 }
            ];
            var get_aabb = function(obj) { return obj.aabb; };
            var root = bvh_build(objects, get_aabb);
            
            var results = [];
            var query_box = [4, 4, 4, 7, 7, 7];
            bvh_query_box(root, query_box, results);
            
            expect(array_length(results)).toBe(1);
            expect(results[0].id).toBe(1);
        });

        test("bvh_query_ray() finds candidates", function() {
            var objects = [
                { aabb: [0, 0, 0, 1, 1, 1], id: 0 },
                { aabb: [10, 10, 10, 11, 11, 11], id: 1 }
            ];
            var root = bvh_build(objects, function(obj) { return obj.aabb; });
            var ray = [0.5, 0.5, -5, 0, 0, 1]; // Points at id: 0
            var results = [];
            bvh_query_ray(root, ray, results);
            
            expect(array_length(results)).toBe(1);
            expect(results[0].id).toBe(0);
        });

        test("bvh_intersect_ray() finds closest hit", function() {
            var objects = [
                { aabb: [0, 0, 10, 1, 1, 11], id: 0 },
                { aabb: [0, 0, 20, 1, 1, 21], id: 1 }
            ];
            var root = bvh_build(objects, function(obj) { return obj.aabb; });
            var ray = [0.5, 0.5, 0, 0, 0, 1];
            
            var hit = bvh_intersect_ray(root, ray);
            expect(hit).toBeTruthy();
            expect(hit.object.id).toBe(0);
            expect(hit.distance).toBe(10);
        });

        test("bvh_query_sphere() finds candidates", function() {
            var objects = [
                { aabb: [0, 0, 0, 1, 1, 1], id: 0 },
                { aabb: [10, 10, 10, 11, 11, 11], id: 1 }
            ];
            var root = bvh_build(objects, function(obj) { return obj.aabb; });
            var sphere = [0.5, 0.5, 0.5, 2];
            var results = [];
            bvh_query_sphere(root, sphere, results);
            
            expect(array_length(results)).toBe(1);
            expect(results[0].id).toBe(0);
        });
    });
});
