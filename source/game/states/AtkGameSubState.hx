package game.states;

class AtkGameSubState extends MiniGameSubState {
	override public function processReward() {
		var rating = null;
		// TODO: Add Rating Score
		var rewardState = new RewardSubState(miniGameCamera, player,
			Agi(player.atk), rating);
		rewardState.closeCallback = () -> {
			stateEnd();
		};

		openSubState(rewardState);
	}
}