//
//  SelfViewController.h
//  myProj
//
//  Created by sky on 13-5-7.
//
//

#import <UIKit/UIKit.h>
#import "SelfActivitiesCellStyle.h"
#import "SelfActivitiesDetailsViewController.h"
@interface SelfViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>


@property(nonatomic, retain)NSMutableDictionary *keys;//key
@property(nonatomic, retain)NSArray *datasource;//dataset

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *school;
@property (strong, nonatomic) IBOutlet UILabel *hour;
- (IBAction)selfDetail:(id)sender;
- (IBAction)LogOut:(id)sender;


@end
