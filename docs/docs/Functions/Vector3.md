---
sidebar_position: 2
---

# Vec3

3D vector functions using arrays `[x, y, z]`. All angles are in **degrees**. Functions modify the first vector in-place for zero allocations.

---

## Creating Vectors

```js
// Create a new vector
var v = vec3_create(3, 4, 5);

// Create a zero vector
var zero = vec3_create();  // [0, 0, 0]
```

---

## Functions Reference

### Creation

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec3_create(x?, y?, z?)` | `Array` | Creates a new vec3 with given components (default: 0, 0, 0) |

### Setters

| Function | Description |
| -------- | ----------- |
| `vec3_set(vec, x, y, z)` | Sets the vector components |
| `vec3_set_scalar(vec, s)` | Sets all components to the same value |
| `vec3_set_x(vec, x)` | Sets the x component |
| `vec3_set_y(vec, y)` | Sets the y component |
| `vec3_set_z(vec, z)` | Sets the z component |
| `vec3_set_component(vec, index, value)` | Sets component by index (0=x, 1=y, 2=z) |

### Getters

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec3_get_component(vec, index)` | `number` | Gets component by index (0=x, 1=y, 2=z) |

### Clone / Copy

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec3_clone(vec)` | `Array` | Returns a new independent copy |
| `vec3_copy(dest, src)` | - | Copies src values into dest |

### Addition

| Function | Description |
| -------- | ----------- |
| `vec3_add(vec, v)` | Adds v to vec |
| `vec3_add_scalar(vec, s)` | Adds scalar to all components |
| `vec3_add_scaled_vector(vec, v, s)` | Adds v * s to vec |
| `vec3_add_vectors(dest, a, b)` | Sets dest = a + b |

### Subtraction

| Function | Description |
| -------- | ----------- |
| `vec3_sub(vec, v)` | Subtracts v from vec |
| `vec3_sub_scalar(vec, s)` | Subtracts scalar from all components |
| `vec3_sub_vectors(dest, a, b)` | Sets dest = a - b |

### Multiplication

| Function | Description |
| -------- | ----------- |
| `vec3_multiply(vec, v)` | Component-wise multiplication |
| `vec3_multiply_scalar(vec, s)` | Multiplies all components by scalar |
| `vec3_multiply_vectors(dest, a, b)` | Sets dest = a * b component-wise |

### Division

| Function | Description |
| -------- | ----------- |
| `vec3_divide(vec, v)` | Component-wise division |
| `vec3_divide_scalar(vec, s)` | Divides all components by scalar |

### Dot / Cross

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec3_dot(vec, v)` | `number` | Dot product |
| `vec3_cross(vec, v)` | - | Cross product (modifies vec in-place) |
| `vec3_cross_vectors(dest, a, b)` | - | Sets dest = a × b |

### Length

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec3_length(vec)` | `number` | Euclidean length |
| `vec3_length_sq(vec)` | `number` | Squared length (faster, no sqrt) |
| `vec3_manhattan_length(vec)` | `number` | Manhattan (taxicab) length |
| `vec3_set_length(vec, len)` | - | Sets vector to specific length |

### Normalize / Negate

| Function | Description |
| -------- | ----------- |
| `vec3_normalize(vec)` | Converts to unit vector (length = 1) |
| `vec3_negate(vec)` | Inverts: x = -x, y = -y, z = -z |

### Distance

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec3_distance_to(vec, v)` | `number` | Euclidean distance |
| `vec3_distance_to_squared(vec, v)` | `number` | Squared distance (faster) |
| `vec3_manhattan_distance_to(vec, v)` | `number` | Manhattan distance |

### Min / Max / Clamp

| Function | Description |
| -------- | ----------- |
| `vec3_min(vec, v)` | Component-wise minimum |
| `vec3_max(vec, v)` | Component-wise maximum |
| `vec3_clamp(vec, min, max)` | Clamps between min and max vectors |
| `vec3_clamp_scalar(vec, min, max)` | Clamps between scalar values |
| `vec3_clamp_length(vec, min, max)` | Clamps vector length between min and max |

### Rounding

| Function | Description |
| -------- | ----------- |
| `vec3_floor(vec)` | Rounds components down |
| `vec3_ceil(vec)` | Rounds components up |
| `vec3_round(vec)` | Rounds components to nearest |
| `vec3_round_to_zero(vec)` | Rounds towards zero |

### Equality

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec3_equals(vec, v)` | `boolean` | True if vectors are exactly equal |

### Interpolation

| Function | Description |
| -------- | ----------- |
| `vec3_lerp(vec, v, alpha)` | Lerp towards v by alpha (0..1) |
| `vec3_lerp_vectors(dest, v1, v2, alpha)` | Sets dest = lerp(v1, v2, alpha) |

### Angle (in degrees)

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec3_angle_to(vec, v)` | `number` | Angle between two vectors |

### Rotation (in degrees)

| Function | Description |
| -------- | ----------- |
| `vec3_apply_axis_angle(vec, axis, angle)` | Rotates around normalized axis |
| `vec3_apply_quaternion(vec, q)` | Applies quaternion rotation |

### Random

| Function | Description |
| -------- | ----------- |
| `vec3_random(vec)` | Sets components to random values [0, 1) |
| `vec3_random_direction(vec)` | Random point on unit sphere |

### Projection / Reflection

