import AVFoundation
import Combine

class AudioRecorder: NSObject, ObservableObject {
    @Published var waveformData: [Float] = []
    private var audioEngine: AVAudioEngine!
    private var inputNode: AVAudioInputNode!
    private let bufferSize: AVAudioFrameCount = 1024 // 波形データ処理のバッファサイズ
    private let waveformPoints = 200 // 表示する波形データの点数

    override init() {
        super.init()
        setupAudioEngine()
    }

    private func setupAudioEngine() {
        audioEngine = AVAudioEngine()
        inputNode = audioEngine.inputNode

        // オーディオフォーマットを設定
        let format = inputNode.inputFormat(forBus: 0)

        // マイク入力からオーディオバッファを受け取るためのタップを設定
        inputNode.installTap(onBus: 0, bufferSize: bufferSize, format: format) { [weak self] buffer, time in
            guard let self = self else { return }
            self.processAudioBuffer(buffer: buffer)
        }

        do {
            try audioEngine.start()
        } catch {
            print("オーディオエンジンの開始に失敗しました: \(error.localizedDescription)")
        }
    }

    private func processAudioBuffer(buffer: AVAudioPCMBuffer) {
        // バッファからオーディオデータ（Float配列）を取得
        guard let channelData = buffer.floatChannelData else { return }
        let frameLength = Int(buffer.frameLength)
        let channelCount = Int(buffer.format.channelCount)

        var newWaveformData: [Float] = []
        if channelCount > 0 {
            let data = channelData[0] // 最初のチャンネルのデータを使用
            // 波形データの間引き処理
            let step = max(1, frameLength / waveformPoints)
            for i in stride(from: 0, to: frameLength, by: step) {
                // 絶対値を取って振幅として表示
                newWaveformData.append(abs(data[i]))
            }
        }

        // UIを更新するためにメインスレッドでPublishedプロパティを更新
        DispatchQueue.main.async {
            // 新しいデータが常に最新の波形になるように置き換え
            self.waveformData = newWaveformData
        }
    }

    func startRecording() {
        // 既に開始されている場合は何もしない
        if audioEngine.isRunning { return }

        do {
            try audioEngine.start()
            print("マイク入力の処理を開始しました。")
        } catch {
            print("オーディオエンジンの開始に失敗しました: \(error.localizedDescription)")
        }
    }

    func stopRecording() {
        audioEngine.stop()
        print("マイク入力の処理を停止しました。")
    }
}
