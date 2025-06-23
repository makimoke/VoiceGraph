import SwiftUI

struct WaveformView: View {
    var waveformData: [Float] // AudioRecorderから受け取る波形データ
    var lineColor: Color = .blue
    var lineWidth: CGFloat = 2.0

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                if waveformData.isEmpty { return }

                // 波形データの各点を描画
                let width = geometry.size.width
                let height = geometry.size.height
                // let maxAmplitude: Float = waveformData.max() ?? 1.0 // 最大振幅で正規化
                let maxAmplitude:Float = 1.0 // 正規化を止める

                // 最初の点に移動
                path.move(to: CGPoint(x: 0, y: height / 2))

                for i in 0..<waveformData.count {
                    let x = CGFloat(i) / CGFloat(waveformData.count - 1) * width
                    // 振幅を0から1の範囲に正規化し、ビューの高さに合わせてスケール
                    let normalizedAmplitude = waveformData[i] / maxAmplitude
                    let y = height / 2 - CGFloat(normalizedAmplitude) * (height / 2)
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            .stroke(lineColor, lineWidth: lineWidth)
            .animation(.easeOut(duration: 0.1), value: waveformData) // 波形の変化を滑らかに
        }
        .background(Color.black.opacity(0.1)) // 背景色
        .cornerRadius(10)
    }
}
