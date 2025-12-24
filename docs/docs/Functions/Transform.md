---
sidebar_position: 17
---

# Transform
Array-based structure for managing position, rotation (quaternion), and scale, with performance-oriented methods and zero allocations where possible.

---

## Overview

- Type: `new Transform(data?)`
- Internals:
- `position`: `vec3` as array `[x, y, z]`
- `rotation`: quaternion as array `[x, y, z, w]`
- `scale`: `vec3` as array `[x, y, z]`
- `up`: up vector (default `[0, 0, -1]`)
- `matrix`: local `mat4` (16-element array, column-major)
- `matrixWorld`: `mat4` in world space
- `parent`: reference to the parent Transform (optional)
- `children`: array of children (Transform)
- Matrix Updates:
- `matrixAutoUpdate`: automatically updates the local matrix
- `matrixWorldAutoUpdate`: automatically updates the world matrix
- `matrixWorldNeedsUpdate`: internal flag to request The update

Dependencies: Uses the array-based functions `vec3_*`, `quat_*`, `mat4_*` present in the project.

---

## Creation

`new Transform(data?)`

- `data.position`: `[x, y, z]` optional
- `data.rotation`: `[x, y, z, w]` optional (identity if not passed)
- `data.scale`: `[x, y, z]` optional (default `[1,1,1]`)
- `data.up`: `[x, y, z]` optional (default `[0,0,-1]`)
- `data.matrix`, `data.matrixWorld`: optional 4x4 matrices
- `data.parent`, `data.children`: optional
- `data.matrixAutoUpdate`, `data.matrixWorldAutoUpdate`: optional Booleans

---

## Matrix API

- `updateMatrix()`
Recomposes the local matrix from `position`, `rotation`, `scale` using `mat4_compose`. Set `matrixWorldNeedsUpdate` = true.

- `updateMatrixWorld(force = false)`
Updates the `matrixWorld`. If a `parent` exists, multiplies `matrix * parent.matrixWorld` (column-major order consistent with `mat4_multiply_matrices`). Propagates to `children` if `force` or requested.

- `updateWorldMatrix(updateParents = false, updateChildren = false)`
Variant that allows updating by going back to the parent and/or propagating to the children, respecting `matrixAutoUpdate` and `matrixWorldAutoUpdate`.

- `applyMatrix4(mat4)`
Post-multiplies `matrix` by `mat4` and decomposes again into `position`, `rotation`, `scale` with `mat4_decompose`.

- `applyQuaternion(quat)`
Combines the current rotation with `quat` via `quat_multiply`.

- `getWorldPosition(target)`
Writes the position vector extracted from `matrixWorld` (`vec3_set_from_matrix_position`) to `target`.

- `getWorldQuaternion(target)`
Decomposes `matrixWorld` and returns the world quaternion to `target`.

- `getWorldScale(target)`
Decomposes `matrixWorld` and returns the world scale to `target`.

- `getWorldDirection(target?)`
Transforms the local `up` to the world direction using `vec3_transform_direction(matrixWorld)`.

---

## Translation

- `setPosition(x, y, z)`
Sets `position` directly.

- `translateOnAxis(axis, distance)`
Moves along `axis` (in object space); `axis` is rotated by the current quaternion and then scaled by `distance`.

- `translate(x, y, z)`
Adds the given vector to `position`.

- `translateX(value)`, `translateY(value)`, `translateZ(value)`
Increments the corresponding component of `position`.

---

## Rotation

- `lookAtVec(target)`
Constructs a look-at `mat4` with `mat4_look_at(position, target, up)` and updates `rotation` via `quat_set_from_rotation_matrix`.

- `lookAt(x, y, z)`
Variant that accepts numeric coordinates.

- `setRotation(x, y, z)`
Sets `rotation` from Euler (degrees) via `quat_set_from_euler`.

- `setRotationFromMatrix(mat)`
Sets `rotation` by reading the upper 3×3 of `mat` (`quat_set_from_rotation_matrix`).

- `setRotationFromQuaternion(quat)`
Copies the quaternion passed into `rotation`.

- `rotate(x, y, z)`
Converts Euler to a temporary quaternion and combines it with `rotation`.

- `rotateX(value)`, `rotateY(value)`, `rotateZ(value)`
Rotate locally around the axes via `quat_set_from_axis_angle` and `quat_multiply`.

- `rotateOnAxis(axis, angle)`
Rotates around an arbitrary local axis.

- `rotateOnWorldAxis(axis, angle)`
Rotates around a world axis (use `quat_premultiply`).

---

## Scale

- `setScale(x, y, z)`
Sets `scale` directly.

- `scaleX(value)`, `scaleY(value)`, `scaleZ(value)`
Increments the corresponding component of `scale`.

---

## Space Conversion

- `localToWorld(vec)`
Applies `matrixWorld` to the `vec` vector (as position, with w=1) using `vec3_apply_matrix4`.

- `worldToLocal(vec)`
Applies the inverse of `matrixWorld` to `vec` to obtain local coordinates.

---
