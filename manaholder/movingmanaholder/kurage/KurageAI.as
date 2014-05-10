//クラゲのAIファイル
//コンストラクタ内で読み込まれる

//うろつきの頻度（何秒に一度か）
this.wanderFrequencySecond = 13;

//気まぐれ値（N回に一度それを行うなどの判定に使う）
this.kimagureValue = 2;


///////////////////
//タイマーイベント
//海藻→クラゲ クラゲが海藻を食べる頻度
this.seaWeedKurageTimer = new Timer(15 * 1000);//秒
this.seaWeedKurageTimer.addEventListener(TimerEvent.TIMER, manaMoveFromSeaWeedToKurage);
this.seaWeedKurageTimer.start();

//クラゲ→人魚 人魚とクラゲがいちゃつく頻度
this.kurageMarmaidTimer = new Timer(10 * 1000);//秒
this.kurageMarmaidTimer.addEventListener(TimerEvent.TIMER, manaMoveFromKurageToMarmaid);
this.kurageMarmaidTimer.start();

//うろつき
this.wanderTimer = new Timer(this.wanderFrequencySecond * 1000);//うろつき頻度秒
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

