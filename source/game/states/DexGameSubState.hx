package game.states;

class DexGameSubState extends MiniGameSubState {
	override public function processReward() {
		var rating = null;
		// TODO: Add Rating Score criteria
		var rewardState = new RewardSubState(miniGameCamera, player,
			Dex(player.dex), rating);
		rewardState.closeCallback = () -> {
			stateEnd();
		};

		openSubState(rewardState);
	}
}