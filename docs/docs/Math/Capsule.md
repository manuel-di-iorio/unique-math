---
sidebar_position: 17
---

# Capsule

Bounding capsule stored as `[startX, startY, startZ, finishX, finishY, finishZ, radius]`.
A capsule is defined by two endpoint positions (start and finish) and a radius.
Functions modify the first argument in-place unless noted.

---

## Functions Reference

### Creation

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `capsule_create(start, finish, radius)` | `Array` | Creates a new capsule (defaults to `[0,0,0,0,0,1,1]` - vertical). |
| `capsule_set(c, start, finish, radius)` | - | Sets start, finish and radius. |
| `capsule_clone(c)` | `Array` | Returns a copy of the capsule. |
| `capsule_copy(c, src)` | - | Copies values from `src`. |
| `capsule_equals(a, b)` | `boolean` | Returns true if capsules are identical. |

### Accessors

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `capsule_get_start(c, out?)` | `Array` | Returns the start point [x, y, z]; uses `out` if provided. |
| `capsule_get_finish(c, out?)` | `Array` | Returns the finish point [x, y, z]; uses `out` if provided. |
| `capsule_get_center(c, out?)` | `Array` | Returns the center point [x, y, z]; uses `out` if provided. |

### Operations

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `capsule_translate(c, offset)` | - | Offsets both start and finish points. |
| `capsule_intersects_box(c, box)` | `boolean` | True if capsule intersects the given bounding box. |

---

## Usage Examples

```js
// Create a vertical capsule (along Z-axis, since Z+ is up)
var c = capsule_create(
    vec3_create(0, 0, 0),
    vec3_create(0, 0, 10),
    2
);

// Move the capsule
capsule_translate(c, vec3_create(5, 5, 0));

// Get the center
var center = capsule_get_center(c);

// Check intersection with a box
var box = box3_create(vec3_create(0, 0, 0), vec3_create(10, 10, 10));
var intersects = capsule_intersects_box(c, box);
```

---

## Notes

- The capsule is effectively a line segment with thickness (sphere swept along the segment).
- When the start and finish points are identical, the capsule degenerates into a sphere.
- The `capsule_intersects_box` function handles edge cases including degenerate capsules.
