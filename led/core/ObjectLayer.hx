package led.core;


import led.core.Layer;
import led.core.GameObject;
import led.core.LayerType;
import led.core.Level;
import led.utils.Log.*;


/* A Objects Layer */
class ObjectLayer extends Layer {


	public var objects:Array<GameObject>;


	public function new(options:LayerOptions) {

		options.type = LayerType.object;
		
		super(options);

		if(options.json != null) {
			var d:ObjectLayerData = cast options.json;
			objects = [];
			// objects = d.objects;
		} else {
			objects = [];
		}

	}

	public function add_object(_obj:GameObject) {

		objects.push(_obj);
		parent.emit(LevelEvent.layer_object_added, { layer : this, object: _obj });

	}

	public function remove_object(_obj:GameObject) {

		if(objects.remove(_obj)){
			parent.emit(LevelEvent.layer_object_added, { layer : this, object: _obj });
		}
		
	}

	override function empty() {

		for (o in objects) {
			remove_object(o);
		}

	}

	override function destroy() {

		super.destroy();

		objects = null;

	}

	override function undo() {}
	override function redo() {}

	override function to_json():LayerData {

		var d:ObjectLayerData = cast super.to_json();
		d.objects = [];

		for (o in objects) {
			d.objects.push(o.to_json());
		}

		return d;

	}

}


typedef ObjectLayerData = {

	>LayerData,

	var objects:Array<GameObjectData>;

}
