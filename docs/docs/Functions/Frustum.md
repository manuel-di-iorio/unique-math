# Frustum

Represents a camera frustum using 6 planes.
Stored as an array of 6 plane arrays `[[nx, ny, nz, d], ...]`.
The planes are ordered: Left, Right, Bottom, Top, Near, Far.
Normals point INWARD (towards the inside of the frustum).

## 🛠 Creation

| Function | Description |
| :--- | :--- |
| `frustum_create()` | Creates a new frustum. |
| `frustum_clone(f)` | Clones. |
| `frustum_copy(f, src)` | Copies. |
| `frustum_set_from_matrix(f, m)` | Sets planes from a 4x4 projection matrix. |

## 🧮 Operations

| Function | Description |
| :--- | :--- |
| `frustum_intersects_sphere(f, s)` | Intersection check. |
| `frustum_intersects_box(f, b)` | Intersection check. |
| `frustum_contains_point(f, x, y, z)` | Point check. |
