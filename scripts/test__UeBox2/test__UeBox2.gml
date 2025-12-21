// GMTL-style test suite for UeBox2
suite(function() {
	describe("UeBox2", function() {
		// Constructor tests
		test("constructor creates empty box by default", function() {
			var box = new UeBox2();
			expect(box.isEmpty()).toBeTruthy();
		});

		test("constructor with min and max creates valid box", function() {
			var _min = new UeVector2(0, 0);
			var _max = new UeVector2(10, 10);
			var box = new UeBox2(_min, _max);
			expect(box.sizeMin.equals(_min)).toBeTruthy();
			expect(box.sizeMax.equals(_max)).toBeTruthy();
		});

		// Set and copy
		test("set() updates min and max", function() {
			var box = new UeBox2();
			var _min = new UeVector2(1, 2);
			var _max = new UeVector2(5, 6);
			box.set(_min, _max);
			expect(box.sizeMin.equals(_min)).toBeTruthy();
			expect(box.sizeMax.equals(_max)).toBeTruthy();
		});

		test("clone() creates independent copy", function() {
			var box1 = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			var box2 = box1.clone();
			expect(box1.equals(box2)).toBeTruthy();
			box2.sizeMin.set(5, 5);
			expect(box1.sizeMin.x).toBe(0);
		});

		test("copy() copies box values", function() {
			var box1 = new UeBox2();
			var box2 = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			box1.copy(box2);
			expect(box1.equals(box2)).toBeTruthy();
		});

		// Empty and validity
		test("makeEmpty() creates empty box", function() {
			var box = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			box.makeEmpty();
			expect(box.isEmpty()).toBeTruthy();
		});

		test("isEmpty() returns true for empty box", function() {
			var box = new UeBox2();
			expect(box.isEmpty()).toBeTruthy();
		});

		test("isEmpty() returns false for valid box", function() {
			var box = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			expect(box.isEmpty()).toBeFalsy();
		});

		// Expand operations
		test("expandByPoint() includes point in box", function() {
			var box = new UeBox2();
			box.expandByPoint(new UeVector2(5, 5));
			expect(box.containsPoint(new UeVector2(5, 5))).toBeTruthy();
		});

		test("expandByScalar() expands box uniformly", function() {
			var box = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			box.expandByScalar(5);
			expect(box.sizeMin.equals(new UeVector2(-5, -5))).toBeTruthy();
			expect(box.sizeMax.equals(new UeVector2(15, 15))).toBeTruthy();
		});

		test("expandByVector() expands by vector", function() {
			var box = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			box.expandByVector(new UeVector2(2, 3));
			expect(box.sizeMin.equals(new UeVector2(-2, -3))).toBeTruthy();
			expect(box.sizeMax.equals(new UeVector2(12, 13))).toBeTruthy();
		});

		// Contains tests
		test("containsPoint() returns true for point inside", function() {
			var box = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			expect(box.containsPoint(new UeVector2(5, 5))).toBeTruthy();
		});

		test("containsPoint() returns false for point outside", function() {
			var box = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			expect(box.containsPoint(new UeVector2(15, 15))).toBeFalsy();
		});

		test("containsBox() returns true for box inside", function() {
			var box1 = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			var box2 = new UeBox2(new UeVector2(2, 2), new UeVector2(8, 8));
			expect(box1.containsBox(box2)).toBeTruthy();
		});

		test("containsBox() returns false for box outside", function() {
			var box1 = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			var box2 = new UeBox2(new UeVector2(5, 5), new UeVector2(15, 15));
			expect(box1.containsBox(box2)).toBeFalsy();
		});

		// Intersection tests
		test("intersectsBox() returns true for overlapping boxes", function() {
			var box1 = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			var box2 = new UeBox2(new UeVector2(5, 5), new UeVector2(15, 15));
			expect(box1.intersectsBox(box2)).toBeTruthy();
		});

		test("intersectsBox() returns false for non-overlapping boxes", function() {
			var box1 = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			var box2 = new UeBox2(new UeVector2(20, 20), new UeVector2(30, 30));
			expect(box1.intersectsBox(box2)).toBeFalsy();
		});

		test("intersect() updates box to intersection", function() {
			var box1 = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			var box2 = new UeBox2(new UeVector2(5, 5), new UeVector2(15, 15));
			box1.intersect(box2);
			expect(box1.sizeMin.equals(new UeVector2(5, 5))).toBeTruthy();
			expect(box1.sizeMax.equals(new UeVector2(10, 10))).toBeTruthy();
		});

		// Union test
		test("union() expands to include both boxes", function() {
			var box1 = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			var box2 = new UeBox2(new UeVector2(5, 5), new UeVector2(15, 15));
			box1.union(box2);
			expect(box1.sizeMin.equals(new UeVector2(0, 0))).toBeTruthy();
			expect(box1.sizeMax.equals(new UeVector2(15, 15))).toBeTruthy();
		});

		// Getters
		test("getCenter() returns box center", function() {
			var box = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			var center = box.getCenter();
			expect(center.equals(new UeVector2(5, 5))).toBeTruthy();
		});

		test("getSize() returns box dimensions", function() {
			var box = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 20));
			var size = box.getSize();
			expect(size.equals(new UeVector2(10, 20))).toBeTruthy();
		});

		test("getParameter() returns normalized coordinates", function() {
			var box = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			var param = box.getParameter(new UeVector2(5, 5));
			expect(param.equals(new UeVector2(0.5, 0.5))).toBeTruthy();
		});

		// Clamp and distance
		test("clampPoint() clamps point to box bounds", function() {
			var box = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			var clamped = box.clampPoint(new UeVector2(15, 15));
			expect(clamped.equals(new UeVector2(10, 10))).toBeTruthy();
		});

		test("distanceToPoint() returns 0 for point inside", function() {
			var box = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			expect(box.distanceToPoint(new UeVector2(5, 5))).toBe(0);
		});

		test("distanceToPoint() returns distance for point outside", function() {
			var box = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			var dist = box.distanceToPoint(new UeVector2(15, 10));
			expect(dist).toBe(5);
		});

		// Translate
		test("translate() moves box", function() {
			var box = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			box.translate(new UeVector2(5, 5));
			expect(box.sizeMin.equals(new UeVector2(5, 5))).toBeTruthy();
			expect(box.sizeMax.equals(new UeVector2(15, 15))).toBeTruthy();
		});

		// SetFromPoints
		test("setFromPoints() creates box from points", function() {
			var points = [
				new UeVector2(0, 0),
				new UeVector2(10, 5),
				new UeVector2(5, 10)
			];
			var box = new UeBox2();
			box.setFromPoints(points);
			expect(box.sizeMin.equals(new UeVector2(0, 0))).toBeTruthy();
			expect(box.sizeMax.equals(new UeVector2(10, 10))).toBeTruthy();
		});

		test("setFromBufferAttribute() creates box from flat array", function() {
			var buffer = [0, 0, 10, 5, 5, 10];
			var box = new UeBox2();
			box.setFromBufferAttribute(buffer);
			expect(box.sizeMin.equals(new UeVector2(0, 0))).toBeTruthy();
			expect(box.sizeMax.equals(new UeVector2(10, 10))).toBeTruthy();
		});

		test("setFromBufferAttribute() works with offset", function() {
			var buffer = [99, 99, 0, 0, 10, 5, 5, 10];
			var box = new UeBox2();
			box.setFromBufferAttribute(buffer, 2);
			expect(box.sizeMin.equals(new UeVector2(0, 0))).toBeTruthy();
			expect(box.sizeMax.equals(new UeVector2(10, 10))).toBeTruthy();
		});

		// SetFromCenterAndSize
		test("setFromCenterAndSize() creates box from center and size", function() {
			var box = new UeBox2();
			box.setFromCenterAndSize(new UeVector2(5, 5), new UeVector2(10, 10));
			expect(box.sizeMin.equals(new UeVector2(0, 0))).toBeTruthy();
			expect(box.sizeMax.equals(new UeVector2(10, 10))).toBeTruthy();
		});

		// Equals
		test("equals() compares boxes correctly", function() {
			var box1 = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			var box2 = new UeBox2(new UeVector2(0, 0), new UeVector2(10, 10));
			var box3 = new UeBox2(new UeVector2(0, 0), new UeVector2(5, 5));
			expect(box1.equals(box2)).toBeTruthy();
			expect(box1.equals(box3)).toBeFalsy();
		});
	});
});
