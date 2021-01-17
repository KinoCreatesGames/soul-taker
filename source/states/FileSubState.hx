package states;

import flixel.util.FlxAxes;

class FileSubState extends FlxSubState {
	public var titleText:FlxText;
	public var fileSprites:Array<FlxSprite>;
	public var backButton:FlxButton;

	private var save:FlxSave;

	override public function create() {
		FlxG.mouse.visible = true;
		save = new FlxSave();
		save.bind(Globals.SAVE_DATA);
		fileSprites = [];
		createTitleText();
		createBackButton();
		createFileList();
		super.create();
	}

	public function createBackButton() {
		backButton = new FlxButton(20, 20, Globals.TEXT_BACK, clickBack);
		add(backButton);
	}

	public function createTitleText() {
		titleText = new FlxText(0, 40, -1, '', 32);
		titleText.screenCenter(FlxAxes.X);
		add(titleText);
	}

	public function setTitleText() {
		titleText.text = '';
	}

	public function createFileList() {}

	public function clickBack() {
		save.close();
		FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
			close();
			FlxG.camera.fade(KColor.BLACK, 1, true);
		});
	}
}