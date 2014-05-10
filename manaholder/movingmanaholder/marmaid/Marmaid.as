//パッケージ名
package manaholder.movingmanaholder.marmaid{
	//インポートをインクルードで一括
	include "../../../IncludeImport.as";

	/** 
	 * 人魚クラス
	 *
	 * @extend manaholder.MovingManaHolder
	 * @access public
	 */
	public class Marmaid extends MovingManaHolder{

		//////////////////////////////////////////////////////
		//プロパティ
		/** マナ移動：人魚→海のためのタイマーインスタンス */
		public var marmaidTheSeaTimer:Timer;

		/** いちゃつく際の相手の位置の座標 */
		private var positionForBeingLovedX:Number;
		private var positionForBeingLovedY:Number;

		/** 歌うための場所の座標 */
		private var myPlaceForSingingX:Number;
		private var myPlaceForSingingY:Number;


		//////////////////////////////////////////////////////
		//メソッド
		/** 
		 * コンストラクタ
		 *
		 * マナ上限値設定
		 *
		 * @access public
		 */
		public function Marmaid():void{

			//マナ上限値
			this.max_mana = 100;
			this.mana = 0;

			//向き
			this.direction_default = "right";
			this.direction = direction_default;

			//大きさ調整
			this.basesize = 1;
			this.scaleX = basesize;
			this.scaleY = basesize;

			//通常の向きの時のX比率
			normal_scale = basesize;
			//反対の向きの時のX比率
			opposite_scale = basesize * -1;

			//現在の行動
			this.currentAction = "default";
			//人魚の行動：
				//default
				//sing
				//moving_to_the_stage_for_singing
				//singing
				//wandering

			//いちゃつくための場所
			this.positionForBeingLovedX = this.x;
			this.positionForBeingLovedY = this.y;

			//AIファイル
			include "MarmaidAI.as";

		}//function

		//メソッドファイル
		include "MarmaidMethodTimer.as";
		include "MarmaidMethodEnterFrame.as";
		include "MarmaidMethodGetterSetter.as";

	}//class
}//package
