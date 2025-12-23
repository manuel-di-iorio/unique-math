//// GMTL-style test suite for UeVector3
//suite(function() {
	//describe("UeVector3", function() {
		//// Constructor tests
		//test("constructor sets x, y, z correctly", function() {
			//var v = new UeVector3(1, 2, 3);
			//expect(v.x).toBe(1);
			//expect(v.y).toBe(2);
			//expect(v.z).toBe(3);
		//});
//
		//test("constructor with default values creates zero vector", function() {
			//var v = new UeVector3();
			//expect(v.x).toBe(0);
			//expect(v.y).toBe(0);
			//expect(v.z).toBe(0);
		//});
//
		//test("set() updates components", function() {
			//var v = new UeVector3(1, 2, 3);
			//v.set(4, 5, 6);
			//expect(v.x).toBe(4);
			//expect(v.y).toBe(5);
			//expect(v.z).toBe(6);
		//});
//
		//test("clone() creates independent copy", function() {
			//var v = new UeVector3(3, 4, 5);
			//var v2 = v.clone();
			//expect(v.equals(v2)).toBeTruthy();
			//// Verify independence
			//v2.set(6, 7, 8);
			//expect(v.x).toBe(3);
			//expect(v.y).toBe(4);
			//expect(v.z).toBe(5);
		//});
//
		//test("equals() compares vectors correctly", function() {
			//var v1 = new UeVector3(1, 2, 3);
			//var v2 = new UeVector3(1, 2, 3);
			//var v3 = new UeVector3(1, 2, 4);
			//expect(v1.equals(v2)).toBeTruthy();
			//expect(v1.equals(v3)).toBeFalsy();
		//});
//
		//// Arithmetic operations
		//test("add() adds vectors", function() {
			//var v = new UeVector3(1, 2, 3);
			//var v2 = new UeVector3(4, 5, 6);
			//v.add(v2);
			//expect(v.equals(new UeVector3(5, 7, 9))).toBeTruthy();
		//});
//
		//test("sub() subtracts vectors", function() {
			//var v = new UeVector3(5, 7, 9);
			//var v2 = new UeVector3(4, 5, 6);
			//v.sub(v2);
			//expect(v.equals(new UeVector3(1, 2, 3))).toBeTruthy();
		//});
//
		//test("copy() copies vector values", function() {
			//var v = new UeVector3(1, 1, 1);
			//var v2 = new UeVector3(5, 6, 7);
			//v.copy(v2);
			//expect(v.equals(new UeVector3(5, 6, 7))).toBeTruthy();
		//});
//
		//test("multiply() multiplies component-wise", function() {
			//var v = new UeVector3(2, 3, 4);
			//v.multiply(new UeVector3(3, 4, 5));
			//expect(v.equals(new UeVector3(6, 12, 20))).toBeTruthy();
		//});
//
		//test("scale() scales vector uniformly", function() {
			//var v = new UeVector3(6, 12, 18);
			//v.scale(0.5);
			//expect(v.equals(new UeVector3(3, 6, 9))).toBeTruthy();
		//});
//
		//test("multiplyScalar() scales vector", function() {
			//var v = new UeVector3(2, 3, 4);
			//v.multiplyScalar(2);
			//expect(v.equals(new UeVector3(4, 6, 8))).toBeTruthy();
		//});
//
		//// Vector operations
		//test("dot() calculates dot product", function() {
			//var a = new UeVector3(1, 0, 0);
			//var b = new UeVector3(0, 1, 0);
			//expect(a.dot(b)).toBe(0);
			//
			//var c = new UeVector3(2, 3, 4);
			//var d = new UeVector3(5, 6, 7);
			//expect(c.dot(d)).toBe(56); // 2*5 + 3*6 + 4*7 = 56
		//});
//
		//test("cross() calculates cross product", function() {
			//var a = new UeVector3(1, 0, 0);
			//var b = new UeVector3(0, 1, 0);
			//var c = a.cross(b);
			//expect(c.equals(new UeVector3(0, 0, 1))).toBeTruthy();
		//});
//
		//test("cross() with parallel vectors returns zero vector", function() {
			//var a = new UeVector3(1, 2, 3);
			//var b = new UeVector3(2, 4, 6);
			//var c = a.cross(b);
			//expect(c.equals(new UeVector3(0, 0, 0))).toBeTruthy();
		//});
//
		//test("crossVectors() sets vector to cross product", function() {
			//var a = new UeVector3(1, 0, 0);
			//var b = new UeVector3(0, 1, 0);
			//var result = new UeVector3();
			//result.crossVectors(a, b);
			//expect(result.equals(new UeVector3(0, 0, 1))).toBeTruthy();
		//});
