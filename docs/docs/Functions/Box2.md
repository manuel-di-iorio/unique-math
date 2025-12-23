---
sidebar_position: 10
---

# Box2

2D axis-aligned bounding box stored as `[minX, minY, maxX, maxY]`.
Functions modify the first argument in-place unless noted.

---

## Functions Reference

### Creation

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `box2_create(minX?, minY?, maxX?, maxY?)` | `Array` | Creates a new Box2. Defaults to empty inverted bounds. |
| `box2_set(b, minX, minY, maxX, maxY)` | - | Sets bounds directly. |

### Operations

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `box2_expand_by_point(b, x, y)` | - | Expands the box to include the point. |
| `box2_contains_point(b, x, y)` | `boolean` | Returns true if point is inside the box. |
| `box2_intersects_box(b, other)` | `boolean` | Returns true if boxes intersect. |
| `box2_copy(b, src)` | - | Copies bounds from `src`. |
| `box2_clone(b)` | `Array` | Returns copy `[minX,minY,maxX,maxY]`. |
| `box2_contains_box(b, other)` | `boolean` | Returns true if `b` fully contains `other`. |
| `box2_equals(b, other)` | `boolean` | Strict equality on all components. |
| `box2_clamp_point(b, x, y, out?)` | `Vector2` | Clamps point to box boundaries. |
| `box2_distance_to_point(b, x, y)` | `number` | Euclidean distance to the box (0 if inside). |
| `box2_expand_by_scalar(b, s)` | - | Expands bounds by scalar in all directions. |
| `box2_expand_by_vector(b, v)` | - | Expands bounds by vector `[x,y]` in both directions. |
| `box2_get_center(b, out?)` | `Vector2` | Returns center point. |
| `box2_get_size(b, out?)` | `Vector2` | Returns width/height. |
| `box2_get_parameter(b, p, out?)` | `Vector2` | Returns normalized coordinates within the box. |
| `box2_is_empty(b)` | `boolean` | True if `minX > maxX` or `minY > maxY`. |
| `box2_make_empty(b)` | - | Sets to empty (`[inf,inf,-inf,-inf]`). |
| `box2_intersect(b, other)` | `Box2` | Sets `b` to overlap with `other` (or empty if none). |
| `box2_union(b, other)` | `Box2` | Sets `b` to the union of both boxes. |
| `box2_translate(b, ox, oy)` | - | Moves box by offset. |
| `box2_set_from_center_and_size(b, center, size)` | `Box2` | Sets from center `[x,y]` and size `[w,h]`. |
| `box2_set_from_points(b, points)` | `Box2` | Sets to enclose array of points `[x,y]`. |

---

## Usage Examples

```js
var b = box2_create();
box2_set(b, 0, 0, 10, 10);

box2_expand_by_point(b, 12, 5);     // b = [0, 0, 12, 10]
var inside = box2_contains_point(b, 6, 6); // true
```
