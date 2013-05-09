//
//  ActivitiesDetailsViewController.h
//  myProj
//
//  Created by sky on 13-4-29.
//
//

#import <UIKit/UIKit.h>

@interface ActivitiesDetailsViewController : UIViewController{
    NSString *key;
    
    NSString *content;
    
    IBOutlet UILabel *keyLabel;
    
    IBOutlet UILabel *contentLabel;
}

@property (nonatomic, retain)NSString *key, *content;

@property (nonatomic, retain)IBOutlet UILabel *keyLabel, *contentLabel;

@end
