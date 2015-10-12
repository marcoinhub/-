//
//  ViewController.m
//  观察者模式
//
//  Created by MBZL on 15/10/9.
//  Copyright (c) 2015年 高昭鹏. All rights reserved.
//

#import "ViewController.h"
#import "personal.h"
@interface ViewController ()
@property(strong,nonatomic)personal * person;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *levelLabel;
@property (strong, nonatomic) IBOutlet UIProgressView *levelProgress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person=[personal new];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    //观察 person
    [self.person addObserver:self
                  forKeyPath:@"name"
                     options:NSKeyValueObservingOptionNew
                     context:nil];
    [self.person addObserver: self//观察person
                  forKeyPath:@"level"//观察person 属性
                     options:NSKeyValueObservingOptionNew
                     context:nil];

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{


}
//响应变化
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"name"]&&object ==self.person) {
        self.nameLabel.text=self.person.name;
    }else if ([keyPath isEqualToString:@"level" ]&&object==self.person){
        self.levelLabel.text=[NSString stringWithFormat:@"%ld",self.person.level];
        self.nameLabel.text=self.person.name;
        
        self.levelProgress.progress=self.person.level/100.0 ;
    }
}
- (IBAction)nameChange:(UITextField *)sender {
    self.person.name=sender.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)levelChange:(UIStepper *)sender {
    self.person.level=sender.value;

}
-(void)dealloc{


}
@end
