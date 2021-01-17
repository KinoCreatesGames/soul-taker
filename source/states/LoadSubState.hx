package states;

class LoadSubState extends FileSubState {
	override public function setTitleText() {
		titleText.text = 'Load';
		titleText.alignment = CENTER;
	}
}