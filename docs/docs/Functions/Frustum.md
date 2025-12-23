---
sidebar_position: 14
---

# Frustum

Camera view frustum using 6 planes, stored as `[[nx, ny, nz, d], ...]`.
Plane order: Left, Right, Bottom, Top, Near, Far. Normals point inward.

---

## Functions Reference

### Creation

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `frustum_create()` | `Array` | Creates a new frustum (6 planes). |
| `frustum_clone(f)` | `Array` | Returns a copy of the frustum. |
| `frustum_copy(f, src)` | - | Copies planes from `src`. |
| `frustum_set_from_matrix(f, m)` | - | Extracts planes from a projection/view matrix. |
| `frustum_set(f, p0, p1, p2, p3, p4, p5)` | - | Copies six planes into the frustum. |
| `frustum_set_from_projection_matrix(f, m, reversedDepth=false)` | - | Extracts planes from projection matrix; swaps near/far when `reversedDepth` is true. |

### Operations

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `frustum_intersects_sphere(f, s)` | `boolean` | True if frustum intersects sphere. |
| `frustum_intersects_box(f, b)` | `boolean` | True if frustum intersects box. |
| `frustum_contains_point(f, x, y, z)` | `boolean` | True if point is inside frustum. |
| `frustum_contains_point_vec(f, v)` | `boolean` | True if `v = [x,y,z]` is inside frustum. |
<!-- | `frustum_intersects_object(f, object)` | `boolean` | True if object's `__intersectionSphere` intersects; returns `true` if not provided. |
| `frustum_intersects_sprite(f, sprite)` | `boolean` | True if sprite's `__intersectionSphere` intersects; returns `true` if not provided. | -->
