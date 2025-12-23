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
| `sphere_equals(a, b)` | `boolean` | Returns true if spheres are identical. |

### Operations

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `sphere_apply_matrix4(s, m)` | - | Transforms center by matrix and scales radius by max axis scale. |
| `sphere_contains_point(s, px, py, pz)` | `boolean` | True if point is inside or on the sphere. |
| `sphere_intersects_sphere(a, b)` | `boolean` | True if spheres intersect. |
| `sphere_distance_to_point(s, px, py, pz)` | `number` | Distance from surface to point (negative if inside). |
| `sphere_clamp_point(s, px, py, pz, out?)` | `Array` | Clamps a point to sphere boundary; returns `out` or new vec. |
| `sphere_expand_by_point(s, px, py, pz)` | - | Expands radius to include point; fixes center if empty. |
| `sphere_is_empty(s)` | `boolean` | True if radius < 0. |
| `sphere_make_empty(s)` | - | Sets center `[0,0,0]`, radius `-1`. |
| `sphere_translate(s, ox, oy, oz)` | - | Offsets center. |
| `sphere_get_bounding_box(s, out?)` | `Box3` | Returns/sets box enclosing sphere. |
| `sphere_intersects_box(s, box)` | `boolean` | True if sphere intersects box. |
| `sphere_intersects_plane(s, plane)` | `boolean` | True if `abs(distance(center,plane)) <= radius`. |
| `sphere_union(s, other)` | `Sphere` | Expands `s` to enclose both spheres. |
| `sphere_set_from_points(s, points, optionalCenter?)` | `Sphere` | Minimal sphere from points; uses optional center if provided. |

---

## Usage Examples

```js
var s = sphere_create(0, 0, 0, 5);
var inside = sphere_contains_point(s, 3, 4, 0); // true
```
