package led.core;


/* Tool type */
@:enum abstract ToolType(Int) from Int to Int {

	var unknown:Int = 0;
	var selection:Int = 1;
	var move:Int = 2;
	var stamp:Int = 3;
	var eraser:Int = 4;

}
