package game.states;

import game.chars.Gal;
import game.ui.File;

class LoadSubState extends FileSubState {
	override public function setTitleText() {
		titleText.text = 'Load';
		titleText.alignment = CENTER;
	}

	// Need to gather up and track game data
	override public function clickFile(file:File) {
		// Grab Load Save Data
		SaveLoad.Save.loadSaveData(file.saveID, (state) -> {
			var gameData = SaveLoad.Save.gameData;
			gameData.days = state.days;
			gameData.gameTime = state.gameTime;
			// Set Player Stats
			gameData.player = new Gal(0, 0, state.playerStats);
			gameData.player.happiness = state.playerHappinessLvl;
			gameData.player.affection = state.playerAffectionLvl;
			// Start loading into the  HubState
			FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
				close();
				// FlxG.camera.fade(KColor.BLACK, 1, true);
				FlxG.switchState(new HubState());
			});
		});
	}
}