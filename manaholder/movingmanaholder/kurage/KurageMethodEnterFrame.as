//クラゲメソッド：エンターフレームイベントリスナー

//////////////////////////////////////////////////////
/** 
 * リスナーメソッド：プロパティを常に監視
 *
 * @access public
 */
public function fullManaShine(event:Event):void{
	//マナが満ちたら光る
	if(this.mana == 50){
		if(
			(this.KurageHead.currentLabel == "shining")||
			(this.KurageHead.currentLabel == "done_shining")
		){
			return;
		}else{
			//currentLabelプロパティ：再生中のフレームラベル
			this.KurageHead.gotoAndPlay("shining");
		}
	}else{
		this.KurageHead.gotoAndPlay("default");
	}
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
	//自分が動作中
	if(this.currentLabel != "default"){
		//時間止める
		this.seaWeedKurageTimer.stop();
		this.wanderTimer.stop();
	}else
	//人魚が歌っている
	if(this.myMarmaid.currentLabel == "sing"){
		//時間止める
		this.seaWeedKurageTimer.stop();
		this.wanderTimer.stop();
	}
	//それ以外
	else{
		//時間止めない
		if(! this.seaWeedKurageTimer.running){
			this.seaWeedKurageTimer.start();
		}
		if(! this.kurageMarmaidTimer.running){
			this.kurageMarmaidTimer.start();
		}
		if(! this.wanderTimer.running){
			this.wanderTimer.start();
		}
	}

}//function


//////////////////////////////////////////////////////
/** 
 * リスナーメソッド：エンターフレーム
 *
 * クラゲの行動・モーション制御
 *
 * @access public
 */
