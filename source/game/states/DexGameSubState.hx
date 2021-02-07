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
	}

	public function createPlayer() {
		var x = miniGameCamera.width / 2;
		var y = miniGameCamera.height / 2;

		playerSprite = new FlxSprite(x, y);
		playerSprite.makeGraphic(8, 8, KColor.SNOW);
		add(playerSprite);
	}

	public function createEnemyShips() {
		enemyShips = new FlxTypedGroup<Enemy>(10);
		add(enemyShips);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateSpawnEnemies(elapsed);
	}

	public function updateSpawnEnemies(elapsed:Float) {}

	override public function processReward() {
		var rating = null;
		// TODO: Add Rating Score criteria
		var rewardState = new RewardSubState(miniGameCamera, player,
			Dex(player.dex), rating);
		rewardState.closeCallback = () -> {
			stateEnd();
		};

		openSubState(rewardState);
	}
}