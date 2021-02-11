package game.chars;

class EnemyShip extends Enemy {
	public var ai:State;
	public var stateTime:Float;
	public var bulletGrp:FlxTypedGroup<Bullet>;

	public function new(x:Float, y:Float, data:Actor,
			bulletGrp:FlxTypedGroup<Bullet>) {
		super(x, y, data);
		this.bulletGrp = bulletGrp;
		initialize();
	}

	public function initialize() {
		// For setting up parameters
	}

	public function idle(elapsed:Float) {}

	public function attack(elapsed:Float) {}
}