//
//  CalendarLayout.swift
//  Calendar
//
//  Created by Vitaliy Ampilogov on 2/25/17.
//  Copyright © 2017 v.ampilogov. All rights reserved.
//

import UIKit

class CalendarLayout: UICollectionViewFlowLayout {
    
    // Rects for separator decoration view
    private var separatorViewsRects = [IndexPath: CGRect]()
    private let daysInWeek = Calendar.current.weekdaySymbols.count
    
    override init() {
        super.init()
        
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        self.register(SeparatorView.self, forDecorationViewOfKind: SeparatorView.className)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init with coder not implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        itemSize = CGSize(width: SizeManager.dayItemWidth, height: SizeManager.dayItemHeight)
        
        let numberOfItems = collectionView?.numberOfItems(inSection: 0) ?? 0
        let rowHeight = SizeManager.dayItemHeight
        
        // Create Rects for separator decoration views every row (daysInWeek)
        DispatchQueue.global(qos: .userInteractive).async {
            for i in 0..<numberOfItems {
                if i % self.daysInWeek == 0 {
                    let indexPath = IndexPath(item: i, section: 0)
                    let yPosition = CGFloat(i / self.daysInWeek) * rowHeight
                    self.separatorViewsRects[indexPath] = CGRect(x: 0,
                                                                 y: yPosition,
                                                                 width: self.collectionViewContentSize.width,
                                                                 height: SizeManager.separatorHeight)
                }
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var array = super.layoutAttributesForElements(in: rect)!
        
        // add attributes for separator decoration view
        for (indexPath, separatorRect) in separatorViewsRects where rect.contains(separatorRect) {
            if let separatorAttributes = layoutAttributesForDecorationView(ofKind:SeparatorView.className, at: indexPath) {
                separatorAttributes.frame = separatorRect
                separatorAttributes.zIndex = 1
                array.append(separatorAttributes)
            }
        }
        
        return array
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        if elementKind == SeparatorView.className {
            let attributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind:elementKind, with:indexPath)
            return attributes
        }
        
        return super.layoutAttributesForDecorationView(ofKind: elementKind, at: indexPath)
    }
}
