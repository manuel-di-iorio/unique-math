---
sidebar_position: 15
---

# Sphere

Bounding sphere stored as `[x, y, z, radius]`.
Functions modify the first argument in-place unless noted.

---

## Functions Reference

### Creation

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `sphere_create(x?, y?, z?, r?)` | `Array` | Creates a new sphere (defaults to `[0,0,0,0]`). |
| `sphere_set(s, x, y, z, r)` | - | Sets center and radius. |
| `sphere_clone(s)` | `Array` | Returns a copy of the sphere. |
| `sphere_copy(s, src)` | - | Copies values from `src`. |

### Operations

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `sphere_apply_matrix4(s, m)` | - | Transforms center by matrix and scales radius by max axis scale. |
| `sphere_contains_point(s, px, py, pz)` | `boolean` | True if point is inside or on the sphere. |
| `sphere_intersects_sphere(a, b)` | `boolean` | True if spheres intersect. |

---

## Usage Examples

```js
var s = sphere_create(0, 0, 0, 5);
var inside = sphere_contains_point(s, 3, 4, 0); // true
```
