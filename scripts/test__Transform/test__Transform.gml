// GMTL-style test suite for array-based Transform
suite(function() {
    describe("Transform", function() {
        
        test("constructor defaults", function() {
            var t = new Transform();
            expect(t.position).toBe([0, 0, 0]);
            expect(t.rotation).toBe([0, 0, 0, 1]);
            expect(t.scale).toBe([1, 1, 1]);
        });
        
        test("updateMatrix composes P/R/S into matrix", function() {
            var t = new Transform();
            t.setPosition(1, 2, 3).setRotation(0, 0, 0).setScale(1, 1, 1);
            t.updateMatrix();
            expect(t.matrix[12]).toBe(1);
            expect(t.matrix[13]).toBe(2);
            expect(t.matrix[14]).toBe(3);
        });
        
        test("translateX/Y/Z modifies position", function() {
            var t = new Transform();
            t.translateX(5);
            expect(t.position[0]).toBe(5);
            t.translateY(4);
            expect(t.position[1]).toBe(4);
            t.translateZ(3);
            expect(t.position[2]).toBe(3);
        });
        
        test("rotateX/Y/Z updates rotation quaternion", function() {
            var t = new Transform();
            t.rotateX(90);
            expect(abs(t.rotation[0]) > 0).toBe(true);
            t = new Transform();
            t.rotateY(90);
            expect(abs(t.rotation[1]) > 0).toBe(true);
            t = new Transform();
            t.rotateZ(90);
            expect(abs(t.rotation[2]) > 0).toBe(true);
        });
        
        test("updateMatrixWorld with parent translation", function() {
            var parent = new Transform();
            parent.setPosition(10, 0, 0).updateMatrix();
            
            var child = new Transform();
            child.setPosition(5, 0, 0).updateMatrix();
            array_push(parent.children, child);
            child.parent = parent;
            
            parent.updateMatrixWorld(true);
            
            var worldPos = array_create(3);
            child.getWorldPosition(worldPos);
            expect(worldPos[0]).toBe(15);
            expect(worldPos[1]).toBe(0);
            expect(worldPos[2]).toBe(0);
        });
        
        test("applyMatrix4 applies translation", function() {
            var t = new Transform();
            t.updateMatrix();
            
            var m = mat4_create();
            mat4_make_translation(m, 3, 2, 1);
            t.applyMatrix4(m);
            
            expect(t.position).toBe([3, 2, 1]);
        });
        
        test("localToWorld/worldToLocal roundtrip", function() {
            var t = new Transform();
            t.setPosition(10, 0, 0).updateMatrixWorld();
            
            var v = [5, 0, 0];
            var world = t.localToWorld([v[0], v[1], v[2]]);
            expect(world[0]).toBe(15);
            expect(world[1]).toBe(0);
            expect(world[2]).toBe(0);
            
            var back = t.worldToLocal([world[0], world[1], world[2]]);
            expect(back).toBe([5, 0, 0]);
        });
    });
});
