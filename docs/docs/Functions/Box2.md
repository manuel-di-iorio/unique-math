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

---

## Usage Examples

```js
var b = box2_create();
box2_set(b, 0, 0, 10, 10);

box2_expand_by_point(b, 12, 5);     // b = [0, 0, 12, 10]
var inside = box2_contains_point(b, 6, 6); // true
```
