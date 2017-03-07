package led.core;

/* Layer type */
@:enum abstract LayerType(Int) from Int to Int {

	var unknown:Int = 0;
	var tile:Int = 1;
	var object:Int = 2;
	var image:Int = 3;
	var sound:Int = 4;

}
