# LoadingIndicator


![LoadingIndicator.gif](http://upload-images.jianshu.io/upload_images/2419179-96f2d4e959198978.gif?imageMogr2/auto-orient/strip)

这种魔术般的效果是怎么做到的？用简单的UIView动画即可：
```swift
    /// 缩小
    private func scaleToSmall() {
        guard isAnimatedEnable else {
            return
        }
        isAnimating = true
        self.contentView.snp.updateConstraints { (make) in
            make.width.height.equalTo(self.dotRadius * 2)
        }
        UIView.animate(withDuration: animationDuration / 2, animations: {
            self.contentView.layoutIfNeeded()
            self.contentView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }) { (_) in
            self.isAnimating = false
            self.scaleToLarge()
            if self.isAnimatedEnable == false {
                self.prepareToAnimate()
            }
        }
    }
    
    /// 放大
    private func scaleToLarge() {
        guard isAnimatedEnable else {
            return
        }
        isAnimating = true
        self.contentView.snp.updateConstraints { (make) in
            make.width.height.equalTo(self.sideLength)
        }
        UIView.animate(withDuration: animationDuration / 2, animations: {
            self.contentView.layoutIfNeeded()
            self.contentView.transform = CGAffineTransform.identity
        }) { (_) in
            self.isAnimating = false
            self.scaleToSmall()
        }
    }
```

使用方法：
```swift
LoadingIndicator.share.show(inView: view)
LoadingIndicator.share.dismiss()
```
