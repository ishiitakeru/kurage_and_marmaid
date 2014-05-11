//人魚メソッド：エンターフレームイベントリスナー

//////////////////////////////////////////////////////
/** 
 * リスナーメソッド：プロパティを常に監視
 *
 * @access public
 */
public function watchProperty(event:Event):void{
	//髪の毛の光るギミックはflaファイルに記述：人魚のムービークリップのフレームアクション
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

	//自分が動作中はタイマーをストップ
	//タイマーを動かす条件：default、、moveback、back_touch
	if(
		(this.currentLabel == "default")||
		(this.currentLabel == "move")||
		(this.currentLabel == "back")||
		(this.currentLabel == "back_touch")
	){
		//時間止めない
		if(! this.marmaidTheSeaTimer.running){
			this.marmaidTheSeaTimer.start();
		}
		if(! this.wanderTimer.running){
			this.wanderTimer.start();
		}
	}
	//指定した除外ラベル以外の時は
	else{
		//時間止める
		this.marmaidTheSeaTimer.stop();
		this.wanderTimer.stop();
	}

}//function


//////////////////////////////////////////////////////
/** 
 * リスナーメソッド：エンターフレーム
 *
 * 人魚の行動制御
 *
 * @access public
 */
public function controllMarmaid(event:Event):void{
	//currentActionプロパティの値によって行動制御を分ける
	switch(this.getCurrentAction()){

		///////////////////////////////////////////////////////////////////////////////
		//マナを受け取る 受動態
		///////////////////////////////////////////////////////////////////////////////
		//クラゲからマナを受け取るとき
		case "taking_mana_from_kurage":
			//モーション指定
			this.playLabel(this, "takeing_mana_from_kurage");
			//髪の毛の光るギミックはflaファイルに記述：人魚のムービークリップのフレームアクション
			this.setCurrentAction("default");
			break;


		///////////////////////////////////////////////////////////////////////////////
		//歌うための一連の流れ
		///////////////////////////////////////////////////////////////////////////////
		//歌うことに決定
		case "sing":
			this.setGoalPlace(this.myPlaceForSingingX, this.myPlaceForSingingY);	//目的地を人魚に設定
			this.setIsReadyToNextAction(false);	//移動が終わるまで準備出来てますフラグをオフにする
			this.setCurrentAction("moving_to_the_place_for_singing");
			break;

		//歌うための場所に移動
		case "moving_to_the_place_for_singing":
			//モーション指定
			//ムービーの再生位置は「move」に
			this.playLabel(this, "move");
			//目的地に着いたら判定
			if(this.getIsReadyToNextAction() == true){
				//目的地に到着したら、「歌っている」ステータスに変更
				this.setCurrentAction("singing");
			}
			break;

		//歌う
		case "singing":
			//モーション指定
			this.playLabel(this, "sing");
			//イベントの発動条件チェックはリスナーイベントメソッドで行うためここでは行わない
			//マナの受け渡し
			var giving_mana_amount:int = this.getMana();	//クラゲが持っているすべてのマナを与える
			this.giveMana(theSea, giving_mana_amount);	//受け渡し実行
			//行動ステータスをディフォルトに戻す（モーションが終わってなくてもステータスだけ先行させて戻す）
			this.setCurrentAction("default");
			break;


		///////////////////////////////////////////////////////////////////////////////
		//ディフォルト系
		///////////////////////////////////////////////////////////////////////////////
		//うろつき
		case "wandering":
			//モーション指定
			//歌ってたりマナの受け取り中だったりしたらその中断をしない
			if(
				(this.currentLabel == "takeing_mana_from_kurage")||
				(this.currentLabel == "sing")
			){
				break;
			}

			//衝突判定して、タッチの当たり判定とクラゲとが重なっていたら
			//衝突判定して、タッチの当たり判定とクラゲとが重なっていたら
			if(this.HitTouch.hitTestObject(this.myKurage.Hit)){
				//後ろ向きにする
				this.playLabel(this, "back_touch");
			}else
			//タッチ判定ではないがクラゲと重なっていたら
			if(this.Hit.hitTestObject(this.myKurage.Hit)){
				//後ろ向きにする
				this.playLabel(this, "back");
			}
			//クラゲと重なってなければ
			else{
				//ムービーの再生位置は「move」に
				this.playLabel(this, "move");
			}//クラゲとの衝突判定

			break;


		//デフォルトの時：動作を受けた時に反応する
		default:
			//受動態のアクション反応の設定
			//クラゲが人魚にマナを与えるために移動中の場合、その場で待つ
			if(this.myKurage.getCurrentAction() == "moving_to_marmaid"){
				//目的地初期化
				this.setGoalPlace(this.x, this.y);
			}

			//クラゲが人魚にマナを与えている時、クラゲからマナを受け取っているという状態にする
			if(this.myKurage.getCurrentAction() == "giving_mana_to_marmaid"){
				this.setCurrentAction("taking_mana_from_kurage");
				//目的地初期化
				this.setGoalPlace(this.x, this.y);
			}

			//共通：クラゲの方を向く
			this.directTo(this.myKurage);

			//クラゲからのマナ受け取りと歌う動作とは中断しない
			if(
				(this.currentLabel == "takeing_mana_from_kurage")||
				(this.currentLabel == "sing")
			){
				break;
			}

			//モーションを初期化
			//衝突判定して、タッチの当たり判定とクラゲとが重なっていたら
			if(this.HitTouch.hitTestObject(this.myKurage.Hit)){
				//後ろ向きにする
				this.playLabel(this, "back_touch");
			}else
			//タッチ判定ではないがクラゲと重なっていたら
			if(this.Hit.hitTestObject(this.myKurage.Hit)){
				//後ろ向きにする
				this.playLabel(this, "back");
			}
			//クラゲと重なっていなかったら
			else{
				//最終：ムービーの再生位置は「default」に
				//モーションが途中で初期化されてしまう場合、ここに至るまでの間の適切な場所で例外ルートがきちんと作られずにここに処理が来てしまっている
				this.playLabel(this, "default");
			}//クラゲとの衝突判定

			break;
	}//switch

	///////////////////////////////////////////////////////////////////////////////
	//他者の行動への対応系
	///////////////////////////////////////////////////////////////////////////////
	//クラゲのcurrentActionプロパティの値によって行動制御を分ける
	switch(this.myKurage.getCurrentAction()){
		//クラゲがマナをくれようとしている、くれているときは動かない
		case "moving_to_marmaid":
		case "giving_mana_to_marmaid":
			this.goalPlaceX = this.x;
			this.goalPlaceY = this.y;
			break;
	}//switch

}//function


