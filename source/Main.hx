package;

import game.chars.Char;
import game.chars.Gal;
import flixel.system.frontEnds.PluginFrontEnd;
import flixel.FlxG;
import flixel.util.FlxSave;
import game.states.TitleState;
import flixel.FlxGame;
import openfl.display.Sprite;
import game.SaveLoad;

class Main extends Sprite {
	public function new() {
		super();

		addChild(new FlxGame(0, 0, TitleState));
		// Add Save Load on Game Start
		SaveLoad.initializeSave();
		SaveLoad.Save.loadSettings();
	}
}