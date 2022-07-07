import UIKit
import Lottie

public protocol LottieAnimationConfigurable {
    var animationView: AnimationView? { get }
    func configureAnimation()
    func removeAnimation()
}

extension LottieAnimationConfigurable where Self: UIViewController {
    public func configureAnimation() {
        if let animationView = animationView {
            view.addSubview(animationView)
            animationView.frame = view.frame
            animationView.play()
        }
    }
    public func removeAnimation() {
        animationView?.removeFromSuperview()
    }
}
