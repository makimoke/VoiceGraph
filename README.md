# VoiceGraph with Gemini

iOS Swift環境でマイク入力の音声の波形を表示するプログラムです。（要Mac＆iOS実機）

コードはUIも含めてほぼほぼGoogle Geminiさんに作ってもらいました。（noteの"#AIとやってみた"に投稿する用）

プロンプトは”iosとswiftとSwiftUIでマイクからリアルタイムに音声を受け取って波形を表示するプログラムを作って”。

importが一行足りないだけでコピペでビルドまで出来ました。スマホの簡単なアプリだったらAIにおまかせで良いかも？

元の最大振幅正規化あり(①)だと無音でも常に振幅していてイマイチだったので、最大振幅正規化なし(②)に修正しました。

① 最大振幅正規化あり

![Image](https://github.com/user-attachments/assets/7f693d5b-176b-467e-ab7f-322f035cf9ca)

② 最大振幅正規化なし

![Image](https://github.com/user-attachments/assets/41243e97-dbf7-47ac-b537-def0484864c7)
