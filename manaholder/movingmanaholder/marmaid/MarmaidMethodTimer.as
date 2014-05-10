//人魚メソッド：タイマーイベントリスナー

//////////////////////////////////////////////////////
/** 
 * タイマーイベントリスナーメソッド
 * マナの移動：人魚→海
 *
 * 人魚が歌う
 *
 * @access public
 */
public function manaMoveFromMarmaidToTheSea(event:TimerEvent):void{
	//【イベント発動条件】
	//人魚のマナが満タンでなければ不発
	if(this.getMana() != this.getMaxMana()){
		return;
	}
	//海のマナが満タンだったら不発
	if(this.theSea.getMana() == this.theSea.getMaxMana()){
		return;
	}

	//タイマーイベント判定のうち数回に一度だけ実行させる
	var temp_random_num = Math.floor(Math.random()*2);
	//確率：分の1
	if(temp_random_num == 0){
		this.setCurrentAction("sing");
	}
}//function

