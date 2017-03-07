package led.core;


import led.Editor;
import led.core.ToolType;


class Tool {


	public var type (default, null): ToolType;
	public var props : Dynamic;


	public function new(_type:ToolType) {

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

	// function onmouseup(e:MouseEvent) {}

	// function onmousedown(e:MouseEvent) {}

	function spacepressed(value:Bool) {}

	function altpressed(value:Bool) {}

	function shiftpressed(value:Bool) {}

	function ctrlpressed(value:Bool) {}

}

