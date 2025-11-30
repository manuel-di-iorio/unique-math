// GMTL-style test suite for UeMatrix3
suite(function() {
	describe("UeMatrix3", function() {
		// Constructor and identity tests
		test("constructor creates identity matrix by default", function() {
			var m = new UeMatrix3();
			var identity = [1, 0, 0, 0, 1, 0, 0, 0, 1];
			for (var i = 0; i < 9; i++) {
				expect(m.data[i]).toBe(identity[i]);
			}
		});

		test("constructor accepts custom data array", function() {
			var customData = [1, 2, 3, 4, 5, 6, 7, 8, 9];
			var m = new UeMatrix3(customData);
			for (var i = 0; i < 9; i++) {
				expect(m.data[i]).toBe(customData[i]);
			}
		});

		test("clone() creates independent copy", function() {
			var m1 = new UeMatrix3([1, 2, 3, 4, 5, 6, 7, 8, 9]);
			var m2 = m1.clone();
			expect(m1.equals(m2)).toBeTruthy();
			// Verify independence
			m2.data[0] = 99;
			expect(m1.data[0]).toBe(1);
		});

		test("copy() copies matrix values", function() {
			var m1 = new UeMatrix3();
			var m2 = new UeMatrix3([1, 2, 3, 4, 5, 6, 7, 8, 9]);
			m1.copy(m2);
			expect(m1.equals(m2)).toBeTruthy();
		});

		test("equals() compares matrices correctly", function() {
			var m1 = new UeMatrix3([1, 2, 3, 4, 5, 6, 7, 8, 9]);
			var m2 = new UeMatrix3([1, 2, 3, 4, 5, 6, 7, 8, 9]);
			var m3 = new UeMatrix3([1, 2, 3, 4, 5, 6, 7, 8, 0]);
			expect(m1.equals(m2)).toBeTruthy();
			expect(m1.equals(m3)).toBeFalsy();
		});

		// Identity and reset
		test("identity() resets matrix to identity", function() {
			var m = new UeMatrix3([1, 2, 3, 4, 5, 6, 7, 8, 9]);
			m.identity();
			var identity = [1, 0, 0, 0, 1, 0, 0, 0, 1];
			for (var i = 0; i < 9; i++) {
				expect(m.data[i]).toBe(identity[i]);
			}
		});

		// Basis extraction
		test("extractBasis() extracts column vectors", function() {
			var m = new UeMatrix3([1, 2, 3, 4, 5, 6, 7, 8, 9]);
			var xAxis = new UeVector3();
			var yAxis = new UeVector3();
			var zAxis = new UeVector3();
			m.extractBasis(xAxis, yAxis, zAxis);
			expect(xAxis.equals(new UeVector3(1, 2, 3))).toBeTruthy();
			expect(yAxis.equals(new UeVector3(4, 5, 6))).toBeTruthy();
			expect(zAxis.equals(new UeVector3(7, 8, 9))).toBeTruthy();
		});

		// Determinant
		test("determinant() calculates determinant of identity", function() {
			var m = new UeMatrix3();
			expect(m.determinant()).toBe(1);
		});

		test("determinant() calculates determinant correctly", function() {
			var m = new UeMatrix3([1, 0, 0, 0, 2, 0, 0, 0, 3]);
			expect(m.determinant()).toBe(6); // 1*2*3 = 6
		});

		// Inversion
		test("invert() inverts identity matrix", function() {
			var m = new UeMatrix3();
			m.invert();
			var identity = [1, 0, 0, 0, 1, 0, 0, 0, 1];
			for (var i = 0; i < 9; i++) {
				expect(round(m.data[i] * 1000) / 1000).toBe(identity[i]);
			}
		});

		test("invert() inverts scaling matrix", function() {
			var m = new UeMatrix3([2, 0, 0, 0, 3, 0, 0, 0, 4]);
			m.invert();
			expect(round(m.data[0] * 1000) / 1000).toBe(0.5);
			expect(round(m.data[4] * 1000) / 1000).toBe(round(1/3 * 1000) / 1000);
			expect(round(m.data[8] * 1000) / 1000).toBe(0.25);
		});

		test("invert() on singular matrix produces zero matrix", function() {
			var m = new UeMatrix3([1, 2, 3, 2, 4, 6, 3, 6, 9]);
			m.invert();
			for (var i = 0; i < 9; i++) {
				expect(m.data[i]).toBe(0);
			}
		});

		// Rotation
		test("makeRotation() creates rotation matrix for 0 degrees", function() {
			var m = new UeMatrix3();
			m.makeRotation(0);
			var identity = [1, 0, 0, 0, 1, 0, 0, 0, 1];
			for (var i = 0; i < 9; i++) {
				expect(round(m.data[i] * 1000) / 1000).toBe(identity[i]);
			}
		});

		test("makeRotation() creates rotation matrix for 90 degrees", function() {
			var m = new UeMatrix3();
			m.makeRotation(degtorad(90));
			expect(round(m.data[0] * 1000) / 1000).toBe(0);
			expect(round(m.data[1] * 1000) / 1000).toBe(1);
			expect(round(m.data[3] * 1000) / 1000).toBe(-1);
			expect(round(m.data[4] * 1000) / 1000).toBe(0);
		});

		test("rotate() applies rotation to existing matrix", function() {
			var m = new UeMatrix3();
			m.rotate(degtorad(90));
			expect(round(m.data[0] * 1000) / 1000).toBe(0);
			expect(round(m.data[1] * 1000) / 1000).toBe(1);
		});

		// Scaling
		test("scale() applies scaling to matrix", function() {
			var m = new UeMatrix3();
			m.scale(2, 3);
			expect(m.data[0]).toBe(2);
			expect(m.data[4]).toBe(3);
		});

		test("makeScale() creates scaling matrix", function() {
			var m = new UeMatrix3();
			m.makeScale(2, 3);
			expect(m.data[0]).toBe(2);
			expect(m.data[4]).toBe(3);
			expect(m.data[8]).toBe(1);
		});

		// Translation (2D affine)
		test("makeTranslation() creates translation matrix", function() {
			var m = new UeMatrix3();
			m.makeTranslation(5, 7);
			expect(m.data[6]).toBe(5);
			expect(m.data[7]).toBe(7);
		});

		// Matrix multiplication
		test("multiply() multiplies matrices correctly", function() {
			var m1 = new UeMatrix3();
			m1.makeScale(2, 3);
			var m2 = new UeMatrix3();
			m2.makeTranslation(5, 7);
			m1.multiply(m2);
			// Result should have scaling and translation
			expect(m1.data[0]).toBe(2);
			expect(m1.data[4]).toBe(3);
		});

		test("multiplyMatrices() sets matrix to product of two matrices", function() {
			var m1 = new UeMatrix3();
			m1.makeScale(2, 3);
			var m2 = new UeMatrix3();
			m2.makeTranslation(5, 7);
			var result = new UeMatrix3();
			result.multiplyMatrices(m1, m2);
			expect(result.data[0]).toBe(2);
			expect(result.data[4]).toBe(3);
		});

		test("premultiply() multiplies from the left", function() {
			var m1 = new UeMatrix3();
			m1.makeScale(2, 3);
			var m2 = new UeMatrix3();
			m2.makeTranslation(5, 7);
			m2.premultiply(m1);
			// m2 = m1 * m2
			expect(m2.data[0]).toBe(2);
		});

		// Transpose
		test("transpose() transposes matrix", function() {
			var m = new UeMatrix3([1, 2, 3, 4, 5, 6, 7, 8, 9]);
			m.transpose();
			var expected = [1, 4, 7, 2, 5, 8, 3, 6, 9];
			for (var i = 0; i < 9; i++) {
				expect(m.data[i]).toBe(expected[i]);
			}
		});

		test("transposeIntoArray() writes transposed matrix to array", function() {
			var m = new UeMatrix3([1, 2, 3, 4, 5, 6, 7, 8, 9]);
			var arr = [];
			m.transposeIntoArray(arr);
			var expected = [1, 4, 7, 2, 5, 8, 3, 6, 9];
			for (var i = 0; i < 9; i++) {
				expect(arr[i]).toBe(expected[i]);
			}
		});

		// Array operations
		test("fromArray() sets matrix from array", function() {
			var m = new UeMatrix3();
			var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9];
			m.fromArray(arr);
			for (var i = 0; i < 9; i++) {
				expect(m.data[i]).toBe(arr[i]);
			}
		});

		test("fromArray() with offset", function() {
			var m = new UeMatrix3();
			var arr = [0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
			m.fromArray(arr, 2);
			for (var i = 0; i < 9; i++) {
				expect(m.data[i]).toBe(arr[i + 2]);
			}
		});

		// Matrix4 conversion
		test("setFromMatrix4() extracts 3x3 from 4x4 matrix", function() {
			var m4 = new UeMatrix4();
			m4.makeScale(2, 3, 4);
			var m3 = new UeMatrix3();
			m3.setFromMatrix4(m4);
			expect(m3.data[0]).toBe(2);
			expect(m3.data[4]).toBe(3);
			expect(m3.data[8]).toBe(4);
		});

		test("getNormalMatrix() computes normal matrix from Matrix4", function() {
			var m4 = new UeMatrix4();
			m4.makeScale(2, 2, 2);
			var m3 = new UeMatrix3();
			m3.getNormalMatrix(m4);
			// Normal matrix should be inverse transpose of upper 3x3
			expect(round(m3.data[0] * 1000) / 1000).toBe(0.5);
			expect(round(m3.data[4] * 1000) / 1000).toBe(0.5);
			expect(round(m3.data[8] * 1000) / 1000).toBe(0.5);
		});

		// UV Transform
		test("setUvTransform() creates UV transformation matrix", function() {
			var m = new UeMatrix3();
			m.setUvTransform(0, 0, 1, 1, 0, 0, 0);
			// With no transformation, should be identity
			expect(round(m.data[0] * 1000) / 1000).toBe(1);
			expect(round(m.data[4] * 1000) / 1000).toBe(1);
		});

		test("setUvTransform() with scale", function() {
			var m = new UeMatrix3();
			m.setUvTransform(0, 0, 2, 3, 0, 0, 0);
			expect(round(m.data[0] * 1000) / 1000).toBe(2);
			expect(round(m.data[4] * 1000) / 1000).toBe(3);
		});
	});
});
