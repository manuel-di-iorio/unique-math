// GMTL-style test suite for Dynamic AABB Tree
suite(function() {
    describe("DynamicAABBTree", function() {
        
        test("dynamic_aabb_tree_create() creates empty tree", function() {
            var tree = dynamic_aabb_tree_create();
            expect(tree.root).toBe(undefined);
        });

        test("dynamic_aabb_tree_insert() adds object", function() {
            var tree = dynamic_aabb_tree_create();
            var obj = { id: 1 };
            var aabb = [0, 0, 0, 1, 1, 1];
            var leaf = dynamic_aabb_tree_insert(tree, obj, aabb);
            
            expect(is_struct(tree.root)).toBe(true);
            expect(tree.root.isLeaf).toBe(true);
            expect(tree.root.data.id).toBe(1);
        });

        test("dynamic_aabb_tree_remove() removes object", function() {
            var tree = dynamic_aabb_tree_create();
            var leaf = dynamic_aabb_tree_insert(tree, {id: 1}, [0, 0, 0, 1, 1, 1]);
            dynamic_aabb_tree_remove(tree, leaf);
            
            expect(tree.root).toBe(undefined);
        });

        test("dynamic_aabb_tree_update() keeps object if within fattened bounds", function() {
            var tree = dynamic_aabb_tree_create(0.5); // Large fattening
            var leaf = dynamic_aabb_tree_insert(tree, {id: 1}, [0, 0, 0, 1, 1, 1]);
            
            var old_root = tree.root;
            var updated = dynamic_aabb_tree_update(tree, leaf, [0.1, 0.1, 0.1, 1.1, 1.1, 1.1]);
            
            expect(updated).toBeFalsy();
            expect(tree.root).toBe(old_root);
        });

        test("dynamic_aabb_tree_update() re-inserts if outside fattened bounds", function() {
            var tree = dynamic_aabb_tree_create(0.1);
            var leaf = dynamic_aabb_tree_insert(tree, {id: 1}, [0, 0, 0, 1, 1, 1]);
            
            var updated = dynamic_aabb_tree_update(tree, leaf, [10, 10, 10, 11, 11, 11]);
            
            expect(updated).toBeTruthy();
            expect(tree.root.aabb[0]).toBeGreaterThan(9);
        });

        test("dynamic_aabb_tree_query_box() finds overlapping objects", function() {
            var tree = dynamic_aabb_tree_create();
            dynamic_aabb_tree_insert(tree, {id: 1}, [0, 0, 0, 1, 1, 1]);
            dynamic_aabb_tree_insert(tree, {id: 2}, [5, 5, 5, 6, 6, 6]);
            
            var results = [];
            dynamic_aabb_tree_query_box(tree, [4, 4, 4, 7, 7, 7], results);
            
            expect(array_length(results)).toBe(1);
            expect(results[0].id).toBe(2);
        });

        test("dynamic_aabb_tree_query_ray() finds objects", function() {
            var tree = dynamic_aabb_tree_create();
            dynamic_aabb_tree_insert(tree, {id: 1}, [0, 0, 0, 1, 1, 1]);
            dynamic_aabb_tree_insert(tree, {id: 2}, [10, 10, 10, 11, 11, 11]);
            
            var results = [];
            var ray = [0.5, 0.5, -5, 0, 0, 1];
            dynamic_aabb_tree_query_ray(tree, ray, results);
            
            expect(array_length(results)).toBe(1);
            expect(results[0].id).toBe(1);
        });

        test("dynamic_aabb_tree_intersect_ray() finds closest", function() {
            var tree = dynamic_aabb_tree_create(0); // No fattening for exact distance test
            dynamic_aabb_tree_insert(tree, {id: 0}, [0, 0, 10, 1, 1, 11]);
            dynamic_aabb_tree_insert(tree, {id: 1}, [0, 0, 20, 1, 1, 21]);
            
            var ray = [0.5, 0.5, 0, 0, 0, 1];
            var hit = dynamic_aabb_tree_intersect_ray(tree, ray);
            
            expect(is_struct(hit)).toBe(true);
            expect(hit.object.id).toBe(0);
            expect(hit.distance).toBe(10);
        });

        test("dynamic_aabb_tree_clear() empties tree", function() {
            var tree = dynamic_aabb_tree_create();
            dynamic_aabb_tree_insert(tree, {id: 1}, [0, 0, 0, 1, 1, 1]);
            dynamic_aabb_tree_clear(tree);
            
            expect(tree.root).toBe(undefined);
        });
    });
});
