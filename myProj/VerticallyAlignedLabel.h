//
//  VerticallyAlignedLabel.h
//  myProj
//
//  Created by sky on 13-5-19.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef enum VerticalAlignment {
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface VerticallyAlignedLabel : UILabel {
@private
    VerticalAlignment verticalAlignment_;
}

@property (nonatomic, assign) VerticalAlignment verticalAlignment;

@end
