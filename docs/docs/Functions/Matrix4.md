---
sidebar_position: 4
---

# Matrix4

4x4 matrix functions using arrays of 16 elements in **column-major** order. Rotation angles are in **degrees**. Functions modify the first matrix in-place for zero allocations.

---

## Creating Matrices

```js
// Create a new identity matrix
var m = mat4_create();

// Create transformation matrices
var translate = mat4_create();
mat4_make_translation(translate, 10, 20, 30);

var rotate = mat4_create();
mat4_make_rotation_y(rotate, 45);  // 45 degrees
```

---

## Matrix Layout

Matrices are stored in **column-major** order (like OpenGL/Three.js):

```
| m[0]  m[4]  m[8]   m[12] |
| m[1]  m[5]  m[9]   m[13] |
| m[2]  m[6]  m[10]  m[14] |
| m[3]  m[7]  m[11]  m[15] |
```

Translation is stored in elements `[12, 13, 14]`.

---

## Functions Reference

### Creation

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `mat4_create()` | `Array` | Creates a new identity 4x4 matrix |

### Setters

| Function | Description |
| -------- | ----------- |
| `mat4_set(m, n11..n44)` | Sets elements (row-major input, 16 args) |
| `mat4_identity(m)` | Resets to identity matrix |

### Clone / Copy

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `mat4_clone(m)` | `Array` | Returns a new independent copy |
| `mat4_copy(dest, src)` | - | Copies all values |
| `mat4_copy_position(dest, src)` | - | Copies only translation |

### Determinant / Inversion

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `mat4_determinant(m)` | `number` | Computes the determinant |
| `mat4_invert(m)` | - | Inverts in-place |

### Transpose

| Function | Description |
| -------- | ----------- |
| `mat4_transpose(m)` | Transposes in place |

### Equality

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `mat4_equals(m, other)` | `boolean` | True if matrices are equal |

### Multiplication

| Function | Description |
| -------- | ----------- |
| `mat4_multiply(m, other)` | Post-multiply: m = m * other |
| `mat4_premultiply(m, other)` | Pre-multiply: m = other * m |
| `mat4_multiply_matrices(dest, a, b)` | Sets dest = a * b |
| `mat4_multiply_scalar(m, s)` | Multiplies all elements by scalar |

### Transform Makers (in degrees)

| Function | Description |
| -------- | ----------- |
| `mat4_make_translation(m, x, y, z)` | Sets to translation matrix |
| `mat4_make_scale(m, x, y, z)` | Sets to scale matrix |
| `mat4_make_rotation_x(m, angle)` | Sets to X rotation matrix |
| `mat4_make_rotation_y(m, angle)` | Sets to Y rotation matrix |
| `mat4_make_rotation_z(m, angle)` | Sets to Z rotation matrix |
| `mat4_make_rotation_axis(m, axis, angle)` | Sets to axis-angle rotation |
| `mat4_make_rotation_from_euler(m, x, y, z)` | Sets from Euler angles (order YXZ) |
| `mat4_make_rotation_from_quaternion(m, q)` | Sets from quaternion |
| `mat4_make_shear(m, xy, xz, yx, yz, zx, zy)` | Sets to shear matrix |

### Projection

| Function | Description |
| -------- | ----------- |
| `mat4_make_perspective(m, fov, aspect, near, far)` | Perspective projection |
| `mat4_make_orthographic(m, left, right, top, bottom, near, far)` | Orthographic projection |

### Look At

| Function | Description |
| -------- | ----------- |
| `mat4_look_at(m, eye, target, up)` | Creates view matrix |

### Basis

| Function | Description |
| -------- | ----------- |
| `mat4_make_basis(m, xAxis, yAxis, zAxis)` | Sets from basis vectors |
| `mat4_extract_basis(m, xAxis, yAxis, zAxis)` | Extracts basis vectors |
| `mat4_extract_rotation(m, src)` | Extracts rotation (no scale) |

### Compose / Decompose

| Function | Description |
| -------- | ----------- |
| `mat4_compose(m, position, quaternion, scale)` | Builds TRS matrix |
| `mat4_decompose(m, position, quaternion, scale)` | Extracts TRS components |

### Scale / Position

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `mat4_scale(m, v)` | - | Scales columns by vector |
| `mat4_set_position(m, x, y, z)` | - | Sets translation |
| `mat4_get_max_scale_on_axis(m)` | `number` | Gets maximum scale |

### Set From Matrix3

| Function | Description |
| -------- | ----------- |
| `mat4_set_from_matrix3(m, m3)` | Sets upper 3x3 from Matrix3 |

### Array Conversion

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `mat4_from_array(m, array, offset?)` | - | Sets from array |
| `mat4_to_array(m, array?, offset?)` | `Array` | Copies to array |

---

## Usage Examples

### Basic Transformations

```js
var m = mat4_create();

// Translation
mat4_make_translation(m, 10, 0, 0);

// Rotation (45 degrees around Y)
mat4_make_rotation_y(m, 45);

// Scale
mat4_make_scale(m, 2, 2, 2);
```

### Combining Transformations

```js
var model = mat4_create();
var translate = mat4_create();
var rotate = mat4_create();
var scale = mat4_create();

mat4_make_translation(translate, 10, 0, 0);
mat4_make_rotation_y(rotate, 45);
mat4_make_scale(scale, 2, 2, 2);

// model = translate * rotate * scale
mat4_multiply_matrices(model, translate, rotate);
mat4_multiply(model, scale);
```

### Compose from TRS

```js
var m = mat4_create();
var position = vec3_create(10, 20, 30);
var rotation = [0, 0, 0, 1];  // Identity quaternion
var scale = vec3_create(1, 1, 1);

mat4_compose(m, position, rotation, scale);
```

### Decompose to TRS

```js
var m = mat4_create();
// ... some transformation

var position = vec3_create();
var rotation = [0, 0, 0, 1];
var scale = vec3_create();

mat4_decompose(m, position, rotation, scale);
```

### Perspective Projection

```js
var projection = mat4_create();
mat4_make_perspective(projection, 60, 16/9, 0.1, 1000);
```

### Look At (View Matrix)

```js
var view = mat4_create();
var eye = vec3_create(0, 5, 10);
var target = vec3_create(0, 0, 0);
var up = vec3_create(0, 1, 0);

mat4_look_at(view, eye, target, up);
```

### Inversion

```js
var m = mat4_create();
mat4_make_translation(m, 10, 20, 30);
mat4_invert(m);  // Now translates by (-10, -20, -30)
```

### With Matrix3 (Normal Matrix)

```js
var modelMatrix = mat4_create();
// ... build model matrix

var normalMatrix = mat3_create();
mat3_get_normal_matrix(normalMatrix, modelMatrix);
```
