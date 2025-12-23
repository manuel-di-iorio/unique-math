---
sidebar_position: 18
---

# Plane

Infinite plane stored as `[nx, ny, nz, constant]`. Equation: `nx*x + ny*y + nz*z + constant = 0`.
Functions modify the first argument in-place unless noted.

---

## Functions Reference

### Creation

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `plane_create(nx?, ny?, nz?, constant?)` | `Array` | Creates a new plane. |
| `plane_set(p, nx, ny, nz, constant)` | - | Sets normal and constant. |
| `plane_set_from_normal_and_coplanar_point(p, nx, ny, nz, px, py, pz)` | - | Sets plane from normal and a coplanar point. |

### Operations

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `plane_normalize(p)` | - | Normalizes the plane normal. |
| `plane_equals(p, other)` | `boolean` | Returns true if normals and constants match. |
| `plane_negate(p)` | - | Negates normal and constant. |
| `plane_translate(p, tx, ty, tz)` | - | Translates plane by offset vector. |
| `plane_coplanar_point(p, [out])` | `Array` | Returns a coplanar point. |
| `plane_project_point(p, px, py, pz, [out])` | `Array` | Projects point onto plane. |
| `plane_distance_to_point(p, px, py, pz)` | `number` | Signed distance from point to plane. |
| `plane_distance_to_sphere(p, sphere)` | `number` | Signed distance from sphere to plane. |
| `plane_intersects_sphere(p, sphere)` | `boolean` | Returns true if plane intersects sphere. |
| `plane_intersect_line(p, line, [out])` | `Array \| undefined` | Intersection point with segment `[sx,sy,sz,ex,ey,ez]`. |
| `plane_intersects_line(p, line)` | `boolean` | Returns true if segment intersects plane. |
| `plane_intersects_box(p, box)` | `boolean` | Returns true if plane intersects axis-aligned box. |
| `plane_apply_matrix4(p, m4, [normalMatrix3])` | - | Applies transform; optional 3x3 normal matrix. |
| `plane_set_from_coplanar_points(p, a, b, c)` | - | Sets plane from three coplanar points. |
| `plane_set_from_normal_and_coplanar_point(p, nx, ny, nz, px, py, pz)` | - | Sets plane from normal and coplanar point. |
