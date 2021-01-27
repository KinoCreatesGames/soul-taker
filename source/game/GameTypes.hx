package game;

import game.chars.Gal;

typedef Actor = {
	public var name:String;
	public var health:Int;
	public var atk:Int;
	public var def:Int;
	public var agi:Int;
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

typedef GameState = {
	public var days:Int;
	public var player:Gal;
	public var gameTime:Float;
}

typedef GameSaveState = {
	public var saveIndex:Int;
	public var days:Int;
	public var playerStats:Actor;
	public var gameTime:Float;
	public var realTime:Float;
	public var playerAffectionLvl:Int;
	public var playerHappinessLvl:Int;
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