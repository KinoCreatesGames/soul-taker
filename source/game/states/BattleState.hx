package game.states;

import game.chars.Enemy;
import game.chars.Char;

// TODO: Make sure other states are substates where we can display
// em inside a tiny box
class BattleState extends FlxState {
	public var turnCounter:Int;
	public var party:Array<Char>;
	public var enemies:Array<Enemy>;

	public function new() {
		turnCounter = 0;
		super();
	}

	override public function create() {
		super.create();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}