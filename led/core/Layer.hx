package led.core;


import led.core.Level;
import led.utils.Log.*;


/* A layer */
class Layer {

		/* The layer's name. */
	public var name    (default, set):String; 
		/* Layer x */
	public var x       (default, null):Float;
		/* Layer y */
	public var y       (default, null):Float;
		/* The tiles width of the layer. */
	public var w       (default, null):Int;
		/* The tiles height of the layer. */
	public var h       (default, null):Int;
		/* The width of the layer in px. */
	public var width        (default, null):Int;
		/* The height of the layer in px. */
	public var height       (default, null):Int;
		/* Is the layer visible? */
	public var visible (default, set):Bool; 
		/* The layer's opacity (between 0.0 and 1.0) */
	public var opacity (default, set):Float; 
		/* The object's container. */
	public var parent  (default, null):Level; 
		/* The layer index */
	public var index   (default, null):Int; 
		/* Is the layer editable? */
	public var locked:Bool; 
		/* Layer type */
	public var type (default, null):LayerType; 


	public function new(options:LayerOptions) {

		_verbose('create new layer with options ' + options);

		parent = options.parent;

		if(options.json != null) {
			
			name = options.json.name;
			x = options.json.x;
			y = options.json.y;
			w = options.json.w;
			h = options.json.h;
			visible = options.json.visible;
			opacity = options.json.opacity;
			index = options.json.index;
			locked = options.json.visible;
			type = options.json.type;

		} else {

			name = def(options.name, 'layer');
			x = def(options.x, parent.x);
			y = def(options.y, parent.y);
			w = def(options.w, parent.w);
			h = def(options.h, parent.h);
			visible = def(options.visible, true);
			opacity = def(options.opacity, 1);
			index = def(options.index, 0);
			locked = def(options.locked, false);
			type = def(options.type, LayerType.unknown);

		}

		width = w * parent.tilesize;
		height = h * parent.tilesize;

		parent.emit(LevelEvent.layer_create, this);

	}

	public inline function point_inside(px:Float, py:Float):Bool {

		var ex:Float = x + parent.x;
		var ey:Float = y + parent.y;

		if ( px < ex || px > (ex + width) ) return false;
		if ( py < ey || py > (ey + height) ) return false;

		return true;

	}

	public inline function overlaps(_x:Float, _y:Float, _w:Float, _h:Float):Bool {

		var ex:Float = x + parent.x;
		var ey:Float = y + parent.y;

		if ( _x < ex || (_x + _w) > (ex + width) ) return false;
		if ( _y < ey || (_y + _h) > (ey + height) ) return false;

		return true;

	}

	public function destroy() {

		_debug('calling destroy on $name');

		parent.emit(LevelEvent.layer_destroy, this);
		
		name = null;
		parent = null;
		index = 0;


	}

	public function undo() {}
	public function redo() {}
	public function empty() {}

	public function to_json():LayerData {

		_debug('calling to_json on $name');

		return {
			name : name,
			x : x,
			y : y,
			w : w,
			h : h,
			visible : visible,
			opacity : opacity,
			index : index,
			locked : locked,
			type : type
		};

	}

	function set_name(value:String):String {

		_verbose('set layer $name name to $value');
		parent.emit(LevelEvent.layer_name_changed, {layer : this, value : value});

		return name = value;

	}

	function set_visible(value:Bool):Bool {

		_verbose('set layer $name visible to $value');
		parent.emit(LevelEvent.layer_visible, {layer : this, value : value});

		return visible = value;

	}

	function set_opacity(value:Float):Float {

		_verbose('set layer $name opacity to $value');
		parent.emit(LevelEvent.layer_opacity, {layer : this, value : value});
		
		return opacity = value;

	}

}

typedef LayerOptions = {

	var parent:Level;

	@:optional var name:String;
	@:optional var x:Float;
	@:optional var y:Float;
	@:optional var w:Int;
	@:optional var h:Int;
	@:optional var visible:Bool;
	@:optional var opacity:Float;
	@:optional var index:Int;
	@:optional var locked:Bool;
	@:optional var type:Int;
	@:optional var json:LayerData;

}

typedef LayerData = {

	var name:String;
	var x:Float;
	var y:Float;
	var w:Int;
	var h:Int;
	var visible:Bool;
	var opacity:Float;
	var index:Int;
	var locked:Bool;
	var type:Int;

}