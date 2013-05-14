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

@interface NewsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>{
    
}
@property(nonatomic, retain)NSMutableDictionary *keys;//key
@property(nonatomic, retain)NSArray *datasource;//dataset
@property (nonatomic, strong) NSArray *photoList;
@property (strong, nonatomic) IBOutlet UIScrollView *_scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *_pageControl;
-(void)setupArray;

@end
