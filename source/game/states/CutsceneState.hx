package game.states;

import flixel.addons.text.FlxTypeText;

class CutsceneState extends FlxState {
	public var sceneText:FlxTypeText;
	public var textIndex:Int;
	public var textList:Array<SceneText>;
	public var nextState:FlxState;
	public var skipBar:FlxBar;
	public var skipText:FlxText;
	public var skipThreshold:Float;
	public var skipPerc:Int;

	/** *  Delay before transitioning to the next text in seconds.
	 */
	public var textDelay:Float;

	public static inline var TEXT_WIDTH:Int = 400;
	public static inline var INIT_TEXT_DELAY:Int = 3;
	public static inline var SKIP_THRESHOLD:Float = 2.5;

	public function new(newState:FlxState, textInfo:Array<SceneText>) {
		textIndex = -1;
		skipThreshold = 0;
		skipPerc = 0;
		textList = textInfo;
		nextState = newState;
		textDelay = 0;

		super();
	}

	override public function create() {
		createSkip();
		createSceneText();
		transitionText();
		super.create();
	}

	public function createSkip() {
		var margin = 48;
		var barWidth = 100;
		var x = FlxG.width - (barWidth + margin);
		var y = margin;
		skipBar = new FlxBar(x, y, LEFT_TO_RIGHT, barWidth, 10, this,
			"skipPerc", 0, 100, true);
		skipBar.createFilledBar(KColor.BLACK, KColor.SNOW);
		skipText = new FlxText(skipBar.x + (skipBar.width / 2),
			skipBar.y + skipBar.height / 2, 50, 'Skip', 8);
		skipBar.visible = false;
		skipText.visible = false;
		add(skipText);
		add(skipBar);
	}

	public function createSceneText() {
		sceneText = new FlxTypeText(0, 0, TEXT_WIDTH, '', Globals.FONT_L);
		sceneText.screenCenter();
		add(sceneText);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateSkip(elapsed);
		updateText(elapsed);
	}

	public function updateSkip(elapsed:Float) {
		// Update Perc
		skipPerc = Math.round(skipThreshold / SKIP_THRESHOLD);
		if (skipPerc > 0) {
			skipBar.visible = true;
			skipBar.visible = true;
		} else {
			skipBar.visible = false;
			skipText.visible = false;
		}
		if (FlxG.keys.anyPressed([Z])) {
			skipThreshold += elapsed;
		} else {
			skipThreshold -= elapsed;
		}

		if (skipThreshold >= SKIP_THRESHOLD) {
			transitionToScene();
		}
	}

	public function updateText(elapsed:Float) {
		var currentText = textList[textIndex % textList.length];
		if (textIndex < textList.length - 1) {
			if (textDelay > currentText.delay) {
				transitionText();
			}
		} else if (textDelay > currentText.delay) {
			transitionToScene();
		}
		textDelay += elapsed;
	}

	public function transitionText() {
		textIndex++;

		var currentText = textList[textIndex % textList.length];
		sceneText.resetText(currentText.text);
		sceneText.start(0.05);
		textDelay = 0;
	}

	public function transitionToScene() {
		FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
			FlxG.camera.fade(KColor.BLACK, 1, true);
			FlxG.switchState(nextState);
		});
	}
}