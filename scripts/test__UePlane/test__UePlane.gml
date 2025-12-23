//// GMTL-style test suite for UePlane
//suite(function() {
	//describe("UePlane", function() {
		//// Constructor tests
		//test("constructor creates plane with default up normal", function() {
			//var plane = new UePlane();
			//expect(plane.isPlane).toBeTruthy();
			//expect(plane.constant).toBe(0);
		//});
//
		//test("constructor with normal and constant", function() {
			//var normal = new UeVector3(0, 1, 0);
			//var plane = new UePlane(normal, 5);
			//expect(plane.normal.equals(normal)).toBeTruthy();
			//expect(plane.constant).toBe(5);
		//});
//
		//// Set operations
		//test("set() updates normal and constant", function() {
			//var plane = new UePlane();
			//var normal = new UeVector3(1, 0, 0);
			//plane.set(normal, 10);
			//expect(plane.normal.equals(normal)).toBeTruthy();
			//expect(plane.constant).toBe(10);
		//});
//
		//test("setComponents() sets from components", function() {
			//var plane = new UePlane();
			//plane.setComponents(1, 0, 0, 5);
			//expect(plane.normal.equals(new UeVector3(1, 0, 0))).toBeTruthy();
			//expect(plane.constant).toBe(5);
		//});
//
		//test("setFromNormalAndPoint() creates plane", function() {
			//var plane = new UePlane();
			//var normal = new UeVector3(0, 1, 0);
			//var point = new UeVector3(0, 5, 0);
			//plane.setFromNormalAndPoint(normal, point);
			//expect(plane.distanceToPoint(point)).toBe(0);
		//});
//
		//test("setFromPoints() creates plane from three points", function() {
			//var plane = new UePlane();
			//var p1 = new UeVector3(0, 0, 0);
			//var p2 = new UeVector3(10, 0, 0);
			//var p3 = new UeVector3(0, 10, 0);
			//plane.setFromPoints(p1, p2, p3);
			//expect(abs(plane.distanceToPoint(p1)) < 0.0001).toBeTruthy();
		//});
//
		//// Clone and copy
		//test("clone() creates independent copy", function() {
			//var plane1 = new UePlane(new UeVector3(0, 1, 0), 5);
			//var plane2 = plane1.clone();
			//expect(plane1.equals(plane2)).toBeTruthy();
			//plane2.constant = 10;
			//expect(plane1.constant).toBe(5);
		//});
//
		//test("copy() copies plane values", function() {
			//var plane1 = new UePlane();
			//var plane2 = new UePlane(new UeVector3(0, 1, 0), 5);
			//plane1.copy(plane2);
			//expect(plane1.equals(plane2)).toBeTruthy();
		//});
//
		//// Distance tests
		//test("distanceToPoint() returns signed distance", function() {
			//var plane = new UePlane(new UeVector3(0, 1, 0), 0);
			//expect(plane.distanceToPoint(new UeVector3(0, 5, 0))).toBe(5);
			//expect(plane.distanceToPoint(new UeVector3(0, -5, 0))).toBe(-5);
		//});
//
		//test("distanceToSphere() returns distance to sphere", function() {
			//var plane = new UePlane(new UeVector3(0, 1, 0), 0);
			//var sphere = new UeSphere(new UeVector3(0, 10, 0), 3);
			//expect(plane.distanceToSphere(sphere)).toBe(7);
		//});
//
		//// Point tests
		//test("isPointOnPlane() detects point on plane", function() {
			//var plane = new UePlane(new UeVector3(0, 1, 0), 0);
			//expect(plane.isPointOnPlane(new UeVector3(5, 0, 5))).toBeTruthy();
			//expect(plane.isPointOnPlane(new UeVector3(0, 5, 0))).toBeFalsy();
		//});
//
		//test("projectPoint() projects point onto plane", function() {
			//var plane = new UePlane(new UeVector3(0, 1, 0), 0);
			//var projected = plane.projectPoint(new UeVector3(5, 10, 5));
			//expect(projected.equals(new UeVector3(5, 0, 5))).toBeTruthy();
		//});
//
		//test("coplanarPoint() returns point on plane", function() {
			//var plane = new UePlane(new UeVector3(0, 1, 0), -5);
			//var point = plane.coplanarPoint();
			//expect(abs(plane.distanceToPoint(point)) < 0.0001).toBeTruthy();
		//});
//
		//// Intersection tests
		//test("intersectsSphere() detects sphere intersection", function() {
			//var plane = new UePlane(new UeVector3(0, 1, 0), 0);
			//var sphere1 = new UeSphere(new UeVector3(0, 2, 0), 5);
			//var sphere2 = new UeSphere(new UeVector3(0, 10, 0), 2);
			//expect(plane.intersectsSphere(sphere1)).toBeTruthy();
			//expect(plane.intersectsSphere(sphere2)).toBeFalsy();
		//});
//
		//// Transformations
		//test("normalize() normalizes the plane", function() {
			//var plane = new UePlane(new UeVector3(0, 2, 0), 10);
			//plane.normalize();
			//expect(round(plane.normal.length() * 1000) / 1000).toBe(1);
		//});
//
		//test("negate() flips the plane", function() {
			//var plane = new UePlane(new UeVector3(0, 1, 0), 5);
			//plane.negate();
			//expect(plane.normal.equals(new UeVector3(0, -1, 0))).toBeTruthy();
			//expect(plane.constant).toBe(-5);
		//});
//
		//test("translate() moves the plane", function() {
			//var plane = new UePlane(new UeVector3(0, 1, 0), 0);
			//plane.translate(new UeVector3(0, 5, 0));
			//expect(plane.constant).toBe(-5);
		//});
//
		//// Equals
		//test("equals() compares planes correctly", function() {
			//var plane1 = new UePlane(new UeVector3(0, 1, 0), 5);
			//var plane2 = new UePlane(new UeVector3(0, 1, 0), 5);
			//var plane3 = new UePlane(new UeVector3(0, 1, 0), 10);
			//expect(plane1.equals(plane2)).toBeTruthy();
			//expect(plane1.equals(plane3)).toBeFalsy();
		//});
	//});
//});
