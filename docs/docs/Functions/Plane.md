# Plane

Infinite 3D plane represented by normal vector and constant `[nx, ny, nz, constant]`.
Equation: `nx*x + ny*y + nz*z + constant = 0`.

## 🛠 Creation

| Function | Description |
| :--- | :--- |
| `plane_create(nx, ny, nz, constant)` | Creates a new plane. |
| `plane_set(p, nx, ny, nz, constant)` | Sets components. |
| `plane_set_from_normal_and_coplanar_point(p, nx, ny, nz, px, py, pz)` | Sets plane from normal and a point. |

## 🧮 Operations

| Function | Description |
| :--- | :--- |
| `plane_normalize(p)` | Normalizes the plane normal. |
| `plane_distance_to_point(p, px, py, pz)` | Returns signed distance from point to plane. |
