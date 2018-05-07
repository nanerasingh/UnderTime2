#define PLIST_PATH @"/var/mobile/Library/Preferences/com.mpg13.UnderTime.plist"


inline bool GetPrefBool(NSString *key)
{
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}