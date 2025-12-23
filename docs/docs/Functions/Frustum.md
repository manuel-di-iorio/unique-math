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

### Operations

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `frustum_intersects_sphere(f, s)` | `boolean` | True if frustum intersects sphere. |
| `frustum_intersects_box(f, b)` | `boolean` | True if frustum intersects box. |
| `frustum_contains_point(f, x, y, z)` | `boolean` | True if point is inside frustum. |
