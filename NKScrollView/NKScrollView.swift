
//
//  ELHScrollView.swift
//  ELHScrollView
//
//  Created by 聂康  on 2017/9/15.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class NKScrollView: UIScrollView {

    //图片间距
    var viewMargin: CGFloat = 0
    
    var imageViews = [UIImageView]()
    
    var isLoopScroll = false // 是否首尾循环滚动
    
    var page: Int = 0 {
        
        didSet {
            if isLoopScroll {
                
                guard let images = images,
                    images.count > 0 else {
                        return
                }
                
                let left = (page == 0) ? images.last! : images[page - 1]
                let middle = images[page]
                let right = (page == images.count - 1) ? images.first! : images[page + 1]
                
                imageViews[0].image = UIImage(named: left)
                imageViews[1].image = UIImage(named: middle)
                imageViews[2].image = UIImage(named: right)
                
                contentOffset = CGPoint(x: bounds.width, y: 0)
            }
        }
    }
    
    var images: [String]? {
        
        didSet {
            guard let images = images,
                images.count > 0 else {
                    return
            }
            
            //移除先前的视图
            for v in imageViews {
                v.removeFromSuperview()
            }
            //清空视图数组
            imageViews = []
            
            let width = bounds.width
            let height = bounds.height
            let rect = CGRect(x: viewMargin/2, y: 0, width: width - viewMargin, height: height)
            
            let count = isLoopScroll ? 3 : images.count
            //添加子视图
            for i in 0..<count {
                let imageView = UIImageView(frame: rect.offsetBy(dx: width * CGFloat(i), dy: 0))
                if !isLoopScroll {//不是循环滚动的话,直接设置图片
                    imageView.image = UIImage(named: images[i])
                }
                addSubview(imageView)
                imageViews.append(imageView)
            }
            //设置
            contentSize = CGSize(width: frame.width * CGFloat(count), height: frame.height)
            
            page = 0
        }
    }
    
    convenience init(frame: CGRect, viewMargin: CGFloat) {
        self.init(frame: frame)
        //设置ScrollView属性
        self.viewMargin = viewMargin
        isPagingEnabled = true
        clipsToBounds = false
        showsHorizontalScrollIndicator = false
        delegate = self
        
    }
    
}

extension NKScrollView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        guard let images = images else {
            return
        }
        
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)

        if isLoopScroll {
            
            if index == 0 {
                //左滑
                page = (page == 0) ? images.count - 1 : page - 1
                
            }else if index == 2 {
                //右滑
                page = (page == images.count - 1) ? 0 : page + 1
            }
        }else {
            page = index
        }
    }
}


