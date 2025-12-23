# Quaternion

Quaternions are used in GameMaker to represent rotations. They are stored as arrays of 4 elements `[x, y, z, w]`.

**Order**: `[x, y, z, w]`
**Angles**: All angles are in **DEGREES**.

## 🛠 Creation & Setters

| Function | Description |
| :--- | :--- |
| `quat_create([x, y, z, w])` | Creates a new quaternion, defaults to identity `[0, 0, 0, 1]`. |
| `quat_set(q, x, y, z, w)` | Sets the components of the quaternion. |
| `quat_identity(q)` | Resets the quaternion to the identity `[0, 0, 0, 1]`. |
| `quat_clone(q)` | Returns a new independent copy of the quaternion. |
| `quat_copy(q, src)` | Copies the values from `src` to `q`. |

## 🔄 Conversions

| Function | Description |
| :--- | :--- |
| `quat_set_from_euler(q, x, y, z, [order])` | Sets the quaternion from Euler angles (degrees). Order defaults to "XYZ". |
| `quat_set_from_axis_angle(q, axis, angle)` | Sets the quaternion from an axis vector and an angle (degrees). |
| `quat_set_from_rotation_matrix(q, m)` | Sets the quaternion from the rotation component of a 4x4 matrix. |
| `quat_set_from_unit_vectors(q, vFrom, vTo)` | Sets rotation required to rotate `vFrom` to `vTo`. Vectors must be normalized. |

## 🧮 Operations

| Function | Description |
| :--- | :--- |
| `quat_invert(q)` | Inverts the quaternion (conjugate). |
| `quat_conjugate(q)` | Conjugates the quaternion in place. |
| `quat_normalize(q)` | Normalizes the quaternion. |
| `quat_multiply(q, q2)` | Multiply `q` by `q2`. Corresponds to a rotation of `q` then `q2` if pre-multiplied logic, or `q2` then `q`? (Three.js: `q = q * q2` usually means `q` rotate then `q2`). |
| `quat_premultiply(q, q2)` | Sets `q = q2 * q`. |
| `quat_slerp(q, qb, t)` | Spherical linear interpolation between `q` and `qb`. |
| `quat_dot(q, q2)` | Calculates the dot product. |
| `quat_length(q)` | Returns the length of the quaternion. |
| `quat_length_sq(q)` | Returns the squared length. |

## 📦 Utilities

| Function | Description |
| :--- | :--- |
| `quat_equals(q, q2)` | Returns `true` if the quaternions are identical. |
| `quat_from_array(q, array, offset)` | Loads values from an array. |
| `quat_to_array(q, array, offset)` | Saves values to an array. |
