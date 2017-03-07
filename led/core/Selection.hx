package led.core;


import led.Rectangle;
import led.utils.Log.*;


class Selection {


	/* Selection active */
	public var active(default, null):Bool; 
	/* The bounding rectangle of the entire selection. */
	public var bounds(default, null):Rectangle; 


	public function new():Void {

		_verbose('create new Selection');

		active = false;
		bounds = new Rectangle();

	}
	

}