package game.states;

import flixel.util.FlxAxes;

class OptionsSubState extends FlxSubState {
	public var optionsText:FlxText;
	public var volumeBar:FlxBar;
	public var volumeText:FlxText;
	public var volumeAmountText:FlxText;
	public var volumeUpButton:FlxButton;
	public var volumeDownButton:FlxButton;
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
}