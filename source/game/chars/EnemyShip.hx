package game.chars;

class EnemyShip extends Enemy {
	public var ai:State;
	public var stateTime:Float;

	public function new(x:Float, y:Float, data:Actor,
			bulletGrp:FlxTypedGroup<Bullet>) {
		super(x, y, data);
	}

	public function initialize() {
		// For setting up parameters
	}

	public function idle(elapsed:Float) {}

	public function attack(elapsed:Float) {}
}