---
sidebar_position: 11
---

# Box3

3D axis-aligned bounding box (AABB) stored as `[minX, minY, minZ, maxX, maxY, maxZ]`.
Functions modify the first argument in-place unless noted.

---

## Functions Reference

### Creation

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `box3_create(minVec, maxVec)` | `Array` | Creates a new Box3. Defaults to empty inverted bounds. |
| `box3_set(b, minVec, maxVec)` | - | Sets bounds directly. |
| `box3_clone(b)` | `Array` | Returns a new copy of the box. |
| `box3_copy(b, src)` | - | Copies bounds from `src` to `b`. |

### Operations

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `box3_expand_by_point(b, p)` | - | Expands the box to include the point. |
| `box3_contains_point(b, p)` | `boolean` | True if point is inside. |
| `box3_intersects_box(b, b2)` | `boolean` | True if boxes intersect. |
| `box3_get_center(b, [out])` | `Array` | Writes/returns center vector. |
| `box3_get_size(b, [out])` | `Array` | Writes/returns size vector. |
| `box3_equals(b, b2)` | `boolean` | True if all bounds equal. |
| `box3_contains_box(b, b2)` | `boolean` | True if `b` fully contains `b2`. |
| `box3_clamp_point(b, p, out?)` | `Vector3` | Clamps point to box boundaries. |
| `box3_distance_to_point(b, p)` | `number` | Euclidean distance to the box (0 if inside). |
| `box3_expand_by_scalar(b, s)` | - | Expands bounds by scalar in all directions. |
| `box3_expand_by_vector(b, v)` | - | Expands bounds by vector `[x,y,z]` in both directions. |
| `box3_is_empty(b)` | `boolean` | True if any `min > max`. |
| `box3_make_empty(b)` | - | Sets to empty (`[inf,inf,inf,-inf,-inf,-inf]`). |
| `box3_union(b, other)` | `Box3` | Sets `b` to union of both boxes. |
| `box3_intersect(b, other)` | `Box3` | Sets `b` to overlap with `other` (or empty if none). |
| `box3_translate(b, ox, oy, oz)` | - | Moves box by offset. |
| `box3_set_from_center_and_size(b, center, size)` | `Box3` | Sets from center `[x,y,z]` and size `[w,h,d]`. |
| `box3_set_from_points(b, points)` | `Box3` | Sets to enclose array of `[x,y,z]` points. |
| `box3_apply_matrix4(b, m)` | `Box3` | Transforms the 8 corners by `m` and recomputes bounds. |
| `box3_get_bounding_sphere(b)` | `Sphere` | Returns minimal sphere enclosing the box. |
| `box3_get_parameter(b, p, out?)` | `Vector3` | Returns normalized coordinates within the box. |
| `box3_intersects_plane(b, plane)` | `boolean` | True if plane intersects box. |
| `box3_intersects_sphere(b, sphere)` | `boolean` | True if sphere intersects box. |
| `box3_intersects_triangle(b, a, c, d)` | `boolean` | Approximates intersection via triangle AABB overlap. |
---

## Usage Examples

```js
var b = box3_create();
box3_set(b, -1, -2, -3, 4, 5, 6);

box3_expand_by_point(b, 10, 0, 0);   // b.maxX becomes 10
var center = box3_get_center(b);     // [ (minX+maxX)/2, ... ]
```
