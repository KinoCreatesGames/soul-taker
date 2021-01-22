package game.states;

// TODO: Make sure other states are substates where we can display
// em inside a tiny box
class BattleState extends FlxState {
	public var turnCounter:Int;

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