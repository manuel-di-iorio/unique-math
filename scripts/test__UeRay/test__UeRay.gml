// GMTL-style test suite for UeRay
suite(function() {
	describe("UeRay", function() {
		// Constructor tests
		test("constructor creates ray with default origin and direction", function() {
			var ray = new UeRay();
			expect(ray.origin.equals(new UeVector3(0, 0, 0))).toBeTruthy();
			expect(round(ray.direction.length() * 1000) / 1000).toBe(1);
		});

		test("constructor with origin and direction", function() {
			var origin = new UeVector3(1, 2, 3);
			var _direction = new UeVector3(0, 1, 0);
			var ray = new UeRay(origin, _direction);
			expect(ray.origin.equals(origin)).toBeTruthy();
			expect(ray.direction.equals(_direction)).toBeTruthy();
		});

		// Set and copy
		test("set() updates origin and direction", function() {
			var ray = new UeRay();
			var origin = new UeVector3(5, 5, 5);
			var _direction = new UeVector3(1, 0, 0);
			ray.set(origin, _direction);
			expect(ray.origin.equals(origin)).toBeTruthy();
			expect(round(ray.direction.length() * 1000) / 1000).toBe(1);
		});

		test("clone() creates independent copy", function() {
			var ray1 = new UeRay(new UeVector3(1, 2, 3), new UeVector3(0, 1, 0));
			var ray2 = ray1.clone();
			expect(ray1.equals(ray2)).toBeTruthy();
			ray2.origin.set(5, 5, 5);
			expect(ray1.origin.x).toBe(1);
		});

		test("copy() copies ray values", function() {
			var ray1 = new UeRay();
			var ray2 = new UeRay(new UeVector3(1, 2, 3), new UeVector3(0, 1, 0));
			ray1.copy(ray2);
			expect(ray1.equals(ray2)).toBeTruthy();
		});

		// At method
		test("at() returns point along ray", function() {
			var ray = new UeRay(new UeVector3(0, 0, 0), new UeVector3(1, 0, 0));
			var point = ray.at(5);
			expect(point.equals(new UeVector3(5, 0, 0))).toBeTruthy();
		});

		test("at() with negative t goes backwards", function() {
			var ray = new UeRay(new UeVector3(0, 0, 0), new UeVector3(1, 0, 0));
			var point = ray.at(-5);
			expect(point.equals(new UeVector3(-5, 0, 0))).toBeTruthy();
		});

		// Distance tests
		test("distanceToPoint() returns distance to point", function() {
			var ray = new UeRay(new UeVector3(0, 0, 0), new UeVector3(1, 0, 0));
			var dist = ray.distanceToPoint(new UeVector3(5, 5, 0));
			expect(dist).toBe(5);
		});

		test("distanceSqToPoint() returns squared distance", function() {
			var ray = new UeRay(new UeVector3(0, 0, 0), new UeVector3(1, 0, 0));
			var distSq = ray.distanceSqToPoint(new UeVector3(5, 5, 0));
			expect(distSq).toBe(25);
		});

		test("closestPointToPoint() returns closest point on ray", function() {
			var ray = new UeRay(new UeVector3(0, 0, 0), new UeVector3(1, 0, 0));
			var closest = ray.closestPointToPoint(new UeVector3(5, 5, 0));
			expect(closest.equals(new UeVector3(5, 0, 0))).toBeTruthy();
		});

		// Plane intersection
		test("intersectPlane() finds intersection with plane", function() {
			var ray = new UeRay(new UeVector3(0, -5, 0), new UeVector3(0, 1, 0));
			var plane = new UePlane(new UeVector3(0, 1, 0), 0);
			var intersection = ray.intersectPlane(plane);
			expect(intersection != undefined).toBeTruthy();
			if (intersection) {
				expect(intersection.equals(new UeVector3(0, 0, 0))).toBeTruthy();
			}
		});

		test("intersectPlane() returns undefined for parallel ray", function() {
			var ray = new UeRay(new UeVector3(0, 5, 0), new UeVector3(1, 0, 0));
			var plane = new UePlane(new UeVector3(0, 1, 0), 0);
			var intersection = ray.intersectPlane(plane);
			expect(intersection).toBe(undefined);
		});

		test("intersectsPlane() detects plane intersection", function() {
			var ray = new UeRay(new UeVector3(0, -5, 0), new UeVector3(0, 1, 0));
			var plane = new UePlane(new UeVector3(0, 1, 0), 0);
			expect(ray.intersectsPlane(plane)).toBeTruthy();
		});

		// Sphere intersection
		test("intersectSphere() finds intersection with sphere", function() {
			var ray = new UeRay(new UeVector3(-10, 0, 0), new UeVector3(1, 0, 0));
			var sphere = new UeSphere(new UeVector3(0, 0, 0), 5);
			var intersection = ray.intersectSphere(sphere);
			expect(intersection != undefined).toBeTruthy();
		});

		test("intersectSphere() returns undefined for miss", function() {
			var ray = new UeRay(new UeVector3(-10, 20, 0), new UeVector3(1, 0, 0));
			var sphere = new UeSphere(new UeVector3(0, 0, 0), 5);
			var intersection = ray.intersectSphere(sphere);
			expect(intersection).toBe(undefined);
		});

		test("intersectsSphere() detects sphere intersection", function() {
			var ray = new UeRay(new UeVector3(-10, 0, 0), new UeVector3(1, 0, 0));
			var sphere = new UeSphere(new UeVector3(0, 0, 0), 5);
			expect(ray.intersectsSphere(sphere)).toBeTruthy();
		});

		// Box intersection
		test("intersectBox() finds intersection with box", function() {
			var ray = new UeRay(new UeVector3(-10, 0, 0), new UeVector3(1, 0, 0));
			var box = new UeBox3(new UeVector3(-5, -5, -5), new UeVector3(5, 5, 5));
			var intersection = ray.intersectBox(box);
			expect(intersection != undefined).toBeTruthy();
		});

		test("intersectBox() returns undefined for miss", function() {
			var ray = new UeRay(new UeVector3(-10, 20, 0), new UeVector3(1, 0, 0));
			var box = new UeBox3(new UeVector3(-5, -5, -5), new UeVector3(5, 5, 5));
			var intersection = ray.intersectBox(box);
			expect(intersection).toBe(undefined);
		});

		// Transformation
		test("applyMatrix4() transforms ray", function() {
			var ray = new UeRay(new UeVector3(0, 0, 0), new UeVector3(1, 0, 0));
			var matrix = new UeMatrix4();
			matrix.makeTranslation(5, 5, 5);
			ray.applyMatrix4(matrix);
			expect(ray.origin.equals(new UeVector3(5, 5, 5))).toBeTruthy();
		});

		// Equals
		test("equals() compares rays correctly", function() {
			var ray1 = new UeRay(new UeVector3(0, 0, 0), new UeVector3(1, 0, 0));
			var ray2 = new UeRay(new UeVector3(0, 0, 0), new UeVector3(1, 0, 0));
			var ray3 = new UeRay(new UeVector3(1, 1, 1), new UeVector3(1, 0, 0));
			expect(ray1.equals(ray2)).toBeTruthy();
			expect(ray1.equals(ray3)).toBeFalsy();
		});
	});
});
