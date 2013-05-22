//
//  NewsDetailsViewController.m
//  myProj
//
//  Created by sky on 13-4-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "NewsDetailsViewController.h"

@interface NewsDetailsViewController ()

@end

@implementation NewsDetailsViewController
@synthesize key,content,keyLabel, contentLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    keyLabel.text = key;
    contentLabel.text = content;
    
    UIButton *leftButton = [[UIButton alloc] init];
    leftButton.frame = CGRectMake(0,0,20,20);
    [leftButton setBackgroundImage:[UIImage imageNamed: @"back.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    NSLog(@"%@",self.navigationItem);
    self.navigationItem.title = @"活动详情";
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
