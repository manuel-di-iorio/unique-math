---
sidebar_position: 13
---

# Euler

Euler angles describe rotation by applying three axis rotations in a specified order.
Stored as `[x, y, z, order]`. Angles are in degrees.

Order: `"XYZ" | "YXZ" | "ZXY" | "ZYX" | "YZX" | "XZY"` (default `"XYZ"`).

---

## Functions Reference

### Creation & Setters

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `euler_create(x?, y?, z?, order?)` | `Array` | Creates a new Euler array. |
| `euler_set(e, x, y, z, order?)` | - | Sets components and order. |
| `euler_copy(e, src)` | - | Copies values from `src`. |
| `euler_clone(e)` | `Array` | Returns a new copy. |

### Conversions

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `euler_set_from_rotation_matrix(e, m, order?)` | - | Sets angles from a rotation matrix. |
| `euler_set_from_quaternion(e, q, order?)` | - | Sets angles from a quaternion. |

### Utilities

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `euler_equals(a, b)` | `boolean` | True if angles and order are equal. |
