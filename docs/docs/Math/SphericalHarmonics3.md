---
sidebar_position: 24
---

# SphericalHarmonics3

Functions for 3rd-order Spherical Harmonics (SH), commonly used to represent global irradiance or radiance in real-time.

### Structure Layout
SH3 is represented as an array of **9 Vec3 coefficients** (totaling 27 float values). Each coefficient corresponds to an SH basis function.

---

## Creation

```js
// Create a set of SH3 coefficients (all zeroed)
var sh = sh3_create();
```

---

## Function Reference

### Base

| Function | Description |
| -------- | ----------- |
| `sh3_create()` | Allocates a new array of 9 Vec3s. |
| `sh3_set(sh, coefficients)` | Sets the SH coefficients by copying values. |
| `sh3_zero(sh)` | Sets all SH coefficients to 0. |
| `sh3_copy(sh, other)` | Copies the values of the given SH to this instance. |
| `sh3_clone(sh)` | Returns a new SH with copied values from this instance. |
| `sh3_equals(sh, other)` | Checks if two SH instances are equal. |

### Math Operations

| Function | Description |
| -------- | ----------- |
| `sh3_add(sh, other)` | Adds the given SH to this instance. |
| `sh3_add_scaled_sh(sh, other, s)` | Adds the given SH scaled by s to this instance. |
| `sh3_scale(sh, s)` | Scales this SH by the given scale factor. |
| `sh3_lerp(sh, other, alpha)` | Linear interpolates between the given SH and this instance by alpha. |

### Data Conversion

| Function | Description |
| -------- | ----------- |
| `sh3_from_array(sh, array, offset?)` | Sets the SH coefficients from an array of numbers. |
| `sh3_to_array(sh, array?, offset?)` | Copies the SH coefficients into an array of numbers. |

### Lighting and Evaluation

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `sh3_get_at(sh, normal, target)` | `vec3` | Returns the radiance in the direction of the given normal. |
| `sh3_get_irradiance_at(sh, normal, target)` | `vec3` | Returns the irradiance in the direction of the given normal. |
| `sh3_get_basis_at(normal, shBasis)` | `void` | Computes the SH basis for the given normal vector. |

---

## Temporary Variables
- `global.UE_SH3_TEMP0`
