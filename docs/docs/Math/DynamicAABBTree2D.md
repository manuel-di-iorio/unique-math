---
sidebar_position: 33
---

# DynamicAABBTree2D

A high-performance 2D Dynamic AABB Tree (Axis-Aligned Bounding Box Tree) based on Box2D's `b2DynamicTree`. This data structure is specifically designed for spatial partitioning in 2D environments where objects are frequently added, removed, or moved. It uses a self-balancing binary tree with "fattened" AABBs to minimize tree updates when objects move slightly.

The `DynamicAABBTree2D` is ideal for:
- **2D game physics** - broad-phase collision detection
- **2D scene management** - frustum culling and visibility queries
- **2D UI systems** - hit testing and pointer interactions
- **Any 2D spatial queries** - finding objects at a point or within a region

## Key Features

- **Zero-allocation queries** - Uses static stack arrays for traversal
- **Automatic rebalancing** - AVL-tree style rotations maintain O(log n) height
- **Fattened AABBs** - Reduces reinsertion frequency for moving objects
- **Draw order optimization** - Tracks maximum draw index for efficient topmost element queries
- **Flat array storage** - Cache-friendly memory layout using Structure of Arrays (SoA)
- **Dynamic capacity** - Automatically expands when needed

---
 
## Constructor

### `new DynamicAABBTree2D(capacity?)`

Creates a new 2D Dynamic AABB Tree.

**Parameters:**
- `capacity` _(optional, default: 1024)_ - Initial capacity for the tree. The tree will automatically expand when needed.

**Returns:** A new `DynamicAABBTree2D` instance.

**Example:**
```js
// Create with default capacity (1024)
var tree = new DynamicAABBTree2D();

// Create with custom initial capacity
var smallTree = new DynamicAABBTree2D(128);
```

---

## Public Methods

### Insertion & Removal

#### `insert(userData, x1, y1, x2, y2)`

Inserts an object into the tree with the given AABB bounds.

**Parameters:**
- `userData` - User data to associate with this object. Can be any value (struct, array, number, etc.)
- `x1` - Minimum X coordinate of the AABB
- `y1` - Minimum Y coordinate of the AABB
- `x2` - Maximum X coordinate of the AABB
- `y2` - Maximum Y coordinate of the AABB

**Returns:** `proxyId` - An integer ID representing this object in the tree. Store this ID to move or remove the object later.

**Notes:**
- The AABB is automatically "fattened" by 2.0 units on all sides to reduce tree updates for small movements.
- If `userData` contains a `__drawIndex` property, it will be used for draw order optimization.

**Example:**
```js
var tree = new DynamicAABBTree2D();
var player = { sprite: spr_player, x: 100, y: 200, __drawIndex: 10 };

// Insert with AABB from (100,200) to (132,264)
var playerId = tree.insert(player, 100, 200, 132, 264);
```

#### `remove(proxyId)`

Removes an object from the tree.

**Parameters:**
- `proxyId` - The ID returned from `insert()`

**Returns:** `boolean` - `true` if successful, `false` if the proxy ID is invalid.

**Example:**
```js
var objectId = tree.insert(myObject, 0, 0, 32, 32);
// ... later ...
tree.remove(objectId);
```

---

### Movement & Updates

#### `move(proxyId, minX, minY, maxX, maxY)`

Moves an object to a new AABB position. This is an optimized incremental update that only reinserts the object if it moves significantly outside its fattened bounds.

**Parameters:**
- `proxyId` - The ID of the object to move
- `minX, minY` - New minimum coordinates
- `maxX, maxY` - New maximum coordinates

**Returns:** `boolean` - `true` if successful, `false` if the proxy ID is invalid.

**Notes:**
- If the new AABB is still within the old fattened AABB, the tree structure is not modified (fast path).
- Otherwise, the object is removed and reinserted (slow path).
- The `userData` and `drawIndex` are preserved during the move.

**Example:**
```js
var objectId = tree.insert(obj, 100, 100, 132, 132);

// Small movement - tree structure unchanged (fast)
tree.move(objectId, 101, 101, 133, 133);

// Large movement - object reinserted (slower but still efficient)
tree.move(objectId, 500, 500, 532, 532);
```

