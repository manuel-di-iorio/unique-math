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
| `box3_create(minX?, minY?, minZ?, maxX?, maxY?, maxZ?)` | `Array` | Creates a new Box3. Defaults to empty inverted bounds. |
| `box3_set(b, minX, minY, minZ, maxX, maxY, maxZ)` | - | Sets bounds directly. |
| `box3_clone(b)` | `Array` | Returns a new copy of the box. |
| `box3_copy(b, src)` | - | Copies bounds from `src` to `b`. |

### Operations

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `box3_expand_by_point(b, x, y, z)` | - | Expands the box to include the point. |
| `box3_contains_point(b, x, y, z)` | `boolean` | True if point is inside. |
| `box3_intersects_box(b, other)` | `boolean` | True if boxes intersect. |
| `box3_get_center(b, [out])` | `Array` | Writes/returns center vector. |
| `box3_get_size(b, [out])` | `Array` | Writes/returns size vector. |

---

## Usage Examples

```js
var b = box3_create();
box3_set(b, -1, -2, -3, 4, 5, 6);

box3_expand_by_point(b, 10, 0, 0);   // b.maxX becomes 10
var center = box3_get_center(b);     // [ (minX+maxX)/2, ... ]
```
