---
sidebar_position: 5
---

# Vector4

Functions for 4D vectors using `[x, y, z, w]` arrays. All functions modify the first vector in-place to ensure zero allocations and high performance.

---

## Creation

```js
// Create a new vector
var v = vec4_create(3, 4, 5, 1);

// Create a vector with default values [0, 0, 0, 1]
var v_def = vec4_create();
```

---

## Function Reference

### Creation and Setting

| Function | Description |
| -------- | ----------- |
| `vec4_create(x?, y?, z?, w?)` | Creates a new vec4 (default: 0, 0, 0, 1). |
| `vec4_set(vec, x, y, z, w)` | Sets all vector components. |
| `vec4_set_scalar(vec, scalar)` | Sets all components to the same value. |
| `vec4_set_x(vec, x)` / `vec4_set_y(vec, y)` | Sets individual components. |
| `vec4_set_z(vec, z)` / `vec4_set_w(vec, w)` | Sets individual components. |
| `vec4_set_width(vec, w)` / `vec4_set_height(vec, h)` | Aliases for Z and W. |
| `vec4_set_component(vec, index, value)` | Sets component by index (0-3). |
| `vec4_get_component(vec, index)` | Gets component by index. |

### Copy and Clone

| Function | Description |
| -------- | ----------- |
| `vec4_clone(vec)` | Returns a new copy of the vector. |
| `vec4_copy(dest, src)` | Copies values from `src` to `dest`. |
| `vec4_from_array(vec, array, offset?)` | Sets from an array. |
| `vec4_to_array(vec, array?, offset?)` | Writes to an array. |

### Math Operations

| Function | Description |
| -------- | ----------- |
| `vec4_add(vec, v)` | Adds `v` to `vec`. |
| `vec4_add_scalar(vec, s)` | Adds scalar `s` to all components. |
| `vec4_add_scaled_vector(vec, v, s)` | Adds `v * s` to `vec`. |
| `vec4_add_vectors(vec, a, b)` | Sets `vec = a + b`. |
| `vec4_sub(vec, v)` | Subtracts `v` from `vec`. |
| `vec4_sub_scalar(vec, s)` | Subtracts scalar `s`. |
| `vec4_sub_vectors(vec, a, b)` | Sets `vec = a - b`. |
| `vec4_multiply(vec, v)` | Component-wise multiplication. |
| `vec4_multiply_scalar(vec, s)` | Multiplies by a scalar. |
| `vec4_divide(vec, v)` | Component-wise division. |
| `vec4_divide_scalar(vec, s)` | Divides by a scalar. |

### Length and Normalization

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec4_length(vec)` | `number` | Euclidean length. |
| `vec4_length_sq(vec)` | `number` | Squared length. |
| `vec4_manhattan_length(vec)` | `number` | Manhattan length. |
| `vec4_set_length(vec, len)` | `vec` | Sets vector length. |
| `vec4_normalize(vec)` | `vec` | Normalizes to length 1. |
| `vec4_negate(vec)` | `vec` | Inverts all components. |
| `vec4_dot(vec, v)` | `number` | Dot product. |

### Range and Rounding

| Function | Description |
| -------- | ----------- |
| `vec4_min(vec, v)` / `vec4_max(vec, v)` | Component-wise min/max. |
| `vec4_clamp(vec, min, max)` | Clamps between two vectors. |
| `vec4_clamp_scalar(vec, min, max)` | Clamps between two scalars. |
| `vec4_clamp_length(vec, min, max)` | Clamps vector length. |
| `vec4_floor(vec)` / `vec4_ceil(vec)` | Rounding functions. |
| `vec4_round(vec)` / `vec4_round_to_zero(vec)` | Rounding functions. |

### Comparison and Interpolation

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec4_equals(vec, v)` | `bool` | Exact equality check. |
| `vec4_lerp(vec, v, alpha)` | `vec` | Linear interpolation. |
| `vec4_lerp_vectors(vec, a, b, alpha)` | `vec` | Sets `vec = lerp(a, b, alpha)`. |
| `vec4_random(vec)` | `vec` | Sets components to random [0, 1). |

### Transformations

| Function | Description |
| -------- | ----------- |
| `vec4_apply_matrix4(vec, mat4)` | Multiplies the vector by a 4x4 matrix. |
| `vec4_set_axis_angle_from_quaternion(vec, q)` | Sets [x,y,z] as axis and [w] as angle (degrees). |
| `vec4_set_axis_angle_from_rotation_matrix(vec, m)` | Sets axis and angle from rotation matrix. |
| `vec4_set_from_matrix_position(vec, m)` | Extracts position from 4x4 matrix. |

---

## Temporary Variables
To avoid allocations during calculations, the following global temporary vectors are available:
- `global.UE_VEC4_TEMP0`
- `global.UE_VEC4_TEMP1`
- `global.UE_VEC4_TEMP2`
- `global.UE_VEC4_TEMP3`
