package game.states;

class PauseSubState extends FlxSubState {
	public var pauseText:FlxText;

	private var initialPosition:Float;
	private var timeCount:Float;

	override public function create() {
		FlxG.mouse.visible = true;
		pauseText = new FlxText(0, 0, -1, 'Pause', 32);
		pauseText.screenCenter();
		pauseText.y -= 30;
		pauseText.scrollFactor.set(0, 0);
		initialPosition = pauseText.y;
		add(pauseText);
		var resumeButton = new FlxButton(0, 0, 'Resume', resumeGame);
		resumeButton.screenCenter();
		resumeButton.y += 40;
		var returnToTitleButton = new FlxButton(0, 0, 'To Title', toTitle);
		returnToTitleButton.screenCenter();
		returnToTitleButton.y += 80;
		add(resumeButton);
		add(returnToTitleButton);
		super.create();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updatePausePosition(elapsed);
	}

	public function updatePausePosition(elapsed:Float) {
		timeCount += elapsed;
		pauseText.y = initialPosition + (30 * Math.sin(timeCount));
		if (timeCount > 30) {
			timeCount = 0;
		}
	}

	public function resumeGame() {
		close();
	}

	public function toTitle() {
		FlxG.switchState(new TitleState());
	}
}