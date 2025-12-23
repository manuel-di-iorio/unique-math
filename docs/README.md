---
sidebar_position: 1
---

# Getting Started

Welcome to **UniqueMath**, a robust and evolving math library for GameMaker, inspired by the intuitive design of three.js. UniqueMath brings you powerful mathematical structures—like vectors, matrices, and quaternions—optimized for both **performance** and **readability**.

---

## 🎯 Two APIs: Functions vs Structs

UniqueMath provides **two ways** to work with math types:

### 1. Functional API (Recommended for Performance)

Uses **arrays** and **functions** for maximum speed and zero memory allocations:

```js
var a = vec2_create(1, 2);
var b = vec2_create(3, 4);

vec2_add(a, b);        // a = [4, 6]
vec2_normalize(a);     // a = unit vector

var dot = vec2_dot(a, b);
```

> Why Functional?
> Array-based operations are **significantly faster** than structs in GameMaker. Use this API for physics, particles, pathfinding, or any performance-critical code.

### 2. Struct API (Readable & Chainable)

Uses **constructors** and **methods** for clean, chainable code:

```js
var a = new UeVector3(1, 2, 3);
var b = new UeVector3(4, 5, 6);

var result = a.clone().add(b).normalize();
```

> When to use Structs?
> Use structs when readability and method chaining are more important than raw performance, such as in initialization code, tools, or prototyping.

---

## 🔧 Requirements

- GameMaker Studio 2 (latest LTS or IDE version recommended)

---

## 📦 Installation

1. Download or copy the UniqueMath files.

2. Import the `uem.yymps` file by dragging it into your GameMaker project.

3. You're ready to use advanced math in your project!

---

## 🚀 Quick Examples

### Functional API (Arrays)

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

### Struct API (Classes)

```js
// 3D Vector operations
var a = new UeVector3(1, 2, 3);
var b = new UeVector3(4, 5, 6);
var result = a.clone().add(b).normalize();

// Matrix operations
var m = new UeMatrix4();
m.makeRotationX(45).invert();

// Quaternion rotation
var q = new UeQuaternion();
q.setFromAxisAngle(new UeVector3(0, 1, 0), 90);
```

---

## 📖 What's Available

### Functions (Array-based)

| Module | Description |
| ------ | ----------- |
| [`Vec2`](./Functions/Vec2) | 2D vector functions |
| [`Vec3`](./Functions/Vec3) | 3D vector functions |
| [`Matrix3`](./Functions/Matrix3) | 3x3 matrix functions |
| [`Matrix4`](./Functions/Matrix4) | 4x4 matrix functions |
| [`Quaternion`](./Functions/Quaternion) | Quaternion functions |
| [`Plane`](./Functions/Plane) | 3D plane functions |
| [`Ray`](./Functions/Ray) | Ray functions |
| [`Box2`](./Functions/Box2) | 2D bounding box functions |
| [`Box3`](./Functions/Box3) | 3D bounding box functions |
| [`Sphere`](./Functions/Sphere) | Bounding sphere functions |
| [`Frustum`](./Functions/Frustum) | View frustum functions |
| [`Euler`](./Functions/Euler) | Euler angles functions |
| [`Transform`](./Functions/Transform) | Transform functions |

### Structs (Class-based)

| Struct | Description |
| ------ | ----------- |
| [`UeVector2`](./Struct/UeVector2) | 2D vector |
| [`UeVector3`](./Struct/UeVector3) | 3D vector |
| [`UeMatrix3`](./Struct/UeMatrix3) | 3x3 matrix |
| [`UeMatrix4`](./Struct/UeMatrix4) | 4x4 matrix |
| [`UeQuaternion`](./Struct/UeQuaternion) | Quaternion rotation |
| [`UeEuler`](./Struct/UeEuler) | Euler angles (degrees) |
| [`UeBox2`](./Struct/UeBox2) | 2D bounding box |
| [`UeBox3`](./Struct/UeBox3) | 3D bounding box |
| [`UeSphere`](./Struct/UeSphere) | Bounding sphere |
| [`UePlane`](./Struct/UePlane) | 3D plane |
| [`UeRay`](./Struct/UeRay) | Ray for raycasting |
| [`UeFrustum`](./Struct/UeFrustum) | View frustum |
| [`UeTransform`](./Struct/UeTransform) | Transform (position, rotation, scale) |
