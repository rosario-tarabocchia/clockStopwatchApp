//
//  ViewController.m
//  clockStopWatchApp
//
//  Created by Rosario Tarabocchia on 5/18/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *clockLabel;
@property (strong, nonatomic) NSTimer *currentTime;
@property (strong, nonatomic) NSTimer *stopWatchTime;
@property (nonatomic) NSUInteger secondsLeft;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UIButton *stopWatchButton;
@property (weak, nonatomic) IBOutlet UIButton *currentTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (weak, nonatomic) IBOutlet UIButton *stopwatchUpButton;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.timePicker setHidden:YES];
    [self.currentTimeButton setHidden:YES];
    [self.startButton setHidden:YES];
    [self.pauseButton setHidden:YES];
    [self.cancelButton setHidden:YES];
    [self.restartButton setHidden:YES];
    [self fireCurrentTime];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)stopWatchButtonAction:(UIButton *)sender {
    
    
    [self.currentTime invalidate];
    [self.clockLabel setHidden:YES];
    [self.timePicker setHidden:NO];
    [self.currentTimeButton setHidden:NO];
    [self.stopwatchUpButton setHidden:NO];
    [self.stopWatchButton setHidden:YES];
    [self startTheCountDownOver];
    
    


}

- (IBAction)currentTimeButtonAction:(UIButton *)sender {

    [self.stopWatchTime invalidate];
    [self fireCurrentTime];
    [self.clockLabel setHidden:NO];
    [self.timePicker setHidden:YES];
    [self.currentTimeButton setHidden:YES];
    [self.startButton setHidden:YES];
    [self.pauseButton setHidden:YES];
    [self.cancelButton setHidden:YES];
    [self.restartButton setHidden:YES];
    [self.stopWatchButton setHidden:NO];
    [self.stopwatchUpButton setHidden:NO];
    


}
- (IBAction)countUpAction:(id)sender {
    
    
    [self.currentTime invalidate];
    [self.stopWatchButton setHidden:NO];
    [self.stopwatchUpButton setHidden:YES];
    [self.currentTimeButton setHidden:NO];
    [self startTheCountDownOver];
    [self.timePicker setHidden:YES];
    [self.clockLabel setHidden:NO];
    
    
    
}

- (IBAction)restartButtonAction:(UIButton *)sender {
    
    [self startCountDown];
    [self.pauseButton setHidden:NO];
    [self.restartButton setHidden:YES];
    
}

- (IBAction)startButtonAction:(UIButton *)sender {
    
    if (self.stopWatchButton.hidden) {
        
        self.secondsLeft = self.timePicker.countDownDuration;

    }

    [self startCountDown];
    [self.startButton setHidden:YES];
    [self.pauseButton setHidden:NO];
    [self.cancelButton setHidden:NO];
    [self.timePicker setHidden:YES];
    [self.clockLabel setHidden:NO];
    
}

- (IBAction)pauseButtonAction:(UIButton *)sender {
    
    [self.stopWatchTime invalidate];
    [self.pauseButton setHidden:YES];
    [self.restartButton setHidden:NO];
    
}

- (IBAction)cancelButtonAction:(UIButton *)sender {
    
    [self startTheCountDownOver];
       
}

-(void)fireCurrentTime {
    
    self.currentTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateLabelCurrentTime) userInfo:nil repeats:YES];
    
    [self.currentTime fire];
    
}

-(void)labelTextFormat {
    
    NSInteger hours = self.secondsLeft / 3600;
    NSInteger minutes = (self.secondsLeft % 3600) / 60;
    NSInteger seconds = (self.secondsLeft % 3600) % 60;
    
    self.clockLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    
}


-(void)updateLabelCurrentTime {
    
    NSDate *today = [NSDate date];
    
    NSDateFormatter *cleanUpDate = [[NSDateFormatter alloc] init];
    
    cleanUpDate.timeStyle = NSDateFormatterMediumStyle;
    
    self.clockLabel.text = [cleanUpDate stringFromDate:today];
    
}

-(void)updateTimeLeftOnLabel {
    
    
    [self labelTextFormat];
    
    if (self.stopWatchButton.hidden == YES) {
        
            self.secondsLeft -= 1;
        
        if (self.secondsLeft == 0) {
            
            [self.stopWatchTime invalidate];
            self.stopWatchTime = nil;
            self.clockLabel.text = [NSString stringWithFormat:@"00:00:00"];
            self.clockLabel.textColor = [UIColor redColor];
            
            [self.pauseButton setHidden:YES];
            
        }
    }
    
    else {
        
        self.secondsLeft += 1;
        
    }
    
}

-(void)startCountDown {
    

        
    self.stopWatchTime = [NSTimer scheduledTimerWithTimeInterval:1
                                                          target:self
                                                        selector:@selector(updateTimeLeftOnLabel)
                                                        userInfo:nil
                                                         repeats:YES];

    [self.stopWatchTime fire];
    
    
    
    
}

-(void)startTheCountDownOver {
    
    if (self.stopWatchButton.hidden) {
        
        [self.timePicker setHidden:NO];
        [self.clockLabel setHidden:YES];
        
    }
    
    else {
        
        [self.timePicker setHidden:YES];
        [self.clockLabel setHidden:NO];
        
    }
    
    
    
    [self.startButton setHidden:NO];
    [self.cancelButton setHidden:YES];
    [self.pauseButton setHidden:YES];
    [self.restartButton setHidden:YES];
    
    self.timePicker.countDownDuration = 60.0f;
    
    [self.stopWatchTime invalidate];
    
    self.secondsLeft = 0;
    
    [self updateTimeLeftOnLabel];
    
    self.clockLabel.textColor = [UIColor blackColor];
    
}







@end
