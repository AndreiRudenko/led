package led;


import led.core.Level;
import led.core.Tools;

/* Editor */
class Editor {


	public var emitter:Emitter<EditorEvent>;
	public var tools (default, null):Tools;
	public var level (default, null):Level;


	public function new() {

	}

	public function init():Void {

		emitter = new Emitter();
		tools = new Tools();

		level = new Level({});
		
	}

	public function destroy() {

		if(level != null) {
			level.destroy();
			level = null;
		}

		tools.destroy();
		emitter._emitter_destroy();

		emitter = null;

	}
	
	public inline function on<T>(event:EditorEvent, handler:T->Void ) {

		emitter.on(event, handler);

	}

	public inline function off<T>(event:EditorEvent, handler:T->Void ) {

		return emitter.off(event, handler);

	}

	public inline function emit<T>(event:EditorEvent, ?data:T) {

		return emitter.emit(event, data);

	}
	

}


@:keep
@:enum abstract EditorEvent(Int) from Int to Int {

	var unknown                   = 1;

	var tool_change               = 2;

	var level_create              = 3;
	var level_destroy             = 4;

	var level_load            	  = 5;
	var level_save            	  = 6;
	var level_reset           	  = 7;
	var level_play            	  = 8;

	var onmousedown            	  = 9;
	var onmouseup            	  = 10;
	var onmousemove            	  = 11;

		// ui events
	var props_changed             = 12;
	var show_grid                 = 13;
	var ui_cursor_change          = 14;

	var marked                    = 15;

}
