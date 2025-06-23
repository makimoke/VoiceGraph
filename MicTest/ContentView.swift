import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject private var audioRecorder = AudioRecorder()
    @State private var isRecording = false

    var body: some View {
        VStack {
            Text("リアルタイム音声波形")
                .font(.largeTitle)
                .padding()

            WaveformView(waveformData: audioRecorder.waveformData)
                .frame(height: 200) // 波形表示領域の高さ
                .padding()

            Button(action: {
                if isRecording {
                    audioRecorder.stopRecording()
                } else {
                    audioRecorder.startRecording()
                }
                isRecording.toggle()
            }) {
                Image(systemName: isRecording ? "mic.fill" : "mic.slash.fill")
                    .font(.largeTitle)
                    .foregroundColor(isRecording ? .red : .gray)
            }
            .padding()
        }
        .onAppear {
            // アプリ起動時にマイクアクセスを要求
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                if granted {
                    print("マイクアクセスが許可されました。")
                } else {
                    print("マイクアクセスが拒否されました。")
                    // ユーザーに設定での許可を促すアラートなどを表示する
                }
            }
        }
    }
}
