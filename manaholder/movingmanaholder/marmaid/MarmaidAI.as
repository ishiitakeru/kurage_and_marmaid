//人魚のAIファイル
//コンストラクタ内で読み込まれる

//うろつきの頻度（何秒に一度か）
this.wanderFrequencySecond = 11;

//気まぐれ値（N回に一度それを行うなどの判定に使う）
this.kimagureValue = 2;


///////////////////
//タイマーイベント
//人魚→海 人魚が歌う頻度
this.marmaidTheSeaTimer = new Timer(3 * 1000);//3秒
this.marmaidTheSeaTimer.addEventListener(TimerEvent.TIMER, manaMoveFromMarmaidToTheSea);
this.marmaidTheSeaTimer.start();

//うろつき
this.wanderTimer = new Timer(this.wanderFrequencySecond * 1000);//うろつき頻度秒
this.wanderTimer.addEventListener(TimerEvent.TIMER, wander);
this.wanderTimer.start();

//////////////////////////
//エンターフレームイベント
this.addEventListener(Event.ENTER_FRAME, watchProperty);

//タイマーを止める、待つ
this.addEventListener(Event.ENTER_FRAME, waitAndStopTimers);

//行動・モーション制御
this.addEventListener(Event.ENTER_FRAME, controllMarmaid);

