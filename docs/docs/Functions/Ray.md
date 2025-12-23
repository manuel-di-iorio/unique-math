---
sidebar_position: 16
---

# Ray

Ray defined by origin and direction, stored as `[ox, oy, oz, dx, dy, dz]`.
Functions modify the first argument in-place unless noted.

---

## Functions Reference

### Creation

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `ray_create(ox?, oy?, oz?, dx?, dy?, dz?)` | `Array` | Creates a new ray. |
| `ray_set(r, ox, oy, oz, dx, dy, dz)` | - | Sets origin and direction. |
| `ray_copy(r, src)` | - | Copies values from `src`. |
| `ray_clone(r)` | `Array` | Returns a copy of the ray. |

### Operations

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `ray_at(r, t, [out])` | `Array` | Point along ray at distance `t`. |
| `ray_recenter(r, ox, oy, oz)` | - | Moves origin to given point. |
| `ray_look_at(r, tx, ty, tz)` | - | Points ray direction towards target. |
| `ray_intersect_sphere(r, sphere)` | `number` | Distance to intersection or `-1`. |
| `ray_intersect_box(r, box)` | `number` | Distance to intersection or `-1`. |
| `ray_apply_matrix4(r, m)` | - | Transforms origin and direction by 4x4 matrix. |
| `ray_equals(r, other)` | `boolean` | Returns true if origin and direction match. |
| `ray_recast(r, t)` | - | Shifts origin along direction by distance `t`. |
| `ray_intersect_plane(r, plane, [out])` | `Array \| undefined` | Intersection point with plane or `undefined`. |
| `ray_distance_to_plane(r, plane)` | `number \| undefined` | Distance to intersection with plane or `undefined`. |
| `ray_intersects_box(r, box)` | `boolean` | Returns true if ray intersects box. |
| `ray_intersects_plane(r, plane)` | `boolean` | Returns true if ray intersects plane. |
| `ray_intersects_sphere(r, sphere)` | `boolean` | Returns true if ray intersects sphere. |
| `ray_distance_to_point(r, px, py, pz)` | `number` | Distance from ray to point. |
| `ray_distance_sq_to_point(r, px, py, pz)` | `number` | Squared distance from ray to point. |
| `ray_closest_point_to_point(r, px, py, pz, [out])` | `Array` | Closest point on ray to given point. |
| `ray_distance_sq_to_segment(r, v0, v1, [outRay], [outSeg])` | `number` | Squared distance between ray and segment; optional closest points. |
| `ray_intersect_sphere_point(r, sphere, [out])` | `Array \| undefined` | Intersection point with sphere or `undefined`. |
| `ray_intersect_triangle(r, a, b, c, backfaceCulling?, [out])` | `Array \| undefined` | Intersection point with triangle or `undefined`. |
