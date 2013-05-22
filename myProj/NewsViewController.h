//
//  NewsViewController.h
//  myProj
//
//  Created by sky on 13-4-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsDetailsViewController.h"
#import "NewsCellStyle.h"
#import "PickCityViewController.h"

@interface NewsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>{
    NSString* city;
}

@property(nonatomic, retain)NSMutableDictionary *keys;//key
@property(nonatomic, retain)NSArray *datasource;//dataset
@property (nonatomic, strong) NSArray *photoList;
@property (strong, nonatomic) UIScrollView *_scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *_pageControl;

-(void)setupArray;

@property (strong, nonatomic) UITableView *tableView;

- (IBAction)refresh:(id)sender;
- (IBAction)pickCity:(id)sender;
@end
