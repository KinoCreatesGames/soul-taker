package game.chars;

class LineShip extends EnemyShip {
	public var bulletCD:Float;
	public var waitTime:Float;

	public static inline var IDLE_TIME:Float = 1.5;
	public static inline var WAIT_TIME:Float = 3;
	public static inline var BULLET_CD:Float = 1;

	override public function update(elapsed:Float) {
		super.update(elapsed);
		processPattern(elapsed);
	}

	override public function initialize() {
		ai = new State(idle);
		bulletCD = BULLET_CD;
		stateTime = IDLE_TIME;
		waitTime = WAIT_TIME;
		// Set Max Velocity
		maxVelocity.set(0, 250);
	}

	public function processPattern(elapsed:Float) {
		ai.update(elapsed);
	}

	override public function idle(elapsed:Float) {
		if (stateTime <= 0) {
			ai.currentState = attack;
		} else {
			stateTime -= elapsed;
			acceleration.y = 300;
		}
	}

	override public function attack(elapsed:Float) {
		if (waitTime > 0) {
			waitTime -= elapsed;
			velocity.set(0, 0);
		} else {
			// Start Moving Again
			acceleration.y = 300;
		}
	}
}