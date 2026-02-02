// GMTL-style test suite for DynamicAABBTree2D
suite(function() {
    describe("DynamicAABBTree2D", function() {
        
        test("constructor creates empty tree with initial capacity", function() {
            var tree = new DynamicAABBTree2D(16);
            expect(tree.capacity).toBe(16);
            expect(tree.nodeCount).toBe(0);
            expect(tree.root).toBe(-1);
            expect(tree.freeList).toBe(0);
        });

        test("constructor creates tree with default capacity", function() {
            var tree = new DynamicAABBTree2D();
            expect(tree.capacity).toBe(1024);
            expect(tree.nodeCount).toBe(0);
            expect(tree.root).toBe(-1);
        });

        test("insert() adds a leaf node and returns valid id", function() {
            var tree = new DynamicAABBTree2D();
            var userData = { objId: 1, name: "object1" };
            var proxyId = tree.insert(userData, 0, 0, 10, 10);
            
            expect(proxyId).toBeGreaterThanOrEqual(0);
            expect(tree.nodeCount).toBe(1);
            expect(tree.root).toBe(proxyId);
            expect(tree.userData[proxyId]).toBe(userData);
        });

        test("insert() fattens the AABB with extension", function() {
            var tree = new DynamicAABBTree2D();
            var proxyId = tree.insert({ objId: 1 }, 10, 20, 30, 40);
            
            var extension = 2.0;
            expect(tree.minX[proxyId]).toBe(10 - extension);
            expect(tree.minY[proxyId]).toBe(20 - extension);
            expect(tree.maxX[proxyId]).toBe(30 + extension);
            expect(tree.maxY[proxyId]).toBe(40 + extension);
        });

        test("insert() multiple objects builds tree structure", function() {
            var tree = new DynamicAABBTree2D();
            var leafId1 = tree.insert({ objId: 1 }, 0, 0, 10, 10);
            var leafId2 = tree.insert({ objId: 2 }, 20, 20, 30, 30);
            
            expect(tree.nodeCount).toBe(3); // 2 leaves + 1 internal node
            // Root should be an internal node with both children
            expect(tree.left[tree.root]).toBeGreaterThanOrEqual(0);
            expect(tree.right[tree.root]).toBeGreaterThanOrEqual(0);
            // Root cannot be a leaf (leaves have left == -1)
            expect(tree.left[leafId1]).toBe(-1);
            expect(tree.left[leafId2]).toBe(-1);
        });

        test("remove() removes a leaf and frees the node", function() {
            var tree = new DynamicAABBTree2D();
            var proxyId = tree.insert({ objId: 1 }, 0, 0, 10, 10);
            
            var result = tree.remove(proxyId);
            
            expect(result).toBe(true);
            expect(tree.nodeCount).toBe(0);
            expect(tree.root).toBe(-1);
            expect(tree.userData[proxyId]).toBe(undefined);
        });

        test("remove() returns false for invalid proxy", function() {
            var tree = new DynamicAABBTree2D();
            expect(tree.remove(999)).toBe(false);
            expect(tree.remove(-1)).toBe(false);
        });

        test("remove() with multiple objects maintains tree structure", function() {
            var tree = new DynamicAABBTree2D();
            var leafId1 = tree.insert({ objId: 1 }, 0, 0, 10, 10);
            var leafId2 = tree.insert({ objId: 2 }, 20, 20, 30, 30);
            var leafId3 = tree.insert({ objId: 3 }, 40, 40, 50, 50);
            
            tree.remove(leafId2);
            
            expect(tree.nodeCount).toBe(3); // 2 leaves + 1 internal
            expect(tree.userData[leafId1].objId).toBe(1);
            expect(tree.userData[leafId3].objId).toBe(3);
        });

        test("queryPoint() finds objects at a point", function() {
            var tree = new DynamicAABBTree2D();
            tree.insert({ objId: 1 }, 0, 0, 10, 10);
            tree.insert({ objId: 2 }, 20, 20, 30, 30);
            
            var results = [];
            tree.queryPoint(5, 5, method({ results }, function(userData) {
                array_push(results, userData);
                return false;
            }));
            
            expect(array_length(results)).toBe(1);
            expect(results[0].objId).toBe(1);
        });

        test("queryPoint() finds overlapping objects", function() {
            var tree = new DynamicAABBTree2D();
            tree.insert({ objId: 1 }, 0, 0, 20, 20);
            tree.insert({ objId: 2 }, 10, 10, 30, 30);
            
            var results = [];
            tree.queryPoint(15, 15, method({ results }, function(userData) {
                array_push(results, userData);
                return false;
            }));
            
            expect(array_length(results)).toBe(2);
        });

        test("queryPoint() stops early when callback returns true", function() {
            var tree = new DynamicAABBTree2D();
            tree.insert({ objId: 1 }, 0, 0, 20, 20);
            tree.insert({ objId: 2 }, 10, 10, 30, 30);
            
            var counter = { count: 0 }; // Use struct for primitives
            var result = tree.queryPoint(15, 15, method({ counter }, function(userData) {
                counter.count++;
                return true; // Stop after first
            }));
            
            expect(result).toBe(true);
            expect(counter.count).toBe(1);
        });

        test("queryPoint() returns false when no early exit", function() {
            var tree = new DynamicAABBTree2D();
            tree.insert({ objId: 1 }, 0, 0, 10, 10);
            
            var result = tree.queryPoint(5, 5, method({}, function(userData) {
                return false;
            }));
            
            expect(result).toBe(false);
        });

        test("getTopmostAtPoint() returns undefined for empty tree", function() {
            var tree = new DynamicAABBTree2D();
            var result = tree.getTopmostAtPoint(5, 5);
            expect(result).toBe(undefined);
        });

        test("getTopmostAtPoint() returns object with highest drawIndex", function() {
            var tree = new DynamicAABBTree2D();
            tree.insert({ objId: 1, __drawIndex: 5 }, 0, 0, 20, 20);
            tree.insert({ objId: 2, __drawIndex: 10 }, 10, 10, 30, 30);
            tree.insert({ objId: 3, __drawIndex: 3 }, 5, 5, 25, 25);
            
            var result = tree.getTopmostAtPoint(15, 15);
            
            expect(result.objId).toBe(2);
            expect(result.__drawIndex).toBe(10);
        });

        test("getTopmostAtPoint() returns undefined when point misses all objects", function() {
            var tree = new DynamicAABBTree2D();
            tree.insert({ objId: 1, __drawIndex: 5 }, 0, 0, 10, 10);
            
            var result = tree.getTopmostAtPoint(100, 100);
            
            expect(result).toBe(undefined);
        });

        test("move() keeps proxy when within fattened bounds", function() {
            var tree = new DynamicAABBTree2D();
            var userData = { objId: 1 };
            var proxyId = tree.insert(userData, 10, 10, 20, 20);
            
            var oldRoot = tree.root;
            var result = tree.move(proxyId, 10.5, 10.5, 20.5, 20.5);
            
            expect(result).toBe(true);
            expect(tree.root).toBe(oldRoot);
            expect(tree.userData[proxyId]).toBe(userData);
        });

        test("move() reinserts when outside fattened bounds", function() {
            var tree = new DynamicAABBTree2D();
            var userData = { objId: 1 };
            var proxyId = tree.insert(userData, 10, 10, 20, 20);
            
            var result = tree.move(proxyId, 100, 100, 110, 110);
            
            expect(result).toBe(true);
            expect(tree.userData[proxyId]).toBe(userData);
            expect(tree.minX[proxyId]).toBeGreaterThan(95);
        });

        test("move() returns false for invalid proxy", function() {
            var tree = new DynamicAABBTree2D();
            expect(tree.move(999, 0, 0, 10, 10)).toBe(false);
        });

        test("move() preserves drawIndex", function() {
            var tree = new DynamicAABBTree2D();
            var userData = { objId: 1, __drawIndex: 42 };
            var proxyId = tree.insert(userData, 10, 10, 20, 20);
            
            tree.move(proxyId, 100, 100, 110, 110);
            
            expect(tree.maxDrawIndex[proxyId]).toBe(42);
        });

        test("updateDrawIndex() updates and propagates to ancestors", function() {
            var tree = new DynamicAABBTree2D();
            var leafId1 = tree.insert({ objId: 1, __drawIndex: 5 }, 0, 0, 10, 10);
            var leafId2 = tree.insert({ objId: 2, __drawIndex: 3 }, 20, 20, 30, 30);
            
            tree.updateDrawIndex(leafId2, 10);
            
            expect(tree.maxDrawIndex[leafId2]).toBe(10);
            expect(tree.maxDrawIndex[tree.root]).toBe(10);
        });

        test("updateDrawIndex() returns false for invalid proxy", function() {
            var tree = new DynamicAABBTree2D();
            expect(tree.updateDrawIndex(999, 10)).toBe(false);
        });

        test("updateDrawIndex() early exits when ancestor already has same value", function() {
            var tree = new DynamicAABBTree2D();
            var leafId1 = tree.insert({ objId: 1, __drawIndex: 10 }, 0, 0, 10, 10);
            var leafId2 = tree.insert({ objId: 2, __drawIndex: 5 }, 20, 20, 30, 30);
            
            // Root maxDrawIndex is already 10
            var result = tree.updateDrawIndex(leafId2, 7);
            
            expect(result).toBe(true);
            expect(tree.maxDrawIndex[leafId2]).toBe(7);
        });

        test("clear() empties the tree", function() {
            var tree = new DynamicAABBTree2D();
            tree.insert({ objId: 1 }, 0, 0, 10, 10);
            tree.insert({ objId: 2 }, 20, 20, 30, 30);
            
            tree.clear();
            
            expect(tree.nodeCount).toBe(0);
            expect(tree.root).toBe(-1);
            expect(tree.freeList).toBe(0);
        });

        test("clear() allows reuse after clearing", function() {
            var tree = new DynamicAABBTree2D();
            tree.insert({ objId: 1 }, 0, 0, 10, 10);
            tree.clear();
            
            var proxyId = tree.insert({ objId: 2 }, 20, 20, 30, 30);
            
            expect(proxyId).toBeGreaterThanOrEqual(0);
            expect(tree.nodeCount).toBe(1);
        });

        test("tree expands capacity when needed", function() {
            var tree = new DynamicAABBTree2D(4);
            var initialCapacity = tree.capacity;
            
            tree.insert({ objId: 1 }, 0, 0, 10, 10);
            tree.insert({ objId: 2 }, 20, 20, 30, 30);
            tree.insert({ objId: 3 }, 40, 40, 50, 50);
            tree.insert({ objId: 4 }, 60, 60, 70, 70);
            tree.insert({ objId: 5 }, 80, 80, 90, 90); // Should trigger expansion
            
            expect(tree.capacity).toBeGreaterThan(initialCapacity);
            expect(tree.nodeCount).toBeGreaterThan(0);
        });

        test("tree maintains proper AABB bounds in internal nodes", function() {
            var tree = new DynamicAABBTree2D();
            tree.insert({ objId: 1 }, 0, 0, 10, 10);
            tree.insert({ objId: 2 }, 20, 20, 30, 30);
            
            var rootNode = tree.root;
            
            // Root should encompass both children
            expect(tree.minX[rootNode]).toBeLessThanOrEqual(0 - 2.0);
            expect(tree.maxX[rootNode]).toBeGreaterThanOrEqual(30 + 2.0);
        });

        test("stress test with many insertions and removals", function() {
            var tree = new DynamicAABBTree2D();
            var proxyIds = [];
            
            // Insert 50 objects
            for (var i = 0; i < 50; i++) {
                var xPos = i * 10;
                var leafId = tree.insert({ objId: i }, xPos, xPos, xPos + 5, xPos + 5);
                array_push(proxyIds, leafId);
            }
            
            expect(tree.nodeCount).toBeGreaterThan(0);
            
            // Remove every other object
            for (var i = 0; i < array_length(proxyIds); i += 2) {
                tree.remove(proxyIds[i]);
            }
            
            expect(tree.nodeCount).toBeGreaterThan(0);
            expect(tree.nodeCount).toBeLessThan(99);
        });

        test("queryPoint works after complex operations", function() {
            var tree = new DynamicAABBTree2D();
            
            var leafId1 = tree.insert({ objId: 1 }, 0, 0, 20, 20);
            var leafId2 = tree.insert({ objId: 2 }, 10, 10, 30, 30);
            tree.insert({ objId: 3 }, 50, 50, 60, 60);
            
            tree.remove(leafId1);
            tree.move(leafId2, 15, 15, 35, 35);
            
            var results = [];
            tree.queryPoint(20, 20, method({ results }, function(userData) {
                array_push(results, userData);
                return false;
            }));
            
            expect(array_length(results)).toBeGreaterThan(0);
        });
    });
});
