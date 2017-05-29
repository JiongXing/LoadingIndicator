//
//  LoadingIndicator.swift
//  LoadingIndicatorDemo
//
//  Created by JiongXing on 2017/5/29.
//  Copyright © 2017年 JiongXing. All rights reserved.
//

import UIKit
import SnapKit

class LoadingIndicator: UIView {
    
    // MARK: - 公开
    
    /// 单例
    static let share = LoadingIndicator()
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bgView)
        addSubview(contentView)
        contentView.addSubview(leftTopDot)
        contentView.addSubview(rightTopDot)
        contentView.addSubview(rightDownDot)
        contentView.addSubview(leftDownDot)
        
        addConstraints()
        addEvents()
    }
    
    private convenience init() {
        self.init(frame: .zero)
    }
    
    /// 显示
    @discardableResult
    func show(inView view: UIView) -> Self {
        view.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        prepareToAnimate()
        startAnimation()
        return self
    }
    
    /// 消失
    func dismiss() {
        stopAnimation()
        self.snp.removeConstraints()
        removeFromSuperview()
    }
    
    // MARK: - 私有
    
    /// 点的半径
    private let dotRadius: CGFloat = 10
    
    /// 区域宽高尺寸
    private let sideLength: CGFloat = 10 * 2 * 3
    
    /// 动画时长
    private let animationDuration = 1.2
    
    /// 控制是否进行动画
    private var isAnimatedEnable = false
    
    /// 是否正在动画
    private var isAnimating = false
    
    /// 背景
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return view
    }()
    
    /// 四点容器
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    /// 左上角的点
    private lazy var leftTopDot: UIView = { [unowned self] in
        return self.makeDot()
        }()
    
    /// 右上角的点
    private lazy var rightTopDot: UIView = { [unowned self] in
        return self.makeDot()
        }()
    
    /// 右下角的点
    private lazy var rightDownDot: UIView = { [unowned self] in
        return self.makeDot()
        }()
    
    /// 左下角的点
    private lazy var leftDownDot: UIView = { [unowned self] in
        return self.makeDot()
        }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 生成点
    private func makeDot() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.yellow
        view.layer.cornerRadius = dotRadius
        view.layer.masksToBounds = true
        view.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.dotRadius * 2)
        }
        return view
    }
    
    /// 添加约束
    private func addConstraints() {
        let bgLength = sqrt(sideLength * sideLength * 2)
        //        let bgLength = sideLength
        bgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(bgLength)
            make.center.equalToSuperview()
        }
        bgView.layer.cornerRadius = dotRadius
        bgView.layer.masksToBounds = true
        contentView.snp.makeConstraints { (make) in
            make.width.height.equalTo(sideLength)
            make.center.equalToSuperview()
        }
        leftTopDot.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView)
        }
        rightTopDot.snp.makeConstraints { (make) in
            make.right.top.equalTo(contentView)
        }
        rightDownDot.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(contentView)
        }
        leftDownDot.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(contentView)
        }
    }
    
    /// 添加事件
    private func addEvents() {
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didSingleTap))
        addGestureRecognizer(tap)
    }
    
    @objc private func didSingleTap() {
        dismiss()
    }
    
    /// 准备动画
    private func prepareToAnimate() {
        self.contentView.snp.updateConstraints { (make) in
            make.width.height.equalTo(self.sideLength)
        }
        self.contentView.transform = CGAffineTransform.identity
        layoutIfNeeded()
    }
    
    /// 开始动画
    private func startAnimation() {
        if isAnimating {
            return
        }
        isAnimatedEnable = true
        scaleToSmall()
    }
    
    /// 停止动画
    private func stopAnimation() {
        isAnimatedEnable = false
    }
    
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
}

