#line 1 "Tweak.xm"
#import "important.h"
#import <spawn.h>

@interface _UIStatusBarStringView : UIView
@property (copy) NSString *text;
@property NSInteger numberOfLines;
@property (copy) UIFont *font;
@property NSInteger textAlignment;
@end

int sizeOfFont = GetPrefInt(@"sizeOfFont");
	

#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class _UIStatusBarTimeItem; @class _UIStatusBarStringView; @class _UIStatusBarBackgroundActivityView; 
static void (*_logos_orig$_ungrouped$_UIStatusBarStringView$setText$)(_LOGOS_SELF_TYPE_NORMAL _UIStatusBarStringView* _LOGOS_SELF_CONST, SEL, NSString *); static void _logos_method$_ungrouped$_UIStatusBarStringView$setText$(_LOGOS_SELF_TYPE_NORMAL _UIStatusBarStringView* _LOGOS_SELF_CONST, SEL, NSString *); static id (*_logos_orig$_ungrouped$_UIStatusBarTimeItem$applyUpdate$toDisplayItem$)(_LOGOS_SELF_TYPE_NORMAL _UIStatusBarTimeItem* _LOGOS_SELF_CONST, SEL, id, id); static id _logos_method$_ungrouped$_UIStatusBarTimeItem$applyUpdate$toDisplayItem$(_LOGOS_SELF_TYPE_NORMAL _UIStatusBarTimeItem* _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_orig$_ungrouped$_UIStatusBarBackgroundActivityView$setCenter$)(_LOGOS_SELF_TYPE_NORMAL _UIStatusBarBackgroundActivityView* _LOGOS_SELF_CONST, SEL, CGPoint); static void _logos_method$_ungrouped$_UIStatusBarBackgroundActivityView$setCenter$(_LOGOS_SELF_TYPE_NORMAL _UIStatusBarBackgroundActivityView* _LOGOS_SELF_CONST, SEL, CGPoint); 

#line 13 "Tweak.xm"


static void _logos_method$_ungrouped$_UIStatusBarStringView$setText$(_LOGOS_SELF_TYPE_NORMAL _UIStatusBarStringView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * text) {
	if(GetPrefBool(@"Enable") && ![text containsString:@"%"]) {
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
			_logos_orig$_ungrouped$_UIStatusBarStringView$setText$(self, _cmd, timeLineTwo);
		}
		else{
			self.textAlignment = 1;
			self.numberOfLines = 2;
			_logos_orig$_ungrouped$_UIStatusBarStringView$setText$(self, _cmd, newString);
		}
	}
	else {
		_logos_orig$_ungrouped$_UIStatusBarStringView$setText$(self, _cmd, text);
	}
}



@interface _UIStatusBarTimeItem
@property (copy) _UIStatusBarStringView *shortTimeView;
@property (copy) _UIStatusBarStringView *pillTimeView;
@end


static id _logos_method$_ungrouped$_UIStatusBarTimeItem$applyUpdate$toDisplayItem$(_LOGOS_SELF_TYPE_NORMAL _UIStatusBarTimeItem* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {
	id returnThis = _logos_orig$_ungrouped$_UIStatusBarTimeItem$applyUpdate$toDisplayItem$(self, _cmd, arg1, arg2);
	if(GetPrefBool(@"Enable")) {
		[self.shortTimeView setFont: [self.shortTimeView.font fontWithSize:sizeOfFont]];
		[self.pillTimeView setFont: [self.pillTimeView.font fontWithSize:sizeOfFont]];
	}
	return returnThis;
}



@interface _UIStatusBarBackgroundActivityView : UIView
@property (copy) CALayer *pulseLayer;
@end



static void _logos_method$_ungrouped$_UIStatusBarBackgroundActivityView$setCenter$(_LOGOS_SELF_TYPE_NORMAL _UIStatusBarBackgroundActivityView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGPoint point) {
	if(GetPrefBool(@"Enable") && !GetPrefBool(@"replaceTime")){
			point.y = 11;
			self.frame = CGRectMake(0, 0, self.frame.size.width, 31);
			self.pulseLayer.frame = CGRectMake(0, 0, self.frame.size.width, 31);
			_logos_orig$_ungrouped$_UIStatusBarBackgroundActivityView$setCenter$(self, _cmd, point);
	}
}




static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$_UIStatusBarStringView = objc_getClass("_UIStatusBarStringView"); MSHookMessageEx(_logos_class$_ungrouped$_UIStatusBarStringView, @selector(setText:), (IMP)&_logos_method$_ungrouped$_UIStatusBarStringView$setText$, (IMP*)&_logos_orig$_ungrouped$_UIStatusBarStringView$setText$);Class _logos_class$_ungrouped$_UIStatusBarTimeItem = objc_getClass("_UIStatusBarTimeItem"); MSHookMessageEx(_logos_class$_ungrouped$_UIStatusBarTimeItem, @selector(applyUpdate:toDisplayItem:), (IMP)&_logos_method$_ungrouped$_UIStatusBarTimeItem$applyUpdate$toDisplayItem$, (IMP*)&_logos_orig$_ungrouped$_UIStatusBarTimeItem$applyUpdate$toDisplayItem$);Class _logos_class$_ungrouped$_UIStatusBarBackgroundActivityView = objc_getClass("_UIStatusBarBackgroundActivityView"); MSHookMessageEx(_logos_class$_ungrouped$_UIStatusBarBackgroundActivityView, @selector(setCenter:), (IMP)&_logos_method$_ungrouped$_UIStatusBarBackgroundActivityView$setCenter$, (IMP*)&_logos_orig$_ungrouped$_UIStatusBarBackgroundActivityView$setCenter$);} }
#line 94 "Tweak.xm"
