package ;


import led.Editor;


class Led {


	public static var editor (default, null):Editor;

	static var inited:Bool = false;


	public static function init():Void {

		if(inited) {
			return;
		}

		editor = new Editor();
		editor.init();
		
		inited = true;

	}

	public static function destroy():Void {

		if(!inited) {
			return;
		}
		
		editor.destroy();
		editor = null;

		inited = false;
		
	}

	public static inline function on<T>(event:EditorEvent, handler:T->Void ) {

		editor.on(event, handler);

	}

	public static inline function off<T>(event:EditorEvent, handler:T->Void ) {

		return editor.off(event, handler);

	}

	public static inline function emit<T>(event:EditorEvent, ?data:T) {

		return editor.emit(event, data);

	}



}