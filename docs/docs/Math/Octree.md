---
sidebar_position: 30
---

# Octree

An Octree is a hierarchical spatial partitioning data structure used to optimize collision detection and raycasting in 3D space. It recursively subdivides space into eight octants (nodes), allowing for efficient querying of triangles within a specific volume.

### Array Layout (Internal)
`[ box, bounds, triangles, subNodes, maxLevel, trianglesPerLeaf ]`

- **box**: The AABB representing the boundaries of this node.
- **bounds**: The actual bounding box of the geometry contained within.
- **triangles**: Array of triangles stored in this node.
- **subNodes**: Array of 8 child Octree nodes (or `undefined` if leaf).
- **maxLevel**: Maximum recursion depth.
- **trianglesPerLeaf**: Threshold of triangles before splitting a node.

---

## Creation and Building

```js
// 1. Create the octree
var oct = octree_create();

// 2. Add triangles to it
var tri1 = tri_create([0,0,0], [1,0,0], [0,1,0]);
octree_add_triangle(oct, tri1);

// 3. Build the hierarchy
octree_build(oct);
```

---

## Function Reference

### Base Operations

| Function | Description |
| -------- | ----------- |
| `octree_create(box?)` | Constructs a new Octree node. |
| `octree_add_triangle(octree, triangle)` | Adds a triangle and expands the total bounds. |
| `octree_build(octree)` | Calculates the initial box and recursively splits the tree. |
| `octree_clear(octree)` | Resets the octree, clearing all triangles and sub-nodes. |

### Querying Triangles

These functions retrieve a list of candidate triangles that *might* intersect with the given primitive.

| Function | Description |
| -------- | ----------- |
| `octree_get_ray_triangles(octree, ray, triangles)` | Populates the `triangles` array with candidates along the ray. |
| `octree_get_sphere_triangles(octree, sphere, triangles)` | Populates the `triangles` array with candidates inside the sphere. |
| `octree_get_capsule_triangles(octree, capsule, triangles)` | Populates the `triangles` array with candidates inside the capsule. |
| `octree_get_box_triangles(octree, box, triangles)` | Populates the `triangles` array with candidates inside the AABB. |

### Collision and Intersection

These functions perform precise intersection tests and return detailed collision data or `false`.

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `octree_ray_intersect(octree, ray)` | `struct?` | Returns `{distance, point, normal, triangle}` or `false`. |
| `octree_sphere_intersect(octree, sphere)` | `struct?` | Returns `{normal, point, depth}` or `false`. |
| `octree_capsule_intersect(octree, capsule)` | `struct?` | Returns `{normal, point, depth}` or `false`. |
| `octree_box_intersect(octree, box)` | `struct?` | Returns `{normal, point, depth}` or `false`. |

---

## Temporary Variables
- `global.__UE_OCT_V1`
- `global.__UE_OCT_V2`
- `global.__UE_OCT_P1`
- `global.__UE_OCT_P2`
- `global.__UE_OCT_PLANE`
- `global.__UE_OCT_LINE1`
- `global.__UE_OCT_LINE2`
- `global.__UE_OCT_BOX`
- `global.__UE_OCT_SPHERE`
