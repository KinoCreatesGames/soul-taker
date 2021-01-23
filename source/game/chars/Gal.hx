package game.chars;

import game.chars.Char;

class Gal extends Char {
	/**
	 * The current happiness Gal has when doing a task.
	 */
	public var happiness:Float;

	/**
	 * The amount of affection the Gal has for the MC.
	 */
	public var affection:Float;

	public function new(x:Float, y:Float, data:Actor) {
		super(x, y, data);
		happiness = 75;
		makeGraphic(64, 64, KColor.SNOW);
	}
}