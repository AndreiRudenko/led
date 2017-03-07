package led.core;


import led.Editor;
import led.core.Layer;
import led.core.Selection;
import led.utils.Log.*;
import org.msgpack.MsgPack;

import haxe.Json;

#if !js

	import sys.io.File;
	import sys.io.FileOutput;
	import sys.io.FileInput;
	
#end


class Level {


		/* positon x */
	public var x:Float;
		/* positon y */
	public var y:Float;
		/* level name. */
	public var name         (default, set):String;
		/* tiles width of the level. */
	public var w            (default, null):Int;
		/* tiles height of the level. */
	public var h            (default, null):Int;
		/* width of the level in px. */
	public var width        (default, null):Int;
		/* height of the level in px. */
	public var height       (default, null):Int;
		/* tile size */
	public var tilesize     (default, null):Int;
		/* selected layer. */
	public var active_layer (default, null):Layer; 
		/* layers collection in the level. */
	public var layers       (default, null):Layers; 
		/* selected area of the level. */
	public var selection    (default, null):Selection; 
		/* level emitter */
	public var emitter      (default, null):Emitter<LevelEvent>;

	var tilesize_pof2:UInt;


	public function new(options:LevelOptions) {

		_verbose('create new level with options ' + options);

		selection = new Selection();
		emitter = new Emitter();
		active_layer = null;

		if(options.json != null) {
			
			name = options.json.name;
			x = options.json.x;
			y = options.json.y;
			w = options.json.w;
			h = options.json.h;
			tilesize = options.json.tilesize;
			tilesize_to_pof2(tilesize);

			layers = new Layers(this, options.json.layers);

		} else {

			name = def(options.name, 'unnamed_level');
			x = def(options.x, 0);
			y = def(options.y, 0);
			w = def(options.w, 16);
			h = def(options.h, 16);
			tilesize = def(options.tilesize, 64);
			tilesize_to_pof2(tilesize);

			layers = new Layers(this);

		}

		width = w * tilesize;
		height = h * tilesize;

		Led.emit(EditorEvent.level_create, this);

	}

	public function to_json():LevelData {

		_debug('calling to_json on ' + name);

		return {
			name : name,
			x : x,
			y : y,
			w : w,
			h : h,
			tilesize : tilesize,
			layers : layers.to_json()
		};

	}

	public function save() {

		#if !js

		_debug('calling save on ' + name);
		
		var ldata:LevelData = to_json();
		var bytes = MsgPack.encode(ldata);
		File.saveBytes('maps\\$name.map', bytes);

		// check file by export to json, just for testing
		var file_bytes = File.getBytes('maps\\$name.map');
		var ld:LevelData = MsgPack.decode(file_bytes);
		var str:String = Json.stringify(ld, null, "	");
		File.saveContent('maps\\$name.json', str);

		#end

	}

	public function close(_save:Bool) {

		_debug('calling close on ' + name);

		if(_save) {
			save();
		}

	}

	public function empty() {

		_debug('calling empty on ' + name);

		layers.empty();

	}

	public function destroy() {

		_debug('destroy ' + name + ' with ' + layers.length + ' layers');

		Led.emit(EditorEvent.level_destroy, this);

		layers.destroy();
		emitter.destroy();

		name = null;
		active_layer = null;
		layers = null;
		selection = null;

	}

	public inline function on<T>(event:LevelEvent, handler:T->Void ) {

		_verbose('calling emit on / on level $name / $event event');

		emitter.on(event, handler);

	}

	public inline function off<T>(event:LevelEvent, handler:T->Void ) {

		_verbose('calling emit off / on level $name / $event');

		return emitter.off(event, handler);

	}

	public inline function emit<T>(event:LevelEvent, ?data:T) {

		_verboser('calling emit / on level $name / $event / $data data');

		return emitter.emit(event, data);

	}

	function tilesize_to_pof2(value:Int) {

		tilesize_pof2 = led.utils.PowerOfTwo.toPowOf2(value);
		tilesize = led.utils.PowerOfTwo.require(value);

	}

	function set_name(value:String):String {

		_verbose('set level name to ' + value);

		name = value;

		emit(LevelEvent.level_name_changed, name);

		return name;

	}

}


@:keep
@:enum abstract LevelEvent(Int) from Int to Int {

	var unknown                   = 0;

	var level_name_changed        = 1;

	var layer_create              = 2;
	var layer_destroy             = 3;
	var layer_add                 = 4;
	var layer_remove              = 5;
	var layer_move                = 6;

	var layer_name_changed        = 7;
	var layer_visible             = 8;
	var layer_opacity             = 9;

	var layer_tile_added          = 10;
	var layer_tile_removed        = 11;
	var layer_object_added        = 12;
	var layer_object_removed      = 13;
	var layer_image_added         = 14;
	var layer_image_removed       = 15;
	var layer_sound_added         = 16;
	var layer_sound_removed       = 17;


}


typedef LevelOptions = {

	@:optional var name:String;

	@:optional var tilesize:Int;
	@:optional var x:Float;
	@:optional var y:Float;
	@:optional var w:Int;
	@:optional var h:Int;

	@:optional var json:LevelData;

}


typedef LevelData = {

	var name:String;

	var tilesize:Int;

	var x:Float;
	var y:Float;
	var w:Int;
	var h:Int;

	var layers:Array<LayerData>;

}

