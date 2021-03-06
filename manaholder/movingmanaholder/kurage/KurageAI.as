//クラゲのAIファイル
//コンストラクタ内で読み込まれる

//海藻を食べる頻度（何秒に一度か）
this.eatFrequencySecond = 15;//15秒

//人魚にマナを与える頻度（何秒に一度か）
this.giveManaToMarmaidSecond = 10;//10秒

//うろつきの頻度（何秒に一度か）
this.wanderFrequencySecond = 13;//13秒

//気まぐれ値（N回に一度それを行うなどの判定に使う）
this.kimagureValue = 2;//2


///////////////////
//タイマーイベント
//海藻→クラゲ クラゲが海藻を食べる頻度
this.seaWeedKurageTimer = new Timer(this.eatFrequencySecond * 1000);
this.seaWeedKurageTimer.addEventListener(TimerEvent.TIMER, manaMoveFromSeaWeedToKurage);
this.seaWeedKurageTimer.start();

//クラゲ→人魚 人魚とクラゲがいちゃつく頻度
this.kurageMarmaidTimer = new Timer(this.giveManaToMarmaidSecond * 1000);
this.kurageMarmaidTimer.addEventListener(TimerEvent.TIMER, manaMoveFromKurageToMarmaid);
this.kurageMarmaidTimer.start();

//うろつき
this.wanderTimer = new Timer(this.wanderFrequencySecond * 1000);
this.wanderTimer.addEventListener(TimerEvent.TIMER, wander);
this.wanderTimer.start();


//////////////////////////
//エンターフレームイベント
//マナが満ちると光る
this.addEventListener(Event.ENTER_FRAME, fullManaShine);

//タイマーを止める、待つ
this.addEventListener(Event.ENTER_FRAME, waitAndStopTimers);

//行動・モーション制御
this.addEventListener(Event.ENTER_FRAME, controllKurage);

