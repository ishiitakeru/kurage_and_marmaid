//パッケージ名
package manaholder{
	//インポートをインクルードで一括
	include "../IncludeImport.as";

	/** 
	 * マナを持つ者クラス
	 *
	 * 抽象クラスとして。
	 * 子クラス：人魚、海、海藻、クラゲ
	 *
	 * @access public
	 */
	public class ManaHolder extends MovieClip{

		//////////////////////////////////////////////////////
		//プロパティ
		//アクセス修飾子 var 変数名:変数の型;

		/** マナ */
		protected var mana:int;

		/** マナ上限値 */
		protected var max_mana:int;

		/** 海 */
		protected var theSea:TheSea;

		/** 海藻 */
		protected var mySeaWeed:SeaWeed;

		/** クラゲ */
		protected var myKurage:Kurage;

		/** 人魚 */
		protected var myMarmaid:Marmaid;


		//////////////////////////////////////////////////////
		/** 
		 * マナを与える
		 *
		 * @param ManaHolder マナを与える対象
		 * @param int マナを与える量
		 * @access public
		 */
		public function giveMana(obj:ManaHolder, mana:int):void{
			//提供側の定義
			var giver:ManaHolder = this;
			//受け取り側の定義
			var taker:ManaHolder = obj;

			this.moveMana(giver, taker, mana);
		}//function


		//////////////////////////////////////////////////////
		/** 
		 * マナを吸収する
		 *
		 * @param  ManaHolder マナを吸収する対象
		 * @param  int マナを吸収する量
		 * @return Boolean 成功フラグ
		 * @access public
		 */
		public function takeMana(obj:ManaHolder, mana:int):void{
			//提供側の定義
			var giver:ManaHolder = obj;
			//受け取り側の定義
			var taker:ManaHolder = this;

			this.moveMana(giver, taker, mana)
		}//function


		//////////////////////////////////////////////////////
		/** 
		 * マナの移動
		 *
		 * @param  ManaHolder マナを与える側
		 * @param  ManaHolder マナを受け取る側
		 * @param  int マナを与える量
		 * @return Boolean 成功したらtrue、何もしなかったのならfalse
		 * @access public
		 */
		public function moveMana(giver:ManaHolder, taker:ManaHolder, mana:int):Boolean{
			//提供側のマナがカラだったら何もしない
			if(! giver.getMana()){
				return false;
			}
			//受け取り側のマナが満タンなら何もしない
			if(taker.getMana() == taker.getMaxMana()){
				return false;
			}

			//提供を受ける側がマナを素直に受け取った際の合計値（仮の値）
			var sum_mana:int = taker.getMana() + mana;

			//変数初期化
			var giving_mana_amount:int;
			var calculated_taker_mana:int;
			var calculated_giver_mana:int;

			//マナ提供側のマナ総量が指定提供量よりも大きいなら、提供量は指定値
			if(giver.getMana() > mana){
				giving_mana_amount = mana;
			}
			//指定提供量のほうが残りマナより大きければ、提供量は提供者の残りマナ全て
			else{
				giving_mana_amount = giver.getMana();
			}

			//マナを受け取る側のマナ量が既に上限に達する場合、提供量は上限値までの値
			if(sum_mana > taker.getMaxMana()){
				giving_mana_amount = taker.getMaxMana() - taker.getMana();
			}

			//提供を受ける側のマナ量操作
			calculated_taker_mana = taker.getMana() + giving_mana_amount;
			taker.setMana(calculated_taker_mana);

			//提供をする側のマナ量操作
			calculated_giver_mana = giver.getMana() - giving_mana_amount;
			giver.setMana(calculated_giver_mana);

			//マナ移動操作をしたらtrueを返す
			return true;

		}//function


		//////////////////////////////////////////////////////
		/** 
		 * ゲッター：マナ
		 *
		 * @return int マナ量
		 * @access public
		 */
		public function getMana():int{
			return this.mana;
		}

		//////////////////////////////////////////////////////
		/** 
		 * ゲッター：マナ上限値
		 *
		 * @return int マナ上限値
		 * @access public
		 */
		public function getMaxMana():int{
			return this.max_mana;
		}


		//////////////////////////////////////////////////////
		/** 
		 * セッター：マナ
		 *
		 * @param  int 新たにセットするマナ
		 * @return void
		 * @access public
		 */
		public function setMana(altered_mana:int):void{
			this.mana = altered_mana;
		}


		//////////////////////////////////////////////////////
		/** 
		 * セッター：海
		 *
		 * @param  ManaHolder
		 * @return void
		 * @access public
		 */
		public function setSea(sea:TheSea):void{
			this.theSea = sea;
		}


		//////////////////////////////////////////////////////
		/** 
		 * セッター：海藻
		 *
		 * @param  ManaHolder
		 * @return void
		 * @access public
		 */
		public function setSeaWeed(seaweed:SeaWeed):void{
			this.mySeaWeed = seaweed;
		}


		//////////////////////////////////////////////////////
		/** 
		 * セッター：クラゲ
		 *
		 * @param  ManaHolder
		 * @return void
		 * @access public
		 */
		public function setKurage(kurage:Kurage):void{
			this.myKurage = kurage;
		}


		//////////////////////////////////////////////////////
		/** 
		 * セッター：人魚
		 *
		 * @param  ManaHolder
		 * @return void
		 * @access public
		 */
		public function setMarmaid(marmaid:Marmaid):void{
			this.myMarmaid = marmaid;
		}


		//////////////////////////////////////////////////////
		/** 
		 * ムービークリップ再生ラベル指定
		 *
		 * @param  MovieClip それを再生する主語となるムービークリップ
		 * @param  String 再生したいムービークリップのフレームラベル名
		 * @return void
		 * @access public
		 */
		public function playLabel(obj:MovieClip, label:String):void{
			if(obj.currentLabel != label){
				obj.gotoAndPlay(label);
			}
		}



	}//class
}//package