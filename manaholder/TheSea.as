//パッケージ名
package manaholder{
	//インポートをインクルードで一括
	include "../IncludeImport.as";

	/** 
	 * 海クラス
	 *
	 * @extend manaholder.ManaHolder
	 * @access public
	 */
	public class TheSea extends manaholder.ManaHolder{

		//////////////////////////////////////////////////////
		//プロパティ
		/** 人魚が歌っている時徐々に明るくなるためのタイマー */
		public var beingBrightedTimer:Timer;

		//////////////////////////////////////////////////////
		//メソッド
		/** 
		 * コンストラクタ
		 *
		 * マナの初期値。この世界でのマナ総量である100を保持。
		 *
		 * @access public
		 */
		public function TheSea():void{
			//マナ量初期化
			this.mana = 100;
			//this.mana = 0;	//テスト用

			//マナ上限値
			//この世界のマナ総量
			this.max_mana = 100;

			//タイマーイベント
			//人魚が歌っている時徐々に明るくなる
			this.beingBrightedTimer = new Timer(1 * 1000);//1秒
			this.beingBrightedTimer.addEventListener(TimerEvent.TIMER, beingBrighted);

			//イベントリスナー
			//常にプロパティを監視
			this.addEventListener(Event.ENTER_FRAME, watchManaAmount);
		}//function


		//////////////////////////////////////////////////////
		/** 
		 * リスナーメソッド：
		 *
		 * マナの量によって海の明るさを変える
		 *
		 * @access public
		 */
		public function watchManaAmount(event:Event):void{
			if(this.myMarmaid.currentLabel != "sing"){
				//徐々に明るくするタイマーを止める
				this.beingBrightedTimer.stop();
				//人魚が歌っている最中でないなら黒い画像のアルファ値をマナ量と対応させる
				this.SeaBrightness.alpha = 1 - (this.mana/100);
			}else{
				//人魚が歌ってるならタイマーイベントを利用して徐々に明るくなる
				this.beingBrightedTimer.start();
			}

		}//function


		//////////////////////////////////////////////////////
		/** 
		 * タイマーイベントリスナーメソッド
		 * 徐々に明るくなる
		 *
		 * @access public
		 */
		public function beingBrighted(event:TimerEvent):void{
			//暗闇のアルファ値が0より大きい時
			if(this.SeaBrightness.alpha > 0){
				this.SeaBrightness.alpha = this.SeaBrightness.alpha - 0.1;//暗闇のアルファ値が1から0.1%ずつ減っていく
			}
		}//function


	}//class
}//package