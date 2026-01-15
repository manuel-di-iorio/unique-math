---
sidebar_position: 32
---

# Dynamic AABB Tree

A Dynamic AABB Tree is a self-balancing binary search tree where each node is an Axis-Aligned Bounding Box (AABB). It is specifically designed for dynamic environments where objects are frequently added, removed, or moved. It uses "fattened" AABBs for leaf nodes to minimize the need for tree updates when objects move only slightly.

---

## Creation and Usage

```js
// 1. Create the tree
var tree = dynamic_aabb_tree_create(0.1); // 0.1 is the fattening margin

// 2. Insert objects
var obj1 = { id: 1 };
var aabb1 = [0, 0, 0, 1, 1, 1];
var leaf1 = dynamic_aabb_tree_insert(tree, obj1, aabb1);

// 3. Update objects
var new_aabb1 = [0.1, 0.1, 0.1, 1.1, 1.1, 1.1];
dynamic_aabb_tree_update(tree, leaf1, new_aabb1);

// 4. Remove objects
dynamic_aabb_tree_remove(tree, leaf1);
```

---

## Function Reference

### Base Operations

| Function | Description |
| -------- | ----------- |
| `dynamic_aabb_tree_create(fattening?)` | Constructs a new Dynamic AABB Tree. |
| `dynamic_aabb_tree_insert(tree, object, aabb)` | Inserts an object and returns its leaf node reference. |
| `dynamic_aabb_tree_remove(tree, leaf)` | Removes an object using its leaf node reference. |
| `dynamic_aabb_tree_update(tree, leaf, aabb, force?)` | Updates an object's AABB. Re-inserts only if it moves outside its "fattened" bounds. |

### Querying

These functions retrieve a list of objects that *might* intersect with the given primitive.

### dynamic_aabb_tree_query_box(tree, box, results)
Queries the tree for objects whose AABB intersects the given box.

### dynamic_aabb_tree_query_sphere(tree, sphere, results)
Queries the tree for objects whose AABB intersects the given sphere.

### dynamic_aabb_tree_query_frustum(tree, frustum, results)
Queries the tree for objects whose AABB intersects the given frustum.

### dynamic_aabb_tree_query_ray(tree, ray, results)
Queries the tree for objects whose AABB intersects the given ray.

### dynamic_aabb_tree_intersect_ray(tree, ray)
Finds the closest object intersection in the tree. Returns a struct with `{object, distance}` or `undefined`.

### dynamic_aabb_tree_clear(tree)
Removes all objects from the tree.
