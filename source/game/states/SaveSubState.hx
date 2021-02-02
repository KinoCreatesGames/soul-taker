package game.states;

import game.ui.File;

class SaveSubState extends FileSubState {
	override public function create() {
		super.create();
	}

	override public function setTitleText() {
		titleText.text = 'Save';
		titleText.alignment = CENTER;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	// Need to gather up and track game data
	override public function clickFile(file:File) {
		var saveSlot = SaveLoad.Save.createSaveData(file.saveID);
		var currentData = SaveLoad.Save.gameData;
		var player = currentData.player;
		var data:GameSaveState = {
			days: currentData.days,
			saveIndex: file.saveID,
			playerStats: cast {
				name: player.name,
				atk: player.atk,
				def: player.def,
				agi: player.agi,
				health: player.health,
			},
			playerAffectionLvl: cast player.affection,
			playerHappinessLvl: cast player.happiness,
			gameTime: currentData.gameTime,
			realTime: Date.now().getTime()
		};
		// Use saveData
		saveSlot.data.saveData = data;
		saveSlot.close();
		// Update File Properties
		file.realTime = data.realTime;
		file.gameTime = data.gameTime;
		file.updateSaveText();
	}
}