package led.core;


import led.Editor;
import led.core.Layer;
import led.core.LayerType;
import led.core.Level;
import led.utils.Log.*;


/* A Tile Layer */
@:access(led.core.Level)
class TileLayer extends Layer{


	public var tiles:Array<Int>;


	public function new(options:LayerOptions) {

		options.type = LayerType.tile;

		_verbose('create new tile layer with options $options');

		super(options);

		if(options.json != null) {
			var d:TileLayerData = cast options.json;
			tiles = d.tiles;
		} else {
			tiles = [];
			for (i in 0...(parent.w * parent.h)) {
				tiles[i] = 0;
			}
		}

	}

	public function add_tile(_x:Float, _y:Float, _tid:Int) {

		_debug('calling add tile on $name / x: $_x, y: $_y / id: $_tid');

		if(point_inside(_x, _y)) {
			var ix:Int = get_index_x(_x);
			var iy:Int = get_index_x(_y);
			var i:Int = get_index1d(ix, iy);

			if(tiles[i] != 0) {
				_remove_tile(i);
			}

			_add_tile(i, _tid);
		}

	}

	public function remove_tile(_x:Float, _y:Float) {
		
		_debug('calling remove tile on $name / x: $_x, y: $_y');

		if(point_inside(_x, _y)) {
			var ix:Int = get_index_x(_x);
			var iy:Int = get_index_x(_y);
			var i:Int = get_index1d(ix, iy);

			if(tiles[i] != 0) {
				_remove_tile(i);
			}
		}

	}

	inline function _add_tile(idx:Int, _tid:Int) {

		tiles[idx] = _tid;
		parent.emit(LevelEvent.layer_tile_added, { layer : this, tile_id: _tid, index : idx });
		
	}

	inline function _remove_tile(idx:Int) {

		var _tid:Int = tiles[idx];
		tiles[idx] = 0;
		parent.emit(LevelEvent.layer_tile_removed, { layer : this, tile_id: _tid, index : idx });

	}

	override function empty() {

		_debug('calling empty on $name');

		var _tile_id:Int = 0;

		for (i in 0...tiles.length) {
			if(tiles[i] != 0) {
				_tile_id = tiles[i];
				tiles[i] = 0;
				parent.emit(LevelEvent.layer_tile_removed, { layer : this, tile_id: _tile_id, index : i });
			}
		}

	}

	override function destroy() {

		_debug('calling destroy on $name');

		super.destroy();

		tiles = null;

	}

	override function undo() {}
	override function redo() {}

	override function to_json():LayerData {

		_debug('calling to_json on $name');

		var d:TileLayerData = cast super.to_json();
		d.tiles = tiles;

		return d;

	}

	inline function get_pos_x(_idx1d:Int):Float {

		_verboser('calling get_pos_x on $name with $_idx1d');

		return (_idx1d << parent.tilesize_pof2) + parent.x + x;

	}

	inline function get_pos_y(_idx1d:Int):Float {

		_verboser('calling get_pos_y on $name with $_idx1d');

		return (_idx1d << parent.tilesize_pof2) + parent.y + y;

	}

	inline function get_index_x(_pos:Float):Int {

		_verboser('calling get_index_x on $name with $_pos');

		return Std.int((_pos - (parent.x + x + w))) >> parent.tilesize_pof2;

	}

	inline function get_index_y(_pos:Float):Int {

		_verboser('calling get_index_y on $name with $_pos');

		return Std.int((_pos - (parent.y + y + h))) >> parent.tilesize_pof2;

	}

	inline function get_index1d(_x:Int, _y:Int):Int { // i = x + w * y;  x = i % w; y = i / w;

		_verboser('calling get_index1d on $name / x: $_x, y: $_y');

		return Std.int(_x + w * _y);


	}


}


typedef TileLayerData = {

	>LayerData,

	var tiles:Array<Int>;

}

