//パッケージ名
package manaholder.movingmanaholder{
	//インポートをインクルードで一括
	include "../../IncludeImport.as";

	/** 
	 * マナを持つ者クラスのうち、動くもの
	 *
	 * 抽象クラスとして。
	 * 子クラス：人魚、クラゲ
	 *
	 * @access public
	 */
	public class MovingManaHolder extends ManaHolder{

		//アニメーション再生制御は具体的な対応ムービークリップを持ったクラスで行うこと
		//ここでは行わない
		//ここで作るのは移動の仕組みのみ


		//////////////////////////////////////////////////////
		//プロパティ
		//アクセス修飾子 var 変数名:変数の型;

		/** 向き */
		protected var direction:String;	//左向き（left）か右向き（right）か

		/** 向きのディフォルト（ムービークリップをどっち向きで作ったか） */
		protected var direction_default:String;	//左向き（left）か右向き（right）か

		/** 移動の際の目的地座標 */
		protected var goalPlaceX:Number;
		protected var goalPlaceY:Number;

		/** 移動完了フラグ */
		protected var isReadyToNextAction:Boolean;

		/** 現在の行動 */
		protected var currentAction:String;

		/** 大きさ調整（100％なら1） */
		protected var basesize:Number;

		/** 通常の向きの時のX比率 */
		protected var normal_scale:Number;

		/** 反対の向きの時のX比率 */
		protected var opposite_scale:Number;

		/** うろつきのための場所 */
		protected var placesForWandering:Array;

		/** うろつきのためのタイマーインスタンス */
		public var wanderTimer:Timer;

		/** うろつきの頻度（何秒に一度か） */
		protected var wanderFrequencySecond:int;

		/** 気まぐれ値（N回に一度それを行うなどの判定に使う） */
		protected var kimagureValue:int;


		//////////////////////////////////////////////////////
		//メソッド

		/** 
		 * コンストラクタ.
		 *
		 * イベントリスナーを作成
		 *
		 * @access public
		 */
		public function MovingManaHolder():void{

			//移動完了フラグ
			this.isReadyToNextAction = true;

			//イベントリスナー
			//向きの調整
			this.addEventListener(Event.ENTER_FRAME, adjustDirection);

			//目的地に移動する
			this.addEventListener(Event.ENTER_FRAME, approach);

		}


		//////////////////////////////////////////////////////
		/** 
		 * リスナーメソッド：常に向きを調整
		 *
		 * @access public
		 */
		public function adjustDirection(event:Event):void{
			//向きの調整
			//ディフォルトの向きと現在の向きの指定とが違うときは反転
			if(this.direction != this.direction_default){
				this.scaleX = this.getOppositeScale();
			}else{
				this.scaleX = this.getNormalScale();
			}
		}//function


		//////////////////////////////////////////////////////
		/** 
		 * リスナーメソッド指定場所へ移動
		 *
		 * 常に実行される。
		 * 目的地設定があるかぎり、常にそこに徐々に近づいていく。
		 *
		 * @return void 移動が完了すればプロパティの行動準備完了フラグをtrueに
		 * @access public
		 */
		public function approach(event:Event):void{
			////////////////////////////////////////////////////////////////////////////////
			//ここはエンターフレームイベントリスナー
			//【注意】
			//「もしcurrentActionがdefaultだったら、ムービーもdefaultラベルを再生させる、
			//ということは決してやってはいけない
			//currentActionとモーションとは瞬間瞬間では対応していない
			////////////////////////////////////////////////////////////////////////////////

			//このメソッドはイベントリスナーメソッド＝目的語を取らない＝自動詞的である

			//目的地があるとき
			//座標計算
			//自分と目標値との距離と向きとを算出
			var distance_x:Number = this.goalPlaceX - this.x;
			var distance_y:Number = this.goalPlaceY - this.y;

			//XY2つの座標の差がそれぞれ*+5以内だったら目的地到着とみなす
			if(
				(
					(distance_x < 5)&&
					(distance_x > -5)
				)&&
				(
					(distance_y < 5)&&
					(distance_y > -5)
				)
			){

				//目的地到着
				//ニュートラル状態に
				this.beNeutral();

				//うろつき状態だったのなら行動ステータスをディフォルトに戻す
				if(this.currentAction == "wandering"){
					this.currentAction = "default";	//行動ステータス初期化
				}
				return;

			}else

			//まだ到着していない
			{
				//毎フレーム移動
				//移動のためのズレ変数初期化
				var moving_x:int = this.goalPlaceX;
				var moving_y:int = this.goalPlaceY;

				//移動のためのX値計算
				if(distance_x > 0){
					//X座標の差がプラス値 = 目的地は自身より右
					this.direction = "right";
					moving_x = this.x + 1;
				}else
				if(distance_x < 0){
					//X座標の差がマイナス値 = 目的地は自身より左
					this.direction = "left";
					moving_x = this.x - 1;
				}

				//移動のためのY値計算
				if(distance_y > 0){
					moving_y = this.y + 1;
				}else
				if(distance_y < 0){
					moving_y = this.y - 1;
				}

				this.x = moving_x;
				this.y = moving_y;

				return;

			}//if 目的地到着判定

		}//function


		//////////////////////////////////////////////////////
		/** 
		 * タイマーイベント うろつき
		 *
		 * @access public
		 */
		public function wander(event:TimerEvent):void{

			//何かしている途中なら何もしない
			if(this.currentLabel != "default"){
				return;
			}

			//タイマーイベント判定のうち数回に一度だけ実行させる
			var temp_random_num = Math.floor(Math.random() * this.kimagureValue);//気まぐれ値
			//確率：分の1
			if(temp_random_num == 0){	//この数値は必ず0でなければならない
				this.setCurrentAction("wandering");
				//うろつき先の指定
				var temp_random_place:Place = this.placesForWandering[Math.floor(Math.random()*this.placesForWandering.length)];
				this.wanderTo(temp_random_place.x, temp_random_place.y);
			}
		}//function


		//////////////////////////////////////////////////////
		/** 
		 * ニュートラルな状態になる
		 *
		 * @return void
		 * @access public
		 */
		public function beNeutral():void{
			//次の行動への準備
			this.isReadyToNextAction = true;

			//目的地を削除
			this.goalPlaceX = this.x;
			this.goalPlaceY = this.y;
		}


		//////////////////////////////////////////////////////
		/** 
		 * うろつく
		 *
		 * @param  Number うろつき先X座標
		 * @param  Number うろつき先Y座標
		 * @return void
		 * @access public
		 */
		public function wanderTo(x:Number, y:Number):void{
			//実際の移動
			this.setGoalPlace(x, y);
		}


		//////////////////////////////////////////////////////
		/** 
		 * 目的地の設定
		 *
		 * 目的地を設定すると、そこに到着するまでインスタンスは移動し続ける
		 * 目的地は、X座標とY座標という2つの数値によって表現される
		 *
		 * @param  Number 目的地X座標
		 * @param  Number 目的地Y座標
		 * @return void
		 * @access public
		 */
		public function setGoalPlace(x:Number, y:Number):void{
			this.goalPlaceX = x;
			this.goalPlaceY = y;

			//目的地があるということはそこに到着するまで次の行動ができない
			this.setIsReadyToNextAction(false);
		}


		//////////////////////////////////////////////////////
		/** 
		 * 現在の行動を取得
		 *
		 * @return String 現在遂行中の行動
		 * @access public
		 */
		public function getCurrentAction():String{
			return this.currentAction;
		}


		//////////////////////////////////////////////////////
		/** 
		 * 現在の行動を設定
		 *
		 * @return void
		 * @access public
		 */
		public function setCurrentAction(action:String):void{
			this.currentAction = action;
		}


		//////////////////////////////////////////////////////
		/** 
		 * 移動完了フラグを取得
		 *
		 * @return String 現在遂行中の行動
		 * @access public
		 */
		public function getIsReadyToNextAction():Boolean{
			return this.isReadyToNextAction;
		}


		//////////////////////////////////////////////////////
		/** 
		 * 移動完了フラグをセット
		 *
		 * @return String 現在遂行中の行動
		 * @access public
		 */
		public function setIsReadyToNextAction(bool:Boolean):void{
			this.isReadyToNextAction = bool;
		}

		//////////////////////////////////////////////////////
		/** 
		 * 対象の方を向く
		 *
		 * @param  DisplayObject
		 * @return void
		 * @access public
		 */
		public function directTo(obj:DisplayObject):void{
			//対象の方が左 自分は左を向く
			if(obj.x < this.x){
				this.direction = "left";
			}else
			//対象の方が右 自分は右を向く
			if(this.x < obj.x){
				this.direction = "right";
			}
		}//function


		//////////////////////////////////////////////////////
		/** 
		 * ゲッター：通常の向きの時のX比率
		 *
		 * @return Number 通常の向きの時のX比率
		 * @access public
		 */
		public function getNormalScale():Number{
			return this.normal_scale;
		}


		//////////////////////////////////////////////////////
		/** 
		 * ゲッター：反対の向きの時のX比率
		 *
		 * @return Number 反対の向きの時のX比率
		 * @access public
		 */
		public function getOppositeScale():Number{
			return this.opposite_scale;
		}

		//////////////////////////////////////////////////////
		/** 
		 * セッター：うろつきのための場所
		 *
		 * これはメインの処理がうろつき場所の配列をインスタンスに通知するために使われる
		 *
		 * @access public
		 */
		public function setWanderPlaces(places:Array):void{
			this.placesForWandering = places;
		}
	}//class
}//package