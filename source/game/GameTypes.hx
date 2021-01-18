package game;

typedef Actor = {
	public var name:String;
	public var health:Int;
	public var atk:Int;
	public var def:Int;
}

typedef Monster = {
	> Actor,
	public var patrol:Array<FlxPoint>;
}

enum abstract AnimTypes(String) from String to String {
	public var IDLE:String = 'idle';
	public var MOVE:String = 'move';
	public var DEATH:String = 'death';
}

enum Splash {
	Delay(imageName:String, seconds:Int);
	Click(imageName:String);
	ClickDelay(imageName:String, seconds:Int);
}