//クラゲメソッド：タイマーイベントリスナー

//////////////////////////////////////////////////////
/** 
 * タイマーイベントリスナーメソッド
 * マナの移動：海藻→クラゲ
 *
 * @access public
 */
public function manaMoveFromSeaWeedToKurage(event:TimerEvent):void{
	//【イベント発動条件】
	//海藻のマナがMAXでないなら不発
	if(this.mySeaWeed.getMana() != this.mySeaWeed.getMaxMana()){
		return;
	}
	//クラゲのマナがMAXなら不発
	if(this.getMana() == this.getMaxMana()){
		return;
	}

	//タイマーイベント判定のうち数回に一度だけ実行させる
	var temp_random_num = Math.floor(Math.random() * this.kimagureValue);	//気まぐれ値
	if(temp_random_num == 0){
		this.setCurrentAction("eat_seaweed");
	}
}//function


//////////////////////////////////////////////////////
/** 
 * タイマーイベントリスナーメソッド
 * マナの移動：クラゲ→人魚
 *
 * クラゲが人魚とイチャつく
 *
 * @access public
 */
public function manaMoveFromKurageToMarmaid(event:TimerEvent):void{
	//【イベント発動条件】
	//クラゲのマナが満タンでなければ不発
	if(this.getMana() != this.getMaxMana()){
		return;
	}
	//人魚のマナが満タンだったら不発
	if(this.myMarmaid.getMana() == this.myMarmaid.getMaxMana()){
		return;
	}

	//タイマーイベント判定のうち数回に一度だけ実行させる
	var temp_random_num = Math.floor(Math.random() * this.kimagureValue);
	if(temp_random_num == 0){
		this.setCurrentAction("give_mana_to_marmaid");
	}
}//function



