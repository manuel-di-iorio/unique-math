// GMTL-style test suite for UeVector2
suite(function() {
	describe("UeVector2", function() {
		test("constructor and set/equals", function() {
			var v = new UeVector2(1, 2);
			expect(v.x).toBe(1);
			expect(v.y).toBe(2);

			v.set(3,4);
			expect(v.x).toBe(3);
			expect(v.y).toBe(4);

			var v2 = v.clone();
			expect(v.equals(v2)).toBeTruthy();
		});

		test("copy/add/sub", function() {
			var v = new UeVector2(1,1);
			var v2 = new UeVector2(2,3);
			v.add(v2);
			expect(v.equals(new UeVector2(3,4))).toBeTruthy();
			v.sub(v2);
			expect(v.equals(new UeVector2(1,1))).toBeTruthy();

			// copy()
			v2.set(5,6);
			v.copy(v2);
			expect(v.equals(new UeVector2(5,6))).toBeTruthy();

			v.set(2,3);
			v.multiply(new UeVector2(3,4));
			expect(v.equals(new UeVector2(6,12))).toBeTruthy();
			v.scale(0.5);
			expect(v.equals(new UeVector2(3,6))).toBeTruthy();
		});

		test("dot/length/normalize", function() {
			var a = new UeVector2(1,0);
			var b = new UeVector2(0,1);
			expect(a.dot(b)).toBe(0);
			expect(a.length()).toBe(1);

			var c = new UeVector2(3,4);
			c.normalize();
			expect(round(c.length()*1000)/1000).toBe(1);
		});

		// angleTo covers computing the angle between vectors in degrees
		test("angleTo", function() {
			var u = new UeVector2(1,0);
			var v = new UeVector2(0,1);
			// angle between x and y axis should be ~90 degrees
			expect(round(u.angleTo(v))).toBe(90);
		});

		test("lerp/distance/perp/rotate", function() {
			var p = new UeVector2(0,0);
			var q = new UeVector2(10,0);
			p.lerp(q, 0.5);
			expect(p.equals(new UeVector2(5,0))).toBeTruthy();

			expect(q.distanceTo(new UeVector2(5,0))).toBe(5);

			var r = new UeVector2(1,0);
			var pr = r.perp();
			expect(pr.equals(new UeVector2(0,1))).toBeTruthy();

			var s = new UeVector2(1,0);
			s.rotate(90);
			expect(round(s.x*1000)/1000).toBe(0);
			expect(round(s.y*1000)/1000).toBe(1);
		});

		// Edge cases
		test("normalize on zero vector", function() {
			var z = new UeVector2(0,0);
			// Should not change or produce NaN; length stays 0
			z.normalize();
			expect(z.length()).toBe(0);
		});

		test("angleTo with zero and opposite vectors", function() {
			var u = new UeVector2(1,0);
			var zero = new UeVector2(0,0);
			// angleTo with zero vector should return 0 as implemented
			expect(u.angleTo(zero)).toBe(0);

			var v = new UeVector2(-1,0);
			// opposite vectors -> 180 degrees
			expect(round(u.angleTo(v))).toBe(180);
		});

		test("lerp edge t=0 and t=1", function() {
			var a = new UeVector2(1,2);
			var b = new UeVector2(5,6);
			var c = a.clone();
			c.lerp(b, 0);
			expect(c.equals(new UeVector2(1,2))).toBeTruthy();
			c = a.clone();
			c.lerp(b, 1);
			expect(c.equals(new UeVector2(5,6))).toBeTruthy();
		});

		test("rotate negative and non-90 angles", function() {
			var v = new UeVector2(1,0);
			v.rotate(-90);
			expect(round(v.x*1000)/1000).toBe(0);
			expect(round(v.y*1000)/1000).toBe(-1);

			var w = new UeVector2(1,0);
			w.rotate(45);
			// rotated coordinates should be cos45,sin45
			expect(round(w.x*1000)/1000).toBe(round(dcos(45)*1000)/1000);
			expect(round(w.y*1000)/1000).toBe(round(dsin(45)*1000)/1000);
		});
	});
});