| Function | Description |
| -------- | ----------- |
| `vec3_project_on_vector(vec, v)` | Projects onto another vector |
| `vec3_project_on_plane(vec, normal)` | Projects onto plane |
| `vec3_reflect(vec, normal)` | Reflects across normal |

### Array Conversion

| Function | Returns | Description |
| -------- | ------- | ----------- |
| `vec3_from_array(vec, array, offset?)` | - | Sets from array at offset |
| `vec3_to_array(vec, array?, offset?)` | `Array` | Copies to array at offset |
| `vec3_from_buffer_attribute(vec, attr, index)` | - | Sets from flat buffer by vertex index |

### Matrix Transformation

| Function | Description |
| -------- | ----------- |
| `vec3_apply_matrix3(vec, m)` | Multiplies by 3x3 matrix |
| `vec3_apply_matrix4(vec, m)` | Multiplies by 4x4 matrix (with perspective divide) |
| `vec3_apply_normal_matrix(vec, m)` | Applies normal matrix and normalizes |
| `vec3_transform_direction(vec, m)` | Transforms direction (ignores translation) |

### Matrix Extraction

| Function | Description |
| -------- | ----------- |
| `vec3_set_from_matrix_column(vec, m, index)` | Extracts column from 4x4 matrix |
| `vec3_set_from_matrix3_column(vec, m, index)` | Extracts column from 3x3 matrix |
| `vec3_set_from_matrix_position(vec, m)` | Extracts position from 4x4 matrix |
| `vec3_set_from_matrix_scale(vec, m)` | Extracts scale from 4x4 matrix |

### Spherical / Cylindrical Coordinates

| Function | Description |
| -------- | ----------- |
| `vec3_set_from_spherical_coords(vec, radius, phi, theta)` | Sets from spherical coords (radians) |
| `vec3_set_from_cylindrical_coords(vec, radius, theta, y)` | Sets from cylindrical coords (radians) |
| `vec3_set_from_spherical(vec, spherical)` | Sets from spherical array [radius, phi, theta] |
| `vec3_set_from_cylindrical(vec, cylindrical)` | Sets from cylindrical array [radius, theta, y] |

### Euler Rotation

| Function | Description |
| -------- | ----------- |
| `vec3_apply_euler(vec, euler, order?)` | Applies Euler rotation [x, y, z] in degrees |
| `vec3_set_from_euler(vec, euler)` | Copies Euler angles to vector |

### Color

| Function | Description |
| -------- | ----------- |
| `vec3_set_from_color(vec, color)` | Sets from color array [r, g, b] (0-1) |
| `vec3_set_from_color_gml(vec, color)` | Sets from GML color value |

### Extra Utility

| Function | Description |
| -------- | ----------- |
| `vec3_abs(vec)` | Sets components to absolute values |

---

## Usage Examples

### Basic Operations

```js
var a = vec3_create(1, 2, 3);
var b = vec3_create(4, 5, 6);

vec3_add(a, b);              // a = [5, 7, 9]
vec3_multiply_scalar(a, 2);  // a = [10, 14, 18]
vec3_normalize(a);           // a = unit vector
```

### Distance and Length

```js
var pos = vec3_create(10, 0, 0);
var target = vec3_create(5, 0, 0);

var dist = vec3_distance_to(pos, target);  // 5
var len = vec3_length(pos);                 // 10
```

### Cross Product

```js
var x = vec3_create(1, 0, 0);
var y = vec3_create(0, 1, 0);

vec3_cross(x, y);  // x = [0, 0, 1] (z-axis)
```

### Rotation

```js
var v = vec3_create(1, 0, 0);
var axis = vec3_create(0, 0, 1);  // Z-axis

vec3_apply_axis_angle(v, axis, 90);  // v ≈ [0, 1, 0]
```

### Euler Rotation

```js
var v = vec3_create(1, 0, 0);

// Rotate 90° around Z axis
vec3_apply_euler(v, [0, 0, 90], "XYZ");  // v ≈ [0, 1, 0]
```

### Projection

```js
var v = vec3_create(3, 4, 0);
var onto = vec3_create(1, 0, 0);

vec3_project_on_vector(v, onto);  // v = [3, 0, 0]
```

### Matrix Transformation

```js
var v = vec3_create(1, 0, 0);

// 4x4 Translation matrix (column-major, translate by [5, 3, 2])
var translate = [1,0,0,0, 0,1,0,0, 0,0,1,0, 5,3,2,1];

vec3_apply_matrix4(v, translate);  // v = [6, 3, 2]
```

### Extract Position/Scale from Matrix

```js
var matrix = [2,0,0,0, 0,3,0,0, 0,0,4,0, 10,20,30,1];

var position = vec3_create();
var scale = vec3_create();

vec3_set_from_matrix_position(position, matrix);  // [10, 20, 30]
vec3_set_from_matrix_scale(scale, matrix);        // [2, 3, 4]
```

### Buffer Attribute (for vertex data)

```js
// Flat buffer with vertices: [x0,y0,z0, x1,y1,z1, ...]
var positions = [10, 20, 30, 40, 50, 60];
var v = vec3_create();

vec3_from_buffer_attribute(v, positions, 0);  // v = [10, 20, 30]
vec3_from_buffer_attribute(v, positions, 1);  // v = [40, 50, 60]
```

### Color Conversion

```js
var v = vec3_create();

// From array [r, g, b] (0-1)
vec3_set_from_color(v, [1.0, 0.5, 0.0]);  // Orange

// From GML color
vec3_set_from_color_gml(v, c_red);  // [1, 0, 0]
```

