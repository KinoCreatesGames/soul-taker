package game.chars;

class LineShip extends EnemyShip {
	public var bulletCD:Float;
	public var waitTime:Float;

	public static inline var IDLE_TIME:Float = 1.5;
	public static inline var WAIT_TIME:Float = 3;
	public static inline var BULLET_CD:Float = 1;
	public static inline var BULLET_SPEED:Float = 800;
	public static inline var SHIP_SPEED:Float = 50;

	override public function update(elapsed:Float) {
		super.update(elapsed);
		processPattern(elapsed);
	}

	override public function initialize() {
		makeGraphic(8, 8, KColor.RED);
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
			acceleration.y = SHIP_SPEED;
		}
	}

	override public function attack(elapsed:Float) {
		if (waitTime > 0) {
			waitTime -= elapsed;
			velocity.set(0, 0);
		} else {
			// Start Moving Again
			acceleration.y = SHIP_SPEED;
		}

		if (bulletCD <= 0) {
			fireBullet();
		} else {
			bulletCD -= elapsed;
		}
	}

	public function fireBullet() {
		if (bulletCD <= 0) {
			trace('Fire Bullet');
			var bullet = bulletGrp.recycle(Bullet);
			bullet.makeGraphic(8, 8, KColor.SNOW);
			bullet.acceleration.y = 0;
			bullet.velocity.set(0, 0);
			bullet.maxVelocity.set(0, 400);
			var spawnY = 18;
			var spawnPoint = this.getPosition();
			bullet.setPosition(spawnPoint.x, spawnPoint.y + spawnY);
			bulletGrp.add(bullet);
			bullet.acceleration.y = BULLET_SPEED;
			bulletCD = BULLET_CD;
		}
	}
}