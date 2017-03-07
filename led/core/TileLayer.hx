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

	public function add_tile(_x:Float, _y:Float, _tile_id:Int) {

		if(point_inside(_x, _y)) {
			var ix:Int = get_index_x(_x);
			var iy:Int = get_index_x(_y);
			var i:Int = get_index1d(ix, iy);

			tiles[i] = _tile_id;
			parent.emit(LevelEvent.layer_tile_added, { layer : this, tile_id: _tile_id, index : i });
		}

	}

	public function remove_tile(_x:Float, _y:Float) {
		
		if(point_inside(_x, _y)) {
			var ix:Int = get_index_x(_x);
			var iy:Int = get_index_x(_y);
			var i:Int = get_index1d(ix, iy);

			if(tiles[i] != 0) {
				var _tile_id:Int = tiles[i];
				tiles[i] = 0;
				parent.emit(LevelEvent.layer_tile_removed, { layer : this, tile_id: _tile_id, index : i });
			}
		}

	}

	override function empty() {

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

		super.destroy();

		tiles = null;

	}

	override function undo() {}
	override function redo() {}

	override function to_json():LayerData {

		var d:TileLayerData = cast super.to_json();
		d.tiles = tiles;

		return d;

	}

	inline function get_pos_x(_idx1d:Int):Float {

		return (_idx1d << parent.tilesize_pof2) + parent.x + x;

	}

	inline function get_pos_y(_idx1d:Int):Float {

		return (_idx1d << parent.tilesize_pof2) + parent.y + y;

	}

	inline function get_index_x(_pos:Float):Int {

		return Std.int((_pos - (parent.x + x + w))) >> parent.tilesize_pof2;

	}

	inline function get_index_y(_pos:Float):Int {

		return Std.int((_pos - (parent.y + y + h))) >> parent.tilesize_pof2;

	}

	inline function get_index1d(_x:Int, _y:Int):Int { // i = x + w * y;  x = i % w; y = i / w;

		return Std.int(_x + w * _y);

	}


}


typedef TileLayerData = {

	>LayerData,

	var tiles:Array<Int>;

}

