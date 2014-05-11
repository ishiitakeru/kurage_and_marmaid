package{
	//インポートをインクルードで一括
	include "IncludeImport.as";

	public class Main extends MovieClip{

		//////////////////////////////////////////////////////
		//プロパティ
		/** 海のインスタンス */
		private var theSea:TheSea;

		/** 海藻のインスタンス */
		private var mySeaWeed:SeaWeed;

		/** クラゲのインスタンス */
		private var myKurage:Kurage;

		/** 人魚のインスタンス */
		private var myMarmaid:Marmaid;

		/** デバッグ用データトレーサー */
		private var trace_timer:Timer;

		/** タイマーインスタンスの配列 */
		private var timers:Array;

		/** 各種「場所」 */
		private var places:Array;

		/** クラゲが人魚といちゃつくための場所 */
		private var positionForLovingMarmaidX:Number;
		private var positionForLovingMarmaidY:Number;

		/** 歌うための場所 */
		private var myPlaceForSingingX:Number;
		private var myPlaceForSingingY:Number;


		//////////////////////////////////////////////////////
		//メソッド
		//コンストラクタ
		public function Main(){

			//////////////////////////////////////////
			//登場キャラのインスタンス作成

			//海
			this.theSea = new TheSea();
			this.theSea.x = 0;
			this.theSea.y = 0;
			this.addChild(this.theSea);

			//クラゲ
			this.myKurage = new Kurage();
			this.myKurage.x = 200;
			this.myKurage.y = 200;
			this.addChild(this.myKurage);
			//目的地座標初期化＝自分のインスタンスの配置座標
			this.myKurage.beNeutral();

			//人魚
			this.myMarmaid = new Marmaid();
			this.myMarmaid.x = 100;
			this.myMarmaid.y = 200;
			this.addChild(myMarmaid);
			//目的地座標初期化＝自分のインスタンスの配置座標
			this.myMarmaid.beNeutral();

			//人魚が歌う場所
			this.myPlaceForSingingX = this.theSea.width / 2;
			this.myPlaceForSingingY = this.theSea.height / 2;
			//人魚に歌う場所を通知
			this.myMarmaid.setPlaceForSinging(this.myPlaceForSingingX, this.myPlaceForSingingY);

			//海藻
			this.mySeaWeed = new SeaWeed();
			var temp_random_num = Math.floor(Math.random()*30);	//出現場所にランダムなズレを
			this.mySeaWeed.x = 200 + temp_random_num;
			this.mySeaWeed.y = 450;
			this.addChild(this.mySeaWeed);
			//海藻を食べる場所初期化（ステージに配置されて座標が定まったあとじゃないとこの操作ができない）
			this.mySeaWeed.setPlaceForEatingSeaWeed(this.mySeaWeed.x-20, this.mySeaWeed.y-60);


			//4者それぞれにそれぞれの存在を知らせる
			this.mySeaWeed.setSea(this.theSea);
			this.myKurage.setSea(this.theSea);
			this.myMarmaid.setSea(this.theSea);

			this.theSea.setSeaWeed(this.mySeaWeed);
			this.myKurage.setSeaWeed(this.mySeaWeed);
			this.myMarmaid.setSeaWeed(this.mySeaWeed);

			this.theSea.setKurage(this.myKurage);
			this.mySeaWeed.setKurage(this.myKurage);
			this.myMarmaid.setKurage(this.myKurage);

			this.theSea.setMarmaid(this.myMarmaid);
			this.mySeaWeed.setMarmaid(this.myMarmaid);
			this.myKurage.setMarmaid(this.myMarmaid);


			//////////////////////////////////////////
			//ランダム移動場所の定義
			var $i:int = 0;
			this.places = new Array();
			//X値10刻み
			for(var ix:int = 80; ix <= 240; ix = ix+10){
				//Y値10刻み
				for(var iy:int = 150; iy <= 300; iy = iy+10){
					//場所インスタンス作成
					places[$i] = new Place();
					this.places[$i].x = ix;
					this.places[$i].y = iy;
					this.theSea.addChild(places[$i]);
					$i++;
				}
			}

			//クラゲと人魚とにうろつき場所を通知
			this.myKurage.setWanderPlaces(this.places);
			this.myMarmaid.setWanderPlaces(this.places);

			//////////////////////////////////////////
			//イベントリスナー

			//デバッグ用データトレーサー
			this.trace_timer = new Timer(2 * 1000);//1秒
			this.trace_timer.addEventListener(TimerEvent.TIMER, traceData);
			this.trace_timer.start();

		}//function コンストラクタ


		//////////////////////////////////////////////////////
		//各種タイマーイベントリスナーメソッド

		//////////////////////////////////////////////////////
		/** 
		 * デバッグ用トレースイベント
		 */
		public function traceData(event:TimerEvent):void{
			trace("クラゲの状態：" + this.myKurage.getCurrentAction());
			trace("人魚の状態："   + this.myMarmaid.getCurrentAction());
			trace("海のマナ    ：" + this.theSea.getMana());
			trace("海藻のマナ  ：" + this.mySeaWeed.getMana());
			trace("クラゲのマナ：" + this.myKurage.getMana());
			trace("人魚のマナ  ：" + this.myMarmaid.getMana());
		}//function

	}//class

}//package
