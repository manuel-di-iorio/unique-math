---
sidebar_position: 13
---

# Euler

Euler angles describe rotation by applying three axis rotations in a specified order.
Stored as `[x, y, z]`. Angles are in degrees. Rotation order: "YXZ"

---

## Functions Reference

### Creation & Setters

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `euler_create(x?, y?, z?)` | `Array` | Creates a new Euler array. |
| `euler_set(e, x, y, z)` | - | Sets components and order. |
| `euler_copy(e, src)` | - | Copies values from `src`. |
| `euler_clone(e)` | `Array` | Returns a new copy. |
| `euler_set_from_vector3(e, v)` | - | Sets angles from a 3D vector; optionally updates order. |

### Conversions

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `euler_set_from_rotation_matrix(e, m)` | - | Sets angles from a rotation matrix. |
| `euler_set_from_quaternion(e, q)` | - | Sets angles from a quaternion. |

### Utilities

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `euler_equals(a, b)` | `boolean` | True if angles and order are equal. |
| `euler_from_array(e, array, offset = 0)` | - | Reads angles (and optional order) from an array. |
| `euler_to_array(e, array = [], offset = 0)` | `Array` | Writes angles and order to an array and returns it. |
