package led.core;


import led.core.Tool;
import led.Editor;
import led.utils.Log.*;


@:access(led.core.Tool)
class Tools {


	public var current_tool (default, null): Tool;
	public var last_tool (default, null): Tool;

	var tools_map:Map<ToolType, Tool>;


	public function new() {

		tools_map = new Map();

	}

	public function destroy() {
			
		for (t in tools_map) {
			t.ondestroy();
		}

		tools_map = null;

	}

	public function set(_type:ToolType) {

		var t:Tool = tools_map.get(_type);

		if(t == null) {
			return;
		}

		last_tool = current_tool;
		current_tool = t;

		last_tool.ondisable();
		current_tool.onenable();

		Led.emit(EditorEvent.tool_change, current_tool);

	}

	public inline function get<T>(_type:ToolType):T {

		return cast tools_map.get(_type);

	}

	function update(dt:Float) {

		if(current_tool != null) {
			current_tool.update(dt);
		}

	}

	// function onmousemove(e:MouseEvent) {

	// 	if(current_tool != null) {
	// 		current_tool.onmousemove(e);
	// 	}

	// }

	// function onmouseup(e:MouseEvent) {

	// 	if(current_tool != null) {
	// 		current_tool.onmouseup(e);
	// 	}
		
	// }

	// function onmousedown(e:MouseEvent) {

	// 	if(current_tool != null) {
	// 		current_tool.onmousedown(e);
	// 	}
		
	// }

	function spacepressed(value:Bool) {

		if(current_tool != null) {
			current_tool.spacepressed(value);
		}
		
	}

	function altpressed(value:Bool) {

		if(current_tool != null) {
			current_tool.altpressed(value);
		}
		
	}

	function shiftpressed(value:Bool) {

		if(current_tool != null) {
			current_tool.shiftpressed(value);
		}
		
	}

	function ctrlpressed(value:Bool) {

		if(current_tool != null) {
			current_tool.ctrlpressed(value);
		}
		
	}


}

@:keep
@:enum abstract ToolMode(Int) from Int to Int {

	var unknown           = 0;
	var add               = 1;
	var select            = 2;
	var remove            = 3;
	var move              = 4;
	var pan               = 5;

}
