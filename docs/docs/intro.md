---
sidebar_position: 1
---

# Getting Started

Welcome to **UniqueMath**, a robust and evolving math library for GameMaker, inspired by the intuitive design of three.js. UniqueMath brings you powerful mathematical structures-like vectors, matrices, and quaternions-using a modern, struct-based syntax for maximum readability and ease of use.

Whether you're building games, simulations, or tools, UniqueMath helps you write clear, chainable, and expressive math code, with many features already proven in production. The library is modular, so you can use only what you need, and is designed to grow and improve over time.

---


## 🔧 Requirements

- GameMaker Studio 2 (latest LTS or IDE version recommended)

---


## 📦 Installation

1. Download or copy the UniqueMath files.

2. Import the `uem.yymps` file by dragging it into your GameMaker project.

3. You're ready to use advanced math in your project!


---

## 🚀 Your First Calculation

Here's how easy it is to use UniqueMath in your GameMaker project. For example, to work with 3D vectors:

```js
var a = new UeVector3(1, 2, 3);
var b = new UeVector3(4, 5, 6);
var result = a.clone().add(b).normalize();
show_debug_message("Result: " + string(result.x) + ", " + string(result.y) + ", " + string(result.z));
```

You can chain methods for clarity and convenience, just like in three.js:

```js
var m = new UeMatrix4();
m.makeRotationX(45).invert();
```

Explore the documentation for all available structs and functions!
