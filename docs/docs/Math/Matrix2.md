---
sidebar_position: 6
---

# Matrix2

Functions for 2x2 matrices using 4-element arrays `[m0, m1, m2, m3]`. All matrices are stored in **COLUMN-MAJOR** order.

### Array Layout
The array `[n11, n21, n12, n22]` represents the matrix:
```
[ n11, n12, 
  n21, n22 ]
```

---

## Creation

```js
// Create an identity matrix
var m = mat2_create(); 

// Create a specific matrix (input in ROW-MAJOR for readability)
var m_custom = mat2_create(
    1, 2,
    3, 4
);
```

---

## Function Reference

### Creation and Setting

| Function | Description |
| -------- | ----------- |
| `mat2_create(n11?, n12?, n21?, n22?)` | Creates a new matrix (default: identity). |
| `mat2_set(m, n11, n12, n21, n22)` | Sets the matrix elements. |
| `mat2_identity(m)` | Sets the matrix to identity. |

### Utilities

| Function | Description |
| -------- | ----------- |
| `mat2_from_array(m, array, offset?)` | Sets the matrix from an array (Column-Major). |
