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

	public function addToStat(stat:Stat) {
		switch (stat) {
			case Atk(value):
				this.atk += value;
			case Def(value):
				this.def += value;
			case Dex(value):
				this.dex += value;
			case Agi(value):
				this.agi += value;
			case Intl(value):
				this.intl += value;
		}
	}

	public function setToStat(stat:Stat) {
		switch (stat) {
			case Atk(value):
				this.atk = value;
			case Def(value):
				this.def = value;
			case Dex(value):
				this.dex = value;
			case Agi(value):
				this.agi = value;
			case Intl(value):
				this.intl = value;
		}
	}

	public function setHappiness(value:Float) {
		happiness = value;
	}

	public function addHappiness(value:Float) {
		happiness += value;
	}

	public function setAffection(value:Float) {
		affection = value;
	}

	public function addAffection(value:Float) {
		affection += value;
	}
}