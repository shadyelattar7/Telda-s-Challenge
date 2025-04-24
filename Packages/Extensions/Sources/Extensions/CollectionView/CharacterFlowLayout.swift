//
//  CharacterFlowLayout.swift
//
//
//  Created by Al-attar on 23/04/2025.
//

import UIKit

class CharacterFlowLayout: UICollectionViewFlowLayout {
 
    let standerdItemAlpha: CGFloat = 0.5
    let standerdItemScale: CGFloat = 0.5
    
    override func prepare() {
        super.prepare()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var attributesCopy = [UICollectionViewLayoutAttributes]()
    
        for itemAttributes in attributes!{
            let itemAttributesCopy = itemAttributes.copy() as! UICollectionViewLayoutAttributes
            
            changeLayoutAttributes(itemAttributesCopy)
            attributesCopy.append(itemAttributesCopy)
            
        }
        
        return attributesCopy
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    func changeLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes){
        
        let collectioCenter = collectionView!.frame.size.width / 2
        let offset = collectionView!.contentOffset.x
        let normalizedCenter = attributes.center.x - offset
        
        let maxDistance = self.itemSize.height - self.minimumLineSpacing
        let distance = min(abs(collectioCenter - normalizedCenter), maxDistance)
        
        let ratio = (maxDistance - distance) / maxDistance
        
        let alpha = ratio * (1 - self.standerdItemAlpha) + self.standerdItemAlpha
        let scale = ratio * (1 - self.standerdItemScale) + self.standerdItemScale
        
        attributes.alpha = alpha
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale , scale, 1)
        
    }

}
