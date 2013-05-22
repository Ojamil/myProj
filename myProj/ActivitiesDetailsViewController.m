//
//  ActivitiesDetailsViewController.m
//  myProj
//
//  Created by sky on 13-4-29.
//
//

#import "ActivitiesDetailsViewController.h"
#import "localSQL.h"
#import "XYAlertViewHeader.h"

@interface ActivitiesDetailsViewController ()

@end

@implementation ActivitiesDetailsViewController


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
    
    UIButton *leftButton = [[UIButton alloc] init];
    leftButton.frame = CGRectMake(0,0,20,20);
    [leftButton setBackgroundImage:[UIImage imageNamed: @"back.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    NSLog(@"%@",self.navigationItem);
    self.navigationItem.title = @"活动详情";
    
    self.myscrollview.frame = CGRectMake(11,11,298,436);
    [self.myscrollview setContentSize:CGSizeMake(298,920)];
    self.myscrollview.backgroundColor=[UIColor whiteColor];
    self.myscrollview.directionalLockEnabled = YES; //只能一个方向滑动
    self.myscrollview.pagingEnabled = NO; //是否翻页
    self.myscrollview.showsVerticalScrollIndicator =YES; //垂直方向的滚动指示
    self.myscrollview.indicatorStyle = UIScrollViewIndicatorStyleWhite;//滚动指示的风格
    self.myscrollview.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
    self.myscrollview.delegate = self;
    
	// Do any additional setup after loading the view.
    self.anameLabel.text = self.aname;
    self.applyDeadlineLabel.text = self.applyDeadline;
    self.apublicLabel.text = self.apublic;
    self.timeBeginLabel.text = self.timeBegin;
    self.timeEndLabel.text = self.timeEnd;
    
    self.maxNumLabel.text = self.maxNum;
    self.aintroLabel=[[VerticallyAlignedLabel alloc]initWithFrame:CGRectMake(20, 134, 241, 186)];
    NSLog(@"aintro2%@",self.aintro);
    self.aintroLabel.text = self.aintro;
    self.aintroLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.aintroLabel.numberOfLines = 0;//自动换行分词，行数无穷
    [self.myscrollview addSubview:_aintroLabel];
    self.aclickLabel.text = self.aclick;
    self.addressLabel.text = self.address;
    self.aconditionLabel.text = self.acondition;
    self.ajoinedLabel.text = self.ajoined;
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)send:(id)sender
{
    NSDictionary *userInfo = [localSQL getLocalUserInfo];
    NSString *uid = [userInfo objectForKey:@"uid"];

    if ([uid isEqualToString:@"128"])
    {
        XYShowAlert(@"游客无法参加活动，请先注册登录吧~");
        return;
    }
    
    JoinUpViewController *joinUp = [self.storyboard instantiateViewControllerWithIdentifier:@"JoinUp"];
    [self.navigationController pushViewController:joinUp animated:YES];
}

- (void)viewDidUnload {
    [self setAintroLabel:nil];
    [super viewDidUnload];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
