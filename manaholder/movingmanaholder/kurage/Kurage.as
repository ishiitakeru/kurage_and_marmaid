//パッケージ名
package manaholder.movingmanaholder.kurage{
	//インポートをインクルードで一括
	include "../../../IncludeImport.as";

	/** 
	 * クラゲクラス
	 *
	 * @extend manaholder.MovingManaHolder
	 * @access public
	 */
	public class Kurage extends MovingManaHolder{

		//////////////////////////////////////////////////////
		//プロパティ

		//タイマー/////////////////////////////////////////
		/** マナ移動：海藻→クラゲのためのタイマーインスタンス */
		public var seaWeedKurageTimer:Timer;

		/** マナ移動：クラゲ→人魚のためのタイマーインスタンス */
		public var kurageMarmaidTimer:Timer;

		//場所/////////////////////////////////////////
		/** 海藻を食べる場所 */
		private var myPlaceForEatingSeaWeedX:Number;
		private var myPlaceForEatingSeaWeedY:Number;

		/** 人魚といちゃつく位置 */
		private var positionForLovingMarmaidX:Number;
		private var positionForLovingMarmaidY:Number;

		/** 人魚の歌を聞く場所 */
		private var placeToListenMarmaidsSongX:Number;
		private var placeToListenMarmaidsSongY:Number;


		//////////////////////////////////////////////////////
		//メソッド
		/** 
		 * コンストラクタ
		 *
		 * マナ上限値設定
		 *
		 * @access public
		 */
		public function Kurage():void{

			//マナ上限値
			this.max_mana = 50;

			//大きさ調整
			this.basesize = 0.6;//作成したムービークリップのN倍
			this.scaleX = basesize;
			this.scaleY = basesize;

			//通常の向きの時のX比率
			normal_scale = basesize;
			//反対の向きの時のX比率
			opposite_scale = basesize * -1;

			//向き
			this.direction_default = "left";
			this.direction = direction_default;

			this.placeToListenMarmaidsSongX = 260;
			this.placeToListenMarmaidsSongY = 240;

			//現在の行動
			this.currentAction = "default";
			//クラゲの行動：
				//default
				//eat_seaweed
				//moving_to_seaweed
				//eating_seaweed
				//give_mana_to_marmaid
				//moving_to_marmaid
				//giving_mana_to_marmaid
				//wandering

			//AIファイル
			include "KurageAI.as";

		}//function


		//メソッドファイル
		include "KurageMethodTimer.as";
		include "KurageMethodEnterFrame.as";
		include "KurageMethodGetterSetter.as";

	}//class
}//package