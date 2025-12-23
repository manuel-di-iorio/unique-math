//// GMTL-style test suite for UeSphere
//suite(function() {
	//describe("UeSphere", function() {
		//// Constructor tests
		//test("constructor creates empty sphere by default", function() {
			//var sphere = new UeSphere();
			//expect(sphere.isSphere).toBeTruthy();
			//expect(sphere.isEmpty()).toBeTruthy();
		//});
//
		//test("constructor with center and radius", function() {
			//var center = new UeVector3(5, 5, 5);
			//var sphere = new UeSphere(center, 10);
			//expect(sphere.center.equals(center)).toBeTruthy();
			//expect(sphere.radius).toBe(10);
		//});
//
		//// Set and copy
		//test("set() updates center and radius", function() {
			//var sphere = new UeSphere();
			//var center = new UeVector3(1, 2, 3);
			//sphere.set(center, 5);
			//expect(sphere.center.equals(center)).toBeTruthy();
			//expect(sphere.radius).toBe(5);
		//});
//
		//test("clone() creates independent copy", function() {
			//var sphere1 = new UeSphere(new UeVector3(1, 2, 3), 5);
			//var sphere2 = sphere1.clone();
			//expect(sphere1.equals(sphere2)).toBeTruthy();
			//sphere2.radius = 10;
			//expect(sphere1.radius).toBe(5);
		//});
//
		//test("copy() copies sphere values", function() {
			//var sphere1 = new UeSphere();
			//var sphere2 = new UeSphere(new UeVector3(1, 2, 3), 5);
			//sphere1.copy(sphere2);
			//expect(sphere1.equals(sphere2)).toBeTruthy();
		//});
//
		//// Empty tests
		//test("isEmpty() returns true for empty sphere", function() {
			//var sphere = new UeSphere();
			//expect(sphere.isEmpty()).toBeTruthy();
		//});
//
		//test("isEmpty() returns false for valid sphere", function() {
			//var sphere = new UeSphere(new UeVector3(0, 0, 0), 5);
			//expect(sphere.isEmpty()).toBeFalsy();
		//});
//
		//test("makeEmpty() creates empty sphere", function() {
			//var sphere = new UeSphere(new UeVector3(5, 5, 5), 10);
			//sphere.makeEmpty();
			//expect(sphere.isEmpty()).toBeTruthy();
		//});
//
		//// Contains tests
		//test("containsPoint() returns true for point inside", function() {
			//var sphere = new UeSphere(new UeVector3(0, 0, 0), 10);
			//expect(sphere.containsPoint(new UeVector3(5, 0, 0))).toBeTruthy();
		//});
//
		//test("containsPoint() returns false for point outside", function() {
			//var sphere = new UeSphere(new UeVector3(0, 0, 0), 10);
			//expect(sphere.containsPoint(new UeVector3(15, 0, 0))).toBeFalsy();
		//});
//
		//// Distance tests
		//test("distanceToPoint() returns 0 for point inside", function() {
			//var sphere = new UeSphere(new UeVector3(0, 0, 0), 10);
			//var dist = sphere.distanceToPoint(new UeVector3(5, 0, 0));
			//expect(dist).toBe(-5);
		//});
//
		//test("distanceToPoint() returns positive for point outside", function() {
			//var sphere = new UeSphere(new UeVector3(0, 0, 0), 10);
			//var dist = sphere.distanceToPoint(new UeVector3(15, 0, 0));
			//expect(dist).toBe(5);
		//});
//
		//// Clamp test
		//test("clampPoint() clamps point to sphere surface", function() {
			//var sphere = new UeSphere(new UeVector3(0, 0, 0), 10);
			//var clamped = sphere.clampPoint(new UeVector3(20, 0, 0));
			//expect(clamped.equals(new UeVector3(10, 0, 0))).toBeTruthy();
		//});
//
		//test("clampPoint() keeps point inside unchanged", function() {
			//var sphere = new UeSphere(new UeVector3(0, 0, 0), 10);
			//var point = new UeVector3(5, 0, 0);
			//var clamped = sphere.clampPoint(point);
			//expect(clamped.equals(point)).toBeTruthy();
		//});
//
		//// Expand tests
		//test("expandByPoint() includes point in sphere", function() {
			//var sphere = new UeSphere(new UeVector3(0, 0, 0), 5);
			//sphere.expandByPoint(new UeVector3(10, 0, 0));
			//expect(sphere.containsPoint(new UeVector3(10, 0, 0))).toBeTruthy();
		//});
//
		//test("expandByPoint() on empty sphere sets center", function() {
			//var sphere = new UeSphere();
			//sphere.expandByPoint(new UeVector3(5, 5, 5));
			//expect(sphere.center.equals(new UeVector3(5, 5, 5))).toBeTruthy();
			//expect(sphere.radius).toBe(0);
		//});
//
		//// SetFromPoints
		//test("setFromPoints() creates sphere from points", function() {
			//var points = [
				//new UeVector3(0, 0, 0),
				//new UeVector3(10, 0, 0),
				//new UeVector3(0, 10, 0)
			//];
			//var sphere = new UeSphere();
			//sphere.setFromPoints(points);
			//expect(sphere.containsPoint(points[0])).toBeTruthy();
			//expect(sphere.containsPoint(points[1])).toBeTruthy();
			//expect(sphere.containsPoint(points[2])).toBeTruthy();
		//});