#### `updateDrawIndex(proxyId, drawIndex)`

Updates the draw index of an object and propagates the maximum draw index up through ancestor nodes.

**Parameters:**
- `proxyId` - The ID of the object
- `drawIndex` - The new draw index value

**Returns:** `boolean` - `true` if successful, `false` if invalid.

**Notes:**
- This is essential for `getTopmostAtPoint()` to work correctly.
- The update propagates up the tree but stops early if an ancestor already has the correct maximum.

**Example:**
```js
var objId = tree.insert({ sprite: spr_box, __drawIndex: 5 }, 0, 0, 32, 32);

// Later, when the draw order changes
tree.updateDrawIndex(objId, 15);
```

---

### Queries

#### `queryPoint(px, py, callback)`

Queries the tree for all objects whose AABB contains the given point.

**Parameters:**
- `px, py` - Point coordinates to query
- `callback` - Function called for each matching object: `function(userData, nodeId)`
  - Return `true` to stop the search early
  - Return `false` to continue searching

**Returns:** `boolean` - `true` if the callback returned `true` (early exit), `false` otherwise.

**Example:**
```js
var tree = new DynamicAABBTree2D();
tree.insert({ id: "box1" }, 0, 0, 50, 50);
tree.insert({ id: "box2" }, 30, 30, 80, 80);

// Find all objects at point (40, 40)
var results = [];
tree.queryPoint(40, 40, function(userData, nodeId) {
    array_push(results, userData);
    return false; // Continue searching
});

// results now contains both box1 and box2
```

#### `getTopmostAtPoint(px, py)`

Returns the object with the highest draw index at the given point. This is optimized using the `maxDrawIndex` tracking to prune branches that can't possibly contain the topmost element.

**Parameters:**
- `px, py` - Point coordinates to query

**Returns:** The `userData` of the topmost object, or `undefined` if no objects are at that point.

**Notes:**
- Objects must have a `__drawIndex` property in their `userData` for this to work correctly.
- Higher draw index means "on top" visually.
- This is perfect for UI hit testing where you only want the topmost clickable element.

**Example:**
```js
var tree = new DynamicAABBTree2D();
tree.insert({ id: "background", __drawIndex: 1 }, 0, 0, 200, 200);
tree.insert({ id: "button", __drawIndex: 10 }, 50, 50, 150, 100);
tree.insert({ id: "tooltip", __drawIndex: 20 }, 60, 60, 140, 90);

// Get the topmost object at (80, 80)
var topmost = tree.getTopmostAtPoint(80, 80);
// topmost.id == "tooltip" (highest __drawIndex)

// Get topmost at (10, 10) 
var topmost2 = tree.getTopmostAtPoint(10, 10);
// topmost2.id == "background"
```

---

### Utility

#### `clear()`

Removes all objects from the tree and resets it to an empty state.

**Example:**
```js
tree.clear();
// Tree is now empty and ready to be reused
```

---

## Performance Characteristics

| Operation | Time Complexity | Notes |
|-----------|----------------|-------|
| `insert()` | O(log n) | Self-balancing tree with AVL rotations |
| `remove()` | O(log n) | Includes ancestor AABB updates and rebalancing |
| `move()` | O(1) best, O(log n) worst | Fast path when within fattened bounds |
| `queryPoint()` | O(log n + k) | k = number of results |
| `getTopmostAtPoint()` | O(log n) average | Early pruning using maxDrawIndex |
| `updateDrawIndex()` | O(log n) | Propagates up to ancestors |
| `clear()` | O(n) | Resets all nodes |

**Space Complexity:** O(n) where n is the number of objects. Internal nodes add roughly n-1 additional nodes.

---

## Internal Structure

The tree uses a **flat array Structure of Arrays (SoA)** layout for cache efficiency:

```js
self.minX[nodeId]        // AABB minimum X
self.minY[nodeId]        // AABB minimum Y
self.maxX[nodeId]        // AABB maximum X
self.maxY[nodeId]        // AABB maximum Y
self.parent[nodeId]      // Parent node ID (-1 for root)
self.left[nodeId]        // Left child ID (-1 for leaf)
self.right[nodeId]       // Right child ID (-1 for leaf)
self.height[nodeId]      // Node height for balancing (-1 for free nodes)
self.userData[nodeId]    // User data (only valid for leaf nodes)
self.maxDrawIndex[nodeId] // Maximum draw index in this subtree
```

