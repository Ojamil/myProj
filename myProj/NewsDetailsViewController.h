//
//  NewsDetailsViewController.h
//  myProj
//
//  Created by sky on 13-4-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailsViewController : UIViewController
{
    
    NSString *state;
    
    NSString *capital;
    
    IBOutlet UILabel *stateLabel;
    
    IBOutlet UILabel *capitalLabel;
    
}

@property (nonatomic, retain)NSString *state, *capital;

@property (nonatomic, retain)IBOutlet UILabel *stateLabel, *capitalLabel;

@end

