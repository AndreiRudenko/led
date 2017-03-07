package led.core;


import led.core.Layer;
import led.core.LayerType;
import led.core.Level;
import led.utils.Log.*;


/* A GameObject */
class GameObject {


	public var name (default, set):String;

	public var x (default, set):Float;
	public var y (default, set):Float;

	public var w (default, set):Float;
	public var h (default, set):Float;

	public var properties :Dynamic;


	public function new(_name:String, _x:Float, _y:Float, _w:Float, _h:Float) {

		name = _name;

		x = _x;
		y = _y;
		w = _w;
		h = _h;
		
		properties = {};

	}

	public function destroy() {}

	public function to_json():GameObjectData {

		return {
			name : name,
			x : x,
			y : y,
			w : w,
			h : h
		};

	}

	function set_name(value:String):String {
		
		return name = value;

	}

	function set_x(value:Float):Float {
		
		return x = value;

	}

	function set_y(value:Float):Float {

		return y = value;

	}

	function set_w(value:Float):Float {

		return w = value;

	}

	function set_h(value:Float):Float {

		return h = value;

	}

}

typedef GameObjectData = {

	var name:String;
	var x:Float;
	var y:Float;
	var w:Float;
	var h:Float;
	
}
