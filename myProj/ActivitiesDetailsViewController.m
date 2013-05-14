//
//  ActivitiesDetailsViewController.m
//  myProj
//
//  Created by sky on 13-4-29.
//
//

#import "ActivitiesDetailsViewController.h"

@interface ActivitiesDetailsViewController ()

@end

@implementation ActivitiesDetailsViewController
@synthesize key,content,keyLabel,contentLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    keyLabel.text = key;
    
    contentLabel.text = content;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
