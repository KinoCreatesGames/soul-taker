package game.states;

import flixel.util.FlxAxes;
import flixel.FlxCamera;
import game.chars.Gal;

/**
 * Substate for creating mini games in game.
 */
class MiniGameSubState extends FlxSubState {
	public var player:Gal;
	public var miniGameCamera:FlxCamera;
	public var timeText:FlxText;
	public var time:Float;
	public var background:FlxSprite;

	public static inline var DEFAULT_TIME:Float = 30;

	public function new(x:Int, y:Int, width:Int, height:Int, gal:Gal) {
		player = gal;
		time = DEFAULT_TIME;
		createCamera(x, y, width, height);

		super();
	}

	override public function create() {
		createElements();
		addMembersToCamera();
		super.create();
	}

	/**
	 * Custom Create Function for Proper Ordering of Methods Per Mini Game
	 */
	public function createElements() {
		createBackground();
		createText();
	}

	public function addMembersToCamera() {
		members.iter((member) -> {
			member.camera = miniGameCamera;
		});
	}

	/**
	 * Creates the camera for the scene for a new view point.
	 */
	public function createCamera(x:Int, y:Int, width:Int, height:Int) {
		miniGameCamera = new FlxCamera(x, y, width, height);
		FlxG.cameras.add(miniGameCamera);
	}

	public function createBackground() {
		background = new FlxSprite(0, 0);
		background.makeGraphic(miniGameCamera.width, miniGameCamera.height,
			KColor.RICH_BLACK_FORGRA);
		add(background);
	}

	public function createText() {
		timeText = new FlxText(0, 0, -1, 'Time: ${0}', Globals.FONT_L);
		timeText.alignment = CENTER;
		timeText.x = (miniGameCamera.width / 2) - (timeText.width / 2);
		// timeText.camera = miniGameCamera;
		add(timeText);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateTime(elapsed);
	}

	public function updateTime(elapsed:Float) {
		if (time >= 0) {
			time -= elapsed;
			timeText.text = 'Time   ${Math.ceil(time)}';
		}

		if (time <= 0) {
			// Perform State End
			processReward();
		}
	}

	public function setTime() {
		time = DEFAULT_TIME;
	}

	/**
	 * Empty method for overwriting to calculate reward for any mini game.
	 */
	public function processReward() {}

	/**
	 * Closes the state when you're ready
	 */
	public function stateEnd() {
		FlxG.cameras.remove(miniGameCamera);
		close();
	}
}