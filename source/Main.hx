package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();
		addChild(new FlxGame(0, 0, TitleState));
		loadSettings();
	}

	public function loadSettings() {
		// Saves The Options For The Game
		var save = new FlxSave();
		save.bind(Globals.SAVE_SETTINGS);
		// Set Volume
		if (save.data.volume != null) {
			FlxG.sound.volume = save.data.volume;
		}
		save.close();
	}
}