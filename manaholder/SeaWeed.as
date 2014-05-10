//パッケージ名
package manaholder{
	//インポートをインクルードで一括
	include "../IncludeImport.as";

	/** 
	 * 海藻クラス
	 *
	 * @extend manaholder.ManaHolder
	 * @access public
	 */
	public class SeaWeed extends manaholder.ManaHolder{

		//////////////////////////////////////////////////////
		//プロパティ
		/** マナ移動：海→海藻のためのタイマーインスタンス */
		public var theSeaSeaWeedTimer:Timer;

		/** 海藻を食べるための場所座標 */
		private var placeForEatingSeaWeedX:Number;
		private var placeForEatingSeaWeedY:Number;

		//////////////////////////////////////////////////////
		//メソッド
		/** 
		 * コンストラクタ
		 *
		 * マナ上限値設定
		 *
		 * @access public
		 */
		public function SeaWeed():void{

			//マナ上限値
			this.max_mana = 10;

			///////////////////
			//タイマーイベント
			//海→海藻 海藻が育つスピード
			this.theSeaSeaWeedTimer = new Timer(3 * 1000);//3秒
			this.theSeaSeaWeedTimer.addEventListener(TimerEvent.TIMER, manaMoveFromTheSeaToSeaWeed);
			this.theSeaSeaWeedTimer.start();

			//イベントリスナー
			//常にプロパティを監視
			this.addEventListener(Event.ENTER_FRAME, grow);

			//タイマーを止める、待つ
			this.addEventListener(Event.ENTER_FRAME, waitAndStopTimers);

		}//function


		//////////////////////////////////////////////////////
		/** 
		 * リスナーメソッド：プロパティの値によって姿を変える
		 *
		 * @access public
		 */
		public function grow(event:Event):void{
			//マナ6以上で成体
			if(this.mana > 5){
				if(this.currentLabel != "old"){
					//currentLabelプロパティ：再生中のフレームラベル
					this.gotoAndPlay("old");
				}
			}else
			//マナ3～6は若い
			if(this.mana > 2){
				if(this.currentLabel != "young"){
					//currentLabelプロパティ：再生中のフレームラベル
					this.gotoAndPlay("young");
				}
			}else
			//マナ1～2は幼体
			if(this.mana > 0){
				if(this.currentLabel != "baby"){
					//currentLabelプロパティ：再生中のフレームラベル
					this.gotoAndPlay("baby");
				}
			}else
			//マナ0になったら種になる
			if(this.mana == 0){
				//成長状態からクラゲに捕食された場合：アニメーションあり
				if(this.currentLabel == "old"){
					if(this.currentLabel != "seed"){
						this.gotoAndPlay("seed");
					}
				}else
				//初期起動時：アニメーションなし
				if(this.currentLabel != "seed"){
					this.gotoAndPlay("none");
				}
			}

		}//finction


		//////////////////////////////////////////////////////
		/** 
		 * タイマーイベントリスナーメソッド
		 * マナの移動：海→海藻
		 *
		 * @access public
		 */
		public function manaMoveFromTheSeaToSeaWeed(event:TimerEvent):void{
			//【イベント発動条件】
			//海のマナが枯渇していたら不発
			if(! this.theSea.getMana()){
				return;
			}
			//海藻のマナが満タンだったら不発
			if(this.getMana() == this.getMaxMana()){
				return;
			}

			this.takeMana(theSea, 2);
		}//function


		//////////////////////////////////////////////////////
		/** 
		 * リスナーメソッド：タイマーストップ
		 *
		 * タイマーを止める、待つ
		 *
		 * @access public
		 */
		public function waitAndStopTimers(event:Event):void{

			//タイマーのストップ
			//人魚が歌っている
			//クラゲが海藻を食べている
			if(
				(this.myKurage.currentLabel == "eat")||
				(this.myMarmaid.currentLabel == "sing")
			){
				//時間止める
				this.theSeaSeaWeedTimer.stop();
			}
			//それ以外
			else{
				//時間止めない
				if(! this.theSeaSeaWeedTimer.running){
					this.theSeaSeaWeedTimer.start();
				}
			}

		}//function


		//////////////////////////////////////////////////////
		/** 
		 * ゲッター：海藻を食べる場所 X座標
		 *
		 * @return Number
		 * @access public
		 */
		public function getPlaceForEatingSeaWeedX():Number{
			return this.placeForEatingSeaWeedX;
		}//function


		//////////////////////////////////////////////////////
		/** 
		 * ゲッター：海藻を食べる場所 Y座標
		 *
		 * @return Number
		 * @access public
		 */
		public function getPlaceForEatingSeaWeedY():Number{
			return this.placeForEatingSeaWeedY;
		}//function


		//////////////////////////////////////////////////////
		/** 
		 * セッター：海藻を食べる場所座標
		 *
		 * ステージに配置された場所から算出するのでメインの処理からこのメソッドを呼び出す
		 *
		 * @return void
		 * @access public
		 */
		public function setPlaceForEatingSeaWeed(x:Number, y:Number):void{
			this.placeForEatingSeaWeedX = x;
			this.placeForEatingSeaWeedY = y;
		}//function

	}//class
}//package