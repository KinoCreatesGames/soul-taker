package states;

class StatsSubState extends FlxSubState {
	public var background:FlxSprite;
	public var charSprite:FlxSprite;

	override public function create() {
		FlxG.mouse.visible = true;
		createBackground();
		createButtons();
		createCharacter();
	}

	public function createBackground() {
		// Based on Screen Ratio
		// 2: 1 Ratio for Screen Here
		var leftPortion = (FlxG.width / 3) * 2;
		var rightPortion = FlxG.width / 3;
		background = new FlxSprite(0, 0);
		// Draw Right
		background.drawRect(leftPortion, 0, rightPortion, FlxG.height,
			KColor.BURGUNDY);
	}

	public function createButtons() {
		var exitButton = new FlxButton(20, 20, Globals.TEXT_RETURN, resumeGame);
		add(exitButton);
	}

	public function createCharacter() {
		var leftPortion = (FlxG.width / 3) * 2;
		var position = leftPortion / 2;
		charSprite = new FlxSprite(position, FlxG.height / 2);
		charSprite.makeGraphic(32, 32, FlxColor.WHITE);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	public function resumeGame() {
		close();
	}
}