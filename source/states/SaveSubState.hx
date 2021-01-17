package states;

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
}