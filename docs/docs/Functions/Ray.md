# Ray

Ray defined by origin and direction.
Stored as `[ox, oy, oz, dx, dy, dz]`.

## 🛠 Creation

| Function | Description |
| :--- | :--- |
| `ray_create(...)` | Creates a new ray. |
| `ray_set(...)` | Sets ray components. |
| `ray_copy(r, src)` | Copies. |
| `ray_clone(r)` | Clones. |

## 🧮 Operations

| Function | Description |
| :--- | :--- |
| `ray_at(r, t, [out])` | Returns point along ray at distance `t`. |
| `ray_recenter(r, ox, oy, oz)` | Moves origin. |
| `ray_look_at(r, tx, ty, tz)` | Points ray towards target. |
| `ray_intersect_sphere(r, sphere)` | Returns distance to intersection or -1. |
| `ray_intersect_box(r, box)` | Returns distance to intersection or -1. |
