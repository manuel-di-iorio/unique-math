# Box3

Axis-aligned bounding box (AABB) in 3D.
Stored as `[minX, minY, minZ, maxX, maxY, maxZ]`.

## 🛠 Creation

| Function | Description |
| :--- | :--- |
| `box3_create(...)` | Creates a new Box3. Defaults to infinite inverted box. |
| `box3_set(...)` | Sets bounds directly. |
| `box3_clone(b)` | Clones the box. |
| `box3_copy(b, src)` | Copies. |

## 🧮 Operations

| Function | Description |
| :--- | :--- |
| `box3_expand_by_point(b, x, y, z)` | Expands the box to include the point. |
| `box3_contains_point(b, x, y, z)` | Checks if point is inside. |
| `box3_intersects_box(b, b2)` | Checks intersection with another box. |
| `box3_get_center(b, [out])` | Returns the center vector. |
| `box3_get_size(b, [out])` | Returns the size vector. |