//
		//test("length() returns vector magnitude", function() {
			//var a = new UeVector3(1, 0, 0);
			//expect(a.length()).toBe(1);
			//
			//var b = new UeVector3(3, 4, 0);
			//expect(b.length()).toBe(5);
		//});
//
		//test("lengthSq() returns squared length", function() {
			//var v = new UeVector3(3, 4, 0);
			//expect(v.lengthSq()).toBe(25);
		//});
//
		//test("normalize() creates unit vector", function() {
			//var c = new UeVector3(3, 4, 0);
			//c.normalize();
			//expect(round(c.length() * 1000) / 1000).toBe(1);
		//});
//
		//test("normalize() on zero vector doesn't produce NaN", function() {
			//var z = new UeVector3(0, 0, 0);
			//z.normalize();
			//expect(z.length()).toBe(0);
			//expect(z.x).toBe(0);
			//expect(z.y).toBe(0);
			//expect(z.z).toBe(0);
		//});
//
		//// Angle operations
		//test("angleTo() calculates angle between perpendicular vectors", function() {
			//var u = new UeVector3(1, 0, 0);
			//var v = new UeVector3(0, 1, 0);
			//expect(round(u.angleTo(v))).toBe(90);
		//});
//
		//test("angleTo() with zero vector returns 0", function() {
			//var u = new UeVector3(1, 0, 0);
			//var zero = new UeVector3(0, 0, 0);
			//expect(u.angleTo(zero)).toBe(0);
		//});
//
		//test("angleTo() with opposite vectors returns 180", function() {
			//var u = new UeVector3(1, 0, 0);
			//var v = new UeVector3(-1, 0, 0);
			//expect(round(u.angleTo(v))).toBe(180);
		//});
//
		//// Interpolation and distance
		//test("lerp() interpolates at t=0.5", function() {
			//var p = new UeVector3(0, 0, 0);
			//var q = new UeVector3(10, 10, 10);
			//p.lerp(q, 0.5);
			//expect(p.equals(new UeVector3(5, 5, 5))).toBeTruthy();
		//});
//
		//test("lerp() at t=0 returns start vector", function() {
			//var a = new UeVector3(1, 2, 3);
			//var b = new UeVector3(5, 6, 7);
			//var c = a.clone();
			//c.lerp(b, 0);
			//expect(c.equals(new UeVector3(1, 2, 3))).toBeTruthy();
		//});
//
		//test("lerp() at t=1 returns end vector", function() {
			//var a = new UeVector3(1, 2, 3);
			//var b = new UeVector3(5, 6, 7);
			//var c = a.clone();
			//c.lerp(b, 1);
			//expect(c.equals(new UeVector3(5, 6, 7))).toBeTruthy();
		//});
//
		//test("distanceTo() calculates distance between vectors", function() {
			//var a = new UeVector3(0, 0, 0);
			//var b = new UeVector3(3, 4, 0);
			//expect(a.distanceTo(b)).toBe(5);
		//});
//
		//test("distanceToSquared() calculates squared distance", function() {
			//var a = new UeVector3(0, 0, 0);
			//var b = new UeVector3(3, 4, 0);
			//expect(a.distanceToSquared(b)).toBe(25);
		//});
//
		//// Scalar operations
		//test("addScalar() adds scalar to all components", function() {
			//var v = new UeVector3(1, 2, 3);
			//v.addScalar(5);
			//expect(v.equals(new UeVector3(6, 7, 8))).toBeTruthy();
		//});
//
		//test("subScalar() subtracts scalar from all components", function() {
			//var v = new UeVector3(6, 7, 8);
			//v.subScalar(5);
			//expect(v.equals(new UeVector3(1, 2, 3))).toBeTruthy();
		//});
//
		//test("setScalar() sets all components to scalar", function() {
			//var v = new UeVector3(1, 2, 3);
			//v.setScalar(5);
			//expect(v.equals(new UeVector3(5, 5, 5))).toBeTruthy();
		//});
//
		//test("addScaledVector() adds scaled vector", function() {
			//var v = new UeVector3(1, 2, 3);
			//var v2 = new UeVector3(2, 3, 4);
			//v.addScaledVector(v2, 2);
			//expect(v.equals(new UeVector3(5, 8, 11))).toBeTruthy();
		//});
//
		//// Vector operations with two vectors
		//test("addVectors() sets vector to sum of two vectors", function() {
			//var a = new UeVector3(1, 2, 3);
			//var b = new UeVector3(4, 5, 6);
			//var result = new UeVector3();
			//result.addVectors(a, b);
			//expect(result.equals(new UeVector3(5, 7, 9))).toBeTruthy();
		//});
