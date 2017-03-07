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
		
		_verbose('create new ObjectLayer with options $options');

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

		_debug('calling add object on $name / $_obj object');

		objects.push(_obj);
		parent.emit(LevelEvent.layer_object_added, { layer : this, object: _obj });

	}

	public function remove_object(_obj:GameObject) {

		_debug('calling remove object on $name / $_obj object');

		if(objects.remove(_obj)){
			parent.emit(LevelEvent.layer_object_added, { layer : this, object: _obj });
		}
		
	}

	override function empty() {

		_debug('calling empty on $name');

		for (o in objects) {
			remove_object(o);
		}

	}

	override function destroy() {

		_debug('calling destroy on $name');

		super.destroy();

		objects = null;

	}

	override function undo() {}
	override function redo() {}

	override function to_json():LayerData {

		_debug('calling to_json on $name');
		
		var d:ObjectLayerData = cast super.to_json();
		d.objects = [];

		for (o in objects) {
			d.objects.push(o.to_json());
		}

		return d;

	}

	override function set_visible(value:Bool):Bool {

		super.set_visible(value);

		for (o in objects) {
			o.visible = value;
		}

		return visible;

	}

	override function set_opacity(value:Float):Float {
		
		super.set_opacity(value);

		for (o in objects) {
			o.opacity = value;
		}
		
		return opacity;

	}

}


typedef ObjectLayerData = {

	>LayerData,

	var objects:Array<GameObjectData>;

}