public function controllKurage(event:Event):void{
	//currentActionプロパティの値によって行動制御を分ける
	switch(this.getCurrentAction()){

		///////////////////////////////////////////////////////////////////////////////
		//海藻を食べる流れ
		///////////////////////////////////////////////////////////////////////////////
		//海藻を食べることに決定
		case "eat_seaweed":
			//目的地＝海藻食べるポイントを取得
			this.myPlaceForEatingSeaWeedX = this.mySeaWeed.getPlaceForEatingSeaWeedX();
			this.myPlaceForEatingSeaWeedY = this.mySeaWeed.getPlaceForEatingSeaWeedY();
			this.setGoalPlace(this.myPlaceForEatingSeaWeedX, this.myPlaceForEatingSeaWeedY);	//目的地を海藻（を食べるための場所）に設定
			this.setIsReadyToNextAction(false);	//移動が終わるまで準備出来てますフラグをオフにする
			this.setCurrentAction("moving_to_seaweed");	//「海藻の場所へ移動」にステータス変更
			break;

		//海藻を食べるために移動している状態
		case "moving_to_seaweed":
			//モーション指定
			//ムービーの再生位置は「move」に
			if(this.currentLabel != "move"){
				this.gotoAndPlay("move");
			}
			//目的地に着いたら判定
			if(this.getIsReadyToNextAction() == true){
				//目的地に到着したら、「海藻を食べている」ステータスに変更
				this.setCurrentAction("eating_seaweed");
			}
			break;

		//海藻を食べている状態
		case "eating_seaweed":
			//モーション指定
			//ムービーの再生位置は「eat」に
			if(this.currentLabel != "eat"){
				this.directTo(mySeaWeed);
				this.gotoAndPlay("eat");
			}
			//イベントの発動条件チェックはリスナーイベントメソッドで行うためここでは行わない
			//マナの受け取り
			var taking_mana_amount:int = this.mySeaWeed.getMana();	//海藻が持っているすべてのマナをもらう
			this.takeMana(mySeaWeed, taking_mana_amount);	//受け取り実行
			this.setCurrentAction("default");
			break;

		///////////////////////////////////////////////////////////////////////////////
		//人魚にマナを与える流れ
		///////////////////////////////////////////////////////////////////////////////
		//人魚にマナを与えることに決定
		case "give_mana_to_marmaid":
			//目的地としての人魚イチャつきポジションの算出
			this.positionForLovingMarmaidX = this.myMarmaid.getLovingPositionX();
			this.positionForLovingMarmaidY = this.myMarmaid.getLovingPositionY();
			this.setGoalPlace(this.positionForLovingMarmaidX, this.positionForLovingMarmaidY);	//目的地を人魚に設定
			this.setIsReadyToNextAction(false);	//移動が終わるまで準備出来てますフラグをオフにする
			this.setCurrentAction("moving_to_marmaid");	//「人魚の場所へ移動」にステータス変更
			break;

		//マーメイドの場所まで移動している状態
		case "moving_to_marmaid":
			//モーション指定
			//ムービーの再生位置は「move」に
			if(this.currentLabel != "move"){
				this.gotoAndPlay("move");
			}
			//目的地に着いたら判定
			if(this.getIsReadyToNextAction() == true){
				//目的地に到着したら、「人魚にマナを与えている」ステータスに変更
				this.setCurrentAction("giving_mana_to_marmaid");
			}
			break;

		//マーメイドにマナを分けている状態
		case "giving_mana_to_marmaid":
			//モーション指定
			//ムービーの再生位置は「give」に
			if(this.currentLabel != "give"){
				this.directTo(myMarmaid);
				this.gotoAndPlay("give");
			}
			//イベントの発動条件チェックはリスナーイベントメソッドで行うためここでは行わない
			//マナの受け渡し
			var giving_mana_amount:int = this.getMana();	//クラゲが持っているすべてのマナを与える
			this.giveMana(myMarmaid, giving_mana_amount);	//受け渡し実行
			this.setCurrentAction("default");
			break;

		///////////////////////////////////////////////////////////////////////////////
		//人魚の歌を聞く流れ
		///////////////////////////////////////////////////////////////////////////////
		case "decide_to_listen_to_marmaids_song":
			//人魚の歌を聞くことに決定
			//目的地指定
			this.setGoalPlace(this.placeToListenMarmaidsSongX, this.placeToListenMarmaidsSongY);
			//移動完了フラグ初期化
			this.setIsReadyToNextAction(false);	//移動が終わるまで準備出来てますフラグをオフにする
			this.setCurrentAction("moving_to_place_to_listen_to_marmaids_song");	//「人魚の歌を聞くための場所へ移動」にステータス変更
			break;

		case "moving_to_place_to_listen_to_marmaids_song":
			//モーション指定
			//ムービーの再生位置は「move」に
			if(this.currentLabel != "move"){
				this.gotoAndPlay("move");
			}
			//目的地に着いたら判定
			if(this.getIsReadyToNextAction() == true){
				//目的地に到着したら、「人魚にマナを与えている」ステータスに変更
				this.setCurrentAction("listening_to_marmaids_song");
			}
			break;

		//人魚の歌を聞いている状態
		case "listening_to_marmaids_song":
			//モーション指定
			//ムービーの再生位置は「default」に
			if(this.currentLabel != "default"){
				this.directTo(myMarmaid);
				this.gotoAndPlay("default");
			}
			//人魚が歌い終わったら行動ステータスをディフォルトに戻す
			if(this.myMarmaid.currentLabel != "sing"){
				this.setCurrentAction("default");
			}
			break;


		///////////////////////////////////////////////////////////////////////////////
		//ディフォルト系
		///////////////////////////////////////////////////////////////////////////////
		//うろつき
		case "wandering":
			//ムービーの再生位置は「move」に
			if(this.currentLabel != "move"){
				this.gotoAndPlay("move");
			}
			break;

		//デフォルト
		default:
			//何かしている時は人魚の方を向かない
			if(
				(this.currentLabel == "eat")
			){
				break;
			}
			//人魚の方を向く
			this.directTo(this.myMarmaid);
			//モーション指定
			//ムービーの再生位置は「default」に
			if(this.currentLabel != "default"){
				this.gotoAndPlay("default");
			}
			break;
	}//switch

	///////////////////////////////////////////////////////////////////////////////
	//他者の行動への対応系
	///////////////////////////////////////////////////////////////////////////////
	//人魚のcurrentActionプロパティの値によって行動制御を分ける
	switch(this.myMarmaid.getCurrentAction()){
		case "moving_to_the_place_for_singing":
			this.setCurrentAction("decide_to_listen_to_marmaids_song");
			break;
	}

}//function


