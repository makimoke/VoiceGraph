# VoiceGraph by Google Gemini

iOS Swift環境でマイク入力の音声の波形を表示するプログラムです。

ほぼほぼGoogle Geminiさんに作ってもらいました。（noteの"#AIとやってみた"というコンテストに投稿します）

プロンプトは”iosとswiftとSwiftUIでマイクからリアルタイムに音声を受け取って波形を表示するプログラムを作って”。

importが一行足りないだけでコピペでビルド出来ました。スマホの簡単なアプリだったらAIにおまかせで良いかも？

元の振幅正規化あり(①)だと無音でも常に振幅していてイマイチだったので、振幅正規化なし(②)に修正しました。

① 振幅正規化あり

![Image](https://github.com/user-attachments/assets/7f693d5b-176b-467e-ab7f-322f035cf9ca)

② 振幅正規化なし

![Image](https://github.com/user-attachments/assets/41243e97-dbf7-47ac-b537-def0484864c7)
