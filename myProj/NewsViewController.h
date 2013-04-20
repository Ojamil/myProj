//
//  NewsViewController.h
//  myProj
//
//  Created by sky on 13-4-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsDetailsViewController.h"

@interface NewsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>{
    
}

@property(nonatomic, retain)NSMutableDictionary *states;
@property(nonatomic, retain)NSArray *datasource;
@property (strong, nonatomic) IBOutlet UIScrollView *_scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *_pageControl;
@property (nonatomic, strong) NSArray *photoList;
-(void)setupArray;

@end
