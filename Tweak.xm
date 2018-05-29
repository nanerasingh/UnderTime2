#import "important.h"
#import <spawn.h>

@interface _UIStatusBarStringView : UIView
@property (copy) NSString *text;
@property NSInteger numberOfLines;
@property (copy) UIFont *font;
@property NSInteger textAlignment;
@end

int sizeOfFont = GetPrefInt(@"sizeOfFont");
	
%hook _UIStatusBarStringView

- (void)setText:(NSString *)text {
	if(GetPrefBool(@"Enable") && ![text containsString:@"%"] && ![text containsString:@"1x"] && ![text containsString:@"LTE"] && ![text containsString:@"4G"] && ![text containsString:@"3G"] && ![text containsString:@"2G"]) {
		NSString *lineTwo = GetPrefString(@"lineTwo");
		NSString *lineOne = GetPrefString(@"lineOne");
		NSString *timeLineTwo = lineTwo;
		NSString *timeLineOne = lineOne;
		
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		NSDate *now = [NSDate date];
		if(!GetPrefBool(@"lineTwoStandard")){
		[dateFormatter setDateFormat:lineTwo];
		timeLineTwo = [dateFormatter stringFromDate:now];
		timeLineTwo = [timeLineTwo substringToIndex:[timeLineTwo length]];
		}
		if(!GetPrefBool(@"lineOneStandard")){
		[dateFormatter setDateFormat:lineOne];
		timeLineOne = [dateFormatter stringFromDate:now];
		timeLineOne = [timeLineOne substringToIndex:[timeLineOne length]];
		}
		NSString *newString;
		if(GetPrefBool(@"lineOneEnable")){
		newString = [NSString stringWithFormat:@"%@\n%@", timeLineOne, timeLineTwo];
		}
		else{
		newString = [NSString stringWithFormat:@"%@\n%@", text, timeLineTwo];
		}

		[self setFont: [self.font fontWithSize:sizeOfFont]];
		if(GetPrefBool(@"replaceTime")){
			%orig(timeLineOne);
		}
		else{
			self.textAlignment = 1;
			self.numberOfLines = 2;
			%orig(newString);
		}
	}
	else {
		%orig(text);
	}
}

%end

@interface _UIStatusBarTimeItem
@property (copy) _UIStatusBarStringView *shortTimeView;
@property (copy) _UIStatusBarStringView *pillTimeView;
@end

%hook _UIStatusBarTimeItem
- (id)applyUpdate:(id)arg1 toDisplayItem:(id)arg2 {
	id returnThis = %orig;
	if(GetPrefBool(@"Enable")) {
		[self.shortTimeView setFont: [self.shortTimeView.font fontWithSize:sizeOfFont]];
		[self.pillTimeView setFont: [self.pillTimeView.font fontWithSize:sizeOfFont]];
	}
	return returnThis;
}

%end

@interface _UIStatusBarBackgroundActivityView : UIView
@property (copy) CALayer *pulseLayer;
@end

%hook _UIStatusBarBackgroundActivityView

- (void)setCenter:(CGPoint)point {
	if(GetPrefBool(@"Enable") && !GetPrefBool(@"replaceTime")){
			point.y = 11;
			self.frame = CGRectMake(0, 0, self.frame.size.width, 31);
			self.pulseLayer.frame = CGRectMake(0, 0, self.frame.size.width, 31);
			%orig(point);
	}
}



%end
