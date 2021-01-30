package game.states;

class IntlGameSubState extends MiniGameSubState {
	override public function processReward() {
		var rating = null;
		// TODO: Add Rating Score criteria
		var rewardState = new RewardSubState(miniGameCamera, player,
			Intl(player.intl), rating);
		rewardState.closeCallback = () -> {
			stateEnd();
		};

		openSubState(rewardState);
	}
}