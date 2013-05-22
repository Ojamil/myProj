//
//  SelfActivitiesDetailsViewController.h
//  myProj
//
//  Created by sky on 13-5-7.
//
//

#import <UIKit/UIKit.h>

@interface SelfActivitiesDetailsViewController : UIViewController{
    NSString *key;
    
    NSString *content;
    
    IBOutlet UILabel *keyLabel;
    
    IBOutlet UILabel *contentLabel;
}
@property (nonatomic, retain)NSString *key, *content;

@property (nonatomic, retain)IBOutlet UILabel *keyLabel, *contentLabel;
- (IBAction)back:(id)sender;

@end
