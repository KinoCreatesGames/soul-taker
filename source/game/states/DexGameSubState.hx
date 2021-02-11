package game.states;

import game.chars.Bullet;
import game.chars.Enemy;

class DexGameSubState extends MiniGameSubState {
	public var playerSprite:FlxSprite;
	public var playerBullets:FlxTypedGroup<Bullet>;
	public var enemyShips:FlxTypedGroup<Enemy>;
	public var enemyBullets:FlxTypedGroup<Bullet>;
	public var spawnCD:Float;
	public var enemySpawnCD:Float;
	public var bulletCD:Float;

	public static inline var PLAYER_SPEED:Float = 800;
	public static inline var BULLET_SPEED:Int = 1200;
	public static inline var BULLET_CD:Float = 0.125;
	public static inline var INVINCIBLE_CD:Float = 2;
	public static inline var ENEMY_SPAWN_CD:Float = 2.5;

	override public function createElements() {
		super.createElements();
		initialize();
		createPlayer();
		createEnemyShips();
	}

	public function initialize() {
		spawnCD = 0;
		enemySpawnCD = 0;
		bulletCD = BULLET_CD;
	}

	public function createPlayer() {
		var x = miniGameCamera.width / 2;
		var y = miniGameCamera.height / 2;

		playerSprite = new FlxSprite(x, y);
		playerSprite.makeGraphic(8, 8, KColor.SNOW);
		playerBullets = new FlxTypedGroup<Bullet>(20);
		add(playerBullets);
		add(playerSprite);
	}

	public function createEnemyShips() {
		enemyShips = new FlxTypedGroup<Enemy>(10);
		enemyBullets = new FlxTypedGroup<Bullet>(100);
		add(enemyBullets);
		add(enemyShips);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateControls(elapsed);
		updateSpawnEnemies(elapsed);
		updateCollisions();
	}

	public function updateControls(elapsed:Float) {
		if (FlxG.keys.anyJustPressed([Z])) {
			// Fire Bullet
			fireBullet();
		}
		updatePlayerMovement(elapsed);
		// Count Down bullet CD
		if (bulletCD > 0) {
			bulletCD -= elapsed;
		}
	}

	public function fireBullet() {
		if (bulletCD <= 0) {
			trace('Fire Bullet');
			var bullet = playerBullets.recycle(Bullet);
			bullet.makeGraphic(8, 8, KColor.SNOW);
			bullet.acceleration.y = 0;
			bullet.velocity.set(0, 0);
			var spawnY = -18;
			var spawnPoint = playerSprite.getPosition();
			bullet.setPosition(spawnPoint.x, spawnPoint.y + spawnY);
			playerBullets.add(bullet);
			bullet.acceleration.y = -BULLET_SPEED;
			bulletCD = BULLET_CD;
		}
	}

	public function updatePlayerMovement(elapsed:Float) {
		var left = false;
		var right = false;

		playerSprite.maxVelocity.set(120, 200);

		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);

		if (left && right) left = right = false;

		// Because we're using acceleration above to handle gravity insteada of velocity
		// We need to then use acceleration in the x  axis to account for change in speed
		// overtime for jumps and for y we use velocity because a jump is a burst of speed
		// trace(y, acceleration.y, velocity.y);
		playerSprite.acceleration.x = 0;
		// Handle Actual Movement
		if (left || right) {
			var newAngle:Float = 0;

			if (left) {
				playerSprite.flipX = true;
				playerSprite.acceleration.x -= PLAYER_SPEED;
			}
			if (right) {
				playerSprite.flipX = false;
				playerSprite.acceleration.x += PLAYER_SPEED;
			}

			// Tween The Sprite
		}
		playerSprite.bound(0, miniGameCamera.width, 0, miniGameCamera.height);
	}

	public function updateSpawnEnemies(elapsed:Float) {}

	public function updateCollisions() {
		playerCollisions();
		enemyCollisions();
	}

	public function playerCollisions() {
		FlxG.overlap(playerSprite, enemyBullets, playerTouchEnemyBullet);
		FlxG.overlap(playerSprite, enemyShips, playerTouchEnemy);
	}

	public function playerTouchEnemyBullet(player:FlxSprite,
			enemyBullet:Bullet) {
		enemyBullet.kill();
		player.kill();
	}

	public function playerTouchEnemy(player:FlxSprite, enemy:Enemy) {
		enemy.kill();
		player.kill();
	}

	public function enemyCollisions() {
		FlxG.overlap(enemyShips, playerBullets, enemyTouchPlayerBullet);
	}

	public function enemyTouchPlayerBullet(enemy:Enemy, playerBullet:Bullet) {
		enemy.kill();
		playerBullet.kill();
	}

	override public function processReward() {
		var rating = null;
		// TODO: Add Rating Score criteria
		if (playerSprite.alive && time <= 0) {
			rating = Amazing;
		} else if (!playerSprite.alive && time <= 30 && time > 15) {
			rating = Good;
		} else if (!playerSprite.alive && time <= 15 && time > 0) {
			rating = Great;
		}
		var rewardState = new RewardSubState(miniGameCamera, player,
			Dex(player.dex), rating);
		rewardState.closeCallback = () -> {
			stateEnd();
		};

		openSubState(rewardState);
	}
}