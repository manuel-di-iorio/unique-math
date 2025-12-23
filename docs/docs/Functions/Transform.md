---
sidebar_position: 17
---

# Transform

High-level container for position, rotation (quaternion), and scale.
Stored as `[[x,y,z], [x,y,z,w], [x,y,z]]`. Functions modify the first argument in-place unless noted.

---

## Functions Reference

### Creation

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `transform_create([pos?, rot?, scl?])` | `Array` | Creates a new transform. |
| `transform_set(t, pos, rot, scl)` | - | Sets components (copies values). |
| `transform_copy(t, src)` | - | Copies from `src`. |
| `transform_clone(t)` | `Array` | Returns a copy. |

### Matrix Operations

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `transform_compose_matrix(t, m)` | - | Builds a 4×4 matrix from this transform. |
| `transform_decompose_matrix(t, m)` | - | Updates transform from a 4×4 matrix. |

### Orientation

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `transform_look_at(t, target, up)` | - | Orients rotation to look at target (world up). |
