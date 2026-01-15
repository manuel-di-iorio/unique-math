---
sidebar_position: 31
---

# BVH (Bounding Volume Hierarchy)

A Bounding Volume Hierarchy (BVH) is a tree-based spatial partitioning structure where each node is enclosed by a bounding volume (AABB in this implementation). BVHs are highly efficient for raycasting and spatial queries, especially for dynamic or static scenes where objects are distributed non-uniformly.

### Array Layout (Internal)
`[ aabb, left, right, data ]`

- **aabb**: The Box3 representing the boundaries of this node and all its children.
- **left**: The left child BVH node (or `undefined` if leaf).
- **right**: The right child BVH node (or `undefined` if leaf).
- **data**: Array of objects stored in this node (only if leaf).

---

## Creation and Building

```js
// 1. Prepare your objects and a function to get their AABB
var objects = [obj1, obj2, obj3];
var get_aabb = function(obj) {
    return obj.aabb; // Should return a Box3 array [minX, minY, minZ, maxX, maxY, maxZ]
};

// 2. Build the BVH
var root = bvh_build(objects, get_aabb);
```

---

## Function Reference

### Base Operations

| Function | Description |
| -------- | ----------- |
| `bvh_create()` | Constructs a new empty BVH node. |
| `bvh_build(objects, get_aabb_fn)` | Recursively builds a BVH from an array of objects. |

### Querying

These functions retrieve a list of objects that *might* intersect with the given primitive.

### bvh_query_box(node, box, results)
Queries the BVH for objects whose AABB intersects the given box.

### bvh_query_sphere(node, sphere, results)
Queries the BVH for objects whose AABB intersects the given sphere.

### bvh_query_frustum(node, frustum, results)
Queries the BVH for objects whose AABB intersects the given frustum.

### bvh_query_ray(node, ray, results)
Queries the BVH for objects whose AABB intersects the given ray.

### bvh_intersect_ray(node, ray)
Finds the closest object intersection in the BVH. Returns a struct with `{object, distance}` or `undefined`.
