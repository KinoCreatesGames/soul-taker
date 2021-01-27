package game;

import flixel.FlxBasic;

class SaveLoad extends FlxBasic {
	/**
	 * Current Game State Information for passing to save files
	 */
	public var gameData:GameState;

	public static inline var SAVE_SETTINGS = 'SoulSettings';
	public static inline var SAVE_DATA_PREFIX = 'SoulData';
	public static var Save(get, null):SaveLoad;

	public static function initializeSave() {
		var save = new SaveLoad();
		save.gameData = {
			days: 0,
			player: null,
			gameTime: 0,
		};
		FlxG.plugins.list.push(save);
	};

	public static function get_Save():SaveLoad {
		return cast(FlxG.plugins.get(SaveLoad), SaveLoad);
	}

	public function createSaveSettings():FlxSave {
		var save = new FlxSave();
		save.bind(SAVE_SETTINGS);
		return save;
	}

	public function loadSettings() {
		// Saves The Options For The Game
		var save = createSaveSettings();
		// Set Volume
		if (save.data.volume != null) {
			FlxG.sound.volume = save.data.volume;
		}
		save.close();
	}

	public function createSaveData(saveId:Int):FlxSave {
		var save = new FlxSave();
		save.bind(SAVE_DATA_PREFIX + saveId);
		return save;
	}

	public function createLoadSaveData(saveId:Int):FlxSave {
		return createSaveData(saveId);
	}

	/**
	 * Returns the loaded save file.
	 * Accessing it via your fn
	 * and close the file after loading complete.
	 * @param saveId
	 * @return FlxSave
	 */
	public function loadSaveData(saveId:Int, loadFn:GameSaveState -> Void) {
		var save = createSaveData(saveId);
		var data:GameSaveState = save.data.saveData;
		loadFn(data);
		save.close();
	}
}