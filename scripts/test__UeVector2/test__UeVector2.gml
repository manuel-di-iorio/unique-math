// GMTL-style test suite for UeVector2
suite(function() {
	describe("UeVector2", function() {
		// Constructor tests
		test("constructor sets x and y correctly", function() {
			var v = new UeVector2(1, 2);
			expect(v.x).toBe(1);
			expect(v.y).toBe(2);
		});

		test("set() updates components", function() {
			var v = new UeVector2(1, 2);
			v.set(3, 4);
			expect(v.x).toBe(3);
			expect(v.y).toBe(4);
		});

		test("clone() creates independent copy", function() {
			var v = new UeVector2(3, 4);
			var v2 = v.clone();
			expect(v.equals(v2)).toBeTruthy();
			// Verify independence
			v2.set(5, 6);
			expect(v.x).toBe(3);
			expect(v.y).toBe(4);
		});

		test("equals() compares vectors correctly", function() {
			var v1 = new UeVector2(1, 2);
			var v2 = new UeVector2(1, 2);
			var v3 = new UeVector2(1, 3);
			expect(v1.equals(v2)).toBeTruthy();
			expect(v1.equals(v3)).toBeFalsy();
		});

		// Arithmetic operations
		test("add() adds vectors", function() {
			var v = new UeVector2(1, 1);
			var v2 = new UeVector2(2, 3);
			v.add(v2);
			expect(v.equals(new UeVector2(3, 4))).toBeTruthy();
		});

		test("sub() subtracts vectors", function() {
			var v = new UeVector2(3, 4);
			var v2 = new UeVector2(2, 3);
			v.sub(v2);
			expect(v.equals(new UeVector2(1, 1))).toBeTruthy();
		});

		test("copy() copies vector values", function() {
			var v = new UeVector2(1, 1);
			var v2 = new UeVector2(5, 6);
			v.copy(v2);
			expect(v.equals(new UeVector2(5, 6))).toBeTruthy();
		});

		test("multiply() multiplies component-wise", function() {
			var v = new UeVector2(2, 3);
			v.multiply(new UeVector2(3, 4));
			expect(v.equals(new UeVector2(6, 12))).toBeTruthy();
		});

		test("scale() scales vector uniformly", function() {
			var v = new UeVector2(6, 12);
			v.scale(0.5);
			expect(v.equals(new UeVector2(3, 6))).toBeTruthy();
		});

		// Vector operations
		test("dot() calculates dot product", function() {
			var a = new UeVector2(1, 0);
			var b = new UeVector2(0, 1);
			expect(a.dot(b)).toBe(0);
			
			var c = new UeVector2(2, 3);
			var d = new UeVector2(4, 5);
			expect(c.dot(d)).toBe(23); // 2*4 + 3*5 = 23
		});

		test("length() returns vector magnitude", function() {
			var a = new UeVector2(1, 0);
			expect(a.length()).toBe(1);
			
			var b = new UeVector2(3, 4);
			expect(b.length()).toBe(5);
		});

		test("normalize() creates unit vector", function() {
			var c = new UeVector2(3, 4);
			c.normalize();
			expect(round(c.length() * 1000) / 1000).toBe(1);
		});

		test("normalize() on zero vector doesn't produce NaN", function() {
			var z = new UeVector2(0, 0);
			z.normalize();
			expect(z.length()).toBe(0);
			expect(z.x).toBe(0);
			expect(z.y).toBe(0);
		});

		// Angle operations
		test("angleTo() calculates angle between perpendicular vectors", function() {
			var u = new UeVector2(1, 0);
			var v = new UeVector2(0, 1);
			expect(round(u.angleTo(v))).toBe(90);
		});

		test("angleTo() with zero vector returns 0", function() {
			var u = new UeVector2(1, 0);
			var zero = new UeVector2(0, 0);
			expect(u.angleTo(zero)).toBe(0);
		});

		test("angleTo() with opposite vectors returns 180", function() {
			var u = new UeVector2(1, 0);
			var v = new UeVector2(-1, 0);
			expect(round(u.angleTo(v))).toBe(180);
		});

		// Interpolation and distance
		test("lerp() interpolates at t=0.5", function() {
			var p = new UeVector2(0, 0);
			var q = new UeVector2(10, 0);
			p.lerp(q, 0.5);
			expect(p.equals(new UeVector2(5, 0))).toBeTruthy();
		});

		test("lerp() at t=0 returns start vector", function() {
			var a = new UeVector2(1, 2);
			var b = new UeVector2(5, 6);
			var c = a.clone();
			c.lerp(b, 0);
			expect(c.equals(new UeVector2(1, 2))).toBeTruthy();
		});

		test("lerp() at t=1 returns end vector", function() {
			var a = new UeVector2(1, 2);
			var b = new UeVector2(5, 6);
			var c = a.clone();
			c.lerp(b, 1);
			expect(c.equals(new UeVector2(5, 6))).toBeTruthy();
		});

		test("distanceTo() calculates distance between vectors", function() {
			var q = new UeVector2(10, 0);
			expect(q.distanceTo(new UeVector2(5, 0))).toBe(5);
		});

		// Perpendicular and rotation
		test("perp() returns perpendicular vector", function() {
			var r = new UeVector2(1, 0);
			var pr = r.perp();
			expect(pr.equals(new UeVector2(0, 1))).toBeTruthy();
		});

		test("rotate() rotates by 90 degrees", function() {
			var s = new UeVector2(1, 0);
			s.rotate(90);
			expect(round(s.x * 1000) / 1000).toBe(0);
			expect(round(s.y * 1000) / 1000).toBe(1);
		});

		test("rotate() rotates by -90 degrees", function() {
			var v = new UeVector2(1, 0);
			v.rotate(-90);
			expect(round(v.x * 1000) / 1000).toBe(0);
			expect(round(v.y * 1000) / 1000).toBe(-1);
		});

		test("rotate() rotates by 45 degrees", function() {
			var w = new UeVector2(1, 0);
			w.rotate(45);
			expect(round(w.x * 1000) / 1000).toBe(round(dcos(45) * 1000) / 1000);
			expect(round(w.y * 1000) / 1000).toBe(round(dsin(45) * 1000) / 1000);
		});
	});
});
