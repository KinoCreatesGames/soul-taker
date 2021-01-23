package game.states;

import flixel.addons.text.FlxTypeText;

class CutsceneState extends FlxState {
	public var sceneText:FlxTypeText;
	public var textIndex:Int;
	public var textList:Array<SceneText>;
	public var nextState:FlxState;
	public var skipThreshold:Float;

	/**
	 *  Delay before transitioning to the next text in seconds.
	 */
	public var textDelay:Float;

	public static inline var TEXT_WIDTH:Int = 400;
	public static inline var INIT_TEXT_DELAY:Int = 3;
	public static inline var SKIP_THRESHOLD:Float = 2.5;

	public function new(newState:FlxState, textInfo:Array<SceneText>) {
		textIndex = -1;
		skipThreshold = SKIP_THRESHOLD;
		textList = textInfo;
		nextState = newState;
		textDelay = 0;

		super();
	}

	override public function create() {
		createSceneText();
		transitionText();
		super.create();
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
		if (FlxG.keys.anyPressed([Z])) {
			skipThreshold -= elapsed;
		} else {
			skipThreshold = SKIP_THRESHOLD;
		}

		if (skipThreshold <= 0) {
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