**Free List:** Freed nodes are maintained in a linked list using the `left` array to enable O(1) node allocation.

**Balancing:** The tree uses AVL-style rotations to maintain O(log n) height. Balance factor threshold is ±2.

---

## Best Practices

### AABB Fattening

The tree automatically fattens AABBs by 2.0 units. This means:
- Small movements (< 2 units) won't trigger reinsertion
- Adjust your game logic to use `move()` frequently but don't worry about micro-movements

### Draw Index Management

For UI or scene graphs:
```js
// When adding objects
var obj = { 
    sprite: spr_button, 
    __drawIndex: depth  // Use GameMaker's depth or custom z-order
};
var id = tree.insert(obj, x1, y1, x2, y2);

// When depth changes
tree.updateDrawIndex(id, newDepth);
```

### Batch Operations

When adding/removing many objects:
```js
// Good: batch inserts
for (var i = 0; i < count; i++) {
    tree.insert(objects[i], ...);
}

// Also good: clear and rebuild if most objects changed
tree.clear();
for (var i = 0; i < count; i++) {
    tree.insert(objects[i], ...);
}
```

### Query Optimization

For callbacks, return early when possible:
```js
// Find first match and stop
tree.queryPoint(x, y, function(userData) {
    if (userData.type == "enemy") {
        targetEnemy = userData;
        return true; // Stop searching
    }
    return false;
});
```

---

## Comparison with Other Spatial Structures

| Feature | DynamicAABBTree2D | Grid | Quadtree |
|---------|-------------------|------|----------|
| Dynamic objects | ✅ Excellent | ⚠️ Poor | ✅ Good |
| Memory efficiency | ✅ Good | ⚠️ Fixed | ✅ Good |
| Point queries | ✅ O(log n) | ✅ O(1) | ✅ O(log n) |
| Moving objects | ✅ Fast with fattening | ❌ Slow (rehash) | ⚠️ Moderate |
| Non-uniform distribution | ✅ Handles well | ❌ Wastes space | ✅ Adapts |
| Implementation complexity | ⚠️ Complex | ✅ Simple | ⚠️ Moderate |

**Use DynamicAABBTree2D when:**
- Objects move frequently
- Object sizes vary significantly
- Distribution is non-uniform
- You need consistent O(log n) performance

**Use Grid when:**
- Objects rarely move
- Objects are similar in size
- Distribution is uniform
- Simplicity is paramount

**Use Quadtree when:**
- You need spatial subdivision
- Objects vary in size but don't move often
- You want a good balance of simplicity and performance

---

## Advanced Usage Example

```js
/// Complete example: 2D scene with UI hit testing

// Create tree
global.sceneTree = new DynamicAABBTree2D(256);

// Add scene objects with depth
function addSceneObject(obj) {
    var bbox = getBoundingBox(obj); // Your AABB calculation
    obj.treeId = global.sceneTree.insert(obj, bbox[0], bbox[1], bbox[2], bbox[3]);
}

// Update object position
function updateSceneObject(obj) {
    var bbox = getBoundingBox(obj);
    global.sceneTree.move(obj.treeId, bbox[0], bbox[1], bbox[2], bbox[3]);
}

// Update draw order
function updateObjectDepth(obj, newDepth) {
    obj.__drawIndex = newDepth;
    global.sceneTree.updateDrawIndex(obj.treeId, newDepth);
}

// Mouse click handling - get topmost clickable element
function handleMouseClick(mx, my) {
    var clicked = global.sceneTree.getTopmostAtPoint(mx, my);
    if (clicked != undefined && clicked.clickable) {
        clicked.onClick();
    }
}

// Cleanup
function removeSceneObject(obj) {
    global.sceneTree.remove(obj.treeId);
    obj.treeId = undefined;
}
```

---

## Related

- **DynamicAABBTree** - The 3D version of this data structure
- **BVH** - Bounding Volume Hierarchy for static scenes
- **Octree** - 3D spatial partitioning with fixed subdivision
