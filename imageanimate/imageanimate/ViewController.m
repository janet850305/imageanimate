//
//  ViewController.m
//  imageopen
//
//  Created by Chen-Chung Liu on 2020/8/12.
//  Copyright © 2020年 Chen-Chung Liu. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
{
    AVAudioPlayer *musicPlayer;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)play:(id)sender;
@property int page;
@property int accumulatedTime;
@property NSArray *myarray;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];

   // [_timer fire];
}


    
    // Do any additional setup after loading the view, typically from a nib.

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)openpicture{
    _accumulatedTime++;
    NSURL *Url = [NSURL URLWithString:_myarray[_page]];


    UIImage *urlImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:Url]];
    _imageView.image = urlImage;
    _page++;
    if(_page>6){
        _page=0;
    }
}





- (IBAction)play:(id)sender {
    _page=0;
    _accumulatedTime=0;
    NSURL *url  =[NSURL URLWithString:@"https://story.csie.ncu.edu.tw:82/syncInfo?folderID=412"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary* jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSURL *musicUrl=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"andre-sonatine" ofType:@"mp3"]];
    musicPlayer =[[AVAudioPlayer alloc]initWithContentsOfURL:musicUrl error:nil];
    [musicPlayer prepareToPlay];
    [musicPlayer play];

    _myarray = [jsonObj objectForKey:@"images"];
    NSURL *Url = [NSURL URLWithString:_myarray[0]];
    UIImage *urlImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:Url]];
    _imageView.image = urlImage;
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(openpicture) userInfo:nil repeats:YES];
}
@end
