---
sidebar_position: 12
---

# Quaternion

Rotation stored as `[x, y, z, w]`. Angles for conversions use degrees.
Functions modify the first argument in-place unless noted.

---

## Functions Reference

### Creation & Setters

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `quat_create(x?, y?, z?, w?)` | `Array` | Creates a quaternion (default identity `[0,0,0,1]`). |
| `quat_set(q, x, y, z, w)` | - | Sets components. |
| `quat_identity(q)` | - | Resets to identity. |
| `quat_clone(q)` | `Array` | Returns a copy. |
| `quat_copy(q, src)` | - | Copies values from `src`. |

### Conversions

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `quat_set_from_euler(q, x, y, z, order?)` | - | Sets from Euler angles (degrees, default `"XYZ"`). |
| `quat_set_from_axis_angle(q, axis, angle)` | - | Sets from axis-angle (degrees). |
| `quat_set_from_rotation_matrix(q, m)` | - | Sets from rotation part of 4×4 matrix. |
| `quat_set_from_unit_vectors(q, vFrom, vTo)` | - | Sets rotation from `vFrom` to `vTo` (normalized). |

### Operations

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `quat_invert(q)` | - | Inverts quaternion (conjugate for unit quaternions). |
| `quat_conjugate(q)` | - | Conjugates in place. |
| `quat_normalize(q)` | - | Normalizes to unit length. |
| `quat_multiply(q, q2)` | - | Sets `q = q * q2`. |
| `quat_premultiply(q, q2)` | - | Sets `q = q2 * q`. |
| `quat_slerp(q, qb, t)` | - | Spherical linear interpolation. |
| `quat_rotate_towards(q, qb, step)` | - | Rotates towards `qb` by angular `step` (radians). |
| `quat_dot(q, q2)` | `number` | Dot product. |
| `quat_length(q)` | `number` | Length (magnitude). |
| `quat_length_sq(q)` | `number` | Squared length. |
| `quat_angle_to(q, q2)` | `number` | Angle to `q2` in radians. |

### Utilities

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `quat_equals(a, b)` | `boolean` | True if components are equal. |
| `quat_from_array(q, array, offset?)` | - | Loads from array. |
| `quat_to_array(q, array?, offset?)` | `Array` | Writes to array. |
| `quat_from_buffer_attribute(q, attr, index)` | - | Loads from flat buffer at `index`. |
| `quat_random(q)` | - | Sets to a random unit quaternion. |
| `quat_multiply_quaternions(dest, a, b)` | - | Sets `dest = a * b`. |
| `quat_slerp_quaternions(dest, qa, qb, t)` | - | Sets `dest = slerp(qa, qb, t)`. |
