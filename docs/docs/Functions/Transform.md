# Transform

High-level container for Position, Rotation, and Scale.
Stored as an array of 3 sub-arrays: `[[x,y,z], [x,y,z,w], [x,y,z]]`.

## 🛠 Creation

| Function | Description |
| :--- | :--- |
| `transform_create([pos, rot, scl])` | Creates a new transform. |
| `transform_set(t, pos, rot, scl)` | Sets components (copying values). |
| `transform_copy(t, src)` | Copies. |
| `transform_clone(t)` | Clones. |

## 🧮 Matrix Operations

| Function | Description |
| :--- | :--- |
| `transform_compose_matrix(t, m)` | Updates a 4x4 matrix from this transform. |
| `transform_decompose_matrix(t, m)` | Updates this transform from a 4x4 matrix. |

## 👁 Orientation

| Function | Description |
| :--- | :--- |
| `transform_look_at(t, target, up)` | Orients the transform to look at target. |
