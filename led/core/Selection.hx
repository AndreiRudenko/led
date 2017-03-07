package led.core;

import led.Rectangle;


class Selection {


	/* Selection active */
	public var active(default, null):Bool; 
	/* The bounding rectangle of the entire selection. */
	public var bounds(default, null):Rectangle; 


	public function new():Void {

		active = false;
		bounds = new Rectangle();

	}
	

}