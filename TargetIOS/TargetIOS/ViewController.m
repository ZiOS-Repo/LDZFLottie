//
//  ViewController.m
//  TargetIOS
//
//  Created by zhuyuhui on 2022/1/24.
//

#import "ViewController.h"
#import <LDZFLottie/LDZFLottie-Swift.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LdzfLottieAnimatedSwitch *switchButton = [[LdzfLottieAnimatedSwitch alloc] initWithFrame:CGRectMake(0, 100, 100, 100) name:@"Switch" bundle:nil subdirectory:nil];
    [self.view addSubview:switchButton];
}


@end
