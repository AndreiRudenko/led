package led.core;


import led.core.Layer;
import led.core.LayerType;
import led.core.Level;
import led.utils.Log.*;


/* A GameObject */
class GameObject {


	public var name (default, set):String;

	public var visible (default, set):Bool; 
	public var opacity (default, set):Float; 

	public var x (default, set):Float;
	public var y (default, set):Float;

	public var w (default, set):Float;
	public var h (default, set):Float;

	public var properties :Dynamic;


	public function new(_name:String, _x:Float, _y:Float, _w:Float, _h:Float) {

		_verbose('create new GameObject $_name, / x: $_x, y: $_y / w: $_w, h: $_h');

		name = _name;
		visible = true;
		opacity = 1;
		properties = {};

		x = _x;
		y = _y;
		w = _w;
		h = _h;
		
	}

	public function destroy() {}

	public function to_json():GameObjectData {

		_debug('calling to_json on $name');

		return {
			name : name,
			x : x,
			y : y,
			w : w,
			h : h
		};

	}

	function set_name(value:String):String {
		
		_verbose('set GameObject $name name to $value');

		return name = value;

	}

	function set_visible(value:Bool):Bool {

		_verbose('set GameObject $name visible to $value');

		return visible = value;

	}

	function set_opacity(value:Float):Float {

		_verbose('set GameObject $name opacity to $value');
		
		return opacity = value;

	}

	function set_x(value:Float):Float {
		
		_verboser('set GameObject $name x to $value');

		return x = value;

	}

	function set_y(value:Float):Float {

		_verboser('set GameObject $name y to $value');

		return y = value;

	}

	function set_w(value:Float):Float {

		_verboser('set GameObject $name w to $value');
		
		return w = value;

	}

	function set_h(value:Float):Float {

		_verboser('set GameObject $name h to $value');

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
