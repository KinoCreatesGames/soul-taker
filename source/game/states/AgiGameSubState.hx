package game.states;

import flixel.addons.effects.chainable.FlxTrailEffect;
import flixel.addons.effects.chainable.FlxEffectSprite;
import game.chars.Bullet;

/**
 * An agility based mini game where you dodge elements falling
 * from the sky.
 */
class AgiGameSubState extends MiniGameSubState {
	public var playerSprite:FlxSprite;
	public var effectSprite:FlxEffectSprite;
	public var trail:FlxTrailEffect;
	public var enemyBullets:FlxTypedGroup<Bullet>;

	public static inline var SPEED:Float = 800;

	public static inline var BULLET_CD:Float = 0.15;
	public static inline var INVINCIBLE_CD:Float = 2.0;

	override public function createElements() {
		super.createElements();
		createPlayer();
		createBullets();
	}

	public function createPlayer() {
		var x = miniGameCamera.width / 2;
		var y = miniGameCamera.height / 2;
		playerSprite = new FlxSprite(x, y);
		playerSprite.makeGraphic(8, 8, KColor.SNOW);
		playerSprite.drag.x = playerSprite.drag.y = 640;
		effectSprite = new FlxEffectSprite(playerSprite);
		trail = new FlxTrailEffect(effectSprite, 3, 0.5, 4);

		// Have to add the effect to the effect sprite after adding it othe trail
		effectSprite.effects = [trail];
		add(effectSprite);
		add(playerSprite);
	}

	public function createBullets() {
		enemyBullets = new FlxTypedGroup<Bullet>(20);
		add(enemyBullets);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updatePlayerMovement(elapsed);
		updateGameOver();
	}

	public function updatePlayerMovement(elapsed:Float) {
		var left = false;
		var right = false;

		playerSprite.maxVelocity.set(120, 200);
		effectSprite.setPosition(playerSprite.x, playerSprite.y);

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
				playerSprite.acceleration.x -= SPEED;
			}
			if (right) {
				playerSprite.flipX = false;
				playerSprite.acceleration.x += SPEED;
			}

			// Tween The Sprite

			playerSprite.bound(0, miniGameCamera.width, 0,
				miniGameCamera.height);
		}
	}

	public function updateGameOver() {
		if (!playerSprite.alive) {
			stateEnd();
		}
	}

	public function updateCollisions() {
		playerCollisions();
	}

	public function playerCollisions() {
		FlxG.overlap(playerSprite, enemyBullets, playerTouchBullet);
	}

	public function playerTouchBullet(playerSprite:FlxSprite, bullet:Bullet) {
		playerSprite.kill();
		bullet.kill();
	}
}