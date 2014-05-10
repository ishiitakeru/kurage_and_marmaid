//人魚メソッド：ゲッターとセッター

//////////////////////////////////////////////////////
/** 
 * いちゃつくときの場所指定 X座標
 *
 * @return Number
 * @access public
 */
public function getLovingPositionX():Number{
	var temp_x:int;	//X座標
	var temp_x_distance:int = 80;	//X座標ズレ計算値

	//X座標計算
	if(this.direction == "left"){
		temp_x = this.x - temp_x_distance;
	}else{
		temp_x = this.x + temp_x_distance;
	}

	return temp_x;
}//function


//////////////////////////////////////////////////////
/** 
 * いちゃつくときの場所指定 Y座標
 *
 * @return Number
 * @access public
 */
public function getLovingPositionY():Number{
	var temp_y:int;	//Y座標
	var temp_y_distance:int = 40;	//Y座標ズレ計算値

	//Y座標計算
	temp_y = this.y - temp_y_distance;

	return temp_y;
}//function


//////////////////////////////////////////////////////
/** 
 * セッター：歌うための場所
 *
 * @access public
 */
public function setPlaceForSinging(x:Number, y:Number):void{
	this.myPlaceForSingingX = x;
	this.myPlaceForSingingY = y;
}//function
