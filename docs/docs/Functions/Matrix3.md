---
sidebar_position: 3
---

# Matrix3

3x3 matrix functions using arrays of 9 elements in **column-major** order. Rotation angles are in **degrees**. Functions modify the first matrix in-place for zero allocations.

---

## Creating Matrices

```js
// Create a new identity matrix
var m = mat3_create();  // [1,0,0, 0,1,0, 0,0,1]

// Create and set to rotation
var rot = mat3_create();
mat3_make_rotation(rot, 45);  // 45 degrees
```

---

## Matrix Layout

Matrices are stored in **column-major** order (like OpenGL/Three.js):

```
| m[0] m[3] m[6] |
| m[1] m[4] m[7] |
| m[2] m[5] m[8] |
```

When using `mat3_set()`, arguments are in **row-major** order for readability:
```js
mat3_set(m, n11, n12, n13, n21, n22, n23, n31, n32, n33);
```

---

## Functions Reference

### Creation

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `mat3_create()` | `Array` | Creates a new identity 3x3 matrix |

### Setters

| Function | Description |
| -------- | ----------- |
| `mat3_set(m, n11, n12, n13, n21, n22, n23, n31, n32, n33)` | Sets elements (row-major input) |
| `mat3_identity(m)` | Resets to identity matrix |

### Clone / Copy

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `mat3_clone(m)` | `Array` | Returns a new independent copy |
| `mat3_copy(dest, src)` | - | Copies src values into dest |

### Determinant / Inversion

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `mat3_determinant(m)` | `number` | Computes the determinant |
| `mat3_invert(m)` | - | Inverts in-place (zero matrix if singular) |

### Transpose

| Function | Description |
| -------- | ----------- |
| `mat3_transpose(m)` | Transposes in place |
| `mat3_transpose_into_array(m, arr)` | Writes transposed matrix to array |

### Equality

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `mat3_equals(m, other)` | `boolean` | True if matrices are equal |

### Multiplication

| Function | Description |
| -------- | ----------- |
| `mat3_multiply(m, other)` | Post-multiply: m = m * other |
| `mat3_premultiply(m, other)` | Pre-multiply: m = other * m |
| `mat3_multiply_matrices(dest, a, b)` | Sets dest = a * b |
| `mat3_multiply_scalar(m, s)` | Multiplies all elements by scalar |

### 2D Transform Makers (in degrees)

| Function | Description |
| -------- | ----------- |
| `mat3_make_rotation(m, angle)` | Sets to 2D rotation matrix |
| `mat3_make_scale(m, x, y)` | Sets to 2D scale matrix |
| `mat3_make_translation(m, x, y)` | Sets to 2D translation matrix |

### 2D Transform Operations (in degrees)

| Function | Description |
| -------- | ----------- |
| `mat3_rotate(m, angle)` | Applies rotation to matrix |
| `mat3_scale(m, sx, sy)` | Applies scale to matrix |
| `mat3_translate(m, tx, ty)` | Applies translation to matrix |

### Extract / Convert

| Function | Description |
| -------- | ----------- |
| `mat3_extract_basis(m, xAxis, yAxis, zAxis)` | Extracts column vectors (vec3) |
| `mat3_set_matrix4(m, m4)` | Sets from upper 3x3 of 4x4 matrix |
| `mat3_get_normal_matrix(m, m4)` | Computes normal matrix (inverse transpose) |

### UV Transform

| Function | Description |
| -------- | ----------- |
| `mat3_set_uv_transform(m, tx, ty, sx, sy, rotation, cx, cy)` | Sets UV transform matrix |

### Array Conversion

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `mat3_from_array(m, array, offset?)` | - | Sets from array at offset |
| `mat3_to_array(m, array?, offset?)` | `Array` | Copies to array at offset |

---

## Usage Examples

### Basic Operations

```js
var m = mat3_create();

// Set specific values
mat3_set(m, 1, 2, 3, 4, 5, 6, 7, 8, 9);

// Reset to identity
mat3_identity(m);
```

### 2D Transformations

```js
var m = mat3_create();

// Create rotation matrix (45 degrees)
mat3_make_rotation(m, 45);

// Create scale matrix
mat3_make_scale(m, 2, 3);

// Create translation matrix
mat3_make_translation(m, 10, 20);
```

### Combining Transforms

```js
var m = mat3_create();

// Apply multiple transforms
mat3_translate(m, 10, 20);  // First translate
mat3_rotate(m, 45);         // Then rotate
mat3_scale(m, 2, 2);        // Then scale
```

### Matrix Multiplication

```js
var a = mat3_create();
var b = mat3_create();

mat3_make_rotation(a, 45);
mat3_make_scale(b, 2, 2);

// a = a * b
mat3_multiply(a, b);

// Or store result in separate matrix
var result = mat3_create();
mat3_multiply_matrices(result, a, b);
```

### Inversion

```js
var m = mat3_create();
mat3_make_scale(m, 2, 4);

mat3_invert(m);  // Now m is [0.5, 0, 0, 0, 0.25, 0, 0, 0, 1]
```

### Normal Matrix

```js
// Get normal matrix from a 4x4 model matrix
var normalMatrix = mat3_create();
var modelMatrix4 = [2,0,0,0, 0,2,0,0, 0,0,2,0, 0,0,0,1];

mat3_get_normal_matrix(normalMatrix, modelMatrix4);
```

### Extract Basis Vectors

```js
var m = mat3_create();
mat3_make_rotation(m, 45);

var xAxis = vec3_create();
var yAxis = vec3_create();
var zAxis = vec3_create();

mat3_extract_basis(m, xAxis, yAxis, zAxis);
```

### UV Transform

```js
var uvMatrix = mat3_create();

// offset, repeat, rotation (degrees), center
mat3_set_uv_transform(uvMatrix, 0.5, 0.5, 2, 2, 45, 0.5, 0.5);
```
