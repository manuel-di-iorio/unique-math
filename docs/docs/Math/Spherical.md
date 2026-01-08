---
sidebar_position: 22
---

# Spherical

Spherical coordinate system represented by an array `[radius, phi, theta]`.

### Array Layout
- `[0]`: **radius** (Distance from the origin)
- `[1]`: **phi** (Polar angle in radians, 0 to PI)
- `[2]`: **theta** (Azimuthal angle in radians, 0 to 2PI)

---

## Function Reference

### Base

| Function | Description |
| -------- | ----------- |
| `spherical_create(radius?, phi?, theta?)` | Creates spherical coordinates (default: 1, 0, 0). |
| `spherical_set(s, radius, phi, theta)` | Sets the spherical components. |
| `spherical_copy(s, other)` | Copies the values of the given spherical to this instance. |
| `spherical_clone(s)` | Returns a new spherical with copied values from this instance. |
| `spherical_make_safe(s)` | Restricts the polar angle phi to be between 0.0001 and pi - 0.0001. |

### Conversions

| Function | Description |
| -------- | ----------- |
| `spherical_set_from_cartesian_coords(s, x, y, z)` | Sets the spherical components from Cartesian coordinates. |
| `spherical_set_from_vector3(s, v)` | Sets the spherical components from a Vec3. |
| `vec3_set_from_spherical(vec3, s)` | Converts from Spherical to Cartesian coordinates (in Vec3 module). |

---

## Temporary Variables
- `global.UE_SPHERICAL_TEMP0`