//
		//test("subVectors() sets vector to difference of two vectors", function() {
			//var a = new UeVector3(5, 7, 9);
			//var b = new UeVector3(4, 5, 6);
			//var result = new UeVector3();
			//result.subVectors(a, b);
			//expect(result.equals(new UeVector3(1, 2, 3))).toBeTruthy();
		//});
//
		//test("multiplyVectors() sets vector to component-wise product", function() {
			//var a = new UeVector3(2, 3, 4);
			//var b = new UeVector3(3, 4, 5);
			//var result = new UeVector3();
			//result.multiplyVectors(a, b);
			//expect(result.equals(new UeVector3(6, 12, 20))).toBeTruthy();
		//});
//
		//// Clamping operations
		//test("clamp() clamps components between min and max vectors", function() {
			//var v = new UeVector3(5, 10, 15);
			//var minVec = new UeVector3(6, 8, 12);
			//var maxVec = new UeVector3(8, 12, 14);
			//v.clamp(minVec, maxVec);
			//expect(v.equals(new UeVector3(6, 10, 14))).toBeTruthy();
		//});
//
		//test("clampScalar() clamps all components between scalars", function() {
			//var v = new UeVector3(5, 10, 15);
			//v.clampScalar(7, 12);
			//expect(v.equals(new UeVector3(7, 10, 12))).toBeTruthy();
		//});
//
		//test("clampLength() clamps vector length", function() {
			//var v = new UeVector3(3, 4, 0);
			//v.clampLength(2, 3);
			//expect(round(v.length() * 1000) / 1000).toBe(3);
		//});
//
		//// Division operations
		//test("divide() divides component-wise", function() {
			//var v = new UeVector3(6, 12, 18);
			//v.divide(new UeVector3(2, 3, 6));
			//expect(v.equals(new UeVector3(3, 4, 3))).toBeTruthy();
		//});
//
		//test("divideScalar() divides by scalar", function() {
			//var v = new UeVector3(6, 12, 18);
			//v.divideScalar(2);
			//expect(v.equals(new UeVector3(3, 6, 9))).toBeTruthy();
		//});
//
		//// Rounding operations
		//test("floor() applies floor to components", function() {
			//var v = new UeVector3(1.7, 2.3, 3.9);
			//v.floor();
			//expect(v.equals(new UeVector3(1, 2, 3))).toBeTruthy();
		//});
//
		//test("ceil() applies ceil to components", function() {
			//var v = new UeVector3(1.1, 2.5, 3.9);
			//v.ceil();
			//expect(v.equals(new UeVector3(2, 3, 4))).toBeTruthy();
		//});
//
		//test("roundVec() rounds components", function() {
			//var v = new UeVector3(1.4, 2.6, 3.6);
			//v.roundVec();
			//expect(v.equals(new UeVector3(1, 3, 4))).toBeTruthy();
		//});
//
		//test("roundToZero() rounds toward zero", function() {
			//var v = new UeVector3(-1.7, 2.3, -3.9);
			//v.roundToZero();
			//expect(v.equals(new UeVector3(-1, 2, -3))).toBeTruthy();
		//});
//
		//// Manhattan distance
		//test("manhattanLength() calculates Manhattan length", function() {
			//var v = new UeVector3(1, 2, 3);
			//expect(v.manhattanLength()).toBe(6);
		//});
//
		//test("manhattanDistanceTo() calculates Manhattan distance", function() {
			//var a = new UeVector3(1, 2, 3);
			//var b = new UeVector3(4, 6, 8);
			//expect(a.manhattanDistanceTo(b)).toBe(12); // |4-1| + |6-2| + |8-3| = 12
		//});
//
		//// Negation
		//test("negate() negates all components", function() {
			//var v = new UeVector3(1, -2, 3);
			//v.negate();
			//expect(v.equals(new UeVector3(-1, 2, -3))).toBeTruthy();
		//});
//
		//// Component setters
		//test("setX() sets x component", function() {
			//var v = new UeVector3(1, 2, 3);
			//v.setX(5);
			//expect(v.equals(new UeVector3(5, 2, 3))).toBeTruthy();
		//});
//
		//test("setY() sets y component", function() {
			//var v = new UeVector3(1, 2, 3);
			//v.setY(5);
			//expect(v.equals(new UeVector3(1, 5, 3))).toBeTruthy();
		//});
//
		//test("setZ() sets z component", function() {
			//var v = new UeVector3(1, 2, 3);
			//v.setZ(5);
			//expect(v.equals(new UeVector3(1, 2, 5))).toBeTruthy();
		//});
