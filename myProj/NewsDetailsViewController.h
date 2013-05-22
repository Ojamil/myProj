//
//  NewsDetailsViewController.h
//  myProj
//
//  Created by sky on 13-4-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailsViewController : UIViewController{
    
    NSString *key;
    
    NSString *content;
    
    IBOutlet UILabel *keyLabel;
    
    IBOutlet UILabel *contentLabel;
    
}

@property (nonatomic, retain)NSString *key, *content;
- (IBAction)back:(id)sender;
@property (nonatomic, retain)IBOutlet UILabel *keyLabel, *contentLabel;

@end

