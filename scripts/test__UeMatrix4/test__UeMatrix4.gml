// GMTL-style test suite for UeMatrix4
suite(function() {
	describe("UeMatrix4", function() {
		// Constructor and identity tests
		test("constructor creates identity matrix by default", function() {
			var m = new UeMatrix4();
			var identity = matrix_build_identity();
			for (var i = 0; i < 16; i++) {
				expect(m.data[i]).toBe(identity[i]);
			}
		});

		test("constructor accepts custom data array", function() {
			var customData = [];
			for (var i = 0; i < 16; i++) customData[i] = i;
			var m = new UeMatrix4(customData);
			for (var i = 0; i < 16; i++) {
				expect(m.data[i]).toBe(customData[i]);
			}
		});

		test("clone() creates independent copy", function() {
			var customData = [];
			for (var i = 0; i < 16; i++) customData[i] = i;
			var m1 = new UeMatrix4(customData);
			var m2 = m1.clone();
			expect(m1.equals(m2)).toBeTruthy();
			// Verify independence
			m2.data[0] = 99;
			expect(m1.data[0]).toBe(0);
		});

		test("copy() copies matrix values", function() {
			var m1 = new UeMatrix4();
			var customData = [];
			for (var i = 0; i < 16; i++) customData[i] = i;
			var m2 = new UeMatrix4(customData);
			m1.copy(m2);
			expect(m1.equals(m2)).toBeTruthy();
		});

		test("equals() compares matrices correctly", function() {
			var m1 = new UeMatrix4();
			var m2 = new UeMatrix4();
			var m3 = new UeMatrix4();
			m3.data[0] = 99;
			expect(m1.equals(m2)).toBeTruthy();
			expect(m1.equals(m3)).toBeFalsy();
		});

		// Identity
		test("identity() resets matrix to identity", function() {
			var m = new UeMatrix4();
			m.data[0] = 99;
			m.identity();
			var identity = matrix_build_identity();
			for (var i = 0; i < 16; i++) {
				expect(m.data[i]).toBe(identity[i]);
			}
		});

		// Basis extraction
		test("extractBasis() extracts column vectors", function() {
			var m = new UeMatrix4();
			m.makeScale(2, 3, 4);
			var xAxis = new UeVector3();
			var yAxis = new UeVector3();
			var zAxis = new UeVector3();
			m.extractBasis(xAxis, yAxis, zAxis);
			expect(xAxis.equals(new UeVector3(2, 0, 0))).toBeTruthy();
			expect(yAxis.equals(new UeVector3(0, 3, 0))).toBeTruthy();
			expect(zAxis.equals(new UeVector3(0, 0, 4))).toBeTruthy();
		});

		// Determinant
		test("determinant() of identity matrix is 1", function() {
			var m = new UeMatrix4();
			expect(round(m.determinant() * 1000) / 1000).toBe(1);
		});

		test("determinant() of scaling matrix", function() {
			var m = new UeMatrix4();
			m.makeScale(2, 3, 4);
			expect(round(m.determinant() * 1000) / 1000).toBe(24); // 2*3*4 = 24
		});

		// Position operations
		test("copyPosition() copies translation component", function() {
			var m1 = new UeMatrix4();
			var m2 = new UeMatrix4();
			m2.makeTranslation(5, 7, 9);
			m1.copyPosition(m2);
			expect(m1.data[12]).toBe(5);
			expect(m1.data[13]).toBe(7);
			expect(m1.data[14]).toBe(9);
		});

		// Scaling
		test("makeScale() creates scaling matrix", function() {
			var m = new UeMatrix4();
			m.makeScale(2, 3, 4);
			expect(m.data[0]).toBe(2);
			expect(m.data[5]).toBe(3);
			expect(m.data[10]).toBe(4);
		});

		test("scale() applies scaling to existing matrix", function() {
			var m = new UeMatrix4();
			m.scaleXYZ(2, 3, 4);
			expect(m.data[0]).toBe(2);
			expect(m.data[5]).toBe(3);
			expect(m.data[10]).toBe(4);
		});

		test("getMaxScaleOnAxis() returns maximum scale", function() {
			var m = new UeMatrix4();
			m.makeScale(2, 5, 3);
			expect(m.getMaxScaleOnAxis()).toBe(5);
		});

		test("scale() with Vector3 applies scaling", function() {
			var m = new UeMatrix4();
			var scaleVec = new UeVector3(2, 3, 4);
			m.scale(scaleVec);
			expect(m.data[0]).toBe(2);
			expect(m.data[5]).toBe(3);
			expect(m.data[10]).toBe(4);
		});


		// Translation
		test("makeTranslation() creates translation matrix", function() {
			var m = new UeMatrix4();
			m.makeTranslation(5, 7, 9);
			expect(m.data[12]).toBe(5);
			expect(m.data[13]).toBe(7);
			expect(m.data[14]).toBe(9);
		});

		// Rotation - Axis angle
		test("makeRotationAxis() creates rotation around axis", function() {
			var m = new UeMatrix4();
			var axis = new UeVector3(0, 1, 0);
			m.makeRotationAxis(axis, 90);
			// Rotating 90 degrees around Y axis
			expect(round(m.data[0] * 1000) / 1000).toBe(0);
			expect(round(m.data[10] * 1000) / 1000).toBe(0);
		});

		// Rotation - Individual axes
		test("makeRotationX() creates rotation around X axis", function() {
			var m = new UeMatrix4();
			m.makeRotationX(90);
			expect(round(m.data[0] * 1000) / 1000).toBe(1);
			expect(round(m.data[5] * 1000) / 1000).toBe(0);
			expect(round(m.data[6] * 1000) / 1000).toBe(1);
		});

		test("makeRotationY() creates rotation around Y axis", function() {
			var m = new UeMatrix4();
			m.makeRotationY(90);
			expect(round(m.data[0] * 1000) / 1000).toBe(0);
			expect(round(m.data[5] * 1000) / 1000).toBe(1);
			expect(round(m.data[10] * 1000) / 1000).toBe(0);
		});

		test("makeRotationZ() creates rotation around Z axis", function() {
			var m = new UeMatrix4();
			m.makeRotationZ(90);
			expect(round(m.data[0] * 1000) / 1000).toBe(0);
			expect(round(m.data[1] * 1000) / 1000).toBe(1);
			expect(round(m.data[4] * 1000) / 1000).toBe(-1);
		});

		// Rotation - Euler
		test("makeRotationFromEuler() creates rotation from Euler angles", function() {
			var m = new UeMatrix4();
			m.makeRotationFromEuler(0, 0, 0);
			// Should be identity
			var identity = matrix_build_identity();
			for (var i = 0; i < 16; i++) {
				expect(round(m.data[i] * 1000) / 1000).toBe(round(identity[i] * 1000) / 1000);
			}
		});

		test("makeRotationFromEuler() with 90 degree Z rotation", function() {
			var m = new UeMatrix4();
			m.makeRotationFromEuler(0, 0, 90);
			expect(round(m.data[0] * 1000) / 1000).toBe(0);
			expect(round(m.data[1] * 1000) / 1000).toBe(-1);
			expect(round(m.data[4] * 1000) / 1000).toBe(1);
			expect(round(m.data[5] * 1000) / 1000).toBe(0);
		});

		// Rotation - Quaternion
		test("makeRotationFromQuaternion() creates rotation from quaternion", function() {
			var q = new UeQuaternion();
			q.setFromAxisAngle(new UeVector3(0, 1, 0), 90);
			var m = new UeMatrix4();
			m.makeRotationFromQuaternion(q);
			expect(round(m.data[0] * 1000) / 1000).toBe(0);
			expect(round(m.data[10] * 1000) / 1000).toBe(0);
		});

		// Basis
		test("makeBasis() creates matrix from basis vectors", function() {
			var xAxis = new UeVector3(1, 0, 0);
			var yAxis = new UeVector3(0, 1, 0);
			var zAxis = new UeVector3(0, 0, 1);
			var m = new UeMatrix4();
			m.makeBasis(xAxis, yAxis, zAxis);
			expect(m.data[0]).toBe(1);
			expect(m.data[5]).toBe(1);
			expect(m.data[10]).toBe(1);
		});

		// Compose and decompose
		test("compose() builds matrix from position, rotation, scale", function() {
			var pos = new UeVector3(5, 7, 9);
			var rot = new UeQuaternion();
			var scl = new UeVector3(2, 3, 4);
			var m = new UeMatrix4();
			m.compose(pos, rot, scl);
			expect(m.data[12]).toBe(5);
			expect(m.data[13]).toBe(7);
			expect(m.data[14]).toBe(9);
		});

		test("decompose() extracts position, rotation, scale", function() {
			var pos = new UeVector3(5, 7, 9);
			var rot = new UeQuaternion();
			var scl = new UeVector3(2, 3, 4);
			var m = new UeMatrix4();
			m.compose(pos, rot, scl);
			
			var outPos = new UeVector3();
			var outRot = new UeQuaternion();
			var outScl = new UeVector3();
			m.decompose(outPos, outRot, outScl);
			
			expect(round(outPos.x * 1000) / 1000).toBe(5);
			expect(round(outPos.y * 1000) / 1000).toBe(7);
			expect(round(outPos.z * 1000) / 1000).toBe(9);
			expect(round(outScl.x * 1000) / 1000).toBe(2);
			expect(round(outScl.y * 1000) / 1000).toBe(3);
			expect(round(outScl.z * 1000) / 1000).toBe(4);
		});

		// Matrix multiplication
		test("multiply() multiplies matrices", function() {
			var m1 = new UeMatrix4();
			m1.makeScale(2, 3, 4);
			var m2 = new UeMatrix4();
			m2.makeTranslation(5, 7, 9);
			m1.multiply(m2);
			// Should have both scale and translation
			expect(m1.data[0]).toBe(2);
			expect(m1.data[5]).toBe(3);
		});

		test("multiplyMatrices() sets matrix to product", function() {
			var m1 = new UeMatrix4();
			m1.makeScale(2, 3, 4);
			var m2 = new UeMatrix4();
			m2.makeTranslation(5, 7, 9);
			var result = new UeMatrix4();
			result.multiplyMatrices(m1, m2);
			expect(result.data[0]).toBe(2);
			expect(result.data[5]).toBe(3);
		});

		test("premultiply() multiplies from the left", function() {
			var m1 = new UeMatrix4();
			m1.makeScale(2, 3, 4);
			var m2 = new UeMatrix4();
			m2.makeTranslation(5, 7, 9);
			m2.premultiply(m1);
			expect(m2.data[0]).toBe(2);
		});

		test("multiplyScalar() scales all elements", function() {
			var m = new UeMatrix4();
			m.makeScale(2, 3, 4);
			m.multiplyScalar(2);
			expect(m.data[0]).toBe(4);
			expect(m.data[5]).toBe(6);
			expect(m.data[10]).toBe(8);
		});

		// Inversion
		test("invert() inverts identity matrix", function() {
			var m = new UeMatrix4();
			m.invert();
			var identity = matrix_build_identity();
			for (var i = 0; i < 16; i++) {
				expect(round(m.data[i] * 1000) / 1000).toBe(round(identity[i] * 1000) / 1000);
			}
		});

		test("invert() inverts scaling matrix", function() {
			var m = new UeMatrix4();
			m.makeScale(2, 4, 8);
			m.invert();
			expect(round(m.data[0] * 1000) / 1000).toBe(0.5);
			expect(round(m.data[5] * 1000) / 1000).toBe(0.25);
			expect(round(m.data[10] * 1000) / 1000).toBe(0.125);
		});

		// Transpose
		test("transpose() transposes matrix", function() {
			var m = new UeMatrix4();
			m.set(
				1, 2, 3, 4,
				5, 6, 7, 8,
				9, 10, 11, 12,
				13, 14, 15, 16
			);
			var original = [];
			for (var i = 0; i < 16; i++) original[i] = m.data[i];
			m.transpose();
			// Check that row-major becomes column-major
			expect(m.data[1]).toBe(original[4]);
			expect(m.data[4]).toBe(original[1]);
		});

		// Set method
		test("set() sets matrix values in row-major order", function() {
			var m = new UeMatrix4();
			m.set(
				1, 0, 0, 0,
				0, 1, 0, 0,
				0, 0, 1, 0,
				5, 7, 9, 1
			);
			expect(m.data[3]).toBe(5);
			expect(m.data[7]).toBe(7);
			expect(m.data[11]).toBe(9);
		});

		// Projection matrices
		test("makePerspective() creates perspective projection", function() {
			var m = new UeMatrix4();
			m.makePerspective(60, 800/600, 0.1, 1000);
			// Just verify it doesn't crash and produces non-zero values
			expect(m.data[0] != 0).toBeTruthy();
		});

		test("makeOrthographic() creates orthographic projection", function() {
			var m = new UeMatrix4();
			m.makeOrthographic(-10, 10, 10, -10, 0.1, 1000);
			// Verify it produces reasonable values
			expect(m.data[0] != 0).toBeTruthy();
			expect(m.data[5] != 0).toBeTruthy();
		});

		// LookAt
		test("lookAt() creates view matrix", function() {
			var m = new UeMatrix4();
			var eye = new UeVector3(0, 0, 10);
			var target = new UeVector3(0, 0, 0);
			var up = new UeVector3(0, 1, 0);
			m.lookAt(eye, target, up);
			// Should produce a valid transformation
			expect(m.data[15]).toBe(1);
		});

		// Vector transformation
		test("applyToVector3() transforms a vector", function() {
			var m = new UeMatrix4();
			m.makeScale(2, 3, 4);
			var v = new UeVector3(1, 1, 1);
			m.applyToVector3(v);
			expect(v.x).toBe(2);
			expect(v.y).toBe(3);
			expect(v.z).toBe(4);
		});

		// Shear
		test("makeShear() creates shear matrix", function() {
			var m = new UeMatrix4();
			m.makeShear(0, 0, 0, 0, 0, 0);
			// With zero shear, should be identity
			var identity = matrix_build_identity();
			for (var i = 0; i < 16; i++) {
				expect(m.data[i]).toBe(identity[i]);
			}
		});

		test("makeShear() with non-zero values", function() {
			var m = new UeMatrix4();
			m.makeShear(1, 0, 0, 0, 0, 0);
			expect(m.data[4]).toBe(1);
		});
	});
});
