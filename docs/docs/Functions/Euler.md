# Euler

Euler angles describe a rotation transformation by rotating about each axis in a specified order.
Stored as arrays `[x, y, z, order]`.
Angles are in **DEGREES**.

**Order**: String "XYZ", "YXZ", "ZXY", "ZYX", "YZX", "XZY". Default "XYZ".

## 🛠 Creation & Setters

| Function | Description |
| :--- | :--- |
| `euler_create(x, y, z, order)` | Creates a new Euler array. |
| `euler_set(e, x, y, z, order)` | Sets the components. |
| `euler_copy(e, src)` | Copies. |
| `euler_clone(e)` | Clones. |

## 🔄 Conversions

| Function | Description |
| :--- | :--- |
| `euler_set_from_rotation_matrix(e, m, order)` | Sets Euler angles from a rotation matrix. |
| `euler_set_from_quaternion(e, q, order)` | Sets Euler angles from a quaternion. |

## 📦 Utilities

| Function | Description |
| :--- | :--- |
| `euler_equals(e1, e2)` | Checks equality (including order). |
