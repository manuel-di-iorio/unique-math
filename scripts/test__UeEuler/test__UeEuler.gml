// GMTL-style test suite for UeEuler
suite(function() {
	describe("UeEuler", function() {
		// Constructor tests
		test("constructor sets x, y, z, order correctly", function() {
			var euler = new UeEuler(10, 20, 30, "XYZ");
			expect(euler.x).toBe(10);
			expect(euler.y).toBe(20);
			expect(euler.z).toBe(30);
			expect(euler.order).toBe("XYZ");
		});

		test("constructor with default values creates zero rotation", function() {
			var euler = new UeEuler();
			expect(euler.x).toBe(0);
			expect(euler.y).toBe(0);
			expect(euler.z).toBe(0);
			expect(euler.order).toBe("XYZ");
		});

		test("isEuler property is true", function() {
			var euler = new UeEuler();
			expect(euler.isEuler).toBeTruthy();
		});

		// Set and copy
		test("set() updates all components", function() {
			var euler = new UeEuler();
			euler.set(45, 90, 180, "ZYX");
			expect(euler.x).toBe(45);
			expect(euler.y).toBe(90);
			expect(euler.z).toBe(180);
			expect(euler.order).toBe("ZYX");
		});

		test("clone() creates independent copy", function() {
			var euler1 = new UeEuler(10, 20, 30, "XYZ");
			var euler2 = euler1.clone();
			expect(euler1.equals(euler2)).toBeTruthy();
			euler2.set(40, 50, 60, "ZYX");
			expect(euler1.x).toBe(10);
		});

		test("copy() copies euler values", function() {
			var euler1 = new UeEuler();
			var euler2 = new UeEuler(10, 20, 30, "XYZ");
			euler1.copy(euler2);
			expect(euler1.equals(euler2)).toBeTruthy();
		});

		// Equals
		test("equals() compares euler angles correctly", function() {
			var euler1 = new UeEuler(10, 20, 30, "XYZ");
			var euler2 = new UeEuler(10, 20, 30, "XYZ");
			var euler3 = new UeEuler(10, 20, 30, "ZYX");
			expect(euler1.equals(euler2)).toBeTruthy();
			expect(euler1.equals(euler3)).toBeFalsy();
		});

		// Array operations
		test("fromArray() sets euler from array", function() {
			var euler = new UeEuler();
			euler.fromArray([45, 90, 180, "ZYX"]);
			expect(euler.x).toBe(45);
			expect(euler.y).toBe(90);
			expect(euler.z).toBe(180);
			expect(euler.order).toBe("ZYX");
		});

		test("fromArray() without order keeps current order", function() {
			var euler = new UeEuler(0, 0, 0, "XYZ");
			euler.fromArray([45, 90, 180]);
			expect(euler.x).toBe(45);
			expect(euler.y).toBe(90);
			expect(euler.z).toBe(180);
			expect(euler.order).toBe("XYZ");
		});

		test("toArray() exports euler to array", function() {
			var euler = new UeEuler(45, 90, 180, "ZYX");
			var arr = euler.toArray();
			expect(arr[0]).toBe(45);
			expect(arr[1]).toBe(90);
			expect(arr[2]).toBe(180);
			expect(arr[3]).toBe("ZYX");
		});

		test("toArray() with offset", function() {
			var euler = new UeEuler(45, 90, 180, "ZYX");
			var arr = array_create(6, 0);
			euler.toArray(arr, 2);
			expect(arr[2]).toBe(45);
			expect(arr[3]).toBe(90);
			expect(arr[4]).toBe(180);
			expect(arr[5]).toBe("ZYX");
		});

		// Vector3 conversion
		test("setFromVector3() sets from vector", function() {
			var euler = new UeEuler();
			var vec = new UeVector3(45, 90, 180);
			euler.setFromVector3(vec);
			expect(euler.x).toBe(45);
			expect(euler.y).toBe(90);
			expect(euler.z).toBe(180);
		});

		test("setFromVector3() with order", function() {
			var euler = new UeEuler();
			var vec = new UeVector3(45, 90, 180);
			euler.setFromVector3(vec, "ZYX");
			expect(euler.x).toBe(45);
			expect(euler.y).toBe(90);
			expect(euler.z).toBe(180);
		});

		// Quaternion conversion
		test("setFromQuaternion() sets from quaternion", function() {
			var q = new UeQuaternion();
			q.setFromAxisAngle(new UeVector3(0, 0, 1), 90);
			var euler = new UeEuler();
			euler.setFromQuaternion(q);
			// Should create rotation around Z
			expect(euler.z != 0).toBeTruthy();
		});

		test("setFromQuaternion() with custom order", function() {
			var q = new UeQuaternion();
			q.setFromAxisAngle(new UeVector3(0, 0, 1), 90);
			var euler = new UeEuler();
			euler.setFromQuaternion(q, "ZYX");
			expect(euler.order).toBe("ZYX");
		});

		// Matrix conversion
		test("setFromRotationMatrix() sets from matrix", function() {
			var m = new UeMatrix4();
			m.makeRotationZ(90);
			var euler = new UeEuler();
			euler.setFromRotationMatrix(m, "XYZ");
			// Should create rotation around Z
			expect(euler.z != 0).toBeTruthy();
		});

		test("setFromRotationMatrix() with different orders", function() {
			var m = new UeMatrix4();
			m.makeRotationZ(90);
			var euler1 = new UeEuler();
			euler1.setFromRotationMatrix(m, "XYZ");
			var euler2 = new UeEuler();
			euler2.setFromRotationMatrix(m, "ZYX");
			expect(euler1.order).toBe("XYZ");
			expect(euler2.order).toBe("ZYX");
		});

		// Reorder
		test("reorder() changes rotation order", function() {
			var euler = new UeEuler(45, 90, 180, "XYZ");
			euler.reorder("ZYX");
			expect(euler.order).toBe("ZYX");
		});

		test("reorder() preserves rotation", function() {
			var euler1 = new UeEuler(45, 0, 0, "XYZ");
			var q1 = new UeQuaternion();
			q1.setFromEuler(euler1.x, euler1.y, euler1.z);
			
			var euler2 = euler1.clone();
			euler2.reorder("ZYX");
			var q2 = new UeQuaternion();
			q2.setFromEuler(euler2.x, euler2.y, euler2.z);
			
			// Quaternions should be approximately equal
			expect(round(q1.w * 1000) / 1000).toBe(round(q2.w * 1000) / 1000);
		});
	});
});
