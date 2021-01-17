package states;

class HubState extends FlxState {
	public var charSprite:FlxSprite;

	override public function create() {
		FlxG.mouse.visible = true;
	}

	public function createBackground() {}

	public function createCharacter() {}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	// Buttons

	public function clickStats() {}

	public function clickOptions() {}
}