//
		//test("setFromBufferAttribute() creates sphere from flat array", function() {
			//var buffer = [0, 0, 0, 10, 0, 0, 0, 10, 0];
			//var sphere = new UeSphere();
			//sphere.setFromBufferAttribute(buffer);
			//expect(sphere.containsPoint(new UeVector3(0, 0, 0))).toBeTruthy();
			//expect(sphere.containsPoint(new UeVector3(10, 0, 0))).toBeTruthy();
			//expect(sphere.containsPoint(new UeVector3(0, 10, 0))).toBeTruthy();
		//});
//
		//test("setFromBufferAttribute() works with offset", function() {
			//var buffer = [99, 99, 99, 0, 0, 0, 10, 0, 0, 0, 10, 0];
			//var sphere = new UeSphere();
			//sphere.setFromBufferAttribute(buffer, 3);
			//expect(sphere.containsPoint(new UeVector3(0, 0, 0))).toBeTruthy();
			//expect(sphere.containsPoint(new UeVector3(10, 0, 0))).toBeTruthy();
			//expect(sphere.containsPoint(new UeVector3(0, 10, 0))).toBeTruthy();
		//});
//
		//// Intersection tests
		//test("intersectsSphere() returns true for overlapping spheres", function() {
			//var sphere1 = new UeSphere(new UeVector3(0, 0, 0), 10);
			//var sphere2 = new UeSphere(new UeVector3(15, 0, 0), 10);
			//expect(sphere1.intersectsSphere(sphere2)).toBeTruthy();
		//});
//
		//test("intersectsSphere() returns false for non-overlapping spheres", function() {
			//var sphere1 = new UeSphere(new UeVector3(0, 0, 0), 5);
			//var sphere2 = new UeSphere(new UeVector3(20, 0, 0), 5);
			//expect(sphere1.intersectsSphere(sphere2)).toBeFalsy();
		//});
//
		//test("intersectsBox() detects box intersection", function() {
			//var sphere = new UeSphere(new UeVector3(0, 0, 0), 10);
			//var box = new UeBox3(new UeVector3(5, 5, 5), new UeVector3(15, 15, 15));
			//expect(sphere.intersectsBox(box)).toBeTruthy();
		//});
//
		//test("intersectsPlane() detects plane intersection", function() {
			//var sphere = new UeSphere(new UeVector3(0, 5, 0), 10);
			//var plane = new UePlane(new UeVector3(0, 1, 0), 0);
			//expect(sphere.intersectsPlane(plane)).toBeTruthy();
		//});
//
		//// Union test
		//test("union() expands to include both spheres", function() {
			//var sphere1 = new UeSphere(new UeVector3(0, 0, 0), 5);
			//var sphere2 = new UeSphere(new UeVector3(10, 0, 0), 5);
			//sphere1.union(sphere2);
			//expect(sphere1.containsPoint(new UeVector3(0, 0, 0))).toBeTruthy();
			//expect(sphere1.containsPoint(new UeVector3(10, 0, 0))).toBeTruthy();
		//});
//
		//// Transform test
		//test("applyMatrix4() transforms sphere", function() {
			//var sphere = new UeSphere(new UeVector3(0, 0, 0), 5);
			//var matrix = new UeMatrix4();
			//matrix.makeTranslation(10, 10, 10);
			//sphere.applyMatrix4(matrix);
			//expect(sphere.center.equals(new UeVector3(10, 10, 10))).toBeTruthy();
		//});
//
		//test("applyMatrix4() scales radius", function() {
			//var sphere = new UeSphere(new UeVector3(0, 0, 0), 5);
			//var matrix = new UeMatrix4();
			//matrix.makeScale(2, 2, 2);
			//sphere.applyMatrix4(matrix);
			//expect(sphere.radius).toBe(10);
		//});
//
		//// Translate test
		//test("translate() moves sphere", function() {
			//var sphere = new UeSphere(new UeVector3(0, 0, 0), 5);
			//sphere.translate(new UeVector3(10, 10, 10));
			//expect(sphere.center.equals(new UeVector3(10, 10, 10))).toBeTruthy();
		//});
//
		//// Bounding box test
		//test("getBoundingBox() creates box containing sphere", function() {
			//var sphere = new UeSphere(new UeVector3(0, 0, 0), 10);
			//var box = sphere.getBoundingBox();
			//expect(box.containsPoint(new UeVector3(10, 0, 0))).toBeTruthy();
			//expect(box.containsPoint(new UeVector3(-10, 0, 0))).toBeTruthy();
		//});
//
		//// Equals test
		//test("equals() compares spheres correctly", function() {
			//var sphere1 = new UeSphere(new UeVector3(0, 0, 0), 5);
			//var sphere2 = new UeSphere(new UeVector3(0, 0, 0), 5);
			//var sphere3 = new UeSphere(new UeVector3(0, 0, 0), 10);
			//expect(sphere1.equals(sphere2)).toBeTruthy();
			//expect(sphere1.equals(sphere3)).toBeFalsy();
		//});
	//});
//});
