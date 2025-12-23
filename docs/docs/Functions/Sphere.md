# Sphere

Bounding sphere represented as an array `[x, y, z, radius]`.

## 🛠 Creation

| Function | Description |
| :--- | :--- |
| `sphere_create(x, y, z, r)` | Creates a new sphere. |
| `sphere_set(s, x, y, z, r)` | Sets sphere components. |
| `sphere_clone(s)` | Clones the sphere. |
| `sphere_copy(s, src)` | Copies the sphere. |

## 🧮 Operations

| Function | Description |
| :--- | :--- |
| `sphere_apply_matrix4(s, m)` | Transforms the sphere by a 4x4 matrix. |
| `sphere_contains_point(s, px, py, pz)` | Checks if the point is inside or on the surface of the sphere. |
| `sphere_intersects_sphere(s1, s2)` | Checks if two spheres intersect. |
