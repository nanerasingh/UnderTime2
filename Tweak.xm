#import "important.h"

@interface _UIStatusBarStringView : UIView
@property (copy) NSString *text;
@property NSInteger numberOfLines;
@property (copy) UIFont *font;
@property NSInteger textAlignment;
@end

int sizeOfFont = GetPrefInt(@"sizeOfFont");
	
%hook _UIStatusBarStringView

- (void)setText:(NSString *)text {
	if(GetPrefBool(@"Enable")) {
		%orig;
		
		NSString *dformat = GetPrefString(@"dformat");
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:dformat];
		NSDate *now = [NSDate date];
		NSString *shortDate = [dateFormatter stringFromDate:now];
		shortDate = [shortDate substringToIndex:[shortDate length]];
		NSString *newString = [NSString stringWithFormat:@"%@\n%@", text, shortDate];
		
		[self setFont: [self.font fontWithSize:sizeOfFont]];
		if(GetPrefBool(@"replaceTime")){
			%orig(shortDate);
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
	%orig;
	if(GetPrefBool(@"Enable")) {
	id returnThis = %orig;
	[self.shortTimeView setFont: [self.shortTimeView.font fontWithSize:sizeOfFont]];
	[self.pillTimeView setFont: [self.pillTimeView.font fontWithSize:sizeOfFont]];
	return returnThis;
	}
return 0;
}

%end

@interface _UIStatusBarBackgroundActivityView : UIView
@property (copy) CALayer *pulseLayer;
@end

%hook _UIStatusBarBackgroundActivityView

- (void)setCenter:(CGPoint)point {
	%orig;
	if(GetPrefBool(@"Enable")) {
		if(GetPrefBool(@"replaceTime")){
		}
		else{
			point.y = 11;
			self.frame = CGRectMake(0, 0, self.frame.size.width, 31);
			self.pulseLayer.frame = CGRectMake(0, 0, self.frame.size.width, 31);
			%orig(point);
		}
	}
}

%end
