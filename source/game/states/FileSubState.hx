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
			var file = new File(i + 1, x, y, clickFile);
			// pass in game data to make it easier
			add(file);
			y += File.HEIGHT + padding;
			// Update File If Save Exits
			updateFileProperties(file, i + 1);
		}
	}

	public function updateFileProperties(file:File, id:Int) {
		var saveData = SaveLoad.Save.createSaveData(id);
		if (saveData.data.saveData != null) {
			var data = saveData.data.saveData;
			file.realTime = data.realTime;
			file.gameTime = data.gameTime;
			file.updateSaveText();
		}
	}

	public function clickFile(file:File) {}

	public function clickBack() {
		// Shouldn't be saving here, should be saving onClick
		// save.close();
		FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
			close();
			FlxG.camera.fade(KColor.BLACK, 1, true);
		});
	}
}