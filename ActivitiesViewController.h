//
//  ActivitiesViewController.h
//  myProj
//
//  Created by sky on 13-4-29.
//
//

#import <UIKit/UIKit.h>
#import "ActivitiesCellStyle.h"
#import "ActivitiesDetailsViewController.h"
@interface ActivitiesViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain)NSMutableDictionary *keys;//key
@property(nonatomic, retain)NSArray *datasource;//dataset

@end
