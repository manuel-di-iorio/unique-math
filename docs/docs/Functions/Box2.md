# Box2

2D Axis-aligned bounding box. `[minX, minY, maxX, maxY]`.

## 🛠 Creation

| Function | Description |
| :--- | :--- |
| `box2_create(...)` | Creates 2D box. |
| `box2_set(...)` | Sets bounds. |

## 🧮 Operations

| Function | Description |
| :--- | :--- |
| `box2_expand_by_point(b, x, y)` | Expands box. |
| `box2_contains_point(b, x, y)` | Point check. |
| `box2_intersects_box(b, other)` | Intersection check. |
