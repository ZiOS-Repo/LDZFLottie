//
//  LdzfLottieAnimationView.swift
//  LDZFLottie
//
//  Created by zhuyuhui on 2022/1/24.
//

import Foundation
import Lottie
import SnapKit

@objcMembers public class LdzfLottieAnimationView: UIView {
    
    let animationView = AnimationView()
    
    public override var contentMode: UIView.ContentMode {
        set {
            animationView.contentMode = newValue
        }
        
        get {
            return animationView.contentMode
        }
    }
    
    
    /**
     Describes the behavior of an AnimationView when the app is moved to the background.
     0 stop
     1 pause
     2 pauseAndRestore
     3 forceFinish
     */
    public var backgroundBehavior:Int {
        set {
            switch newValue {
            case 0:
                animationView.backgroundBehavior = .stop
            case 1:
                animationView.backgroundBehavior = .pause
            case 2:
                animationView.backgroundBehavior = .pauseAndRestore
            case 3:
                animationView.backgroundBehavior = .forceFinish
            default:
                animationView.backgroundBehavior = .pause
            }
        }
        
        get {
            switch animationView.backgroundBehavior {
            case .stop:
                return 0
            case .pause:
                return 1
            case .pauseAndRestore:
                return 2
            case .forceFinish:
                return 3
            }
        }
    }
    
    
    public init(frame: CGRect, name: String?, bundle: Bundle?, subdirectory: String?) {
        super.init(frame: frame)
        
        let animation = Animation.named(name ?? "", bundle: bundle ?? Bundle.main, subdirectory: subdirectory)
        animationView.animation = animation
        addSubview(animationView)
        
        animationView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit %s",self)
    }
    
    // MARK: - Public Functions
    func transformLoopMode(loopModeRawValue: Int, repeatTimes: Float) -> LottieLoopMode {
        var loopMode:LottieLoopMode
        switch loopModeRawValue {
        case 0:
            loopMode = .playOnce
        case 1:
            loopMode = .loop
        case 2:
            loopMode = .autoReverse
        case 3:
            loopMode = .repeat(repeatTimes)
        case 4:
            loopMode = .repeatBackwards(repeatTimes)
        default:
            loopMode = .playOnce
        }
        return loopMode
    }
    /**
     Plays the animation from its current state to the end.
     
     - Parameter completion: An optional completion closure to be called when the animation completes playing.
     */
    public func play(completion: ((Bool) -> Void)? = nil) {
        animationView.play(completion:completion)
    }
    
    /**
    Plays the animation from a progress (0-1) to a progress (0-1).
    
    - Parameter fromProgress: The start progress of the animation. If `nil` the animation will start at the current progress.
    - Parameter toProgress: The end progress of the animation.
    - Parameter loopMode: The loop behavior of the animation. If `nil` the view's `loopMode` property will be used.
    - Parameter completion: An optional completion closure to be called when the animation stops.
    */
    public func play(fromProgress: CGFloat,
                     toProgress: CGFloat,
                     loopModeRawValue: Int,
                     repeatTimes: Float,
                     completion: ((Bool) -> Void)? = nil) {
        
        let loopMode = transformLoopMode(loopModeRawValue: loopModeRawValue, repeatTimes: repeatTimes)
        animationView.play(fromProgress: fromProgress, toProgress: toProgress, loopMode: loopMode, completion: completion)
    }
    
    /**
     Plays the animation from a start frame to an end frame in the animation's framerate.
     
     - Parameter fromFrame: The start frame of the animation. If `nil` the animation will start at the current frame.
     - Parameter toFrame: The end frame of the animation.
     - Parameter loopMode: The loop behavior of the animation. If `nil` the view's `loopMode` property will be used.
     - Parameter completion: An optional completion closure to be called when the animation stops.
     */
    public func play(fromFrame: CGFloat,
                     toFrame: CGFloat,
                     loopModeRawValue: Int,
                     repeatTimes: Float,
                     completion: ((Bool) -> Void)? = nil) {
      
        let loopMode = transformLoopMode(loopModeRawValue: loopModeRawValue, repeatTimes: repeatTimes)
        animationView.play(fromFrame: fromFrame, toFrame: toFrame, loopMode: loopMode, completion: completion)
    }
    
    /**
     Plays the animation from a named marker to another marker.
     
     Markers are point in time that are encoded into the Animation data and assigned
     a name.
     
     NOTE: If markers are not found the play command will exit.
     
     - Parameter fromMarker: The start marker for the animation playback. If `nil` the
     animation will start at the current progress.
     - Parameter toMarker: The end marker for the animation playback.
     - Parameter loopMode: The loop behavior of the animation. If `nil` the view's `loopMode` property will be used.
     - Parameter completion: An optional completion closure to be called when the animation stops.
     */
    public func play(fromMarker: String? = nil,
                     toMarker: String,
                     loopModeRawValue: Int,
                     repeatTimes: Float,
                     completion: ((Bool) -> Void)? = nil) {
        
        let loopMode = transformLoopMode(loopModeRawValue: loopModeRawValue, repeatTimes: repeatTimes)
        animationView.play(fromMarker: fromMarker, toMarker: toMarker, loopMode: loopMode, completion: completion)
    }
    
    /**
     Stops the animation and resets the view to its start frame.
     
     The completion closure will be called with `false`
     */
    public func stop() {
        animationView.stop()
    }
    
    /**
     Pauses the animation in its current state.
     
     The completion closure will be called with `false`
     */
    public func pause() {
        animationView.pause()
    }
}
