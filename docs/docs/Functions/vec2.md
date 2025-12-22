---
sidebar_position: 1
---

# vec2

2D vector functions using arrays `[x, y]`. All angles are in **degrees**. Functions modify the first vector in-place for zero allocations and high performance.

---

## Creating Vectors

```js
// Create a new vector
var v = vec2_create(3, 4);

// Create a zero vector
var zero = vec2_create();  // [0, 0]
```

---

## Functions Reference

### Creation

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec2_create(x?, y?)` | `Array` | Creates a new vec2 with given components (default: 0, 0) |

### Setters

| Function | Description |
| -------- | ----------- |
| `vec2_set(vec, x, y)` | Sets the vector components |
| `vec2_set_scalar(vec, s)` | Sets all components to the same value |
| `vec2_set_x(vec, x)` | Sets the x component |
| `vec2_set_y(vec, y)` | Sets the y component |
| `vec2_set_component(vec, index, value)` | Sets component by index (0=x, 1=y) |

### Getters

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec2_get_component(vec, index)` | `number` | Gets component by index (0=x, 1=y) |

### Clone / Copy

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec2_clone(vec)` | `Array` | Returns a new independent copy |
| `vec2_copy(dest, src)` | - | Copies src values into dest |

### Addition

| Function | Description |
| -------- | ----------- |
| `vec2_add(vec, v)` | Adds v to vec |
| `vec2_add_scalar(vec, s)` | Adds scalar to all components |
| `vec2_add_scaled_vector(vec, v, s)` | Adds v * s to vec |
| `vec2_add_vectors(dest, a, b)` | Sets dest = a + b |

### Subtraction

| Function | Description |
| -------- | ----------- |
| `vec2_sub(vec, v)` | Subtracts v from vec |
| `vec2_sub_scalar(vec, s)` | Subtracts scalar from all components |
| `vec2_sub_vectors(dest, a, b)` | Sets dest = a - b |

### Multiplication

| Function | Description |
| -------- | ----------- |
| `vec2_multiply(vec, v)` | Component-wise multiplication |
| `vec2_multiply_scalar(vec, s)` | Multiplies all components by scalar |

### Division

| Function | Description |
| -------- | ----------- |
| `vec2_divide(vec, v)` | Component-wise division |
| `vec2_divide_scalar(vec, s)` | Divides all components by scalar |

### Dot / Cross

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec2_dot(vec, v)` | `number` | Dot product |
| `vec2_cross(vec, v)` | `number` | 2D cross product (scalar) |

### Length

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec2_length(vec)` | `number` | Euclidean length |
| `vec2_length_sq(vec)` | `number` | Squared length (faster, no sqrt) |
| `vec2_manhattan_length(vec)` | `number` | Manhattan (taxicab) length |
| `vec2_set_length(vec, len)` | - | Sets vector to specific length |

### Normalize / Negate

| Function | Description |
| -------- | ----------- |
| `vec2_normalize(vec)` | Converts to unit vector (length = 1) |
| `vec2_negate(vec)` | Inverts: x = -x, y = -y |

### Distance

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec2_distance_to(vec, v)` | `number` | Euclidean distance |
| `vec2_distance_to_squared(vec, v)` | `number` | Squared distance (faster) |
| `vec2_manhattan_distance_to(vec, v)` | `number` | Manhattan distance |

### Min / Max / Clamp

| Function | Description |
| -------- | ----------- |
| `vec2_min(vec, v)` | Component-wise minimum |
| `vec2_max(vec, v)` | Component-wise maximum |
| `vec2_clamp(vec, min, max)` | Clamps between min and max vectors |
| `vec2_clamp_scalar(vec, min, max)` | Clamps between scalar values |
| `vec2_clamp_length(vec, min, max)` | Clamps vector length between min and max |

### Rounding

| Function | Description |
| -------- | ----------- |
| `vec2_floor(vec)` | Rounds components down |
| `vec2_ceil(vec)` | Rounds components up |
| `vec2_round(vec)` | Rounds components to nearest |
| `vec2_round_to_zero(vec)` | Rounds towards zero |

### Equality

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec2_equals(vec, v)` | `boolean` | True if vectors are exactly equal |

### Interpolation

| Function | Description |
| -------- | ----------- |
| `vec2_lerp(vec, v, alpha)` | Lerp towards v by alpha (0..1) |
| `vec2_lerp_vectors(dest, v1, v2, alpha)` | Sets dest = lerp(v1, v2, alpha) |

### Angle (in degrees)

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec2_angle(vec)` | `number` | Angle from positive X-axis |
| `vec2_angle_to(vec, v)` | `number` | Angle between two vectors |

### Rotation (in degrees)

| Function | Description |
| -------- | ----------- |
| `vec2_rotate_around(vec, center, angle)` | Rotates around center point |

### Random

| Function | Description |
| -------- | ----------- |
| `vec2_random(vec)` | Sets components to random values [0, 1) |

### Array Conversion

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec2_from_array(vec, array, offset?)` | - | Sets from array at offset |
| `vec2_to_array(vec, array?, offset?)` | `Array` | Copies to array at offset |
| `vec2_from_buffer_attribute(vec, attr, index)` | - | Sets from flat buffer by vertex index |

### Matrix Transformation

| Function | Description |
| -------- | ----------- |
| `vec2_apply_matrix3(vec, m)` | Multiplies by 3x3 matrix (column-major) |

### Extra Utility

| Function | Description |
| -------- | ----------- |
| `vec2_abs(vec)` | Sets components to absolute values |
| `vec2_reflect(vec, normal)` | Reflects across normal vector |
| `vec2_project(vec, onto)` | Projects onto another vector |
| `vec2_perp(vec)` | Rotates 90° CCW (perpendicular) |

---

## Usage Examples

### Basic Operations

```js
var a = vec2_create(3, 4);
var b = vec2_create(1, 2);

vec2_add(a, b);           // a = [4, 6]
vec2_multiply_scalar(a, 2); // a = [8, 12]
vec2_normalize(a);         // a = unit vector
```

### Distance and Length

```js
var pos = vec2_create(10, 0);
var target = vec2_create(5, 0);

var dist = vec2_distance_to(pos, target);  // 5
var len = vec2_length(pos);                 // 10
```

### Interpolation

```js
var start = vec2_create(0, 0);
var end = vec2_create(100, 100);

vec2_lerp(start, end, 0.5);  // start = [50, 50]
```

### Rotation

```js
var v = vec2_create(1, 0);
var center = vec2_create(0, 0);

vec2_rotate_around(v, center, 90);  // v ≈ [0, 1]
```

### Buffer Attribute (for vertex data)

```js
// Flat buffer with vertices: [x0,y0, x1,y1, x2,y2, ...]
var positions = [10, 20, 30, 40, 50, 60];
var v = vec2_create();

vec2_from_buffer_attribute(v, positions, 0);  // v = [10, 20]
vec2_from_buffer_attribute(v, positions, 1);  // v = [30, 40]
vec2_from_buffer_attribute(v, positions, 2);  // v = [50, 60]
```
