---
sidebar_position: 20
---

# Line3

Functions for line segments in 3D space, represented as an array of two `Vec3` (start and end).

### Array Layout
The array consists of 2 elements, each being a `Vec3` (3-element array):
`[ [startX, startY, startZ], [endX, endY, endZ] ]`

---

## Creation

```js
// Create a line between two points
var start = vec3_create(0, 0, 0);
var stop = vec3_create(10, 10, 10);
var line = line3_create(start, stop);
```

---

## Function Reference

### Base

| Function | Description |
| -------- | ----------- |
| `line3_create(start?, end?)` | Creates a new line (default: 0,0,0 -> 0,0,0). |
| `line3_set(line, start, end)` | Sets the start and end values by copying the given vectors. |
| `line3_copy(line, source)` | Copies the values of the given line segment to this instance. |
| `line3_clone(line)` | Returns a new line segment with copied values from this instance. |
| `line3_equals(line, source)` | Returns true if this line segment is equal with the given one. |

### Geometric Operations

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `line3_get_center(line, target)` | `vec3` | Returns the center of the line segment. |
| `line3_delta(line, target)` | `vec3` | Returns the delta vector of the line segment's start and end point. |
| `line3_at(line, t, target)` | `vec3` | Returns a vector at a certain position along the line segment. |
| `line3_distance(line)` | `real` | Returns the Euclidean distance between the line's start and end point. |
| `line3_distance_sq(line)` | `real` | Returns the squared Euclidean distance between the line's start and end point. |
| `line3_closest_point_to_point_parameter(line, point, clampToLine)` | `real` | Returns a point parameter based on the closest point as projected on the line segment. |
| `line3_closest_point_to_point(line, point, clampToLine, target)` | `vec3` | Returns the closest point on the line for a given point. |
| `line3_distance_sq_to_line3(line, line2, c1, c2)` | `real` | Returns the closest squared distance between this line segment and the given one. |
| `line3_apply_matrix4(line, matrix)` | `line3` | Applies a 4x4 transformation matrix to this line segment. |

---

## Temporary Variables
- `global.UE_LINE3_TEMP0`
- `global.UE_LINE3_TEMP1`
