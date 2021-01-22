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

typedef SceneText = {
	public var text:String;

	/**
	 * Delay in seconds
	 */
	public var delay:Int;
}

typedef GameSaveState = {
	public var saveIndex:Int;
	public var days:Int;
	public var playerStats:Actor;
	public var playerAffectionLvl:Int;
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