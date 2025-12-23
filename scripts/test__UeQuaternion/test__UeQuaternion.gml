//// GMTL-style test suite for UeQuaternion
//suite(function() {
	//describe("UeQuaternion", function() {
		//// Constructor tests
		//test("constructor sets x, y, z correctly and calculates w from Euler", function() {
			//var q = new UeQuaternion(0, 0, 0);
			//// Identity quaternion for zero rotation
			//expect(round(q.x * 1000) / 1000).toBe(0);
			//expect(round(q.y * 1000) / 1000).toBe(0);
			//expect(round(q.z * 1000) / 1000).toBe(0);
			//expect(round(q.w * 1000) / 1000).toBe(1);
		//});
//
		//test("set() updates all components", function() {
			//var q = new UeQuaternion();
			//q.set(0.1, 0.2, 0.3, 0.4);
			//expect(q.x).toBe(0.1);
			//expect(q.y).toBe(0.2);
			//expect(q.z).toBe(0.3);
			//expect(q.w).toBe(0.4);
		//});
//
		//test("clone() creates independent copy", function() {
			//var q1 = new UeQuaternion(45, 0, 0);
			//var q2 = q1.clone();
			//expect(q1.x).toBe(q2.x);
			//expect(q1.y).toBe(q2.y);
			//expect(q1.z).toBe(q2.z);
			//expect(q1.w).toBe(q2.w);
			//// Verify independence
			//q2.set(0, 0, 0, 1);
			//expect(q1.equals(q2)).toBeFalsy();
		//});
//
		//test("copy() copies quaternion values", function() {
			//var q1 = new UeQuaternion();
			//var q2 = new UeQuaternion(45, 0, 0);
			//q1.copy(q2);
			//expect(q1.x).toBe(q2.x);
			//expect(q1.y).toBe(q2.y);
			//expect(q1.z).toBe(q2.z);
			//expect(q1.w).toBe(q2.w);
		//});
//
		//test("equals() compares quaternions with epsilon", function() {
			//var q1 = new UeQuaternion(0, 0, 0);
			//var q2 = new UeQuaternion(0, 0, 0);
			//var q3 = new UeQuaternion(45, 0, 0);
			//expect(q1.equals(q2)).toBeTruthy();
			//expect(q1.equals(q3)).toBeFalsy();
		//});
//
		//// Identity
		//test("identity() creates identity quaternion", function() {
			//var q = new UeQuaternion(45, 45, 45);
			//q.identity();
			//expect(q.x).toBe(0);
			//expect(q.y).toBe(0);
			//expect(q.z).toBe(0);
			//expect(q.w).toBe(1);
		//});
//
		//// Euler angles
		//test("setFromEuler() sets quaternion from Euler angles", function() {
			//var q = new UeQuaternion();
			//q.setFromEuler(0, 0, 0);
			//expect(round(q.x * 1000) / 1000).toBe(0);
			//expect(round(q.y * 1000) / 1000).toBe(0);
			//expect(round(q.z * 1000) / 1000).toBe(0);
			//expect(round(q.w * 1000) / 1000).toBe(1);
		//});
//
		//test("setFromEuler() with 90 degree rotation", function() {
			//var q = new UeQuaternion();
			//q.setFromEuler(0, 0, 90);
			//// 90 degree rotation around Z axis
			//expect(round(q.z * 1000) / 1000 != 0).toBeTruthy();
			//expect(round(q.w * 1000) / 1000 != 1).toBeTruthy();
		//});
//
		//// Axis-angle
		//test("setFromAxisAngle() sets quaternion from axis and angle", function() {
			//var q = new UeQuaternion();
			//var axis = new UeVector3(0, 0, 1);
			//q.setFromAxisAngle(axis, 90);
			//expect(round(q.z * 1000) / 1000 != 0).toBeTruthy();
			//expect(round(q.w * 1000) / 1000 != 1).toBeTruthy();
		//});
//
		//test("setFromAxisAngle() with zero angle creates identity", function() {
			//var q = new UeQuaternion();
			//var axis = new UeVector3(1, 0, 0);
			//q.setFromAxisAngle(axis, 0);
			//expect(round(q.x * 1000) / 1000).toBe(0);
			//expect(round(q.y * 1000) / 1000).toBe(0);
			//expect(round(q.z * 1000) / 1000).toBe(0);
			//expect(round(q.w * 1000) / 1000).toBe(1);
		//});
//
		//// Normalization
		//test("normalize() creates unit quaternion", function() {
			//var q = new UeQuaternion();
			//q.set(1, 2, 3, 4);
			//q.normalize();
			//var len = sqrt(q.x*q.x + q.y*q.y + q.z*q.z + q.w*q.w);
			//expect(round(len * 1000) / 1000).toBe(1);
		//});
