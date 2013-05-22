//
//  SignUpSuccessViewController.m
//  myProj
//
//  Created by sky on 13-5-15.
//
//

#import "SignUpSuccessViewController.h"

@interface SignUpSuccessViewController ()

@end

@implementation SignUpSuccessViewController
@synthesize myName;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMyName:nil];
    [super viewDidUnload];
}
@end
