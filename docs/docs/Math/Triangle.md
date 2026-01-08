---
sidebar_position: 21
---

# Triangle

Functions for 3D triangles represented as an array of three `Vec3` (vertices).

### Array Layout
`[ [v1X, v1Y, v1Z], [v2X, v2Y, v2Z], [v3X, v3Y, v3Z] ]`

---

## Creation

```js
var v1 = vec3_create(0, 0, 0);
var v2 = vec3_create(1, 0, 0);
var v3 = vec3_create(0, 1, 0);
var tri = tri_create(v1, v2, v3);
```

---

## Function Reference

### Base and Setting

| Function | Description |
| -------- | ----------- |
| `tri_create(a?, b?, c?)` | Creates a new triangle. |
| `tri_set(tri, a, b, c)` | Sets the triangle vertices. |
| `tri_set_from_points_and_indices(tri, points, i0, i1, i2)` | Sets the triangle from a points array and indices. |
| `tri_copy(tri, src)` | Copies src triangle to tri. |
| `tri_clone(tri)` | Clones the triangle. |
| `tri_equals(tri, other)` | Checks if two triangles are equal. |

### Properties and Calculations

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `tri_get_area(tri)` | `real` | Calculates the area of the triangle. |
| `tri_get_midpoint(tri, target)` | `vec3` | Calculates the midpoint (centroid) of the triangle. |
| `tri_get_normal(tri, target)` | `vec3` | Calculates the normal of the triangle. |
| `tri_get_plane(tri, target)` | `plane` | Calculates the plane of the triangle. |

### Barycentric and Interpolation

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `tri_get_barycoord(tri, point, target)` | `vec3?` | Calculates barycentric coordinates for a point. |
| `tri_get_interpolation(tri, point, v1, v2, v3, target)` | `vec3?` | Interpolates values over the triangle surface. |

### Utilities and Collision

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `tri_contains_point(tri, point)` | `bool` | Checks if the point lies within the triangle. |
| `tri_is_front_facing(tri, direction)` | `bool` | Checks if the triangle is front-facing relative to a direction. |
| `tri_closest_point_to_point(tri, p, target)` | `vec3` | Returns the closest point on the triangle for a given point. |
| `tri_intersects_box(tri, box)` | `bool` | Checks if the triangle intersects an AABB. |

---

## Temporary Variables
- `global.UE_TRI_VBA`
- `global.UE_TRI_VCA`
- `global.UE_TRI_VPA`
- `global.UE_TRI_VPB`
- `global.UE_TRI_VPC`
- `global.UE_TRI_VCB`
- `global.UE_TRI_BARY`