//
		//test("normalize() on zero quaternion doesn't produce NaN", function() {
			//var q = new UeQuaternion();
			//q.set(0, 0, 0, 0);
			//q.normalize();
			//expect(q.x).toBe(0);
			//expect(q.y).toBe(0);
			//expect(q.z).toBe(0);
			//expect(q.w).toBe(0);
		//});
//
		//// Length operations
		//test("length() returns quaternion magnitude", function() {
			//var q = new UeQuaternion();
			//q.identity();
			//expect(q.length()).toBe(1);
		//});
//
		//test("lengthSq() returns squared length", function() {
			//var q = new UeQuaternion();
			//q.identity();
			//expect(q.lengthSq()).toBe(1);
		//});
//
		//// Dot product
		//test("dot() calculates dot product", function() {
			//var q1 = new UeQuaternion();
			//q1.identity();
			//var q2 = new UeQuaternion();
			//q2.identity();
			//expect(q1.dot(q2)).toBe(1);
		//});
//
		//// Multiplication
		//test("multiply() multiplies quaternions", function() {
			//var q1 = new UeQuaternion();
			//q1.setFromAxisAngle(new UeVector3(0, 0, 1), 45);
			//var q2 = new UeQuaternion();
			//q2.setFromAxisAngle(new UeVector3(0, 0, 1), 45);
			//q1.multiply(q2);
			//// Result should be 90 degree rotation
			//expect(round(q1.z * 1000) / 1000 != 0).toBeTruthy();
		//});
//
		//test("multiplyQuaternions() sets quaternion to product", function() {
			//var q1 = new UeQuaternion();
			//q1.setFromAxisAngle(new UeVector3(0, 0, 1), 45);
			//var q2 = new UeQuaternion();
			//q2.setFromAxisAngle(new UeVector3(0, 0, 1), 45);
			//var result = new UeQuaternion();
			//result.multiplyQuaternions(q1, q2);
			//expect(round(result.z * 1000) / 1000 != 0).toBeTruthy();
		//});
//
		//// Rotation
		//test("rotate() rotates by axis and angle", function() {
			//var q = new UeQuaternion();
			//q.identity();
			//q.rotate(new UeVector3(0, 0, 1), 90);
			//expect(round(q.z * 1000) / 1000 != 0).toBeTruthy();
		//});
//
		//test("rotateX() rotates around X axis", function() {
			//var q = new UeQuaternion();
			//q.identity();
			//q.rotateX(90);
			//expect(round(q.x * 1000) / 1000 != 0).toBeTruthy();
		//});
//
		//test("rotateY() rotates around Y axis", function() {
			//var q = new UeQuaternion();
			//q.identity();
			//q.rotateY(90);
			//expect(round(q.y * 1000) / 1000 != 0).toBeTruthy();
		//});
//
		//test("rotateZ() rotates around Z axis", function() {
			//var q = new UeQuaternion();
			//q.identity();
			//q.rotateZ(90);
			//expect(round(q.z * 1000) / 1000 != 0).toBeTruthy();
		//});
//
		//// Interpolation
		//test("slerp() interpolates between quaternions at t=0", function() {
			//var q1 = new UeQuaternion();
			//q1.setFromAxisAngle(new UeVector3(0, 0, 1), 0);
			//var q2 = new UeQuaternion();
			//q2.setFromAxisAngle(new UeVector3(0, 0, 1), 90);
			//var result = q1.clone();
			//result.slerp(q2, 0);
			//expect(result.equals(q1)).toBeTruthy();
		//});
//
		//test("slerp() interpolates between quaternions at t=1", function() {
			//var q1 = new UeQuaternion();
			//q1.setFromAxisAngle(new UeVector3(0, 0, 1), 0);
			//var q2 = new UeQuaternion();
			//q2.setFromAxisAngle(new UeVector3(0, 0, 1), 90);
			//var result = q1.clone();
			//result.slerp(q2, 1);
			//expect(result.equals(q2)).toBeTruthy();
		//});
//
		//test("slerp() interpolates between quaternions at t=0.5", function() {
			//var q1 = new UeQuaternion();
			//q1.setFromAxisAngle(new UeVector3(0, 0, 1), 0);
			//var q2 = new UeQuaternion();
			//q2.setFromAxisAngle(new UeVector3(0, 0, 1), 90);
			//var result = q1.clone();
			//result.slerp(q2, 0.5);
			//// Should be approximately 45 degrees
			//expect(result.equals(q1)).toBeFalsy();
			//expect(result.equals(q2)).toBeFalsy();
		//});
