---
sidebar_position: 13
---

# DualQuaternion

Dual Quaternion stored as `[rx, ry, rz, rw, dx, dy, dz, dw]`.
The first 4 elements are the real part (rotation quaternion), and the last 4 are the dual part (translation and rotation combined).
Functions modify the first argument in-place unless noted.

---

## Functions Reference

### Creation & Setters

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `dualquat_create(rx?, ry?, rz?, rw?, dx?, dy?, dz?, dw?)` | `Array` | Creates a dual quaternion (default identity). |
| `dualquat_identity(dq)` | - | Resets to identity. |
| `dualquat_set(dq, rx, ry, rz, rw, dx, dy, dz, dw)` | - | Sets all components. |
| `dualquat_clone(dq)` | `Array` | Returns a copy. |
| `dualquat_copy(dq, src)` | - | Copies values from `src`. |

### Conversions

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `dualquat_from_translation_rotation(dq, translation, rotation)` | - | Sets from `Vector3` translation and `Quaternion` rotation. |
| `dualquat_to_translation_rotation(dq, translation, rotation)` | - | Extracts translation and rotation. |
| `dualquat_to_matrix4(dq, m)` | - | Converts to a 4x4 matrix. |
| `dualquat_get_translation(dq, target)` | - | Helper to get only translation part. |
| `dualquat_get_rotation(dq, target)` | - | Helper to get only rotation part. |

### Operations

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `dualquat_multiply(dq1, dq2)` | - | Sets `dq1 = dq1 * dq2`. |
| `dualquat_premultiply(dq1, dq2)` | - | Sets `dq1 = dq2 * dq1`. |
| `dualquat_multiply_dualquaternions(dest, dq1, dq2)` | - | Sets `dest = dq1 * dq2`. |
| `dualquat_dlerp(dq1, dq2, t)` | - | Dual Linear Interpolation (blending). |
| `dualquat_normalize(dq)` | - | Normalizes the dual quaternion. |
| `dualquat_conjugate(dq)` | - | Conjugates in place. |
| `dualquat_invert(dq)` | - | Inverts (conjugate for unit dual quaternions). |
| `dualquat_dot(dq1, dq2)` | `number` | Dot product of real parts. |
| `dualquat_transform_vec3(dq, v, target)` | - | Transforms `Vector3` `v` by the dual quaternion. |

### Utilities

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `dualquat_equals(dq1, dq2)` | `boolean` | True if components are equal. |
| `dualquat_from_array(dq, array, offset?)` | - | Reads from array. |
| `dualquat_to_array(dq, array?, offset?)` | `Array` | Writes to array. |
