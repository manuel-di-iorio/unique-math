//// GMTL-style test suite for UeFrustum
//suite(function() {
	//describe("UeFrustum", function() {
		//// Constructor tests
		//test("constructor creates frustum with 4 planes", function() {
			//var frustum = new UeFrustum();
			//expect(array_length(frustum.planes)).toBe(6);
			//expect(frustum.planes[0].isPlane).toBeTruthy();
		//});
//
		//// Set tests
		//test("set() updates planes", function() {
			//var frustum = new UeFrustum();
			//var p0 = new UePlane(new UeVector3(1, 0, 0), 1);
			//var p1 = new UePlane(new UeVector3(-1, 0, 0), 2);
			//var p2 = new UePlane(new UeVector3(0, 1, 0), 3);
			//var p3 = new UePlane(new UeVector3(0, -1, 0), 4);
			//var p4 = new UePlane(new UeVector3(0, 0, 1), 5);
			//var p5 = new UePlane(new UeVector3(0, 0, -1), 6);
			//
			//frustum.set(p0, p1, p2, p3, p4, p5);
			//
			//expect(frustum.planes[0].constant).toBe(1);
			//expect(frustum.planes[1].constant).toBe(2);
			//expect(frustum.planes[2].constant).toBe(3);
			//expect(frustum.planes[3].constant).toBe(4);
			//expect(frustum.planes[4].constant).toBe(5);
			//expect(frustum.planes[5].constant).toBe(6);
		//});
		//
		//// Clone and copy
		//test("clone() creates independent copy", function() {
			//var frustum1 = new UeFrustum();
			//frustum1.planes[0].constant = 10;
			//var frustum2 = frustum1.clone();
			//expect(frustum2.planes[0].constant).toBe(10);
			//frustum2.planes[0].constant = 20;
			//expect(frustum1.planes[0].constant).toBe(10);
		//});
//
		//test("copy() copies frustum values", function() {
			//var frustum1 = new UeFrustum();
			//var frustum2 = new UeFrustum();
			//frustum2.planes[0].constant = 10;
			//frustum1.copy(frustum2);
			//expect(frustum1.planes[0].constant).toBe(10);
		//});
//
		//// Intersection tests
		//test("containsPoint() returns true for point inside", function() {
			//var frustum = new UeFrustum();
			//// Setup a simple box frustum around origin
			//frustum.planes[0] = new UePlane(new UeVector3(1, 0, 0), 10);  // Left facing right
			//frustum.planes[1] = new UePlane(new UeVector3(-1, 0, 0), 10); // Right facing left
			//frustum.planes[2] = new UePlane(new UeVector3(0, 1, 0), 10);  // Bottom facing up
			//frustum.planes[3] = new UePlane(new UeVector3(0, -1, 0), 10); // Top facing down
			//
			//expect(frustum.containsPoint(new UeVector3(0, 0, 0))).toBeTruthy();
		//});
//
		//test("containsPoint() returns false for point outside", function() {
			//var frustum = new UeFrustum();
			//frustum.planes[0] = new UePlane(new UeVector3(1, 0, 0), 10);
			//
			//// Point at x = -20 is behind the plane (dist = -20*1 + 10 = -10 < 0)
			//expect(frustum.containsPoint(new UeVector3(-20, 0, 0))).toBeFalsy();
		//});
//
		//test("intersectsSphere() detects intersection", function() {
			//var frustum = new UeFrustum();
			//frustum.planes[0] = new UePlane(new UeVector3(1, 0, 0), 10);
			//frustum.planes[1] = new UePlane(new UeVector3(-1, 0, 0), 10);
			//frustum.planes[2] = new UePlane(new UeVector3(0, 1, 0), 10);
			//frustum.planes[3] = new UePlane(new UeVector3(0, -1, 0), 10);
			//
			//var sphere = new UeSphere(new UeVector3(0, 0, 0), 5);
			//expect(frustum.intersectsSphere(sphere)).toBeTruthy();
		//});
//
		//test("intersectsBox() detects intersection", function() {
			//var frustum = new UeFrustum();
			//frustum.planes[0] = new UePlane(new UeVector3(1, 0, 0), 10);
			//frustum.planes[1] = new UePlane(new UeVector3(-1, 0, 0), 10);
			//frustum.planes[2] = new UePlane(new UeVector3(0, 1, 0), 10);
			//frustum.planes[3] = new UePlane(new UeVector3(0, -1, 0), 10);
			//
			//var box = new UeBox3(new UeVector3(-5, -5, -5), new UeVector3(5, 5, 5));
			//expect(frustum.intersectsBox(box)).toBeTruthy();
		//});
	//});
//});