//
		//// Conjugate and invert
		//test("conjugate() negates x, y, z components", function() {
			//var q = new UeQuaternion();
			//q.set(0.1, 0.2, 0.3, 0.4);
			//q.conjugate();
			//expect(q.x).toBe(-0.1);
			//expect(q.y).toBe(-0.2);
			//expect(q.z).toBe(-0.3);
			//expect(q.w).toBe(0.4);
		//});
//
		//test("invert() inverts quaternion", function() {
			//var q = new UeQuaternion();
			//q.setFromAxisAngle(new UeVector3(0, 0, 1), 90);
			//var original = q.clone();
			//q.invert();
			//// Multiplying by inverse should give identity
			//var result = original.clone();
			//result.multiply(q);
			//expect(round(result.x * 1000) / 1000).toBe(0);
			//expect(round(result.y * 1000) / 1000).toBe(0);
			//expect(round(result.z * 1000) / 1000).toBe(0);
			//expect(round(result.w * 1000) / 1000).toBe(1);
		//});
//
		//// Matrix conversion
		//test("toMat3() creates 3x3 rotation matrix", function() {
			//var q = new UeQuaternion();
			//q.setFromAxisAngle(new UeVector3(0, 0, 1), 90);
			//var m = q.toMat3();
			//expect(m.data != undefined).toBeTruthy();
			//expect(array_length(m.data)).toBe(9);
		//});
//
		//test("setFromRotationMatrix() extracts quaternion from matrix", function() {
			//var m = new UeMatrix4();
			//m.makeRotationZ(90);
			//var q = new UeQuaternion();
			//q.setFromRotationMatrix(m);
			//expect(round(q.z * 1000) / 1000 != 0).toBeTruthy();
		//});
//
		//// Unit vectors
		//test("setFromUnitVectors() creates rotation between vectors", function() {
			//var from = new UeVector3(1, 0, 0);
			//var to = new UeVector3(0, 1, 0);
			//var q = new UeQuaternion();
			//q.setFromUnitVectors(from, to);
			//// Should create 90 degree rotation around Z
			//expect(round(q.z * 1000) / 1000 != 0).toBeTruthy();
		//});
//
		//test("setFromUnitVectors() with same vectors creates identity", function() {
			//var from = new UeVector3(1, 0, 0);
			//var to = new UeVector3(1, 0, 0);
			//var q = new UeQuaternion();
			//q.setFromUnitVectors(from, to);
			//expect(round(q.x * 1000) / 1000).toBe(0);
			//expect(round(q.y * 1000) / 1000).toBe(0);
			//expect(round(q.z * 1000) / 1000).toBe(0);
			//expect(round(q.w * 1000) / 1000).toBe(1);
		//});
//
		//test("setFromUnitVectors() with opposite vectors", function() {
			//var from = new UeVector3(1, 0, 0);
			//var to = new UeVector3(-1, 0, 0);
			//var q = new UeQuaternion();
			//q.setFromUnitVectors(from, to);
			//// Should create 180 degree rotation
			//expect(round(q.w * 1000) / 1000).toBe(0);
		//});
//
		//// Rotate towards
		//test("rotateTowards() with zero step doesn't change quaternion", function() {
			//var q1 = new UeQuaternion();
			//q1.setFromAxisAngle(new UeVector3(0, 0, 1), 0);
			//var q2 = new UeQuaternion();
			//q2.setFromAxisAngle(new UeVector3(0, 0, 1), 90);
			//var original = q1.clone();
			//q1.rotateTowards(q2, 0);
			//expect(q1.equals(original)).toBeTruthy();
		//});
//
		//test("rotateTowards() with large step reaches target", function() {
			//var q1 = new UeQuaternion();
			//q1.setFromAxisAngle(new UeVector3(0, 0, 1), 0);
			//var q2 = new UeQuaternion();
			//q2.setFromAxisAngle(new UeVector3(0, 0, 1), 90);
			//q1.rotateTowards(q2, degtorad(180));
			//expect(q1.equals(q2)).toBeTruthy();
		//});
//
		//// Array conversion
		//test("toArray() exports quaternion to array", function() {
			//var q = new UeQuaternion();
			//q.set(0.1, 0.2, 0.3, 0.4);
			//var arr = q.toArray();
			//expect(arr[0]).toBe(0.1);
			//expect(arr[1]).toBe(0.2);
			//expect(arr[2]).toBe(0.3);
			//expect(arr[3]).toBe(0.4);
		//});
	//});
//});
