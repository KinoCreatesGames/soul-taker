package states;

class HubState extends FlxState {
	public var charSprite:FlxSprite;

	public var statsButton:FlxButton;
	public var saveButton:FlxButton;
	public var optionsButton:FlxButton;

	override public function create() {
		FlxG.mouse.visible = true;
		createBackground();
		createButtons();
		createCharacter();
	}

	public function createBackground() {
		// Background for character as a pixel art room
	}

	public function createButtons() {
		// Add Buttons
		var x = FlxG.width - 80;
		var y = 20;
		statsButton = new FlxButton(x, y, 'Stats', clickStats);
		x += 20;
		saveButton = new FlxButton(x, y, 'Save', clickSave);
		x += 20;
		optionsButton = new FlxButton(x, y, 'Options', clickOptions);

		// Add Buttons to  screen
		add(statsButton);
		add(saveButton);
		add(optionsButton);
	}

	public function createCharacter() {}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updatePause();
	}

	public function updatePause() {
		if (FlxG.keys.anyPressed([ESCAPE])) {
			openSubState(new PauseSubState());
		}
	}

	// Buttons

	public function clickStats() {
		openSubState(new StatsSubState());
	}

	public function clickSave() {
		openSubState(new SaveSubState());
	}

	public function clickOptions() {
		openSubState(new OptionsSubState());
	}
}