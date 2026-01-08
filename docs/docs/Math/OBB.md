---
sidebar_position: 19
---

# OBB

Functions for Oriented Bounding Boxes (OBB). An OBB is represented by a 15-element array containing its center, half-extents, and a 3x3 rotation matrix.

### Array Layout
The array is structured as follows:
- `[0-2]`: Center (X, Y, Z)
- `[3-5]`: Half-extents
- `[6-14]`: 3x3 Rotation matrix (Column-Major)

---

### Creation and Setting

| Function | Description |
| -------- | ----------- |
| `obb_create(center?, halfSize?, rotation?)` | Creates a new OBB array. |
| `obb_set(obb, center, halfSize, rotation)` | Sets the OBB components. |
| `obb_copy(obb, src)` | Copies values from another OBB. |
| `obb_clone(obb)` | Clones the OBB. |
| `obb_from_box3(obb, box3)` | Sets OBB from an AABB. |

### Getters and Comparison

| Function | Description |
| -------- | ----------- |
| `obb_get_center(obb, out?)` | Gets the center of the OBB. |
| `obb_get_half_size(obb, out?)` | Gets the half-size of the OBB. |
| `obb_get_rotation(obb, out?)` | Gets the rotation matrix of the OBB. |
| `obb_equals(obb1, obb2)` | Checks if two OBBs are equal. |

### Transformations

| Function | Description |
| -------- | ----------- |
| `obb_apply_matrix4(obb, mat4)` | Transforms the OBB by a 4x4 matrix. |

### Collisions and Intersections

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `obb_contains_point(obb, point)` | `bool` | Checks if the OBB contains a point. |
| `obb_clamp_point(obb, point, out?)` | `vec3` | Clamps a point to the OBB. |
| `obb_intersects_sphere(obb, sphere)` | `bool` | Checks if OBB intersects a sphere. |
| `obb_intersects_box3(obb, box3)` | `bool` | Checks if OBB intersects an AABB. |
| `obb_intersects_plane(obb, plane)` | `bool` | Checks if OBB intersects a plane. |
| `obb_intersects_obb(obb1, obb2)` | `bool` | Checks if two OBBs intersect using SAT. |
| `obb_intersect_ray(obb, ray, out?)` | `real?` | Checks if ray intersects OBB. Returns `t` or `undefined`. |

---

## Temporary Variables
- `global.UE_OBB_TEMP0`
- `global.UE_OBB_TEMP1`
- `global.UE_OBB_TEMP2`
