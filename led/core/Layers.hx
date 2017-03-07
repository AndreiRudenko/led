package led.core;


import led.Editor;
import led.core.Level;
import led.core.Layer;
import led.core.TileLayer;
import led.core.ObjectLayer;
import led.utils.Maths;


/* A collection of layers. */
@:access(led.core.Layer)
class Layers {

	/* The object's container. */
	public var parent  (default, null):Level; 
	/* Layers count */
	public var length  (get, never):Int;
	
	var layers:Array<Layer>;


	public function new(_parent:Level, ?_json:Array<LayerData>) {

		parent = _parent;
		layers = [];

		if(_json != null) {
			for (ld in _json) {
				var l:Layer = create(ld.type, ld);
				add(l);
			}
		}

	}

	public function create(_type:LayerType, ?_data:LayerData):Layer {

		var ret:Layer = null;

		switch (_type) {

			case LayerType.tile :{
				ret = new TileLayer({parent : parent, json : _data});
			}
			case LayerType.object :{
				ret = new ObjectLayer({parent : parent, json : _data});
			}
			case LayerType.image :{
				ret = new Layer({parent : parent, json : _data});
			}
			case LayerType.sound :{
				ret = new Layer({parent : parent, json : _data});
			}
			default: {
				throw('unknown LayerType');
			}

		}

		return ret;

	}


	public function empty():Void {
		
		for (l in layers) {
			_remove(l);
		}

	}

	public function destroy():Void {

		empty();
		parent = null;
		layers = null;

	}

	public function add(l:Layer) {

		layers.push(l);

		parent.emit(LevelEvent.layer_add, l);

		move(l, l.index);

	}

	public function remove(l:Layer) {

		if(l != null) {
			_remove(l);
			parent.emit(LevelEvent.layer_remove, l);
		}

	}

	public inline function get(_name:String):Layer {

		var ret:Layer = null;

		for (l in layers) {
			if(l.name == _name) {
				ret = l;
				break;
			}
		}

		return ret;
		
	}

	public function move(l:Layer, to:UInt) {

		if(l == null || layers.length <= 1) {
			return;
		}

		if(to > layers.length-1) {
			to = layers.length-1;
		}

		var other:Layer = layers[to];

		if(other != l) {

			var from:Int = l.index;

			layers[to] = l;
			layers.splice(from, 1);

			if(from > to) {
				layers.insert(to + 1, other);
			} else {
				layers.insert(to - 1, other);
			}

			update_indexes();

			parent.emit(LevelEvent.layer_move, l);

		}

	}

	public function to_json():Array<LayerData> {

		var ret:Array<LayerData> = [];

		for (l in layers) {
			ret.push(l.to_json());
		}

		return ret;

	}

	inline function _remove(l:Layer) {
		
		l.empty();

		layers.remove(l);
		update_indexes();

	}

	inline function update_indexes():Void {

		for (i in 0...layers.length) {
			layers[i].index = i;
		}
		
	}

	inline function get_length():Int {

		return layers.length;

	}

	inline function toString() {

		var _list = []; 

		for (l in layers) {
			_list.push(l.name);
		}

		return 'layers: [${_list.join(", ")}]';

	}

	@:noCompletion public inline function iterator():Iterator<Layer> {

		return layers.iterator();

	}

}
