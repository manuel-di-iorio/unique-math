---
sidebar_position: 23
---

# Cylindrical

Cylindrical coordinate system represented by an array `[radius, theta, y]`.

### Array Layout
- `[0]`: **radius** (Distance from the Y-axis)
- `[1]`: **theta** (Azimuthal angle in radians)
- `[2]`: **y** (Height along the Y-axis)

---

## Function Reference

### Base

| Function | Description |
| -------- | ----------- |
| `cyl_create(radius?, theta?, y?)` | Creates a new cylindrical coordinate array. |
| `cyl_set(c, radius, theta, y)` | Sets the cylindrical components. |
| `cyl_copy(c, other)` | Copies the values of the given cylindrical to this instance. |
| `cyl_clone(c)` | Returns a new cylindrical with copied values from this instance. |

### Conversions

| Function | Description |
| -------- | ----------- |
| `cyl_set_from_cartesian_coords(c, x, y, z)` | Sets the cylindrical components from Cartesian coordinates. |
| `cyl_set_from_vector3(c, v)` | Sets the cylindrical components from a Vec3. |

---

## Temporary Variables
- `global.UE_CYLINDRICAL_TEMP0`
