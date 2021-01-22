package game.states;

import game.ui.File;
import flixel.util.FlxAxes;

class FileSubState extends FlxSubState {
	public var titleText:FlxText;
	public var fileSprites:Array<File>;
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

	public function createFileList() {
		var padding = 25;
		var y = titleText.y + titleText.height + padding;
		var x = FlxG.width / 2 - (File.WIDTH / 2);
		for (i in 0...Globals.GAME_SAVE_SLOTS) {
			var file = new File(i + 1, x, y);
			add(file);
			y += File.HEIGHT + padding;
		}
	}

	public function clickBack() {
		save.close();
		FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
			close();
			FlxG.camera.fade(KColor.BLACK, 1, true);
		});
	}
}