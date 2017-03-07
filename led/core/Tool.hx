package led.core;


import led.Editor;
import led.core.ToolType;
import led.utils.Log.*;


class Tool {


	public var name (default, null): String;
	public var type (default, null): ToolType;
	public var props : Dynamic;


	public function new(_name:String, _type:ToolType) {

		_verbose('create new tool $_name / $_type type');

		name = _name;
		type = _type;
		props = {};

	}

	function ondestroy() {

		props = null;

	}

	function onenable() {}
	function ondisable() {}
	
	function update(dt:Float) {}

	// function onmousemove(e:MouseEvent) {}
	// function onmousedown(e:MouseEvent) {}
	// function onmouseup(e:MouseEvent) {}

	// function onkeydown(e:KeyEvent) {}
	// function onkeyup(e:KeyEvent) {}

	function spacepressed(value:Bool) {}
	function altpressed(value:Bool) {}
	function shiftpressed(value:Bool) {}
	function ctrlpressed(value:Bool) {}

}

