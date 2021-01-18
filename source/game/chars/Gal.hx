package game.chars;

import game.chars.Char;

class Gal extends Char {
	public function new(x:Float, y:Float) {
		super(x, y);
		makeGraphic(64, 64, KColor.SNOW);
	}
}