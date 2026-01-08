# Getting Started

Welcome to **UniqueMath**, a robust and evolving math library for GameMaker, inspired by the intuitive design of three.js. UniqueMath brings you powerful mathematical structures—like vectors, matrices, and quaternions—optimized for both **performance** and **readability**.

---

## 🎯 Functional API

UniqueMath uses **arrays** and **functions** for maximum speed and zero memory allocations:

```js
var a = vec2_create(1, 2);
var b = vec2_create(3, 4);

vec2_add(a, b);        // a = [4, 6]
vec2_normalize(a);     // a = unit vector

var dot = vec2_dot(a, b);
```

> Why Functional?
> Array-based operations are **significantly faster** than structs in GameMaker. Use this API for physics, particles, pathfinding, or any performance-critical code.

---

## 🚀 Quick Examples

```js
// 2D Vector operations
var pos = vec2_create(100, 200);
var vel = vec2_create(5, 3);

vec2_add(pos, vel);                    // Update position
var speed = vec2_length(vel);          // Get speed
vec2_normalize(vel);                   // Get direction

// Rotate around a point
var center = vec2_create(0, 0);
vec2_rotate_around(pos, center, 45);   // Rotate 45 degrees
```

## 🔧 Requirements

- GameMaker Studio 2 (latest LTS or IDE version recommended)

---

## 📦 Installation

1. Download or copy the UniqueMath files.

2. Import the `uem.yymps` file by dragging it into your GameMaker project.

3. You're ready to use advanced math in your project!

---

## 📖 What's Available

| Module | Description |
| ------ | ----------- |
| `Vector2` | 2D vector functions |
| `Vector3` | 3D vector functions |
| `Vector4` | 4D vector functions |
| `Euler` | Euler angles functions |
| `Spherical` | Spherical coordinate functions |
| `Cylindrical` | Cylindrical coordinate functions |
| `Quaternion` | Quaternion functions |
| `Matrix2` | 2x2 matrix functions |
| `Matrix3` | 3x3 matrix functions |
| `Matrix4` | 4x4 matrix functions |
| `Box2` | 2D bounding box functions |
| `Box3` | 3D bounding box functions |
| `OBB` | Oriented Bounding Box functions |
| `Sphere` | Bounding sphere functions |
| `Plane` | 3D plane functions |
| `Ray` | Raycasting functions |
| `Line3` | 3D line functions |
| `Triangle` | 3D triangle functions |
| `Frustum` | View frustum functions |
| `SphericalHarmonics3` | 3rd-order Spherical Harmonics functions |
| `Octree` | Spatial partitioning tree functions |

---
