package led.msgpack;

// https://github.com/aaulia/msgpack-haxe

import haxe.io.Bytes;
import led.msgpack.Decoder.DecodeOption;


class MsgPack {


	public static inline function encode(d:Dynamic):Bytes { 

		return new Encoder(d).getBytes(); 

	}

	public static inline function decode(b:Bytes, ?option:DecodeOption):Dynamic {

		if (option == null) 
            option = DecodeOption.AsObject;

		return new Decoder(b, option).getResult();

	}


}