//
		//test("setComponent() sets component by index", function() {
			//var v = new UeVector3(1, 2, 3);
			//v.setComponent(0, 5);
			//v.setComponent(1, 6);
			//v.setComponent(2, 7);
			//expect(v.equals(new UeVector3(5, 6, 7))).toBeTruthy();
		//});
//
		//test("getComponent() gets component by index", function() {
			//var v = new UeVector3(1, 2, 3);
			//expect(v.getComponent(0)).toBe(1);
			//expect(v.getComponent(1)).toBe(2);
			//expect(v.getComponent(2)).toBe(3);
		//});
//
		//// Length operations
		//test("setLength() sets vector length", function() {
			//var v = new UeVector3(3, 4, 0);
			//v.setLength(10);
			//expect(round(v.length() * 1000) / 1000).toBe(10);
		//});
//
		//test("setLength() on zero vector doesn't produce NaN", function() {
			//var v = new UeVector3(0, 0, 0);
			//v.setLength(5);
			//expect(v.equals(new UeVector3(0, 0, 0))).toBeTruthy();
		//});
//
		//// Min/Max operations
		//test("minVec() takes minimum components", function() {
			//var v = new UeVector3(5, 2, 8);
			//v.minVec(new UeVector3(3, 4, 6));
			//expect(v.equals(new UeVector3(3, 2, 6))).toBeTruthy();
		//});
//
		//test("maxVec() takes maximum components", function() {
			//var v = new UeVector3(5, 2, 8);
			//v.maxVec(new UeVector3(3, 4, 6));
			//expect(v.equals(new UeVector3(5, 4, 8))).toBeTruthy();
		//});
//
		//// Array operations
		//test("fromArray() sets components from array", function() {
			//var v = new UeVector3();
			//v.fromArray([1, 2, 3]);
			//expect(v.equals(new UeVector3(1, 2, 3))).toBeTruthy();
		//});
//
		//test("fromArray() with offset", function() {
			//var v = new UeVector3();
			//v.fromArray([0, 1, 2, 3, 4], 2);
			//expect(v.equals(new UeVector3(2, 3, 4))).toBeTruthy();
		//});
//
		//test("toArray() exports components to array", function() {
			//var v = new UeVector3(1, 2, 3);
			//var arr = v.toArray();
			//expect(arr[0]).toBe(1);
			//expect(arr[1]).toBe(2);
			//expect(arr[2]).toBe(3);
		//});
//
		//test("toArray() with existing array and offset", function() {
			//var v = new UeVector3(1, 2, 3);
			//var arr = [0, 0, 0, 0, 0];
			//v.toArray(arr, 2);
			//expect(arr[2]).toBe(1);
			//expect(arr[3]).toBe(2);
			//expect(arr[4]).toBe(3);
		//});
//
		//// Projection operations
		//test("projectOnVector() projects onto another vector", function() {
			//var v = new UeVector3(2, 2, 0);
			//var target = new UeVector3(1, 0, 0);
			//v.projectOnVector(target);
			//expect(v.equals(new UeVector3(2, 0, 0))).toBeTruthy();
		//});
//
		//test("projectOnPlane() projects onto plane", function() {
			//var v = new UeVector3(1, 1, 0);
			//var normal = new UeVector3(0, 1, 0);
			//v.projectOnPlane(normal);
			//expect(v.equals(new UeVector3(1, 0, 0))).toBeTruthy();
		//});
//
		//test("reflect() reflects vector over normal", function() {
			//var v = new UeVector3(1, -1, 0);
			//var normal = new UeVector3(0, 1, 0);
			//v.reflect(normal);
			//expect(v.equals(new UeVector3(1, 1, 0))).toBeTruthy();
		//});
//
		//// Coordinate system conversions
		//test("setFromSphericalCoords() sets from spherical coordinates", function() {
			//var v = new UeVector3();
			//v.setFromSphericalCoords(1, pi/2, 0);
			//expect(round(v.x * 1000) / 1000).toBe(1);
			//expect(round(v.y * 1000) / 1000).toBe(0);
			//expect(round(v.z * 1000) / 1000).toBe(0);
		//});
//
		//test("setFromCylindricalCoords() sets from cylindrical coordinates", function() {
			//var v = new UeVector3();
			//v.setFromCylindricalCoords(1, 0, 5);
			//expect(round(v.x * 1000) / 1000).toBe(1);
			//expect(round(v.y * 1000) / 1000).toBe(5);
			//expect(round(v.z * 1000) / 1000).toBe(0);
		//});
	//});
//});
