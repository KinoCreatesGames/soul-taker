package game.states;

import flixel.util.FlxAxes;

class OptionsSubState extends FlxSubState {
	public var optionsText:FlxText;
	public var volumeBar:FlxBar;
	public var volumeText:FlxText;
	public var volumeAmountText:FlxText;
	public var volumeUpButton:FlxButton;
	public var volumeDownButton:FlxButton;
	public var skipLabelText:FlxText;
	public var skipMiniGamesText:FlxText;
	public var skipUpButton:FlxButton;
	public var skipDownButton:FlxButton;
	public var textSpeedLabelText:FlxText;
	public var textSpeedUpButton:FlxButton;
	public var textSpeedModeText:FlxText;
	public var textSpeedDownButton:FlxButton;
	public var backButton:FlxButton;

	private var save:FlxSave;

	public function new() {
		super(KColor.RICH_BLACK_FORGRA);
	}

	override public function create() {
		FlxG.mouse.visible = true;
		save = SaveLoad.Save.createSaveSettings();
		createTitleText();
		createOptions();
		createSkip();
		createTextSpeed();
		super.create();
	}

	public function createTitleText() {
		optionsText = new FlxText(0, 40, -1, Globals.TEXT_OPTIONS, 32);
		optionsText.screenCenter(FlxAxes.X);
		add(optionsText);
	}

	public function createOptions() {
		var pos = new FlxPoint(0, 0);
		pos.y = optionsText.y + 40;
		createVolume(pos);
		createBackButton();
	}

	public function createVolume(position:FlxPoint) {
		volumeText = new FlxText(0, optionsText.y + optionsText.height + 10,
			0, 'Volume', 16);
		volumeText.alignment = CENTER;
		volumeText.screenCenter(FlxAxes.X);
		add(volumeText);

		// Volume Button smaller than 'default' buttons
		volumeDownButton = new FlxButton(8,
			volumeText.y + volumeText.height + 2, '-', clickVolumeDown);
		volumeDownButton.loadGraphic(AssetPaths.button__png, true, 20, 20);
		// volumeDownButton.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(volumeDownButton);

		volumeUpButton = new FlxButton(FlxG.width - 28, volumeDownButton.y,
			"+", clickVolumeUp);
		volumeUpButton.loadGraphic(AssetPaths.button__png, true, 20, 20);
		// volumeUpButton.onUp.sound =
		add(volumeUpButton);

		volumeBar = new FlxBar(volumeDownButton.x + volumeDownButton.width + 4,
			volumeDownButton.y, LEFT_TO_RIGHT, Std.int(FlxG.width - 64),
			Std.int(volumeUpButton.height));
		volumeBar.createFilledBar(0xff464646, KColor.SNOW, true, KColor.WHITE);
		add(volumeBar);

		volumeAmountText = new FlxText(0, 0, 200,
			(FlxG.sound.volume * 100) + '%', 8);
		volumeAmountText.alignment = CENTER;
		volumeAmountText.borderStyle = FlxTextBorderStyle.OUTLINE;
		volumeAmountText.borderColor = 0xff464646;
		volumeAmountText.y = volumeBar.y
			+ (volumeBar.height / 2)
			- (volumeAmountText.height / 2);
		volumeAmountText.screenCenter(FlxAxes.X);
		add(volumeAmountText);
		updateVolume();
	}

	public function createSkip() {
		var pos = volumeAmountText.getPosition();
		var spacing = 48;
		var horizontalSpacing = 48;
		var x = volumeDownButton.x;
		var y = pos.y + spacing;
		skipLabelText = new FlxText(x, y, -1, 'Skip Mini Games',
			Globals.FONT_N);
		x += (horizontalSpacing * 2) + skipLabelText.width;
		skipDownButton = new FlxButton(x, y, '<-', clickSkip);
		skipDownButton.loadGraphic(AssetPaths.button__png, true, 20, 20);
		x += horizontalSpacing;
		skipMiniGamesText = new FlxText(x, y, -1, 'No', Globals.FONT_N);
		x += horizontalSpacing;
		skipUpButton = new FlxButton(x, y, '->', clickSkip);
		skipUpButton.loadGraphic(AssetPaths.button__png, true, 20, 20);

		add(skipLabelText);
		add(skipDownButton);
		add(skipMiniGamesText);
		add(skipUpButton);
		updateSkip();
	}

	public function clickSkip() {
		skipMiniGamesText.text = skipMiniGamesText.text == 'No' ? 'Yes' : 'No';
		// Update skipMiniGames
		save.data.skipMiniGames = skipMiniGamesText.text == 'Yes' ? true : false;
	}

	public function createTextSpeed() {
		var pos = skipLabelText.getPosition();
		var spacing = 48;
		var horizontalSpacing = 48;
		var x = volumeDownButton.x;
		var y = pos.y + spacing;
		textSpeedLabelText = new FlxText(x, y, -1, 'Text Speed',
			Globals.FONT_N);
		x += (horizontalSpacing * 2) + skipLabelText.width;
		textSpeedDownButton = new FlxButton(x, y, '<-', clickSpeedDown);
		textSpeedDownButton.loadGraphic(AssetPaths.button__png, true, 20, 20);
		x += horizontalSpacing;
		textSpeedModeText = new FlxText(x, y, -1, 'Normal', Globals.FONT_N);
		x += horizontalSpacing + 12;
		textSpeedUpButton = new FlxButton(x, y, '->', clickSpeedUp);
		textSpeedUpButton.loadGraphic(AssetPaths.button__png, true, 20, 20);

		add(textSpeedLabelText);
		add(textSpeedDownButton);
		add(textSpeedModeText);
		add(textSpeedUpButton);
		updateTextMode();
	}

	public function clickSpeedUp() {
		switch (textSpeedModeText.text) {
			case 'Normal':
				textSpeedModeText.text = 'Fast';
			case 'Slow':
				textSpeedModeText.text = 'Normal';
			case 'Fast':
				textSpeedModeText.text = 'Slow';
			case _:
				// Do nothing
		}
		save.data.modeText = textSpeedModeText.text;
		updateTextMode();
	}

	public function clickSpeedDown() {
		switch (textSpeedModeText.text) {
			case 'Normal':
				textSpeedModeText.text = 'Slow';
			case 'Slow':
				textSpeedModeText.text = 'Fast';
			case 'Fast':
				textSpeedModeText.text = 'Normal';
			case _:
				// Do nothing
		}
		save.data.modeText = textSpeedModeText.text;
		updateTextMode();
	}

	public function createBackButton() {
		backButton = new FlxButton(20, 20, Globals.TEXT_BACK, clickBack);
		add(backButton);
	}

	public function clickVolumeDown() {
		FlxG.sound.volume -= 0.1;
		save.data.volume = FlxG.sound.volume;
		updateVolume();
	}

	public function clickVolumeUp() {
		FlxG.sound.volume += 0.1;
		save.data.volume = FlxG.sound.volume;
		updateVolume();
	}

	public function clickBack() {
		save.close();
		FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
			close();
			FlxG.camera.fade(KColor.BLACK, 1, true);
		});
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	public function updateVolume() {
		var volume:Int = Math.round(FlxG.sound.volume * 100);
		volumeBar.value = volume;
		volumeAmountText.text = volume + '%';
	}

	public function updateTextMode() {
		trace(textSpeedModeText.text, save.data.modeText);
		textSpeedModeText.text = save.data.modeText;
	}

	public function updateSkip() {
		skipMiniGamesText.text = save.data.skipMiniGames ? 'Yes' : 'No';
	}
}