// GMTL-style test suite for UeTransform
suite(function() {
	describe("UeTransform", function() {
		// Constructor tests
		test("constructor creates default transform", function() {
			var t = new UeTransform();
			expect(t.position.equals(new UeVector3(0, 0, 0))).toBeTruthy();
			expect(t.rotation.x).toBe(0);
			expect(t.rotation.y).toBe(0);
			expect(t.rotation.z).toBe(0);
			expect(t.rotation.w).toBe(1);
			expect(t.scale.equals(new UeVector3(1, 1, 1))).toBeTruthy();
		});

		test("constructor with data", function() {
			var t = new UeTransform({ x: 1, y: 2, z: 3 });
			expect(t.position.equals(new UeVector3(1, 2, 3))).toBeTruthy();
		});

		// Matrix updates
		test("updateMatrix() updates local matrix", function() {
			var t = new UeTransform();
			t.position.set(1, 2, 3);
			t.updateMatrix();
			expect(t.matrix.data[12]).toBe(1);
			expect(t.matrix.data[13]).toBe(2);
			expect(t.matrix.data[14]).toBe(3);
		});

		// Translation
		test("translate() moves object", function() {
			var t = new UeTransform();
			t.translate(1, 2, 3);
			expect(t.position.equals(new UeVector3(1, 2, 3))).toBeTruthy();
		});

		test("translateX() moves along X", function() {
			var t = new UeTransform();
			t.translateX(5);
			expect(t.position.x).toBe(5);
		});

		test("translateY() moves along Y", function() {
			var t = new UeTransform();
			t.translateY(5);
			expect(t.position.y).toBe(5);
		});

		test("translateZ() moves along Z", function() {
			var t = new UeTransform();
			t.translateZ(5);
			expect(t.position.z).toBe(5);
		});

		test("translateOnAxis() moves along arbitrary axis", function() {
			var t = new UeTransform();
			var axis = new UeVector3(1, 0, 0);
			t.translateOnAxis(axis, 5);
			expect(t.position.x).toBe(5);
		});

		// Rotation
		test("setRotationFromQuaternion() sets rotation", function() {
			var t = new UeTransform();
			var q = new UeQuaternion();
			q.setFromAxisAngle(new UeVector3(0, 1, 0), 90);
			t.setRotationFromQuaternion(q);
			expect(t.rotation.x).toBe(q.x);
			expect(t.rotation.y).toBe(q.y);
			expect(t.rotation.z).toBe(q.z);
			expect(t.rotation.w).toBe(q.w);
		});

		test("rotateX() rotates around X", function() {
			var t = new UeTransform();
			t.rotateX(90);
			expect(round(t.rotation.x * 1000) / 1000 != 0).toBeTruthy();
		});

		test("rotateY() rotates around Y", function() {
			var t = new UeTransform();
			t.rotateY(90);
			expect(round(t.rotation.y * 1000) / 1000 != 0).toBeTruthy();
		});

		test("rotateZ() rotates around Z", function() {
			var t = new UeTransform();
			t.rotateZ(90);
			expect(round(t.rotation.z * 1000) / 1000 != 0).toBeTruthy();
		});

		// Scaling
		test("setScale() sets scale", function() {
			var t = new UeTransform();
			t.setScale(2, 3, 4);
			expect(t.scale.equals(new UeVector3(2, 3, 4))).toBeTruthy();
		});

		test("scaleX() adds to X scale", function() {
			var t = new UeTransform();
			t.scaleX(1);
			expect(t.scale.x).toBe(2); // Default is 1, +1 = 2
		});

		// World transforms
		test("getWorldPosition() returns world position", function() {
			var parent = new UeTransform();
			parent.position.set(10, 0, 0);
			
			var child = new UeTransform();
			child.position.set(5, 0, 0);
            array_push(parent.children, child);
            child.parent = parent;
			
			parent.updateMatrixWorld(true);
			
			var worldPos = new UeVector3();
			child.getWorldPosition(worldPos);
			expect(worldPos.x).toBe(15);
		});

		test("getWorldScale() returns world scale", function() {
			var parent = new UeTransform();
			parent.scale.set(2, 2, 2);
			
			var child = new UeTransform();
			child.scale.set(2, 2, 2);
            array_push(parent.children, child);
            child.parent = parent;
			
			parent.updateMatrixWorld(true);
			
			var worldScale = new UeVector3();
			child.getWorldScale(worldScale);
			expect(worldScale.x).toBe(4);
		});

		// LookAt
		test("lookAtVec() orients object", function() {
			var t = new UeTransform();
			t.lookAtVec(new UeVector3(0, 0, 1));
			expect(t.rotation.equals(new UeQuaternion(0, 0, 0, 1))).toBeFalsy();
		});

		test("lookAt() orients object", function() {
			var t = new UeTransform();
			t.lookAt(0, 0, 1);
			expect(t.rotation.equals(new UeQuaternion(0, 0, 0, 1))).toBeFalsy();
		});

		// Space conversion
		test("worldToLocal() converts vector", function() {
			var t = new UeTransform();
			t.position.set(10, 0, 0);
			t.updateMatrixWorld();
			
			var vec = new UeVector3(15, 0, 0);
			var local = t.worldToLocal(vec);
			expect(local.x).toBe(5);
		});

		test("localToWorld() converts vector", function() {
			var t = new UeTransform();
			t.position.set(10, 0, 0);
			t.updateMatrixWorld();
			
			var vec = new UeVector3(5, 0, 0);
			var world = t.localToWorld(vec);
			expect(world.x).toBe(15);
		});
	});
});
