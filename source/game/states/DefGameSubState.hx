package game.states;

class DefGameSubState extends MiniGameSubState {
	override public function processReward() {
		var rating = null;
		// TODO: Add Rating Score
		var rewardState = new RewardSubState(miniGameCamera, player,
			Def(player.def), rating);
		rewardState.closeCallback = () -> {
			stateEnd();
		};
		openSubState(rewardState);
	}
}